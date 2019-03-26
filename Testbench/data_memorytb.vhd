library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity data_memorytb is
end data_memorytb;

architecture behavioral of data_memorytb is 
    component data_memory 
    port(
        clk, MemRead, MemWrite : in std_logic;
    address : in  std_logic_vector(31 downto 0);
    datain  : in  std_logic_vector(31 downto 0);
    dataout : out std_logic_vector(31 downto 0)
    );
    end component;

    signal s_addr: std_logic_vector(31 downto 0);
    signal s_clk: std_logic;
    signal s_MemRead: std_logic;
    signal s_MemWrite: std_logic;
    signal s_di: std_logic_vector(31 downto 0);
    signal s_do: std_logic_vector(31 downto 0);

    begin
        memoria: data_memory
        port map(
            address => s_addr,
            clk => s_clk,
            MemRead => s_MemRead,
            MemWrite => s_MemWrite,
            datain => s_di,
            dataout => s_do
            
        );
    process
        begin
            s_clk<='0';
            s_addr<=x"00000000";
            s_MemRead<='0';
            s_di<=x"FFFFFFFF";
            s_MemWrite<='1';
            wait for 10 ns;
            s_clk<='1';
            wait for 10 ns;
            s_clk<='0';
            s_MemRead<='1';
            s_MemWrite<='0';
            wait for 10 ns;
            s_clk<='1';
            wait for 10 ns;
            s_MemRead<='0';
            s_clk<='0';
            s_MemWrite<='0';
            s_addr<=x"00000004";
            s_di<=x"ABABABAB";
            wait for 10 ns;
            s_clk<='1';
            wait for 10 ns;
            s_clk<='0';
            s_MemWrite<='1';
            wait for 10 ns;
            s_clk<='1';
            wait for 10 ns;
            s_clk<='0';
            s_MemWrite<='0';
            s_MemRead<='1';
            s_addr<=x"00000008";
            wait for 10 ns;
            s_clk<='1';
            s_MemRead<='1';
            s_addr<=x"00000000";
            wait for 10 ns;
            s_clk<='0';
            s_MemRead<='1';
            s_addr<=x"00000004";
            wait for 10 ns;

            wait;
    end process;
end behavioral;