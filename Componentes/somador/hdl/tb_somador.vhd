library IEEE;
use IEEE.std_logic_1164.all;

entity tb_somador is
end tb_somador;

architecture arch_1 of tb_somador is
  -- Declaracao de DUV
  component somador_completo_32bits is
  port ( i_A                : in  std_logic_vector (31 downto 0);
         i_B                : in  std_logic_vector (31 downto 0);
         i_CIN              : in  std_logic;
         o_COUT             : out std_logic;
         o_SOMADOR_COMPLETO : out std_logic_vector (31 downto 0));
  end component;
  
  -- Declaracao de Sinais
  signal w_A, w_B      : std_logic_vector(31 downto 0);
  signal w_CIN, w_COUT : std_logic;
  signal w_S           : std_logic_vector(31 downto 0);
  
begin
  -- Conectando DUV
  u_DUV: somador_completo_32bits port map ( i_A                => w_A,
                                            i_B                => w_B,
                                            i_CIN              => w_CIN,
                                            o_COUT             => w_COUT,
                                            o_SOMADOR_COMPLETO => w_S);
                        
  process
  begin
    w_A   <= "00000000000000000000000000000111"; 
    w_B   <= "00000000000000000000000000000111";
    w_CIN <= '0';
    wait for 1 ns; -- 7 + 7
	  assert (w_COUT = '0' and w_S = "00000000000000000000000000001110")
	  report "Fail @ 001" severity error;
		
	  w_A   <= "11111111111111111111111111111111";
    w_B   <= "11111111111111111111111111111111";
    w_CIN <= '0';
	  wait for 1 ns; -- 4294967295 + 4294967295
	  assert (w_COUT = '1' and w_S = "11111111111111111111111111111110")
	  report "Fail @ 002" severity error;
		
	  w_A   <= "11111111111111111111111111110111";
    w_B   <= "00000000000000000000000000000011";
    w_CIN <= '0'; -- -9 + 3
	  wait for 1 ns;
	  assert (w_COUT = '0' and w_S = "11111111111111111111111111111010")
	  report "Fail @ 003" severity error;

	  -- Clear Inputs
	  w_A   <= "00000000000000000000000000000000";
    w_B   <= "00000000000000000000000000000000";
    w_CIN <= '0';
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;