library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is										
  Port (i_CLK  : in  std_logic;							   -- Clock
        i_ADDR : in  std_logic_vector (31 downto 0);  -- Endereço de memória
        o_OUT  : out std_logic_vector (31 downto 0)); -- Dados de saída
end instruction_memory;
	
architecture arq_1 of instruction_memory is
  type t_MEMORY is array (0 to 255) of std_logic_vector (31 downto 0);	-- Cria um tipo memory_array que e um vetor de 256 posicoes que guarda 32 bits em cada uma delas
  
  function init_rom
		return t_MEMORY is 
		variable tmp : t_MEMORY := (others => (others => '0'));
	begin 
		for addr_pos in 0 to 255 loop 
			-- Initialize each address with the address itself
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos * 4, 32));
		end loop;
		return tmp;
	end init_rom;
	
	signal w_MEM : t_MEMORY := init_rom;			  -- Sinal memory do tipo vetor
	signal w_RDATA: std_logic_vector(31 downto 0); -- Sinal para armazenar o dado lido do endereço apontado por ADDR
	
begin
  process(i_CLK)
  begin
    if rising_edge(i_CLK) then
      w_RDATA <= w_MEM(to_integer(unsigned(i_ADDR(7 downto 0)))); -- RDATA armazena o dado apontado por ADDR (só os 8 primeiros bits do endereço)
    end if;
  end process;
	 
  o_OUT <= w_RDATA;
	 
end arq_1;