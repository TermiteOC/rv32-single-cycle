library IEEE;
use IEEE.std_logic_1164.all;

entity pc is
port ( i_CLK  : in std_logic;
		 i_D : in std_logic_vector(31 downto 0);
		 o_Q : out std_logic_vector(31 downto 0));
end pc;
	
architecture arch_pc of pc is
begin
  process(i_CLK)  										
  begin 
    if (rising_edge(i_CLK)) then
      o_Q <= i_D;
	 end if;
  end process;
end arch_pc;


