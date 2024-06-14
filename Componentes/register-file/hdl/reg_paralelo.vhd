library IEEE;
use IEEE.std_logic_1164.all;

entity reg_paralelo is
port ( i_CLK : in  std_logic;   					      -- clock
       i_LD  : in  std_logic;   						   -- load
		 i_A   : in  std_logic_vector(31 downto 0);  -- data input
       o_S   : out std_logic_vector(31 downto 0)); -- data output
end reg_paralelo;

architecture arch_1 of reg_paralelo is
begin
  process(i_CLK,i_LD) 
  begin
    if (rising_edge(i_CLK)) then
      if (i_LD = '1') then
        o_S <= i_A;
      end if;
    end if;
  end process;
end arch_1;