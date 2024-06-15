library IEEE;
use IEEE.std_logic_1164.all;

entity tb_instruction_memory is
end tb_instruction_memory;

architecture arch_1 of tb_instruction_memory is
  -- Declaracao de Componentes
  component instruction_memory is
  port ( i_ADDR : in  std_logic_vector (31 downto 0);
         o_OUT  : out std_logic_vector (31 downto 0));
  end component;
  
  -- Declaracao de Sinais
  signal w_ADDR     : std_logic_vector(31 downto 0);
  signal w_OUT      : std_logic_vector(31 downto 0);
  constant c_PERIOD : time := 1 ns ;
  
begin
  -- Instancias de Componentes
  u_DUV: instruction_memory port map ( i_ADDR => w_ADDR,
													             o_OUT  => w_OUT);
													 
  process
  begin
    w_ADDR <= "00000000000000000000000000000000";
    wait for 1 ns;
	  assert (w_OUT = "00000000010000000000010010010011")
	  report "Fail @ 1" severity error;
		
	  w_ADDR <= "00000000000000000000000000000001";
	  wait for 1 ns;
	  assert (w_OUT = "00000000001100000000100100010011")
	  report "Fail @ 2" severity error;
		
	  w_ADDR <= "00000000000000000000000000000010";
	  wait for 1 ns;
	  assert (w_OUT = "00000000001000000000100110010011")
	  report "Fail @ 3" severity error;
		
	  w_ADDR <= "00000000000000000000000000000011";
	  wait for 1 ns;
	  assert (w_OUT = "00000000000100000000101000010011")
	  report "Fail @ 4" severity error;
		
	  w_ADDR <= "00000000000000000000000000000100";
	  wait for 1 ns;
	  assert (w_OUT = "00000001001001001000001010110011")
	  report "Fail @ 5" severity error;
		
	  w_ADDR <= "00000000000000000000000000000101";
	  wait for 1 ns;
	  assert (w_OUT = "00000001010010011000001100110011")
	  report "Fail @ 6" severity error;
		
	  w_ADDR <= "00000000000000000000000000000110";
	  wait for 1 ns;
	  assert (w_OUT = "01000000011000101000010000110011")
	  report "Fail @ 7" severity error;
		
	  -- Clear Inputs
    w_ADDR <= ( others => '0');
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;