library ieee;
use ieee.std_logic_1164.all;

entity re_hab_buff is
    port (
        data_in: in std_logic_vector(31 downto 0);
        eBusA: in std_logic;
        eBusB: in std_logic;
        e: in std_logic;
        clk: in std_logic;
        dataBusA_out: out std_logic_vector(31 downto 0);
        dataBusB_out: out std_logic_vector(31 downto 0);
        reset: in std_logic             
    ) ;
  end re_hab_buff;

  architecture structural of re_hab_buff is

    component tri_state_buff --Buffer de tres estados

      port (
        data_in: in std_logic_vector(31 downto 0);
        data_out: out std_logic_vector(31 downto 0);
        en_buff: in std_logic
      ) ;
    end component tri_state_buff;

    component re_hab

    port(
        data_in: in std_logic_vector(31 downto 0);
        e: in std_logic;
        clk: in std_logic;
        data_out: out std_logic_vector(31 downto 0);
        reset: in std_logic
    );   
    end component re_hab;

    
    signal re_buff: std_logic_vector(31 downto 0);
    signal busA: std_logic_vector(31 downto 0);
    signal busB: std_logic_vector(31 downto 0);
  begin

    regi : re_hab
    port map(
      data_in => data_in,
      reset => reset,
      clk => clk,
      e => e,
      data_out => re_buff
    );
    triSateBusA : tri_state_buff
      port map(
        data_in => re_buff,
        data_out => busA,
        en_buff => eBusA
      );
    triSateBusB : tri_state_buff
      port map(
        data_in => re_buff,
        data_out => busB,
        en_buff => eBusB
      );
   
    dataBusA_out <= busA;
    dataBusB_out <= busB;
  end structural ; -- structural