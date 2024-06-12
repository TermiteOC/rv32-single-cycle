library IEEE;
use IEEE.std_logic_1164.all;
 
entity somador_completo_1bit is
port ( i_A                : in  std_logic;  -- entrada A
	    i_B                : in  std_logic;  -- entrada B
       i_CIN              : in  std_logic;  -- entrada carry in
       o_COUT             : out std_logic;  -- saída carry out
       o_SOMADOR_COMPLETO : out std_logic); -- saída resultado
end somador_completo_1bit;
 
architecture arq_1 of somador_completo_1bit is
begin
  o_SOMADOR_COMPLETO <= i_A xor i_B xor i_CIN;
  o_COUT             <= (i_A and i_B) or (i_CIN and i_A) OR (i_CIN and i_B);
end arq_1;
