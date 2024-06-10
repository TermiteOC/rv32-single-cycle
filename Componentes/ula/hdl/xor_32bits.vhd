library ieee;
use ieee.std_logic_1164.all;
 
entity xor_32bits is
port (i_A   : in  std_logic_vector (31 downto 0);  -- entrada A
	   i_B   : in  std_logic_vector (31 downto 0);  -- entrada B
      o_XOR : out std_logic_vector (31 downto 0)); -- saída resultado xor_32bits
end xor_32bits;
 
architecture arq_1 of xor_32bits is
begin
  o_XOR <= i_A xor i_B;
end arq_1;
