library ieee;
use ieee.std_logic_1164.all;

entity seletor_ula_3bits is
port (i_SOMA      : in  std_logic_vector (31 downto 0);  -- entrada resultado soma
      i_SUBTRAI   : in  std_logic_vector (31 downto 0);  -- entrada resultado subtração
      i_A_MAIS_UM : in  std_logic_vector (31 downto 0);  -- entrada resultado A+1
      i_A         : in  std_logic_vector (31 downto 0);  -- entrada resultado A
      i_AND       : in  std_logic_vector (31 downto 0);  -- entrada resultado and
      i_OR        : in  std_logic_vector (31 downto 0);  -- entrada resultado or
      i_XOR       : in  std_logic_vector (31 downto 0);  -- entrada resultado xor
      i_NOT_A     : in  std_logic_vector (31 downto 0);  -- entrada resultado not A
	   i_SELETOR   : in  std_logic_vector (2  downto 0);  -- entrada seletor
      o_RESULTADO : out std_logic_vector (31 downto 0)); -- saída resultado
end seletor_ula_3bits;

architecture arq_1 of seletor_ula_3bits is
begin
  process (i_SOMA, i_SUBTRAI, i_A_MAIS_UM, i_A, i_AND, i_OR, i_XOR, i_NOT_A, i_SELETOR)
  begin
    case i_SELETOR is
      when "000" =>
        o_RESULTADO <= i_SOMA;
      when "001" =>
        o_RESULTADO <= i_SUBTRAI;
      when "010" =>
        o_RESULTADO <= i_A_MAIS_UM;
      when "011" =>
        o_RESULTADO <= i_A;
      when "100" =>
        o_RESULTADO <= i_AND;
      when "101" =>
        o_RESULTADO <= i_OR;
      when "110" =>
        o_RESULTADO <= i_XOR;
      when "111" =>
        o_RESULTADO <= i_NOT_A;
      when others =>
      	o_RESULTADO <= i_A;
      end case;
  end process;
end arq_1;
