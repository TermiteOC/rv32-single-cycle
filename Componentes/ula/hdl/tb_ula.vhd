library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ula is
end tb_ula;

architecture arq_1 of tb_ula is

  -- Componente DUT
  component ula_32bits is
  port ( i_A    : in  std_logic_vector (31 downto 0);  -- entrada A
         i_B    : in  std_logic_vector (31 downto 0);  -- entrada B
         i_SEL  : in  std_logic_vector (2  downto 0);  -- seletor de operação
		   o_ZERO : out std_logic;                       -- saída flag zero
         o_ULA  : out std_logic_vector (31 downto 0)); -- saída resultado
  end component;

  signal w_z           : std_logic := '1';
  signal w_S           : std_logic_vector (2  downto 0) := "000" ;
  signal w_A, w_B, w_U : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";

begin
  -- Conectando DUT
  u_DUT: ula_32bits
  port map (i_A    => w_A,
				i_B    => w_B,
				i_SEL  => w_S,
				o_ZERO => w_z,
				o_ULA  => w_U);
				
  -- Processo de estimulação
  process
  begin
    w_A <= "00000000000000000000000000000000";
    w_B <= "00000000000000000000000000000000";
	 w_S <= "000"; -- soma e teste zero
    wait for 10 ns;
	 assert(w_Z = '1' and w_U = "00000000000000000000000000000000")
	 report "Erro saída zero" severity error;

	 w_A <= "00000000000000000000000000000001";
    w_B <= "00000000000000000000000000000011";
	 w_S <= "000"; -- soma
    wait for 10 ns;
	 assert(w_Z = '0' and w_U = "00000000000000000000000000000100")
	 report "Erro soma" severity error;
	 
	 w_A <= "00000000000000000000000000000100";
    w_B <= "00000000000000000000000000000011";
	 w_S <= "001"; -- subtrai
    wait for 10 ns;
	 assert(w_Z = '0' and w_U = "00000000000000000000000000000001")
	 report "Erro subtração" severity error;
	
	 w_A <= "00000000000000000000000000000100";
    w_B <= "00000000000000000000010000000000";
	 w_S <= "010"; -- a mais um
    wait for 10 ns;
	 assert(w_Z = '0' and w_U = "00000000000000000000000000000101")
	 report "Erro a mais um" severity error;
	 
	 w_A <= "00000000000000000000000000000111";
    w_B <= "00000000000000000000010000000000";
	 w_S <= "011"; -- a 
    wait for 10 ns;
	 assert(w_Z = '0' and w_U = "00000000000000000000000000000111")
	 report "Erro a" severity error;
	 
	 w_A <= "00000000000000000000000000000111";
    w_B <= "00000000000000000000000000000011";
	 w_S <= "100"; -- and
    wait for 10 ns;
	 assert(w_Z = '0' and w_U = "00000000000000000000000000000011")
	 report "Erro and" severity error;
	 
	 w_A <= "00000000000000000000000000000111";
    w_B <= "00000000000000000000000000001011";
	 w_S <= "101"; -- or
    wait for 10 ns;
	 assert(w_Z = '0' and w_U = "00000000000000000000000000001111")
	 report "Erro or" severity error;
	 
	 w_A <= "00000000000000000000000000000111";
    w_B <= "00000000000000000000000000001011";
	 w_S <= "110"; -- xor
    wait for 10 ns;
	 assert(w_Z = '0' and w_U = "00000000000000000000000000001100")
	 report "Erro xor" severity error;
	 
	 w_A <= "11111111111111111111111111111111";
    w_B <= "00000000000000000000000111111111";
	 w_S <= "111"; -- not a
    wait for 10 ns;
	 assert(w_Z = '1' and w_U = "00000000000000000000000000000000")
	 report "Erro not a" severity error;
	 
	 -- Clear Inputs
    w_A <= ( others => '0');
	 w_B <= ( others => '0');
	 w_S <= "000";
    assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arq_1;
