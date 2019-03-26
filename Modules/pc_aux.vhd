library ieee;
use ieee.std_logic_1164.all;

entity pc_aux is
    generic(n: integer);
    port(
        data_in: in std_logic_vector(31 downto 0);
        e: in std_logic;
        clk: in std_logic;
        data_out: out std_logic_vector(31 downto 0);
        reset: in std_logic
    );   
end pc_aux;

architecture behavioral of pc_aux is
    begin 
    process(clk)
    begin
        if clk'event and clk='1' then 
            if (reset = '1' )then 
               data_out <= (others => '0');  
            elsif e='1' then
                data_out <= data_in;
            end if;
        end if;
    end process;
     
end behavioral;