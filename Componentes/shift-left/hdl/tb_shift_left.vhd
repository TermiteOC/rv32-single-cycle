library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_shift_left is
end entity tb_shift_left;

architecture behavioral of tb_shift_left is
  -- Declaração de DUV
  component shift_left is
  port ( i_DATA   : in  std_logic_vector(31 downto 0);
         o_RESULT : out std_logic_vector(31 downto 0));
  end component;

  -- Declaração de Sinais
  signal w_DATA   : std_logic_vector(31 downto 0);
  signal w_RESULT : std_logic_vector(31 downto 0);

begin
  -- Conectando DUV
  u_DUV: shift_left port map ( i_DATA   => w_DATA,
                               o_RESULT => w_RESULT);

  -- Processo de Estímulo
  process
  begin
    w_DATA <= "00000000000000000000000000000001";
    wait for 1 ns;
    assert (w_RESULT = "00000000000000000000000000000010")
    report "Fail @ 001" severity error;

    w_DATA <= "10000000000000000000000000000000";
    wait for 1 ns;
    assert (w_RESULT = "00000000000000000000000000000000")
    report "Fail @ 002" severity error;

    w_DATA <= "11111111111111111111111111111111";
    wait for 1 ns;
    assert (w_RESULT = "11111111111111111111111111111110")
    report "Fail @ 003" severity error;
	 
	  -- Clear Inputs
	  w_DATA <= (others => '0');
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end behavioral;
