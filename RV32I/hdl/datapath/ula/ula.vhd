library IEEE;
use IEEE.std_logic_1164.all;

entity ula is
port ( i_A    : in  std_logic_vector(31 downto 0);  -- entrada A
       i_B    : in  std_logic_vector(31 downto 0);  -- entrada B
       i_SEL  : in  std_logic_vector(3  downto 0);  -- seletor de operação
		   o_ZERO : out std_logic;                       -- saída flag zero
       o_ULA  : out std_logic_vector(31 downto 0)); -- saída resultado
end ula;

architecture arq_1 of ula is
  component and_32bits is
  port ( i_A   : in  std_logic_vector(31 downto 0);  -- entrada A
	       i_B   : in  std_logic_vector(31 downto 0);  -- entrada B
         o_AND : out std_logic_vector(31 downto 0)); -- saída resultado and_32bits
  end component;

  component or_32bits is
  port ( i_A  : in  std_logic_vector(31 downto 0);  -- entrada A
	       i_B  : in  std_logic_vector(31 downto 0);  -- entrada B
         o_OR : out std_logic_vector(31 downto 0)); -- saída resultado or_32bits
  end component;

  component soma_subtrai_32bits is
  port ( i_A            : in  std_logic_vector(31 downto 0);  -- entrada A
         i_B            : in  std_logic_vector(31 downto 0);  -- entrada B
         i_SUBTRAIR     : in  std_logic;                       -- entrada =0 soma normal, =1 faz o complemento de 2 e subtrai
         o_COUT         : out std_logic;                       -- saída carry out
         o_SOMA_SUBTRAI : out std_logic_vector(31 downto 0)); -- saída resultado
  end component;

  component slt_32bits is
  port ( i_A   : in  std_logic_vector(31 downto 0);  -- entrada A
	       i_B   : in  std_logic_vector(31 downto 0);  -- entrada B
         o_SLT : out std_logic_vector(31 downto 0)); -- saída resultado slt_32bits
  end component;

  component nor_32bits is
  port ( i_A   : in  std_logic_vector(31 downto 0);  -- entrada A
	       i_B   : in  std_logic_vector(31 downto 0);  -- entrada B
         o_NOR : out std_logic_vector(31 downto 0)); -- saída resultado nor_32bits
  end component;


  component seletor_ula is
  port ( i_AND          : in  std_logic_vector(31 downto 0);  -- entrada resultado AND
         i_OR           : in  std_logic_vector(31 downto 0);  -- entrada resultado OR
         i_ADD_SUBTRACT : in  std_logic_vector(31 downto 0);  -- entrada resultado ADD/SUBTRACT
         i_SLT          : in  std_logic_vector(31 downto 0);  -- entrada resultado SET LESS THAN
         i_NOR          : in  std_logic_vector(31 downto 0);  -- entrada resultado NOR
	       i_SELETOR      : in  std_logic_vector(3  downto 0);  -- entrada seletor
         o_RESULTADO    : out std_logic_vector(31 downto 0)); -- saída resultado
  end component;
  
  signal w_0, w_1, w_2, w_3, w_4, w_ULA : std_logic_vector(31 downto 0);

begin
  -- Instâncias dos componentes
  u_AND : and_32bits port map ( i_A   => i_A,
                                i_B   => i_B,
                                o_AND => w_0);
								 
  u_OR : or_32bits port map ( i_A  => i_A,
                              i_B  => i_B,
                              o_OR => w_1);
									  
  u_SOMA_SUBTRAI : soma_subtrai_32bits port map ( i_A            => i_A,
                                                  i_B            => i_B,
                                                  i_SUBTRAIR     => i_SEL(2),
                                                  o_SOMA_SUBTRAI => w_2);
																 															 
  u_SLT : slt_32bits port map ( i_A   => i_A,
                                i_B   => i_B,
                                o_SLT => w_3);																 																 
																  
  u_NOR : nor_32bits port map ( i_A   => i_A,
                                i_B   => i_B,
                                o_NOR => w_4);

  u_SELETOR : seletor_ula port map ( i_AND          => w_0,
														         i_OR           => w_1,
														         i_ADD_SUBTRACT => w_2,
														         i_SLT          => w_3,
														         i_NOR          => w_4,
														         i_SELETOR      => i_SEL,
														         o_RESULTADO    => W_ULA);
																										
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