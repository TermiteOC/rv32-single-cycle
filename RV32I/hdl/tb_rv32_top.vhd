library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_rv32_top is
end tb_rv32_top;

architecture arch_1 of tb_rv32_top is
  -- Declaração de DUV
  component rv32_top is
  port ( i_CLK : in std_logic;
         i_RST : in std_logic);
  end component;

  -- Declaração de Sinais
  signal w_CLK : std_logic := '0';
  signal w_RST : std_logic;

  -- Definição do Período de Clock
  constant c_CLK_PERIOD : time := 1 ns;

begin
  -- Conectando DUV
  u_DUV: rv32_top port map ( i_CLK => w_CLK,
		                         i_RST => w_RST);

  -- Definições do Processo de Clock
  w_CLK <= not w_CLK after c_CLK_PERIOD /2;

  -- Processo de Estímulo
  process
  begin
    -- Initialize Inputs
    w_RST     <= '0';
    wait for 1 ns;
    
    w_RST     <= '1';
    wait for 1 ns;
    
    w_RST     <= '0';
    wait for 1 ns;

    wait for 40 ns;
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;
