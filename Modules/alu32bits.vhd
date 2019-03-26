library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity alu32bits is port(
    entrada1:in std_logic_vector(31 downto 0);
    entrada2:in std_logic_vector(31 downto 0);
    control:in std_logic_vector (3 downto 0);
    result: out std_logic_vector(31 downto 0);
    zero:out std_logic
);

end alu32bits;

architecture behavioral of alu32bits is
    begin
        result<=std_logic_vector(signed(entrada1)+signed(entrada2))when(control="0010")else
        std_logic_vector(signed(entrada1)-signed(entrada2))when(control="0110")else
        (entrada1) and (entrada2)when(control="0000")else
        (entrada1) or (entrada2)when(control="0001")else
        "00000000000000000000000000000001" when (control="0111" and entrada1<entrada2) else
        "00000000000000000000000000000000" when (control="0111");

        zero<= '1' when (std_logic_vector(signed(entrada1)) = std_logic_vector(signed(entrada2)) and control="0110")else 
            '1' when (std_logic_vector(signed(entrada1)) = std_logic_vector(-signed(entrada2)) and control="0010")else 
            '1' when (control="0110")else 
            '0';
    
    
    
    end behavioral;