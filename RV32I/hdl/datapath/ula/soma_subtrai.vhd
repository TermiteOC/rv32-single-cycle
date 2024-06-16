library IEEE;
use IEEE.std_logic_1164.all;

entity soma_subtrai_32bits is
port ( i_A            : in  std_logic_vector (31 downto 0);  -- entrada A
       i_B            : in  std_logic_vector (31 downto 0);  -- entrada B
       i_SUBTRAIR     : in  std_logic;                       -- entrada =0 soma normal, =1 faz o complemento de 2 e subtrai
		   o_COUT         : out std_logic;                       -- saída carry out
       o_SOMA_SUBTRAI : out std_logic_vector (31 downto 0)); -- saída resultado
end soma_subtrai_32bits;

architecture arq_1 of soma_subtrai_32bits is
  component somador_completo_32bits
  port ( i_A                : in  std_logic_vector (31 downto 0);  -- entrada A
	       i_B                : in  std_logic_vector (31 downto 0);  -- entrada B
         i_CIN              : in  std_logic;                       -- entrada carry in
         o_COUT             : out std_logic;                       -- saída carry out
         o_SOMADOR_COMPLETO : out std_logic_vector (31 downto 0)); -- saída resultado
  end component;

  component complemento_32bits is
  port ( i_B        : in  std_logic_vector (31 downto 0);  -- entrada B
	       i_SUBTRAIR : in  std_logic;                       -- entrada subtrair
         o_B        : out std_logic_vector (31 downto 0)); -- saída resultado complemento_32bits
  end component;
  
  signal w_B : std_logic_vector(31 downto 0); -- entrada B que passa pelo componente 'complemento_32bits' do 'soma_subtrai'

begin
  -- Instâncias dos componentes
  u_COMPLEMENTO : complemento_32bits port map ( i_B        => i_B,
															                  i_SUBTRAIR => i_SUBTRAIR,
															                  o_B        => w_B);     
                                          
  u_SOMADOR_COMPLETO : somador_completo_32bits port map ( i_A                => i_A, 
																			                    i_B                => w_B,
                                                          i_CIN              => i_SUBTRAIR,
                                                          o_COUT             => o_COUT,
                                                          o_SOMADOR_COMPLETO => o_SOMA_SUBTRAI);
end arq_1;