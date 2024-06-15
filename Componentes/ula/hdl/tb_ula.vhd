library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ula is
end tb_ula;

architecture arq_1 of tb_ula is
  -- Componente DUT
  component ula is
  port ( i_A    : in  std_logic_vector (31 downto 0);  -- entrada A
         i_B    : in  std_logic_vector (31 downto 0);  -- entrada B
         i_SEL  : in  std_logic_vector (3  downto 0);  -- seletor de operação
		     o_ZERO : out std_logic;                       -- saída flag zero
         o_ULA  : out std_logic_vector (31 downto 0)); -- saída resultado
  end component;

  signal w_Z           : std_logic;
  signal w_S           : std_logic_vector (3  downto 0);
  signal w_A, w_B, w_U : std_logic_vector (31 downto 0);

begin
  -- Conectando DUT
  u_DUT: ula port map ( i_A    => w_A,
                        i_B    => w_B,
                        i_SEL  => w_S,
                        o_ZERO => w_Z,
                        o_ULA  => w_U);
				
  -- Processo de estimulação
  process
  begin
    w_A <= "00000000000000000000000000000000";
    w_B <= "00000000000000000000000000000000";
	  w_S <= "0000"; -- and e teste zero
    wait for 1 ns;
	  assert(w_Z = '1' and w_U = "00000000000000000000000000000000")
	  report "Fail @ 000" severity error;

	  w_A <= "00000000000000000000000000001101";
    w_B <= "00000000000000000000000000000111";
	  w_S <= "0000"; -- and
    wait for 1 ns;
	  assert(w_Z = '0' and w_U = "00000000000000000000000000000101")
	  report "Fail @ 001" severity error;
	 
	  w_A <= "00000000000000000000000000001101";
    w_B <= "00000000000000000000000000000111";
	  w_S <= "0001"; -- or
    wait for 1 ns;
	  assert(w_Z = '0' and w_U = "00000000000000000000000000001111")
	  report "Fail @ 002" severity error;
	
	  w_A <= "00000000000000000000000000000111";
    w_B <= "00000000000000000000000000000011";
	  w_S <= "0010"; -- soma
    wait for 1 ns;
	  assert(w_Z = '0' and w_U = "00000000000000000000000000001010")
	  report "Fail @ 003" severity error;
	 
	  w_A <= "00000000000000000000000000000111";
    w_B <= "00000000000000000000000000000011";
	  w_S <= "0110"; -- subtração 
    wait for 1 ns;
	  assert(w_Z = '0' and w_U = "00000000000000000000000000000100")
	  report "Fail @ 004" severity error;
	 
	  w_A <= "00000000000000000000000000000111";
    w_B <= "00000000000000000000000000000011";
	  w_S <= "0111"; -- set less than
    wait for 1 ns;
	  assert(w_Z = '1' and w_U = "00000000000000000000000000000000")
	  report "Fail @ 005" severity error;
    
    w_A <= "00000000000000000000000000000000";
    w_B <= "00000000000000000000000000000011";
	  w_S <= "0111"; -- set less than
    wait for 1 ns;
	  assert(w_Z = '0' and w_U = "00000000000000000000000000000001")
	  report "Fail @ 006" severity error;
	 
	  w_A <= "11111111111111110000111100001100";
    w_B <= "11111111111111110000000011111100";
	  w_S <= "1100"; -- nor
    wait for 1 ns;
	  assert(w_Z = '0' and w_U = "00000000000000001111000000000011")
	  report "Fail @ 007" severity error;
	 
	  -- Clear Inputs
    w_A <= ( others => '0');
	  w_B <= ( others => '0');
	  w_S <= "0000";
    assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arq_1;
