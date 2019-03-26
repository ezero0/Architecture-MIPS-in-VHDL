library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
entity pc is 
    port(
        pcin:in std_logic_vector(31 downto 0);
        pcout:out std_logic_vector(31 downto 0)
    );
end pc;
architecture behavioral of pc is
begin
pcout<=pcin;
end behavioral ; --pce
