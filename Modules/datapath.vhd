library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    port (
        data_in: in std_logic_vector(31 downto 0);
        instruction: in std_logic_vector(25 downto 0);
        --RegDst, ALUSrc, MemToReg, RegWrite, Branch
        ctrlword: in std_logic_vector(4 downto 0); 
        alu_code: in std_logic_vector(3 downto 0);
        data_out, mem_addr: out std_logic_vector(31 downto 0);
        instr_addr: out std_logic_vector(31 downto 0);
        clock, reset: in std_logic
    ) ;
  end datapath;

  architecture structural of datapath is

    component Register_File
      port (
        clk: in std_logic;
        reset: in std_logic;
        RegWrite:in std_logic; --señal de control
        RR1: in std_logic_vector (4 downto 0); --numero de registro 1
        RR2: in std_logic_vector (4 downto 0); --numero de registro 2
        Write_Register: in std_logic_vector (4 downto 0); 
        Write_Data: in std_logic_vector (31 downto 0); --En el anterior numero guardar los 8 bytes de esta entrada
        RD1: out std_logic_vector (31 downto 0); --Salida de 32 bits.
        RD2: out std_logic_vector (31 downto 0)); --Salida de 32 bits.
                   
  
    end component Register_File;

    component alu32bits
    port(
        entrada1:in std_logic_vector(31 downto 0);
        entrada2:in std_logic_vector(31 downto 0);
        control:in std_logic_vector (3 downto 0);
        result: out std_logic_vector(31 downto 0);
        zero:out std_logic
    );   
    end component alu32bits;
    
    component mux5bits
    port(
        entrada1: in std_logic_vector(4 downto 0);
        entrada2: in std_logic_vector(4 downto 0);
        sel: in std_logic;
        salida: out std_logic_vector(4 downto 0)
    );
    end component mux5bits;

    component mux32bits
    port(
        entrada1: in std_logic_vector(31 downto 0);
        entrada2: in std_logic_vector(31 downto 0);
        sel: in std_logic;
        salida: out std_logic_vector(31 downto 0)
    );   
    end component mux32bits;

    component sll2
    port(
        entrada: in std_logic_vector(31 downto 0);
        salida: out std_logic_vector(31 downto 0)
    );   
    end component sll2;

    component sign_ext
    port(
        entrada16: in std_logic_vector(15 downto 0);
        salida32: out std_logic_vector(31 downto 0)
    );   
    end component sign_ext;
    component pc_aux
    port(
        data_in: in std_logic_vector(31 downto 0);
        e: in std_logic;
        clk: in std_logic;
        data_out: out std_logic_vector(31 downto 0);
        reset: in std_logic
    );   
    end component pc_aux;

    signal vacio: std_logic;
    signal muxaregistro:std_logic_vector(4 downto 0);
    signal cablememreg:std_logic_vector(31 downto 0);
    signal salida1r:std_logic_vector(31 downto 0);
    signal salida2r:std_logic_vector(31 downto 0);
    signal se_a_sll2:std_logic_vector(31 downto 0);
    signal sll2_a_ADDALU:std_logic_vector(31 downto 0);
    signal muxaalui:std_logic_vector(31 downto 0);
    signal rai:std_logic_vector(31 downto 0);
    signal aluaalu:std_logic_vector(31 downto 0);
    signal cablezero:std_logic;
    signal addamux:std_logic_vector(31 downto 0);
    signal salidapcaux:std_logic_vector(31 downto 0);
    signal retorno:std_logic_vector (31 downto 0);
    signal compuertaand:std_logic;
    
  begin
    primermux : mux5bits
      port map(
        entrada1 => instruction(20 downto 16),
        entrada2 => instruction(15 downto 11), 
        sel => ctrlword(4),
        salida => muxaregistro
      );
    archivoderegistros: Register_File
    port map(
        RegWrite=>ctrlword(1),
        RR1=> instruction (25 downto 21),
        RR2=> instruction (20 downto 16),
        Write_Register=>muxaregistro,
        Write_Data=>cablememreg,
        RD1=>salida1r,
        RD2=>salida2r,
        clk=>clock,
        reset=>reset
    );

    extensordesigno:sign_ext
    port map(
        entrada16=>instruction(15 downto 0),
        salida32=>se_a_sll2
    );

    shiftleft:sll2
    port map(
        entrada=>se_a_sll2,
        salida=>sll2_a_ADDALU
    );

    muxdespuesregistro:mux32bits
    port map(
        entrada1=>salida2r,
        entrada2=>se_a_sll2,
        sel=>ctrlword(3),
        salida=>muxaalui
    );
    
    aluimportante: alu32bits
    port map(
        entrada1=>salida1r,
        entrada2=>muxaalui,
        control=>alu_code,
        result=>rai,
        zero=>cablezero
    );

    muxsalidamemoria:mux32bits
    port map(
        entrada1=>rai,
        entrada2=>data_in,
        sel=>ctrlword(2),
        salida=>cablememreg
    );

    sumador4:alu32bits port map(
        entrada1=>x"00000004",
        entrada2=>salidapcaux,
        control=>"0010",
        result=>aluaalu,
        zero=>vacio
    );

    sumadorsig:alu32bits port map(
        entrada1=>aluaalu,
        entrada2=>sll2_a_ADDALU,
        control=>"0010",
        result=>addamux,
        zero=>vacio
    );

    muxpc: mux32bits 
    port map(
        entrada1=>aluaalu,
        entrada2=>addamux,
        sel=>compuertaand,
        salida=>retorno
    );

    pc_pc : pc_aux
        port map(
            data_in => retorno,
            e => '1',
            clk => clock,
            data_out => salidapcaux,
            reset => reset
        );
    
    
    instr_addr <= salidapcaux;
    data_out <= salida2r;
    mem_addr <= rai;
    compuertaand<=ctrlword(0) and cablezero;

  end structural ; -- structural
  