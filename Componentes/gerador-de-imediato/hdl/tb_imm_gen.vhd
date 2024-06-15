library IEEE;
use IEEE.std_logic_1164.all;

entity tb_imm_gen is
end tb_imm_gen;

architecture arch_1 of tb_imm_gen is
  -- Declaracao de Componentes
  component imm_gen is
  port ( i_INST : in  std_logic_vector(31 downto 0);
         o_IMM  : out std_logic_vector(31 downto 0));
  end component;
  
  -- Declaracao de Sinais
  signal w_INST, w_IMM : std_logic_vector(31 downto 0);
  constant c_PERIOD    : time := 1 ns ;
  
begin
  -- Instancias de Componentes
  u_DUV: imm_gen port map ( i_INST => w_INST,
                            o_IMM  => w_IMM);
  
  process
  begin
	  -- Formato I. Imediato = 3
    w_INST <= "00000000001100000000000000010011";
    wait for 1 ns;
	  assert(w_IMM = "00000000000000000000000000000011")
	  report "Fail @ 000" severity error;
		
    -- Formato I. Imediato = -5
	  w_INST <= "11111111101100000000000000010011";
	  wait for 1 ns;
	  assert(w_IMM = "11111111111111111111111111111011")
	  report "Fail @ 001" severity error;
		
	  -- Formato S. Imediato = 9
	  w_INST <= "00000001111111111111010010100011";
	  wait for 1 ns;
	  assert(w_IMM = "00000000000000000000000000001001")
	  report "Fail @ 002" severity error;
		
	  -- Formato B. Imediato = -1. Deslocado para a esquerda. -2 resultado
	  w_INST <= "11111110000000000000111111100011";
	  wait for 1 ns;
	  assert(w_IMM = "11111111111111111111111111111110")
	  report "Fail @ 003" severity error;
		
	  -- Formato U. Imediato = 11 deslocado para a esquerda 12x.
	  w_INST <= "00000000000000001011000000110111";
	  wait for 1 ns;
	  assert(w_IMM = "00000000000000001011000000000000")
	  report "Fail @ 004" severity error;
		
	  -- Formato U. Imediato = -1 deslocado para a esquerda 12x.
	  w_INST <= "11111111111111111111000000010111";
	  wait for 1 ns;
	  assert(w_IMM = "11111111111111111111000000000000")
	  report "Fail @ 005" severity error;
		
	  -- Clear Inputs
    w_INST <= "00000000000000000000000000000000";
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;