library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity data_memory is
    Port (
        i_CLK      : in  std_logic;
        i_MEMWRITE : in  std_logic;
        i_MEMREAD  : in  std_logic;
        i_ADDRESS  : in  std_logic_vector(31 downto 0);
        i_IN       : in  std_logic_vector(31 downto 0);
        o_OUT      : out std_logic_vector(31 downto 0)
    );
end data_memory;

architecture arch_1 of data_memory is
  type memory_array is array (0 to 511) of std_logic_vector(31 downto 0);
  signal memory : memory_array := (others => (others => '0'));
  signal w_READ_DATA : std_logic_vector(31 downto 0);
begin

  process(i_CLK)
  begin
    if rising_edge(i_CLK) then
      -- Write operation
      if i_MEMWRITE = '1' then
        memory(to_integer(unsigned(i_ADDRESS(8 downto 0)))) <= i_IN;
      end if;

      -- Read operation
      if i_MEMREAD = '1' then
        w_READ_DATA <= memory(to_integer(unsigned(i_ADDRESS(8 downto 0))));
      end if;
    end if;
  end process;

  -- Output the read data when i_MEMREAD is '1', otherwise high impedance state
  o_OUT <= w_READ_DATA;

end arch_1;
