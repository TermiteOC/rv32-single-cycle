library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity in_imm_gen is
port ( i_INST : in  std_logic_vector(31 downto 0);
       o_IMM  : out std_logic_vector(31 downto 0));
end in_imm_gen;

architecture arch_1 of in_imm_gen is
begin
  process(i_INST)
  begin
    -- Tipo I
    if i_INST(6 downto 0) = "0010011" then 
      o_IMM(31 downto 12) <= (others => i_INST(31));
      o_IMM(11 downto 0)  <= i_INST(31 downto 20);
    -- Tipo S
    elsif i_INST(6 downto 0) = "0100011" then
      o_IMM(31 downto 12) <= (others => i_INST(31));
      o_IMM(11 downto 0)  <= i_INST(31 downto 25) & i_INST(11 downto 7);
    -- Tipo B
    elsif i_INST(6 downto 0) = "1100011" then
      o_IMM(31 downto 13) <= (others => i_INST(31));
      o_IMM(12 downto 1)  <= i_INST(31) & i_INST(7) & i_INST(30 downto 25) & i_INST(11 downto 8);
      o_IMM(0)            <= '0';
    -- Tipo U
    elsif i_INST(6 downto 0) = "0110111" or i_INST(6 downto 0) = "0010111" then
      o_IMM(31 downto 12) <= i_INST(31 downto 12);
      o_IMM(11 downto 0)  <= (others => '0');
    else
      o_IMM <= (others => '0');
    end if;
  end process;
end arch_1;