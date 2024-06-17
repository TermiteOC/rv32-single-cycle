library IEEE;
use IEEE.std_logic_1164.all;
 
entity somador_completo_32bits is
port ( i_A                : in  std_logic_vector(31 downto 0);  -- entrada A
	     i_B                : in  std_logic_vector(31 downto 0);  -- entrada B
       i_CIN              : in  std_logic;                       -- entrada carry in
       o_COUT             : out std_logic;                       -- saída carry out
       o_SOMADOR_COMPLETO : out std_logic_vector(31 downto 0)); -- saída resultado
end somador_completo_32bits;
 
architecture arq_1 of somador_completo_32bits is
  component somador_completo_16bits
  port ( i_A                : in  std_logic_vector(15 downto 0);  -- entrada A
	       i_B                : in  std_logic_vector(15 downto 0);  -- entrada B
         i_CIN              : in  std_logic;                       -- entrada carry in
         o_COUT             : out std_logic;                       -- saída carry out
         o_SOMADOR_COMPLETO : out std_logic_vector(15 downto 0)); -- saída resultado
  end component;
  
  signal w_C1 : std_logic;
  signal w_B  : std_logic_vector(31 downto 0);

begin
  u_SOMADOR_COMPLETO0 : somador_completo_16bits port map ( i_A                => i_A(15 downto 0), 
                                                           i_B                => i_B(15 downto 0),
																			                     i_CIN              => i_CIN,
																			                     o_COUT             => w_C1,
																			                     o_SOMADOR_COMPLETO => o_SOMADOR_COMPLETO(15 downto 0));
  
  u_SOMADOR_COMPLETO1 : somador_completo_16bits port map ( i_A                => i_A(31 downto 16), 
                                                           i_B                => i_B(31 downto 16),
																			                     i_CIN              => w_C1,
																			                     o_COUT             => o_COUT,
																			                     o_SOMADOR_COMPLETO => o_SOMADOR_COMPLETO(31 downto 16));
end arq_1;