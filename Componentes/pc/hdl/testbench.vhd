library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is

end testbench;

architecture arch_1 of testbench is
  -- Declaracao de Componentes
  component pc is
  port ( i_CLK  : in  std_logic;
		 i_D    : in  std_logic_vector(31 downto 0);
		 o_Q    : out std_logic_vector(31 downto 0));
  end component;
  
  -- Declaracao de Sinais
  signal w_CLK : std_logic := '0';
  signal w_D   : std_logic_vector(31 downto 0);
  signal w_Q   : std_logic_vector(31 downto 0);
  constant c_PERIOD : time := 1 ns ;
  
begin
  -- Instancias de Componentes
  u_DUV: pc port map ( i_CLK => w_CLK,
                       i_D   => w_D,
                       o_Q   => w_Q);
							  
  -- Geracao de Sistemas de Sinais
  w_CLK   <= not w_CLK after c_PERIOD /2;
  
  process
    begin
      w_D   <= "00000000000000000000000000000001";
		wait for 1 ns;
		
		w_D   <= "00000000000000000000000000000011";
		wait for 1 ns;
		
		w_D   <= "00000000000000000000000000000100";
		wait for 1 ns;
		
		-- Clear Inputs
      w_D <= "00000000000000000000000000000000";
      wait;
  end process;
end arch_1;