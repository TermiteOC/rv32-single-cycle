library ieee;
use ieee.std_logic_1164.all;
 
entity a_32bits is
port (i_A : in  std_logic_vector (31 downto 0);  -- entrada A
      o_A : out std_logic_vector (31 downto 0)); -- saída resultado a_32bits
end a_32bits;
 
architecture arq_1 of a_32bits is
begin
  o_A <= i_A;
end arq_1;
