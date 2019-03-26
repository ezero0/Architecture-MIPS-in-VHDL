library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity control_unit_tb is
end control_unit_tb;

architecture behavioral of control_unit_tb is 
    component control_unit 
    port(
        
        op : in std_logic_vector(5 downto 0);
        RegDst, ALUSrc, MemToReg, RegWrite : out std_logic; 
        MemRead, MemWrite, Branch : out std_logic;
        ALUOp : out std_logic_vector(1 downto 0)
    );
    end component;

    signal s_op: std_logic_vector(5 downto 0);
    signal s_RegDst: std_logic;
    signal s_ALUSrc: std_logic;
    signal s_MemToReg: std_logic;
    signal s_RegWrite: std_logic;
    signal s_MemRead: std_logic;
    signal s_MemWrite: std_logic; 
    signal s_Branch: std_logic;
    signal s_aluop: std_logic_vector(1 downto 0);

    begin
        ctrl: control_unit
        port map(
            op => s_op,
            RegDst => s_RegDst,
            ALUSrc => s_ALUSrc,
            MemToReg => s_MemToReg,
            RegWrite => s_RegWrite,
            MemRead => s_MemRead,
            MemWrite => s_MemWrite, 
            Branch => s_Branch,
            aluop => s_aluop
        );
    process
        begin
            s_op <= "100011"; wait for 80 ns;

            s_op <= "011011"; wait for 80 ns;

            s_op <= "000100"; wait for 80 ns;

            s_op <= "000000"; wait for 80 ns;

            s_op <= "101011"; wait for 80 ns;
            wait;
    end process;
end behavioral;