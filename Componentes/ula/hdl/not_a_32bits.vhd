library IEEE;
use IEEE.std_logic_1164.all;
 
entity not_a_32bits is
port ( i_A     : in  std_logic_vector (31 downto 0);  -- entrada A
       o_NOT_A : out std_logic_vector (31 downto 0)); -- saída resultado
end not_a_32bits;
 
architecture arq_1 of not_a_32bits is
begin
  o_NOT_A <= not i_A;
end arq_1;
