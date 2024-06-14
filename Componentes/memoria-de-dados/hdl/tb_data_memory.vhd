library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_data_memory is
end tb_data_memory;

architecture arch_1 of tb_data_memory is
  -- Declaração de DUV
  component data_memory is
  port ( i_CLK      : in  std_logic;
         i_MEMWRITE : in  std_logic;
		   i_MEMREAD  : in  std_logic;
         i_ADDRESS  : in  std_logic_vector(31 downto 0);
         i_IN       : in  std_logic_vector(31 downto 0);
         o_OUT      : out std_logic_vector(31 downto 0));
  end component;

  -- Signals to connect to DUV
  signal w_CLK      : std_logic := '0';
  signal w_MEMWRITE : std_logic;
  signal w_MEMREAD  : std_logic;
  signal w_ADDRESS  : std_logic_vector(31 downto 0);
  signal w_IN       : std_logic_vector(31 downto 0);
  signal w_OUT      : std_logic_vector(31 downto 0);

  -- Clock period definition
  constant c_CLK_PERIOD : time := 1 ns;

begin

  -- Conectando DUV
  u_DUV: data_memory port map ( i_CLK      => w_CLK,
		                          i_MEMWRITE => w_MEMWRITE,
										  i_MEMREAD  => w_MEMREAD,
		                          i_ADDRESS  => w_ADDRESS,
		                          i_IN       => w_IN,
		                          o_OUT      => w_OUT);

  -- Clock process definitions
  w_CLK <= not w_CLK after c_CLK_PERIOD /2;

  -- Stimulus process
  process
  begin
    -- Initialize Inputs
    w_MEMWRITE <= '0';
	 w_MEMREAD  <= '0';
    w_ADDRESS  <= "00000000000000000000000000000000";
    w_IN       <= "00000000000000000000000000000000";
    wait for 1 ns;

    -- Write '32' to memory address 0
    w_MEMWRITE <= '1';
    w_ADDRESS  <= "00000000000000000000000000000000"; -- Posição 0
    w_IN       <= "00000000000000000000000000100000"; -- Valor 32
    wait for 1 ns;
	 assert(w_OUT = "00000000000000000000000000100000")
	 report "Fail @ 001" severity error;

    -- Read Value from memory address 511
    w_MEMWRITE <= '0';
    w_ADDRESS  <= "00000000000000000000000111111111"; -- Posição 511
    w_IN       <= "00000000000000000000000000111111"; -- Valor 63
    wait for 1 ns;
    assert(w_OUT = "00000000000000000000000000000000")
	 report "Fail @ 002" severity error;

    -- Read Value from memory address 0
	 w_ADDRESS  <= "00000000000000000000000000000000"; -- Posição 0
    w_IN       <= "00000000000000000000000000111111"; -- Valor 63
	 wait for 1 ns;
    assert(w_OUT = "00000000000000000000000000100000")
	 report "Fail @ 003" severity error;

    -- Clear Inputs
	 w_MEMWRITE <= '0';
	 w_MEMREAD  <= '0';
    w_ADDRESS  <= (others => '0');
	 w_IN       <= (others => '0');
	 assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;
