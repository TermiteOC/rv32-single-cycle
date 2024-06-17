library IEEE;
use IEEE.std_logic_1164.all;

entity tb_main_control is
end tb_main_control;

architecture behavioral of tb_main_control is
  -- Declaração de DUV
  component main_control
  port ( i_OP       : in  std_logic_vector(6 downto 0);
         o_ALU_OP   : out std_logic_vector(1 downto 0);  
         o_ALUSRC   : out std_logic;   
         o_MEMTOREG : out std_logic;   
         o_REGWRITE : out std_logic;   
         o_MEMREAD  : out std_logic;   
         o_MEMWRITE : out std_logic;   
         o_BRANCH   : out std_logic);
  end component;

  --Declaração de Sinais
  signal w_OP       : std_logic_vector(6 downto 0);
  signal w_ALU_OP   : std_logic_vector(1 downto 0);  
  signal w_ALUSRC   : std_logic;   
  signal w_MEMTOREG : std_logic;   
  signal w_REGWRITE : std_logic;   
  signal w_MEMREAD  : std_logic;   
  signal w_MEMWRITE : std_logic;   
  signal w_BRANCH   : std_logic;

begin
  -- Conectando DUV
  u_DUV: main_control port map ( i_OP       => w_OP,
                                 o_ALU_OP    => w_ALU_OP,
                                 o_ALUSRC   => w_ALUSRC,
                                 o_MEMTOREG => w_MEMTOREG,
                                 o_REGWRITE => w_REGWRITE,
                                 o_MEMREAD  => w_MEMREAD,
                                 o_MEMWRITE => w_MEMWRITE,
                                 o_BRANCH   => w_BRANCH);

  process
  begin
    -- Test case: R-type instruction (i_OP = "0110011")
    w_OP <= "0110011";
    wait for 1 ns;
    assert (w_ALU_OP = "10" and w_ALUSRC = '0' and w_MEMTOREG = '0' and w_REGWRITE = '1' and w_MEMREAD = '0' and w_MEMWRITE = '0' and w_BRANCH = '0')
    report "Test case for R-type instruction failed" severity error;

    -- Test case: I-type (Load) instruction (i_OP = "0000011")
    w_OP <= "0000011";
    wait for 1 ns;
    assert (w_ALU_OP = "00" and w_ALUSRC = '1' and w_MEMTOREG = '1' and w_REGWRITE = '1' and w_MEMREAD = '1' and w_MEMWRITE = '0' and w_BRANCH = '0')
    report "Test case for I-type Load instruction failed" severity error;

    -- Test case: S-type (Store) instruction (i_OP = "0100011")
    w_OP <= "0100011";
    wait for 1 ns;
    assert (w_ALU_OP = "00" and w_ALUSRC = '1' and w_MEMTOREG = '0' and w_REGWRITE = '0' and w_MEMREAD = '0' and w_MEMWRITE = '1' and w_BRANCH = '0')
    report "Test case for S-type Store instruction failed" severity error;

    -- Test case: B-type (Branch) instruction (i_OP = "1100011")
    w_OP <= "1100011";
    wait for 1 ns;
    assert (w_ALU_OP = "01" and w_ALUSRC = '0' and w_MEMTOREG = '0' and w_REGWRITE = '0' and w_MEMREAD = '0' and w_MEMWRITE = '0' and w_BRANCH = '1')
    report "Test case for B-type Branch instruction failed" severity error;

    -- Clear Inputs
    w_OP <= (others => '0');
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end architecture behavioral;
