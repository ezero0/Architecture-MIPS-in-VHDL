library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tbalu32bits is
end tbalu32bits;

architecture behavioral of tbalu32bits is 
    component alu32bits 
    port(
        
    entrada1:in std_logic_vector(31 downto 0);
    entrada2:in std_logic_vector(31 downto 0);
    control:in std_logic_vector (3 downto 0);
    result: out std_logic_vector(31 downto 0);
    zero:out std_logic
    );
    end component;

    signal s_e1: std_logic_vector(31 downto 0);
    signal s_e2: std_logic_vector(31 downto 0);
    signal s_c: std_logic_vector(3 downto 0);
    signal s_r: std_logic_vector(31 downto 0);
    signal s_z: std_logic;
    

    begin
        prueba: alu32bits
        port map(
            entrada1=>s_e1,
            entrada2=>s_e2,
            control=>s_c,
            result=>s_r,
            zero=>s_z);

    process
        begin
            s_e1 <= x"00000005"; 
            s_e2 <= x"00000004"; 
            wait for 10 ns;
            s_c<="0111";
            wait for 10 ns;
            s_c<="0000";
            wait for 10 ns;
            s_c<="0001";
            wait for 10 ns;
            s_c<="0010";
            wait for 10 ns;
            s_c<="0110";
            wait for 10 ns;

            s_e1 <= x"00000003"; 
            s_e2 <= x"00000004"; 
            wait for 10 ns;
            s_c<="0111";
            wait for 10 ns;
            s_c<="0000";
            wait for 10 ns;
            s_c<="0001";
            wait for 10 ns;
            s_c<="0010";
            wait for 10 ns;
            s_c<="0110";
            wait for 10 ns;
            wait;
    end process;
end behavioral;