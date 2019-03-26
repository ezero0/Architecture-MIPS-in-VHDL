library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity instruction_memorytb is
end instruction_memorytb;

architecture mixed of instruction_memorytb is

  component instruction_memory
    port (
      addr: in std_logic_vector(31 downto 0);
      instruction: out std_logic_vector(31 downto 0)
    ) ;
  end component instruction_memory;

  signal s_addr: std_logic_vector(31 downto 0);
  signal s_instruction: std_logic_vector(31 downto 0);

begin

  rom: instruction_memory port map(
    addr => s_addr,
    instruction => s_instruction
  );

  stimuli : process
  begin
    for i in 0 to 31 loop
      s_addr <= std_logic_vector(to_unsigned(4*i, s_addr'length));
      wait for 1 ns;
    end loop;
    wait;
  end process stimuli; -- stimuli

end mixed ; -- mixed