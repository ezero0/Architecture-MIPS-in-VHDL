library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sll2 is
    port(
        entrada: in std_logic_vector(31 downto 0);
        salida: out std_logic_vector(31 downto 0)
    );
end sll2;

architecture structural of sll2 is
        begin
            salida <= entrada(29 downto 0) & "00";
end structural; 