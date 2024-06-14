library ieee;
use ieee.std_logic_1164.all;

entity tb_ALU_control is
end tb_ALU_control;

architecture behavioral of tb_ALU_control is
    -- Component declaration for the Unit Under Test (UUT)
    component ALU_control
        port (
            i_ALUOp : in  std_logic_vector(1 downto 0); 
            i_F     : in  std_logic_vector(5 downto 0);  
            o_Q     : out std_logic_vector(3 downto 0)   
        );
    end component;

    -- Signals to connect to the UUT
    signal i_ALUOp : std_logic_vector(1 downto 0);
    signal i_F     : std_logic_vector(5 downto 0);
    signal o_Q     : std_logic_vector(3 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: ALU_control
        port map (
            i_ALUOp => i_ALUOp,
            i_F     => i_F,
            o_Q     => o_Q
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case: i_ALUOp = "10", i_F = "100000" (Add operation expected)
        i_ALUOp <= "10";
        i_F <= "100000";
        wait for 10 ns;
        assert (o_Q = "0010")
            report "Test case for ADD operation failed" severity error;

        -- Test case: i_ALUOp = "10", i_F = "100010" (Subtract operation expected)
        i_ALUOp <= "10";
        i_F <= "100010";
        wait for 10 ns;
        assert (o_Q = "0110")
            report "Test case for SUB operation failed" severity error;

        -- Test case: i_ALUOp = "10", i_F = "100100" (AND operation expected)
        i_ALUOp <= "10";
        i_F <= "100100";
        wait for 10 ns;
        assert (o_Q = "0000")
            report "Test case for AND operation failed" severity error;

        -- Test case: i_ALUOp = "10", i_F = "100101" (OR operation expected)
        i_ALUOp <= "10";
        i_F <= "100101";
        wait for 10 ns;
        assert (o_Q = "0001")
            report "Test case for OR operation failed" severity error;

        -- Test case: i_ALUOp = "10", i_F = "101010" (Set Less Than operation expected)
        i_ALUOp <= "10";
        i_F <= "101010";
        wait for 10 ns;
        assert (o_Q = "0111")
            report "Test case for SLT operation failed" severity error;

        -- Test case: i_ALUOp = "00" (Load/Store operation expected)
        i_ALUOp <= "00";
        i_F <= "XXXXXX";  -- Don't care
        wait for 10 ns;
        assert (o_Q = "0010")
            report "Test case for LW/SW operation failed" severity error;

        -- Test case: i_ALUOp = "01" (Branch operation expected)
        i_ALUOp <= "01";
        i_F <= "XXXXXX";  -- Don't care
        wait for 10 ns;
        assert (o_Q = "0110")
            report "Test case for BEQ operation failed" severity error;

        -- End of simulation
        wait;
    end process;

end architecture behavioral;
