library ieee;
use ieee.std_logic_1164.all;

entity ALU_control is
port (
  i_ALUOp : in  std_logic_vector(1 downto 0); 
  i_F     : in  std_logic_vector(3 downto 0);  
  o_Q     : out std_logic_vector(3 downto 0)   
);
end ALU_control;

architecture arch_1 of ALU_control is
begin
    -- Processo que descreve o comportamento da porta OR
    process(i_ALUOp, i_F)
    begin
        o_Q(0) <=  (i_F(0) or i_F(3)) and i_ALUOp(1);
		  o_Q(1) <=  (not i_F(2)) or (not i_ALUOp(1));
		  o_Q(2) <=  (i_F(1) and i_ALUOp(1)) or i_ALUOp(0);
		  o_Q(3) <=  i_ALUOp(0) and (not i_ALUOp(0));
    end process;
  
end arch_1;
