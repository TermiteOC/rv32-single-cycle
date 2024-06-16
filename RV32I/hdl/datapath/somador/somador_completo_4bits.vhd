library IEEE;
use IEEE.std_logic_1164.all;
 
entity somador_completo_4bits is
port ( i_A                : in  std_logic_vector (3 downto 0);  -- entrada A
	     i_B                : in  std_logic_vector (3 downto 0);  -- entrada B
       i_CIN              : in  std_logic;                      -- entrada carry in
       o_COUT             : out std_logic;                      -- saída carry out
       o_SOMADOR_COMPLETO : out std_logic_vector (3 downto 0)); -- saída resultado
end somador_completo_4bits;
 
architecture arq_1 of somador_completo_4bits is
  component somador_completo_1bit
  port ( i_A                : in  std_logic;  -- entrada A
	       i_B                : in  std_logic;  -- entrada B
         i_CIN              : in  std_logic;  -- entrada carry in
         o_COUT             : out std_logic;  -- saída carry out
         o_SOMADOR_COMPLETO : out std_logic); -- saída resultado somador completo
  end component;
  
  signal w_C1, w_C2, w_C3 : std_logic;

begin
  u_SOMADOR_COMPLETO0 : somador_completo_1bit port map ( i_A                => i_A(0), 
                                                         i_B                => i_B(0),
																		                     i_CIN              => i_CIN,
																		                     o_COUT             => w_C1,
																		                     o_SOMADOR_COMPLETO => o_SOMADOR_COMPLETO(0));

  u_SOMADOR_COMPLETO1 : somador_completo_1bit port map ( i_A                => i_A(1), 
																		                     i_B                => i_B(1),
																		                     i_CIN              => w_C1,
																		                     o_COUT             => w_C2,
																		                     o_SOMADOR_COMPLETO => o_SOMADOR_COMPLETO(1));

  u_SOMADOR_COMPLETO2 : somador_completo_1bit port map ( i_A                => i_A(2), 
																		                     i_B                => i_B(2),
																		                     i_CIN              => w_C2,
																		                     o_COUT             => w_C3,
																		                     o_SOMADOR_COMPLETO => o_SOMADOR_COMPLETO(2));
  
  u_SOMADOR_COMPLETO3 : somador_completo_1bit port map ( i_A                => i_A(3), 
																		                     i_B                => i_B(3),
																		                     i_CIN              => w_C3,
																		                     o_COUT             => o_COUT,
																		                     o_SOMADOR_COMPLETO => o_SOMADOR_COMPLETO(3));
end arq_1;
