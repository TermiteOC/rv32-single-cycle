library IEEE;
use IEEE.std_logic_1164.all;

entity tb_reg is
end tb_reg;

architecture arch_1 of tb_reg is
  -- Declaracao de DUV
  component reg is
  port ( i_RST : in  std_logic;
         i_CLK : in  std_logic;
		   i_A   : in  std_logic_vector(31 downto 0);
         o_S   : out std_logic_vector(31 downto 0));
  end component;
  
  -- Declaracao de Sinais
  signal w_CLK : std_logic := '0';
  signal w_RST : std_logic;
  signal w_A, w_S : std_logic_vector(31 downto 0);
  constant c_PERIOD : time := 1 ns;
  
begin
  -- Conectando DUV
  u_DUV: reg port map ( i_RST => w_RST,
                        i_CLK => w_CLK,
                        i_A   => w_A,
                        o_S   => w_S);
							  
  -- Geracao de Sistemas de Sinais
  w_CLK <= not w_CLK after c_PERIOD /2;
  
  process
  begin
    w_RST <= '1';
    w_A   <= "00000000000000000000000000000111";
    wait for 1 ns;
	 assert (w_S = "00000000000000000000000000000000")
	 report "Fail @ 000" severity error;
		
	 w_RST <= '0';
	 w_A   <= "00000000000000000000000000000011";
	 wait for 1 ns;
	 assert (w_S = "00000000000000000000000000000011")
	 report "Fail @ 001" severity error;
		
	 w_A   <= "00000000000000000000000000000100";
	 wait for 1 ns;
	 assert (w_S = "00000000000000000000000000000100")
	 report "Fail @ 002" severity error;

	 -- Clear Inputs
	 w_RST <= '0';
    w_A   <= "00000000000000000000000000000000";
	 assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;