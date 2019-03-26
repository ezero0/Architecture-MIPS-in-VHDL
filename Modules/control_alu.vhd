library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity control_alu is 
    port(
        ALUOp: in std_logic_vector(1 downto 0);
        FuncCode: in std_logic_vector(5 downto 0); 
        ALUCtl: out std_logic_vector(3 downto 0)
    );
end control_alu;

architecture estructural of control_alu is
    begin
    ALUCtl <= "0010" when ALUOp(1) = '0' and ALUOp(0) = '0' else
    "0110" when ALUOp(1) = '0' and ALUOp(0) = '1' else
    "0010" when ALUOp(1) = '1' and ALUOp(0) = '0' and FuncCode(3) = '0' and FuncCode(2) = '0' and FuncCode(1) = '0' and FuncCode(0) = '0' else
    "0110" when ALUOp(1) = '1' and FuncCode(3) = '0' and FuncCode(2) = '0' and FuncCode(1) = '1' and FuncCode(0) = '0' else
    "0000" when ALUOp(1) = '1' and ALUOp(0) = '0' and FuncCode(3) = '0' and FuncCode(2) = '1' and FuncCode(1) = '0' and FuncCode(0) = '0' else
    "0001" when ALUOp(1) = '1' and ALUOp(0) = '0' and FuncCode(3) = '0' and FuncCode(2) = '1' and FuncCode(1) = '0' and FuncCode(0) = '1' else
    "0111" when ALUOp(1) = '1' and FuncCode(3) = '1' and FuncCode(2) = '0' and FuncCode(1) = '1' and FuncCode(0) = '0';

end estructural;