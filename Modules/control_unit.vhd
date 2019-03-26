
--Unidad de control MIPS
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity control_unit is
    port(
        op : in std_logic_vector(5 downto 0);
        RegDst:out std_logic; 
        ALUSrc:out std_logic; 
        MemToReg:out std_logic; 
        RegWrite : out std_logic; 
        MemRead, MemWrite, Branch : out std_logic;
        ALUOp : out std_logic_vector(1 downto 0)
    );
end control_unit;  

architecture Estructura of control_unit is 
    signal ctrl_word: std_logic_vector(8 downto 0);
    begin
       
        ctrl_word <= "100100010" when op = "000000" else --instrucciones Type-R
                     "011110000" when op = "100011" else --lw  :0x23
                     "X1X001000" when op = "101011" else --sw  :0x2B
                     "X0X000101" when op = "000100" else --beq :0x04
                     "000000000";
        RegDst <= ctrl_word(8);
        ALUSrc <= ctrl_word(7);
        MemToReg <= ctrl_word(6);
        RegWrite <= ctrl_word(5);
        MemRead <= ctrl_word(4);
        MemWrite <= ctrl_word(3);
        Branch <= ctrl_word(2);
        ALUOp <= ctrl_word(1 downto 0);
   
end Estructura;