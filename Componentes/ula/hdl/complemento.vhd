library IEEE;
use IEEE.std_logic_1164.all;

entity complemento_32bits is
port ( i_B        : in  std_logic_vector(31 downto 0);  -- entrada B
       i_SUBTRAIR : in  std_logic;                      -- entrada subtrair
       o_B        : out std_logic_vector(31 downto 0)); -- saída resultado complemento_32bits
end complemento_32bits;

architecture arq_1 of complemento_32bits is
begin
  process(i_B, i_SUBTRAIR)
  begin
    for i in 0 to 31 loop
      o_B(i) <= i_B(i) xor i_SUBTRAIR;
    end loop;
  end process;
end arq_1;