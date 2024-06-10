library ieee;
use ieee.std_logic_1164.all;
 
entity complemento_32bits is
port (i_B        : in  std_logic_vector (31 downto 0);  -- entrada B
	   i_SUBTRAIR : in  std_logic;                       -- entrada subtrair
      o_B        : out std_logic_vector (31 downto 0)); -- saída resultado complemento_32bits
end complemento_32bits;
 
architecture arq_1 of complemento_32bits is
begin
  o_B(0)  <= i_B(0) xor i_SUBTRAIR;
  o_B(1)  <= i_B(1) xor i_SUBTRAIR;
  o_B(2)  <= i_B(2) xor i_SUBTRAIR;
  o_B(3)  <= i_B(3) xor i_SUBTRAIR;
  o_B(4)  <= i_B(4) xor i_SUBTRAIR;
  o_B(5)  <= i_B(5) xor i_SUBTRAIR;
  o_B(6)  <= i_B(6) xor i_SUBTRAIR;
  o_B(7)  <= i_B(7) xor i_SUBTRAIR;
  o_B(8)  <= i_B(8) xor i_SUBTRAIR;
  o_B(9)  <= i_B(9) xor i_SUBTRAIR;
  o_B(10) <= i_B(10) xor i_SUBTRAIR;
  o_B(11) <= i_B(11) xor i_SUBTRAIR;
  o_B(12) <= i_B(12) xor i_SUBTRAIR;
  o_B(13) <= i_B(13) xor i_SUBTRAIR;
  o_B(14) <= i_B(14) xor i_SUBTRAIR;
  o_B(15) <= i_B(15) xor i_SUBTRAIR;
  o_B(16) <= i_B(16) xor i_SUBTRAIR;
  o_B(17) <= i_B(17) xor i_SUBTRAIR;
  o_B(18) <= i_B(18) xor i_SUBTRAIR;
  o_B(19) <= i_B(19) xor i_SUBTRAIR;
  o_B(20) <= i_B(20) xor i_SUBTRAIR;
  o_B(21) <= i_B(21) xor i_SUBTRAIR;
  o_B(22) <= i_B(22) xor i_SUBTRAIR;
  o_B(23) <= i_B(23) xor i_SUBTRAIR;
  o_B(24) <= i_B(24) xor i_SUBTRAIR;
  o_B(25) <= i_B(25) xor i_SUBTRAIR;
  o_B(26) <= i_B(26) xor i_SUBTRAIR;
  o_B(27) <= i_B(27) xor i_SUBTRAIR;
  o_B(28) <= i_B(28) xor i_SUBTRAIR;
  o_B(29) <= i_B(29) xor i_SUBTRAIR;
  o_B(30) <= i_B(30) xor i_SUBTRAIR;
  o_B(31) <= i_B(31) xor i_SUBTRAIR;
end arq_1;
