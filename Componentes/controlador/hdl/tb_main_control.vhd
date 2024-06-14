library ieee;
use ieee.std_logic_1164.all;

entity tb_Main_control is
end tb_Main_control;

architecture behavioral of tb_Main_control is
    -- Component declaration for the Unit Under Test (UUT)
    component Main_control
        port (
            i_OP     : in  std_logic_vector(6 downto 0);
            o_ALUOp  : out std_logic_vector(1 downto 0);  
            o_ALUSRC : out std_logic;   
            o_MEMTOREG : out std_logic;   
            o_REGWRITE : out std_logic;   
            o_MEMREAD : out std_logic;   
            o_MEMWRITE : out std_logic;   
            o_BRANCH : out std_logic  
        );
    end component;

    -- Signals to connect to the UUT
    signal i_OP     : std_logic_vector(6 downto 0);
    signal o_ALUOp  : std_logic_vector(1 downto 0);  
    signal o_ALUSRC : std_logic;   
    signal o_MEMTOREG : std_logic;   
    signal o_REGWRITE : std_logic;   
    signal o_MEMREAD : std_logic;   
    signal o_MEMWRITE : std_logic;   
    signal o_BRANCH : std_logic;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Main_control
        port map (
            i_OP => i_OP,
            o_ALUOp => o_ALUOp,
            o_ALUSRC => o_ALUSRC,
            o_MEMTOREG => o_MEMTOREG,
            o_REGWRITE => o_REGWRITE,
            o_MEMREAD => o_MEMREAD,
            o_MEMWRITE => o_MEMWRITE,
            o_BRANCH => o_BRANCH
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case: R-type instruction (i_OP = "0110011")
        i_OP <= "0110011";
        wait for 10 ns;
        assert (o_ALUOp = "10" and o_ALUSRC = '0' and o_MEMTOREG = '0' and o_REGWRITE = '1' and o_MEMREAD = '0' and o_MEMWRITE = '0' and o_BRANCH = '0')
            report "Test case for R-type instruction failed" severity error;

        -- Test case: I-type (Load) instruction (i_OP = "0000011")
        i_OP <= "0000011";
        wait for 10 ns;
        assert (o_ALUOp = "00" and o_ALUSRC = '1' and o_MEMTOREG = '1' and o_REGWRITE = '1' and o_MEMREAD = '1' and o_MEMWRITE = '0' and o_BRANCH = '0')
            report "Test case for I-type Load instruction failed" severity error;

        -- Test case: S-type (Store) instruction (i_OP = "0100011")
        i_OP <= "0100011";
        wait for 10 ns;
        assert (o_ALUOp = "00" and o_ALUSRC = '1' and o_MEMTOREG = '0' and o_REGWRITE = '0' and o_MEMREAD = '0' and o_MEMWRITE = '1' and o_BRANCH = '0')
            report "Test case for S-type Store instruction failed" severity error;

        -- Test case: B-type (Branch) instruction (i_OP = "1100011")
        i_OP <= "1100011";
        wait for 10 ns;
        assert (o_ALUOp = "01" and o_ALUSRC = '0' and o_MEMTOREG = '0' and o_REGWRITE = '0' and o_MEMREAD = '0' and o_MEMWRITE = '0' and o_BRANCH = '1')
            report "Test case for B-type Branch instruction failed" severity error;

        -- End of simulation
        wait;
    end process;

end architecture behavioral;
