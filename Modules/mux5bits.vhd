library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux5bits is
    port (
        entrada1: in std_logic_vector(4 downto 0);
        entrada2: in std_logic_vector(4 downto 0);
        sel: in std_logic;
        salida: out std_logic_vector(4 downto 0)
    );
end mux5bits;

architecture behavioral of mux5bits is
    begin
        process(entrada1,entrada2,sel)
            begin
        if sel = '0' then  
            salida <= entrada1;
        end if;
        if sel = '1' then  
            salida <= entrada2;
        end if ;
    end process;
end behavioral;