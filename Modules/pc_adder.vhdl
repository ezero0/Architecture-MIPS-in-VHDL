library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;


entity pc_adder is 
    port(
        pcin:in std_logic_vector(31 downto 0);
        pcout:out std_logic_vector(31 downto 0)
    );
end pc_adder;
architecture behavioral of pc_adder is
    signal cuatro: std_logic_vector(2 downto 0):="100";
    begin
    process (pcin)
    begin
pcout<=std_logic_vector(unsigned(pcin)+unsigned(cuatro));
end process;
end behavioral ; --pce


--SE REQUIERE UN CLK!?