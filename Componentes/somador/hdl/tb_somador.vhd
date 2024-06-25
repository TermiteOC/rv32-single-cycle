library IEEE;
use IEEE.std_logic_1164.all;

entity tb_somador is
end tb_somador;

architecture arch_1 of tb_somador is
  -- Declaracao de DUV
  component somador is
  port ( i_A   : in  std_logic_vector(31 downto 0);  -- entrada A
         i_B   : in  std_logic_vector(31 downto 0);  -- entrada B
         o_OUT : out std_logic_vector(31 downto 0)); -- saída resultado
  end component;
  
  -- Declaracao de Sinais
  signal w_A, w_B : std_logic_vector(31 downto 0);
  signal w_OUT    : std_logic_vector(31 downto 0);
  
begin
  -- Conectando DUV
  u_DUV: somador port map ( i_A   => w_A,
                            i_B   => w_B,
                            o_OUT => w_OUT);
                        
  process
  begin
    w_A <= "00000000000000000000000000000111"; 
    w_B <= "00000000000000000000000000000111";
    wait for 1 ns; -- 7 + 7
	  assert (w_OUT = "00000000000000000000000000001110")
	  report "Fail @ 001" severity error;
		
	  w_A <= "11111111111111111111111111111111";
    w_B <= "11111111111111111111111111111111";
	  wait for 1 ns; -- 4294967295 + 4294967295
	  assert (w_OUT = "11111111111111111111111111111110")
	  report "Fail @ 002" severity error;
		
	  w_A <= "11111111111111111111111111110111";
    w_B <= "00000000000000000000000000000011";
	  wait for 1 ns; -- -9 + 3
	  assert (w_OUT = "11111111111111111111111111111010")
	  report "Fail @ 003" severity error;

	  -- Clear Inputs
	  w_A <= "00000000000000000000000000000000";
    w_B <= "00000000000000000000000000000000";
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;