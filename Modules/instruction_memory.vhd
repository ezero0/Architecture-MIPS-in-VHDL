library ieee;
use ieee.std_logic_1164.all;

entity instruction_memory is
  port (
    addr: in std_logic_vector(31 downto 0);
    instruction: out std_logic_vector(31 downto 0)
  ) ;
end instruction_memory;

architecture structural of instruction_memory is

  component dec5a32
    port (
      a: in std_logic_vector(4 downto 0);
      e: in std_logic;
      d: out std_logic_vector(31 downto 0)
    );
  end component dec5a32;
  
  signal dec_line: std_logic_vector(31 downto 0);

begin

  decoder5x32_u: dec5a32 port map(
    a => addr(6 downto 2),
    d => dec_line,
    e=> '1'
  );

--TODO: Make the generation of decoder lines automatically

  instruction(31) <= dec_line(0) or dec_line(1) or dec_line(16);
  instruction(30) <= '0';
  instruction(29) <= dec_line(16);
  instruction(28) <= dec_line(4) or dec_line(6) or dec_line(10) or
                     dec_line(15);
  instruction(27) <= dec_line(0) or dec_line(1) or dec_line(16);
  instruction(26) <= dec_line(0) or dec_line(1) or dec_line(16);
  instruction(25) <= dec_line(14);
  instruction(24) <= dec_line(7) or dec_line(8) or dec_line(9) or
                     dec_line(13);
  instruction(23) <= '0';
  instruction(22) <= dec_line(7) or dec_line(14);
  instruction(21) <= dec_line(8) or dec_line(10) or dec_line(15);

  instruction(20) <= dec_line(0) or dec_line(1) or dec_line(2) or 
                     dec_line(3) or dec_line(5) or dec_line(7) or dec_line(8) or dec_line(13) or dec_line(16);
  instruction(19) <= dec_line(9) or dec_line(11) or dec_line(12) or
                     dec_line(14);
  instruction(18) <= '0';
  instruction(17) <= dec_line(1) or dec_line(7) or dec_line(11) or 
                     dec_line(12) or dec_line(16);
  instruction(16) <= dec_line(0) or dec_line(2) or
                     dec_line(3) or dec_line(5) or dec_line(7) or
                     dec_line(8) or dec_line(9) or dec_line(13) or dec_line(16);
  instruction(15) <= dec_line(2) or dec_line(10) or dec_line(11) or 
                     dec_line(15);
  instruction(14) <= dec_line(3) or dec_line(5) or dec_line(7) or dec_line(8) or
                     dec_line(10) or dec_line(12) or dec_line(13) or
                     dec_line(15);
  instruction(13) <= dec_line(10) or dec_line(15);
  instruction(12) <= dec_line(2) or dec_line(7) or dec_line(10) or
                     dec_line(11) or dec_line(12) or dec_line(15);
  instruction(11) <= dec_line(2) or dec_line(5) or dec_line(8) or
                     dec_line(9) or dec_line(10) or dec_line(11) or
                     dec_line(14) or dec_line(15);
  instruction(10) <= dec_line(10) or dec_line(15);
  instruction( 9) <= dec_line(10) or dec_line(15);
  instruction( 8) <= dec_line(10) or dec_line(15);
  instruction( 7) <= dec_line(10) or dec_line(15);
  instruction( 6) <= dec_line(10) or dec_line(15);
  instruction( 5) <= dec_line(2) or dec_line(3) or dec_line(5) or
                     dec_line(7) or dec_line(8) or dec_line(9) or
                     dec_line(10) or dec_line(11) or dec_line(12) or
                     dec_line(13) or dec_line(14) or dec_line(15);
  instruction( 4) <= dec_line(10) or dec_line(15);
  instruction( 3) <= dec_line(4) or dec_line(9) or
                     dec_line(10) or dec_line(14) or dec_line(16);
  instruction( 2) <= dec_line(1) or dec_line(2) or dec_line(3) or
                     dec_line(5) or dec_line(10) or dec_line(11) or
                     dec_line(12) or dec_line(15);
  instruction( 1) <= dec_line(6) or dec_line(9) or dec_line(14);
  instruction( 0) <= dec_line(2) or dec_line(3) or dec_line(4) or dec_line(5) or
                     dec_line(11) or dec_line(15);

end structural ; -- structural