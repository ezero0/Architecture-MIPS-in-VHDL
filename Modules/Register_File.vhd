library ieee;
use ieee.std_logic_1164.all;

entity Register_File is
    port (
        clk: in std_logic;
        reset: in std_logic;
        RegWrite:in std_logic; --señal de control
        RR1: in std_logic_vector (4 downto 0); --numero de registro 1
        RR2: in std_logic_vector (4 downto 0); --numero de registro 2
        Write_Register: in std_logic_vector (4 downto 0); 
        Write_Data: in std_logic_vector (31 downto 0); --En el anterior numero guardar los 8 bytes de esta entrada
        RD1: out std_logic_vector (31 downto 0); --Salida de 32 bits.
        RD2: out std_logic_vector (31 downto 0)); --Salida de 32 bits
  end Register_File;

  architecture structural of Register_File is

    component dec5a32 
      port (
        a: in std_logic_vector(4 downto 0);
        e: in std_logic;
        d: out std_logic_vector(31 downto 0)
      ) ;
    end component dec5a32;

    component re_hab_buff
    port(
        data_in: in std_logic_vector(31 downto 0);
        eBusA: in std_logic;
        eBusB: in std_logic;
        e: in std_logic;
        clk: in std_logic;
        dataBusA_out: out std_logic_vector(31 downto 0);
        dataBusB_out: out std_logic_vector(31 downto 0);
        reset: in std_logic   
    );   
    end component re_hab_buff;

    
    signal decoderRW_d_data: std_logic_vector(31 downto 0);
    signal decoderA_d_data: std_logic_vector(31 downto 0);
    signal decoderB_d_data: std_logic_vector(31 downto 0);
    
  begin
    decoderRW : dec5a32
      port map(
        a => Write_Register,
        d => decoderRW_d_data,
        e => RegWrite
      );
    decoderA : dec5a32
      port map(
        a => RR1,
        d => decoderA_d_data,
        e => '1'
      );
    decoderB : dec5a32
      port map(
        a => RR2,
        d => decoderB_d_data,
        e => '1'
      );

    alus : for i in 0 to 31 generate
    
        regis0_31 :  re_hab_buff port map(
            data_in => Write_Data,
            eBusA => decoderA_d_data(i),
            eBusB => decoderB_d_data(i),
            e => decoderRW_d_data(i),
            clk => clk,
            dataBusA_out => RD1,
            dataBusB_out => RD2,
            reset => reset
        );
        
    end generate ; 
  end structural ; 