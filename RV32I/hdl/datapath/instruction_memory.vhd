library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is										
port ( i_ADDR : in  std_logic_vector(31 downto 0);  -- Endereço de memória
       o_OUT  : out std_logic_vector(31 downto 0)); -- Dados de saída
end instruction_memory;
	
architecture arq_1 of instruction_memory is
  type t_MEMORY is array (0 to 255) of std_logic_vector (31 downto 0); -- Cria um tipo memory_array que e um vetor de 256 posicoes que guarda 32 bits em cada uma delas
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
	
begin 
  o_OUT <= w_MEM(to_integer(unsigned(i_ADDR(9 downto 2))));
end arq_1;