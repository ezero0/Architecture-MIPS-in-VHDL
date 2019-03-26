library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity control_alutb is
end control_alutb;

architecture behavioral of control_alutb is 
    component control_alu 
    port(
        ALUOp: in std_logic_vector(1 downto 0);
        FuncCode: in std_logic_vector(5 downto 0); 
        ALUCtl: out std_logic_vector(3 downto 0)
    );
    end component;

    signal s_ap: std_logic_vector(1 downto 0);
    signal s_f: std_logic_vector(5 downto 0);
    signal s_a: std_logic_vector(3 downto 0);
    
    

    begin
        prueba: control_alu
        port map(
            ALUOp=>s_ap,
            FuncCode=>s_f,
            ALUCtl=>s_a);

    process
        begin
            s_ap <= "00"; 
            s_f<="000000"; 
            wait for 10 ns;
            s_f<="000001" ;
            wait for 10 ns;
            s_ap <= "01"; 
            s_f<="000000"; 
            wait for 10 ns;
            s_ap <= "10"; 
            s_f<="100000"; 
            wait for 10 ns;
            s_f<="100010"; 
            wait for 10 ns;
            s_f<="100100"; 
            wait for 10 ns;
            s_f<="100101"; 
            wait for 10 ns;
            s_f<="101010"; 
            wait for 10 ns;
            wait;
    end process;
end behavioral;