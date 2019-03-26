library ieee;
use ieee.std_logic_1164.all;

entity processor is
    port (
        clock: in std_logic;
        reset: in std_logic
    ) ;
end processor;

architecture structural of processor is

  component datapath is
    port (
      data_in: in std_logic_vector(31 downto 0);
      instruction: in std_logic_vector(25 downto 0);
      --RegDst, ALUSrc, MemToReg, RegWrite, PCSrc
      ctrlword: in std_logic_vector(4 downto 0); 
      alu_code: in std_logic_vector(3 downto 0);
      data_out, mem_addr: out std_logic_vector(31 downto 0);
      instr_addr: out std_logic_vector(31 downto 0);
      clock, reset: in std_logic
    );
  end component datapath;

  component instruction_memory
    port (
      addr: in std_logic_vector(31 downto 0);
      instruction: out std_logic_vector(31 downto 0)
    ) ;
  end component instruction_memory;

  component data_memory
    port(
      clk, MemRead, MemWrite : in std_logic;
      address : in  std_logic_vector(31 downto 0);
      datain  : in  std_logic_vector(31 downto 0);
      dataout : out std_logic_vector(31 downto 0)
  );
  end component data_memory;

  component control_unit
  port ( 
    op : in std_logic_vector(5 downto 0);
    RegDst:out std_logic; 
    ALUSrc:out std_logic; 
    MemToReg:out std_logic; 
    RegWrite : out std_logic; 
    MemRead, MemWrite, Branch : out std_logic;
    ALUOp : out std_logic_vector(1 downto 0)
  );
  end component control_unit;

  component control_alu
    port (
      ALUOp: in std_logic_vector(1 downto 0);
        FuncCode: in std_logic_vector(5 downto 0); 
        ALUCtl: out std_logic_vector(3 downto 0)
    );
  end component control_alu;


    signal salidamemo:std_logic_vector(31 downto 0);
    signal instruccion:std_logic_vector(31 downto 0);
    signal palabracontrol:std_logic_vector(4 downto 0);
    signal salidaalucontrol:std_logic_vector(3 downto 0);
    signal direccion1:std_logic_vector(31 downto 0);
    signal dtadm:std_logic_vector(31 downto 0);
    signal dpadm:std_logic_vector(31 downto 0);
    signal cablememread:std_logic;
    signal cablememwrite:std_logic;
    signal aluopc:std_logic_vector (1 downto 0);
    --signal MemRead, MemWrite: std_logic;
    --signal initial_data, data, initial_addr, address: std_logic_vector(31 downto 0);
    --signal clock: std_logic := '0';
    --signal reset: std_logic := '1';
    --signal finish_flag: boolean := false;

    --signal initial_complete: boolean := false;
    --signal instruction_addr, instruction: std_logic_vector(31 downto 0);
    --RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, PCSrc, ALUOp1 y ALUOp0
    
    begin

      
 --MemWrite <= '1' when initial_complete = false else unidadctrl_dataMemo_MemWrite;
 --MemRead  <= '0' when initial_complete = false else unidadctrl_dataMemo_MemRead;
 -- data <= initial_data when initial_complete = false else ruta_dataMemo_data_out;
 -- address <= initial_addr when initial_complete = false else ruta_dataMemo_addresRes;
 memoriainstrucciones: instruction_memory
      port map(
        addr => direccion1,
        instruction => instruccion
      );
     unioncondatapath : datapath
      port map(
        clock => clock,
        reset => reset,
        data_in => salidamemo,
        instruction =>instruccion(25 downto 0),
        ctrlword => palabracontrol,
        alu_code => salidaalucontrol,
        mem_addr => dtadm,
        data_out => dpadm,
        instr_addr => direccion1
      );
   
    memoriadedatos : data_memory
      port map(
        clk => clock, 
        --MemRead => MemRead,
        MemRead => cablememread, 
        --MemWrite => MemWrite,
        MemWrite => cablememwrite,
        --address => address,
        address => dtadm,
        --datain => data,
        datain => dpadm,
        dataout => salidamemo
      );
    unidaddecontrol : control_unit
      port map(
        op => instruccion(31 downto 26),
        RegDst => palabracontrol(4),
        ALUSrc => palabracontrol(3),
        MemToReg => palabracontrol(2),
        RegWrite => palabracontrol(1),
        MemRead => cablememread,
        MemWrite => cablememwrite,
        Branch => palabracontrol(0),
        ALUOp => aluopc(1 downto 0)
      );
    alucontrol : control_alu
      port map(
        ALUOp => aluopc,
        FuncCode => instruccion(5 downto 0),
        ALUCtl => salidaalucontrol
      );
    
  end structural ; -- structural
  