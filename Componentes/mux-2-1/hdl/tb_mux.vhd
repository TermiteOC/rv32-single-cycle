library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux is
-- empty
end tb_mux;

architecture arch_1 of tb_mux is
  -- DUT component
  component mux is
  port ( i_SEL : in  std_logic; 
         i_A	 : in  std_logic_vector(31 downto 0); 
	      i_B	 : in  std_logic_vector(31 downto 0); 
         o_OUT : out std_logic_vector(31 downto 0));
  end component;

  signal w_S, w_A, w_B : std_logic_vector(31 downto 0);
  signal w_SEL : std_logic;
  
begin
  -- Connect DUT
  u_DUT: mux port map( i_SEL => w_SEL,
                       i_A => w_A,
                       i_B => w_B,
                       o_OUT => w_S);
  process
    begin
    w_A   <= "00000000000000000000000000000000";
	 w_B   <= "11111111111111111111111111111111";
    w_SEL <= '0';
    wait for 1 ns;
    assert (w_S = "00000000000000000000000000000000")
	 report "Fail @ 000" severity error;
	 
	 w_SEL <= '1';
    wait for 1 ns;
    assert (w_S = "11111111111111111111111111111111")
	 report "Fail @ 001" severity error;
	 
    -- Clear inputs
    w_SEL <= '0';
    assert false report "Test done." severity note;
    wait;
  end process;
end arch_1;