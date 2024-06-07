library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is

end testbench;

architecture arch_1 of testbench is

  -- Declaracao de Componentes
  component instruction_memory is
  port ( i_CLK    : in  std_logic;
		   i_ADDR   : in  std_logic_vector(31 downto 0);
		   o_OUT    : out std_logic_vector(31 downto 0));
  end component;
  
  -- Declaracao de Sinais
  signal w_CLK      : std_logic := '0';
  signal w_ADDR     : std_logic_vector(31 downto 0);
  signal w_OUT      : std_logic_vector(31 downto 0);
  constant c_PERIOD : time := 1 ns ;
  
begin
  -- Instancias de Componentes
  u_DUV: instruction_memory port map ( i_CLK  => w_CLK,
												   i_ADDR => w_ADDR,
													o_OUT  => w_OUT);
							  
  -- Geracao de Sistemas de Sinais
  w_CLK   <= not w_CLK after c_PERIOD /2;
  
  process
    begin
      w_ADDR <= "00000000000000000000000000000001";
		assert (w_ADDR = "00000000000000000000000000000100")
		report "Fail @ 1" severity error;
		wait for 1 ns;
		
		w_ADDR   <= "00000000000000000000000000000011";
		assert (w_ADDR = "00000000000000000000000000001100")
		report "Fail @ 2" severity error;
		wait for 1 ns;
		
		w_ADDR   <= "00000000000000000000000000000100";
		assert (w_ADDR = "00000000000000000000000000010000")
		report "Fail @ 3" severity error;
		wait for 1 ns;
		
		-- Clear Inputs
      w_ADDR <= ( others => '0');
      wait;
  end process;
end arch_1;