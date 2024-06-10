library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is										
  Port ( i_CLK  : in  std_logic;							   -- Clock
         i_ADDR : in  std_logic_vector (31 downto 0);  -- Endereço de memória
         o_OUT  : out std_logic_vector (31 downto 0)); -- Dados de saída
end instruction_memory;
	
architecture arq_1 of instruction_memory is
  type t_MEMORY is array (0 to 255) of std_logic_vector (31 downto 0);	-- Cria um tipo memory_array que e um vetor de 256 posicoes que guarda 32 bits em cada uma delas
  signal w_MEM : t_MEMORY := (
    0 => "00000000010000000000010010010011",
    1 => "00000000001100000000100100010011",
    2 => "00000000001000000000100110010011",
    3 => "00000000000100000000101000010011",
    4 => "00000001001001001000001010110011",
    5 => "00000001010010011000001100110011",
    6 => "01000000011000101000010000110011",
    others => (others => '0')
  );
  signal w_RDATA: std_logic_vector(31 downto 0); -- Sinal para armazenar o dado lido do endereço apontado por ADDR
	
begin
  w_MEM(0) <= "00000000010000000000010010010011";
  w_MEM(1) <= "00000000001100000000100100010011";
  w_MEM(2) <= "00000000001000000000100110010011";
  w_MEM(3) <= "00000000000100000000101000010011";
  w_MEM(4) <= "00000001001001001000001010110011";
  w_MEM(5) <= "00000001010010011000001100110011";
  w_MEM(6) <= "01000000011000101000010000110011";
  
  process(i_CLK)
  begin
    if rising_edge(i_CLK) then
      w_RDATA <= w_MEM(to_integer(unsigned(i_ADDR(7 downto 0)))); -- RDATA armazena o dado apontado por ADDR (só os 8 primeiros bits do endereço)
    end if;
  end process;
	 
  o_OUT <= w_RDATA;
	 
end arq_1;