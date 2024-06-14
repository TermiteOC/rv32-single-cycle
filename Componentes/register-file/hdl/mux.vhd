library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
port ( i_SEL : in  std_logic; 
       i_A	 : in  std_logic_vector(31 downto 0); 
	    i_B	 : in  std_logic_vector(31 downto 0); 
       o_OUT : out std_logic_vector(31 downto 0));
end mux;

architecture arq1 of mux is
begin
  process(i_SEL, i_A, i_B)
  begin
    if (i_SEL='0') then
      o_OUT <= i_A;
    else
      o_OUT <= i_B;
    end if;
  end process;
end arq1;