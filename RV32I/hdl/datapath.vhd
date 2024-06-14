library IEEE;
use IEEE.std_logic_1164.all;

entity datapath is
port ( i_I : in  std_logic;
       o_O : out std_logic);
end datapath;

architecture arch_1 of datapath is
  -- Declaracao de Sinais
  signal w_W : std_logic;
  
  -- Declaracao de Componentes
  component entidade is
  port ( i_I : in  std_logic;
         o_O : out std_logic);
  end component;
  
begin
  -- Instancias de Componentes
  u_U: entidade port map ( i_I => i_I,
                           o_O => o_O);				
end arch_1;