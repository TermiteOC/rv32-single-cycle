 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder5to32 is
    port (
        i_SEL : in  std_logic_vector(4 downto 0); -- Sinal de seleção de 5 bits
        o     : out std_logic_vector(31 downto 0) -- Saída de 32 bits
    );
end entity decoder5to32;

architecture Behavioral of decoder5to32 is
begin
    process(i_SEL)
    begin
        -- Inicializa todas as saídas para '0'
        o <= (others => '0');
        -- Define a saída correspondente ao valor de i_SEL para '1'
        case to_integer(unsigned(i_SEL)) is
            when 0  => o(0)  <= '1';
            when 1  => o(1)  <= '1';
            when 2  => o(2)  <= '1';
            when 3  => o(3)  <= '1';
            when 4  => o(4)  <= '1';
            when 5  => o(5)  <= '1';
            when 6  => o(6)  <= '1';
            when 7  => o(7)  <= '1';
            when 8  => o(8)  <= '1';
            when 9  => o(9)  <= '1';
            when 10 => o(10) <= '1';
            when 11 => o(11) <= '1';
            when 12 => o(12) <= '1';
            when 13 => o(13) <= '1';
            when 14 => o(14) <= '1';
            when 15 => o(15) <= '1';
            when 16 => o(16) <= '1';
            when 17 => o(17) <= '1';
            when 18 => o(18) <= '1';
            when 19 => o(19) <= '1';
            when 20 => o(20) <= '1';
            when 21 => o(21) <= '1';
            when 22 => o(22) <= '1';
            when 23 => o(23) <= '1';
            when 24 => o(24) <= '1';
            when 25 => o(25) <= '1';
            when 26 => o(26) <= '1';
            when 27 => o(27) <= '1';
            when 28 => o(28) <= '1';
            when 29 => o(29) <= '1';
            when 30 => o(30) <= '1';
            when 31 => o(31) <= '1';
            when others => null; -- No default case needed
        end case;
    end process;
end architecture Behavioral;
