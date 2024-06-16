library IEEE;
use IEEE.std_logic_1164.all;

entity tb_reg_file is
end tb_reg_file;

architecture arch_1 of tb_reg_file is
  -- Declaracao de DUV
  component reg_file is
  port ( i_CLK        : in std_logic;
         i_READ_REG1  : in std_logic_vector(4 downto 0);
         i_READ_REG2  : in std_logic_vector(4 downto 0);
         i_WRITE_REG  : in std_logic_vector(4 downto 0);
         i_WRITE_DATA : in std_logic_vector(31 downto 0);
         i_REGWRITE   : in std_logic;
         o_READ_DATA1 : out std_logic_vector(31 downto 0);
         o_READ_DATA2 : out std_logic_vector(31 downto 0));
  end component;
  
  -- Declaracao de Sinais
  signal w_CLK        : std_logic := '0';
  signal w_READ_REG1  : std_logic_vector(4 downto 0);
  signal w_READ_REG2  : std_logic_vector(4 downto 0);
  signal w_WRITE_REG  : std_logic_vector(4 downto 0);
  signal w_WRITE_DATA : std_logic_vector(31 downto 0);
  signal w_REGWRITE   : std_logic;
  signal w_READ_DATA1 : std_logic_vector(31 downto 0);
  signal w_READ_DATA2 : std_logic_vector(31 downto 0);
  constant c_PERIOD   : time := 1 ns;
  
begin
  -- Conectando DUV
  u_DUV: reg_file port map ( i_CLK        => w_CLK,
                             i_READ_REG1  => w_READ_REG1,
                             i_READ_REG2  => w_READ_REG2,
                             i_WRITE_REG  => w_WRITE_REG,
                             i_WRITE_DATA => w_WRITE_DATA,
                             i_REGWRITE   => w_REGWRITE,
                             o_READ_DATA1 => w_READ_DATA1,
                             o_READ_DATA2 => w_READ_DATA2);

  -- Geracao de Sistemas de Sinais
  w_CLK <= not w_CLK after c_PERIOD /2;

  process
  begin
    -- Teste 1: escrevendo no registrador x1
    w_READ_REG1  <= (others => '0');
    w_READ_REG2  <= (others => '0');
    w_WRITE_REG  <= "00001";
    w_WRITE_DATA <= "00000000000000000000000000001110"; -- Valor 14
    w_REGWRITE   <= '1';
    wait for 1 ns;
    assert (w_READ_DATA1 = "00000000000000000000000000000000" and
            w_READ_DATA2 = "00000000000000000000000000000000")
	  report "Fail @ 001" severity error;
    
    -- Teste 2: lendo do registrador x1
    w_READ_REG1  <= "00001";
    w_READ_REG2  <= (others => '0');
    w_WRITE_REG  <= "00001";
    w_WRITE_DATA <= "00000000000000000000000000000011"; -- valor 3
    w_REGWRITE   <= '0';
    wait for 1 ns;
	  assert (w_READ_DATA1 = "00000000000000000000000000001110" and
            w_READ_DATA2 = "00000000000000000000000000000000")
	  report "Fail @ 002" severity error;
    
    -- Teste 3: escrevendo no registrador x0
    w_READ_REG1  <= (others => '0');
    w_READ_REG2  <= (others => '0');
    w_WRITE_REG  <= (others => '0');
    w_WRITE_DATA <= (others => '1');
    w_REGWRITE   <= '1';
    wait for 1 ns;
	  assert (w_READ_DATA1 = "00000000000000000000000000000000" and
            w_READ_DATA2 = "00000000000000000000000000000000")
	  report "Fail @ 003" severity error;
    
    -- Teste 6: lendo do registrador x0
    w_READ_REG1  <= (others => '0');
    w_READ_REG2  <= (others => '0');
    w_REGWRITE   <= '0';
    wait for 1 ns;
	  assert (w_READ_DATA1 = "00000000000000000000000000000000" and
            w_READ_DATA2 = "00000000000000000000000000000000")
	  report "Fail @ 006" severity error;
		
    -- Teste 5: escrevendo no registrador x31
    w_READ_REG1  <= (others => '0');
    w_READ_REG2  <= (others => '1');
    w_WRITE_REG  <= (others => '1');
    w_WRITE_DATA <= "00000000000000000000000000001010"; -- valor 10
    w_REGWRITE   <= '1';
    wait for 1 ns;
	  assert (w_READ_DATA1 = "00000000000000000000000000000000" and
            w_READ_DATA2 = "00000000000000000000000000001010")
	  report "Fail @ 005" severity error;
    
    -- Teste 6: lendo do registrador x31
    w_READ_REG1  <= (others => '0');
    w_READ_REG2  <= (others => '1');
    w_WRITE_REG  <= "00010";
    w_WRITE_DATA <= "11111111111111111111111111111111";
    w_REGWRITE   <= '0';
    wait for 1 ns;
	  assert (w_READ_DATA1 = "00000000000000000000000000000000" and
            w_READ_DATA2 = "00000000000000000000000000001010")
	  report "Fail @ 006" severity error;
    
    -- Teste 7: lendo dos registradores x31 e x1
    w_READ_REG1  <= (others => '1');
    w_READ_REG2  <= "00001";
    w_REGWRITE   <= '0';
    wait for 1 ns;
	  assert (w_READ_DATA1 = "00000000000000000000000000001010" and
            w_READ_DATA2 = "00000000000000000000000000001110")
	  report "Fail @ 007" severity error;
    
	  -- Clear Inputs
	  w_READ_REG1  <= (others => '0');
    w_READ_REG2  <= (others => '0');
    w_WRITE_REG  <= (others => '0');
    w_WRITE_DATA <= (others => '0');
    w_REGWRITE   <= '0';
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;