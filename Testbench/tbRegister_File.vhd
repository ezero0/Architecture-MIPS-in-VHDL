library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tbRegister_File is
end tbRegister_File;

architecture behavioral of tbRegister_File is 
    component Register_File
    port(
        RegWrite:in std_logic; --señal de control
    RR1: in std_logic_vector (4 downto 0); --numero de registro 1
    RR2: in std_logic_vector (4 downto 0); --numero de registro 2
    Write_Register: in std_logic_vector (4 downto 0); 
    Write_Data: in std_logic_vector (31 downto 0); --En el anterior numero guardar los 8 bytes de esta entrada
    RD1: out std_logic_vector (31 downto 0); --Salida de 32 bits.
    RD2: out std_logic_vector (31 downto 0)
    );
    end component;

    signal s_RR1: std_logic_vector(4 downto 0);
    signal s_RR2: std_logic_vector(4 downto 0);
    signal s_Write_Register: std_logic_vector(4 downto 0);
    signal s_RegWrite: std_logic;
   
    signal s_Write_Data: std_logic_vector(31 downto 0);
    signal s_RD1: std_logic_vector(31 downto 0);
    signal s_RD2: std_logic_vector(31 downto 0);

    begin
        rf: Register_File
        port map(
            RegWrite=>s_RegWrite,
            RR1=>s_RR1,
            RR2=>s_RR2,
            Write_Register=>s_Write_register,
            Write_Data=>s_Write_Data,
            RD1=>s_RD1,
            RD2=>s_RD2
        );
    process
        begin
            s_RegWrite <= '0';
            wait for 2 ns;
            s_RegWrite <= '1';
            s_RR1<="01000";
            s_RR2<="00010";
            s_Write_Register<="00010";
            s_Write_Data<="11111111111111111111111111111111";
            wait for 8 ns;
            s_RegWrite<='0';
            wait for 2 ns;
            s_RegWrite <= '1';
            s_RR1<="01000";
            s_RR2<="00010";
            s_Write_Register<="01000";
            s_Write_Data<="00000000111111111111111111111111";
            wait for 8 ns;
            
            wait;
    end process;
end behavioral;