library ieee;
use ieee.std_logic_1164.all;

entity reg_32bit is
port (
  i_CLR_n : in  std_logic;                   -- clear/reset
  i_CLK   : in  std_logic;                   -- clock
  i_LOAD  : in  std_logic;                   -- load enable
  i_D     : in  std_logic_vector(31 downto 0);  -- data input (32 bits)
  o_Q     : out std_logic_vector(31 downto 0)   -- data output (32 bits)
);
end reg_32bit;

architecture arch_1 of reg_32bit is
begin
  process(i_CLR_n, i_CLK) 
  begin
    if (i_CLR_n = '0') then
      o_Q <= (others => '0');
    elsif (rising_edge(i_CLK)) then
      if (i_LOAD = '1') then
        o_Q <= i_D;
      end if;
    end if;
  end process;
end arch_1;
