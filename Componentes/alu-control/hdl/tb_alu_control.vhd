library IEEE;
use IEEE.std_logic_1164.all;

entity tb_alu_control is
end tb_alu_control;

architecture arch_1 of tb_alu_control is
  -- Declaração de DUV
  component alu_control is
  port ( i_ALU_OP : in  std_logic_vector(1 downto 0);
         i_F      : in  std_logic_vector(3 downto 0);
         o_Q      : out std_logic_vector(3 downto 0));
  end component;

  -- Declaração de Sinais
  signal w_ALU_OP : std_logic_vector(1 downto 0);
  signal w_F      : std_logic_vector(3 downto 0);
  signal w_Q      : std_logic_vector(3 downto 0);

begin
  -- Conectando DUV
  u_DUV: ALU_control port map ( i_ALU_OP => w_ALU_OP,
                                i_F      => w_F,
                                o_Q      => w_Q);

  process
  begin
    -- Test case: i_ALUOp = "10", i_F = "100000" (Add operation expected)
    w_ALU_OP <= "10";
    w_F      <= "0000";
    wait for 1 ns;
    assert (w_Q = "0010")
    report "Test case for ADD operation failed" severity error;

    -- Test case: i_ALUOp = "10", i_F = "100010" (Subtract operation expected)
    w_ALU_OP <= "10";
    w_F      <= "0010";
    wait for 1 ns;
    assert (w_Q = "0110")
    report "Test case for SUB operation failed" severity error;

    -- Test case: i_ALUOp = "10", i_F = "100100" (AND operation expected)
    w_ALU_OP <= "10";
    w_F      <= "0100";
    wait for 1 ns;
    assert (w_Q = "0000")
    report "Test case for AND operation failed" severity error;

    -- Test case: i_ALUOp = "10", i_F = "100101" (OR operation expected)
    w_ALU_OP <= "10";
    w_F      <= "0101";
    wait for 1 ns;
    assert (w_Q = "0001")
    report "Test case for OR operation failed" severity error;

    -- Test case: i_ALUOp = "10", i_F = "101010" (Set Less Than operation expected)
    w_ALU_OP <= "10";
    w_F      <= "1010";
    wait for 1 ns;
    assert (w_Q = "0111")
    report "Test case for SLT operation failed" severity error;

    -- Test case: i_ALUOp = "00" (Load/Store operation expected)
    w_ALU_OP <= "00";
    w_F      <= "XXXX";  -- Don't care
    wait for 1 ns;
    assert (w_Q = "0010")
    report "Test case for LW/SW operation failed" severity error;

    -- Test case: i_ALUOp = "01" (Branch operation expected)
    w_ALU_OP <= "01";
    w_F      <= "XXXX";  -- Don't care
    wait for 1 ns;
    assert (w_Q = "0110")
    report "Test case for BEQ operation failed" severity error;

    -- Clear Inputs
    w_ALU_OP <= "00";
    w_F      <= "0000";
	  assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end architecture arch_1;
