library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rv32_top is
port ( i_CLK        : in  std_logic;
       i_RST        : in  std_logic;
       o_ALU_RESULT : out std_logic_vector(31 downto 0));
end rv32_top;

architecture arch_1 of rv32_top is 
  -- Declaracao de Componentes
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
  
  component somador_completo_32bits is
  port ( i_A                : in  std_logic_vector(31 downto 0);
         i_B                : in  std_logic_vector(31 downto 0);
         i_CIN              : in  std_logic;
         o_COUT             : out std_logic;
         o_SOMADOR_COMPLETO : out std_logic_vector(31 downto 0));
  end component;
  
  component ula is
  port ( i_A    : in  std_logic_vector(31 downto 0);
         i_B    : in  std_logic_vector(31 downto 0);
         i_SEL  : in  std_logic_vector(3  downto 0);
         o_ZERO : out std_logic;
         o_ULA  : out std_logic_vector(31 downto 0));
  end component;
  
  component data_memory is
  port ( i_CLK      : in  std_logic;
         i_MEMWRITE : in  std_logic;
         i_MEMREAD  : in  std_logic;
         i_ADDRESS  : in  std_logic_vector(31 downto 0);
         i_IN       : in  std_logic_vector(31 downto 0);
         o_OUT      : out std_logic_vector(31 downto 0));
  end component;
  
  component imm_gen is
  port ( i_INST : in  std_logic_vector(31 downto 0);
         o_IMM  : out std_logic_vector(31 downto 0));
  end component;
  
  component instruction_memory is										
  port ( i_ADDR : in  std_logic_vector(31 downto 0);
         o_OUT  : out std_logic_vector(31 downto 0));
  end component;
  
  component mux is
  port ( i_SEL : in  std_logic;
         i_A	 : in  std_logic_vector(31 downto 0);
         i_B	 : in  std_logic_vector(31 downto 0);
         o_OUT : out std_logic_vector(31 downto 0));
  end component;
  
  component reg is
  port ( i_RST : in  std_logic;
         i_CLK : in  std_logic;
         i_A   : in  std_logic_vector(31 downto 0);
         o_S   : out std_logic_vector(31 downto 0));
  end component;
  
  component shift_left is
  port ( i_DATA   : in  std_logic_vector(31 downto 0);
         o_RESULT : out std_logic_vector(31 downto 0));
  end component;
  
  component alu_control is
  port ( i_ALU_OP : in  std_logic_vector(1 downto 0);
         i_F      : in  std_logic_vector(3 downto 0);
         o_Q      : out std_logic_vector(3 downto 0));
  end component;
  
  component main_control is
  port ( i_OP       : in  std_logic_vector(6 downto 0);
         o_ALU_OP   : out std_logic_vector(1 downto 0);
         o_ALUSRC   : out std_logic;
         o_MEMTOREG : out std_logic;
         o_REGWRITE : out std_logic;
         o_MEMREAD  : out std_logic;
         o_MEMWRITE : out std_logic;
         o_BRANCH   : out std_logic);
  end component;
  
  -- Declaracao de Sinais do Datapath
  signal w_PC_OUT     : std_logic_vector(31 downto 0);
  signal w_INST       : std_logic_vector(31 downto 0);
  signal w_READ1      : std_logic_vector(31 downto 0);
  signal w_READ2      : std_logic_vector(31 downto 0);
  signal w_IMM        : std_logic_vector(31 downto 0);
  signal w_SRC        : std_logic_vector(31 downto 0);
  signal w_ALU_RES    : std_logic_vector(31 downto 0);
  signal w_DATA       : std_logic_vector(31 downto 0);
  signal w_WRITE_DATA : std_logic_vector(31 downto 0);
  signal w_SHIFT      : std_logic_vector(31 downto 0);
  signal w_BRANCHED   : std_logic_vector(31 downto 0);
  signal w_PC4        : std_logic_vector(31 downto 0);
  signal w_PC_IN      : std_logic_vector(31 downto 0);
  
  -- Declaracao de Sinais do Controlador
  signal w_BRANCH   : std_logic;
  signal w_MEMREAD  : std_logic;
  signal w_MEMTOREG : std_logic;
  signal w_ALU_OP   : std_logic_vector(1 downto 0);
  signal w_MEMWRITE : std_logic;
  signal w_ALUSRC   : std_logic;
  signal w_REGWRITE : std_logic;
  signal w_OP       : std_logic_vector(3 downto 0);
  signal w_ZERO     : std_logic;
  
  signal w_UNUSED1 : std_logic;
  signal w_UNUSED2 : std_logic_vector(31 downto 0);
  
begin
  -- Instancias de Componentes
  u_PC: reg port map ( i_RST => i_RST,
                       i_CLK => i_CLK,
                       i_A   => w_PC_IN,
                       o_S   => w_PC_OUT);

  u_INSTRUCTION: instruction_memory port map ( i_ADDR => w_PC_OUT,
                                               o_OUT  => w_INST);
                                               

  u_MAINCTRL: main_control port map ( i_OP       => w_INST(6 downto 0),
                                      o_ALU_OP   => w_ALU_OP,
                                      o_ALUSRC   => w_ALUSRC,
                                      o_MEMTOREG => w_MEMTOREG,
                                      o_REGWRITE => w_REGWRITE,
                                      o_MEMREAD  => w_MEMREAD,
                                      o_MEMWRITE => w_MEMWRITE,
                                      o_BRANCH   => w_BRANCH);

  u_REGFILE: reg_file port map ( i_CLK        => i_CLK,
                                 i_READ_REG1  => w_INST(19 downto 15),
                                 i_READ_REG2  => w_INST(24 downto 20),
                                 i_WRITE_REG  => w_INST(11 downto 7),
                                 i_WRITE_DATA => w_WRITE_DATA,
                                 i_REGWRITE   => w_REGWRITE,
                                 o_READ_DATA1 => w_READ1,
                                 o_READ_DATA2 => w_READ2);

  u_IMMGEN: imm_gen port map ( i_INST => w_INST,
                               o_IMM  => w_IMM);

  u_MUX_IMM: mux port map ( i_SEL => w_ALUSRC,
                            i_A	  => w_READ2,
                            i_B	  => w_IMM,
                            o_OUT => w_SRC);

  u_ALUCTRL: alu_control port map ( i_ALU_OP => w_ALU_OP,
                                    i_F      => w_INST(30) & w_INST(14 downto 12),
                                    o_Q      => w_OP);

  u_ALU: ula port map ( i_A    => w_READ1,
                        i_B    => w_SRC,
                        i_SEL  => w_OP,
                        o_ZERO => w_ZERO,
                        o_ULA  => w_ALU_RES);

  u_DATA: data_memory port map ( i_CLK      => i_CLK,
                                 i_MEMWRITE => w_MEMWRITE,
                                 i_MEMREAD  => w_MEMREAD,
                                 i_ADDRESS  => w_ALU_RES,
                                 i_IN       => w_READ2,
                                 o_OUT      => w_DATA);

  u_MUX_MEMORY: mux port map ( i_SEL => w_MEMTOREG,
                               i_A	 => w_ALU_RES,
                               i_B	 => w_DATA,
                               o_OUT => w_WRITE_DATA);

  u_ADDER_4: somador_completo_32bits port map ( i_A                => w_PC_OUT,
                                                i_B                => "00000000000000000000000000000100",
                                                i_CIN              => '0',
                                                o_COUT             => w_UNUSED1,
                                                o_SOMADOR_COMPLETO => w_PC4);

  u_SHIFT: shift_left port map ( i_DATA   => w_IMM,
                                 o_RESULT => w_SHIFT);

  u_ADDER_BRANCH: somador_completo_32bits port map ( i_A                => w_PC_OUT,
                                                     i_B                => w_SHIFT,
                                                     i_CIN              => '0',
                                                     o_COUT             => w_UNUSED1,
                                                     o_SOMADOR_COMPLETO => w_BRANCHED);

  u_MUX_BRANCH: mux port map ( i_SEL => w_BRANCH and w_ZERO,
                               i_A	 => w_PC4,
                               i_B	 => w_BRANCHED,
                               o_OUT => w_PC_IN);
										 
  o_ALU_RESULT <= w_ALU_RES;
end arch_1;