library ieee;
use ieee.std_logic_1164.all;

entity ula_32bits is
port (i_A    : in  std_logic_vector (31 downto 0);  -- entrada A
      i_B    : in  std_logic_vector (31 downto 0);  -- entrada B
      i_SEL  : in  std_logic_vector (2  downto 0);  -- seletor de operação
		o_ZERO : out std_logic;                       -- saída flag zero
      o_ULA  : out std_logic_vector (31 downto 0)); -- saída resultado
end ula_32bits;

architecture arq_1 of ula_32bits is

signal w_0, w_2, w_3, w_4, w_5, w_6, w_7, w_ULA : std_logic_vector (31 downto 0);
signal w_UNUSED : std_logic;

component soma_subtrai_32bits is
port (i_A            : in  std_logic_vector (31 downto 0);  -- entrada A
      i_B            : in  std_logic_vector (31 downto 0);  -- entrada B
      i_SUBTRAIR     : in  std_logic;                       -- entrada =0 soma normal, =1 faz o complemento de 2 e subtrai
		o_COUT         : out std_logic;                       -- saída carry out
      o_SOMA_SUBTRAI : out std_logic_vector (31 downto 0)); -- saída resultado
end component;

component somador_completo_32bits is
port (i_A                : in  std_logic_vector (31 downto 0);  -- entrada A
	   i_B                : in  std_logic_vector (31 downto 0);  -- entrada B
      i_CIN              : in  std_logic;                       -- entrada carry in
      o_COUT             : out std_logic;                       -- saída carry out
      o_SOMADOR_COMPLETO : out std_logic_vector (31 downto 0)); -- saída resultado
end component;

component a_32bits is
port (i_A : in  std_logic_vector (31 downto 0);  -- entrada A
      o_A : out std_logic_vector (31 downto 0)); -- saída resultado a_32bits
end component;

component and_32bits is
port (i_A   : in  std_logic_vector (31 downto 0);  -- entrada A
	   i_B   : in  std_logic_vector (31 downto 0);  -- entrada B
      o_AND : out std_logic_vector (31 downto 0)); -- saída resultado and_32bits
end component;

component or_32bits is
port (i_A  : in  std_logic_vector (31 downto 0);  -- entrada A
	   i_B  : in  std_logic_vector (31 downto 0);  -- entrada B
      o_OR : out std_logic_vector (31 downto 0)); -- saída resultado or_32bits
end component;

component xor_32bits is
port (i_A   : in  std_logic_vector (31 downto 0);  -- entrada A
	   i_B   : in  std_logic_vector (31 downto 0);  -- entrada B
      o_XOR : out std_logic_vector (31 downto 0)); -- saída resultado xor_32bits
end component;

component not_a_32bits is
port (i_A     : in  std_logic_vector (31 downto 0);  -- entrada A
      o_NOT_A : out std_logic_vector (31 downto 0)); -- saída resultado not_a_32bits
end component;

component seletor_ula_3bits is
port (i_SOMA      : in  std_logic_vector (31 downto 0);  -- entrada resultado soma
      i_SUBTRAI   : in  std_logic_vector (31 downto 0);  -- entrada resultado subtração
      i_A_MAIS_UM : in  std_logic_vector (31 downto 0);  -- entrada resultado A+1
      i_A         : in  std_logic_vector (31 downto 0);  -- entrada resultado A
      i_AND       : in  std_logic_vector (31 downto 0);  -- entrada resultado and
      i_OR        : in  std_logic_vector (31 downto 0);  -- entrada resultado or
      i_XOR       : in  std_logic_vector (31 downto 0);  -- entrada resultado xor
      i_NOT_A     : in  std_logic_vector (31 downto 0);  -- entrada resultado not A
	   i_SELETOR   : in  std_logic_vector (2  downto 0);  -- entrada seletor
      o_RESULTADO : out std_logic_vector (31 downto 0)); -- saída resultado
end component;

begin
  -- Instâncias dos componentes
  
  -- Instância do componente soma_subtrai_32bits
  u_SOMA_SUBTRAI : soma_subtrai_32bits port map (i_A            => i_A,
																 i_B            => i_B,
																 i_SUBTRAIR     => i_SEL(0),
																 o_COUT         => w_UNUSED,
																 o_SOMA_SUBTRAI => w_0);

  -- Instância do componente a_mais_um_32bits
  u_A_MAIS_UM : somador_completo_32bits port map (i_A                => i_A,
                                                  i_B                => (others => '0'),
                                                  i_CIN              => '1',
        						                          o_COUT             => w_UNUSED,
														        o_SOMADOR_COMPLETO => w_2);

  -- Instância do componente a_32bits
  u_A : a_32bits port map (i_A => i_A,
                           o_A => w_3);

  -- Instância do componente and_32bits
  u_AND : and_32bits port map (i_A   => i_A,
                               i_B   => i_B,
                               o_AND => w_4);

  -- Instância do componente or_32bits
  u_OR : or_32bits port map (i_A  => i_A,
        			              i_B  => i_B,
        			              o_OR => w_5);

  -- Instância do componente xor_32bits
  u_XOR : xor_32bits port map (i_A   => i_A,
        				             i_B   => i_B,
                               o_XOR => w_6);

  -- Instância do componente not_a_32bits
  u_NOT_A : not_a_32bits port map (i_A     => i_A,
        				                 o_NOT_A => w_7);

  -- Instância do componente seletor_ula_3bits
  u_SELETOR : seletor_ula_3bits port map (i_SOMA      => w_0,
														i_SUBTRAI   => w_0,
														i_A_MAIS_UM => w_2,
														i_A         => w_3,
														i_AND       => w_4,
														i_OR        => w_5,
														i_XOR       => w_6,
														i_NOT_A     => w_7,
														i_SELETOR   => i_SEL,
														o_RESULTADO => W_ULA);
																										
  process(w_ULA) 
  begin
    o_ULA <= w_ULA;
    if (w_ULA = "00000000000000000000000000000000") then
      o_ZERO <= '1';
	 else
		o_ZERO <= '0';
    end if;
  end process;													
end arq_1;