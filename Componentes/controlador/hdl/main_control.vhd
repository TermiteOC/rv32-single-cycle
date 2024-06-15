library ieee;
use ieee.std_logic_1164.all;

entity Main_control is
port (
  i_OP     : in  std_logic_vector(6 downto 0);
  o_ALUOp : out  std_logic_vector(1 downto 0);     
  o_ALUSRC : out std_logic;   
  o_MEMTOREG : out std_logic;   
  o_REGWRITE : out std_logic;   
  o_MEMREAD : out std_logic;   
  o_MEMWRITE : out std_logic;   
  o_BRANCH : out std_logic  
);
end Main_control;

architecture arch_1 of Main_control is
begin
    process(i_OP)
    begin
        o_ALUOp(0) <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and i_OP(6);
        o_ALUOp(1) <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and i_OP(5) and (not i_OP(6));
        o_ALUSRC <=   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6))) or 
                      (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and (not i_OP(6)));
        o_MEMTOREG <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6));   
        o_REGWRITE <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and i_OP(5) and (not i_OP(6))) or 
                      (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6)));
        o_MEMREAD  <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6));    
        o_MEMWRITE <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and (not i_OP(6)); 
        o_BRANCH <=   i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and i_OP(6);
    end process;
end arch_1;