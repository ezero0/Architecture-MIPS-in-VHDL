library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sign_ext is 
    port(
        entrada16: in std_logic_vector(15 downto 0);
        salida32: out std_logic_vector(31 downto 0)
    );
end sign_ext;

architecture structural of sign_ext is
    begin
    ciclo:for i in 16 to 31 generate 
            salida32(i) <= entrada16(15);

    end generate ;
            salida32(15 downto 0) <= entrada16;
end structural; 