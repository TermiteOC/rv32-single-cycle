library IEEE;
use IEEE.std_logic_1164.all;

entity meio_somador_1bit is
port ( i_A            : in  std_logic;  -- entrada A
       i_B            : in  std_logic;  -- entrada B
       o_MEIO_SOMADOR : out std_logic;  -- saída resultado meio_somador_1bit
       o_COUT         : out std_logic); -- saída carry out
end meio_somador_1bit;

architecture arq_1 of meio_somador_1bit is
begin
  o_MEIO_SOMADOR <= i_A xor i_B;
  o_COUT         <= i_A and i_B;
end arq_1;
