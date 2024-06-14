library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is
    Port (
        read_reg1  : in std_logic_vector(4 downto 0);  -- Número do registrador a ser lido (primeiro)
        read_reg2  : in std_logic_vector(4 downto 0);  -- Número do registrador a ser lido (segundo)
        write_reg  : in std_logic_vector(4 downto 0);  -- Número do registrador a ser escrito
        write_data : in std_logic_vector(31 downto 0); -- Dados a serem escritos no registrador
        regwrite   : in std_logic;                     -- Sinal de controle para escrita
        clk        : in std_logic;                     -- Sinal de clock
        read_data1 : out std_logic_vector(31 downto 0);-- Dados lidos do primeiro registrador
        read_data2 : out std_logic_vector(31 downto 0) -- Dados lidos do segundo registrador
    );
end entity registers;

architecture Behavioral of registers is

    -- Definindo o tipo de arquivo de registradores
    type reg_file_type is array (0 to 31) of std_logic_vector(31 downto 0);
    signal reg_file : reg_file_type := (others => (others => '0')); -- Inicializa todos os registradores com 0

    -- Sinal de saída dos registradores
    signal reg_outs : reg_file_type;  -- Saídas individuais dos registradores

    -- Sinal de controle para escrita
    signal write_enable : std_logic_vector(31 downto 0);

    -- Componentes
    component mux32_32bit is
        port (
            i_SEL    : in  std_logic_vector(4 downto 0); -- Sinal de seleção
            i_DATA0  : in  std_logic_vector(31 downto 0); -- Dados de entrada 0
            i_DATA1  : in  std_logic_vector(31 downto 0); -- Dados de entrada 1
            i_DATA2  : in  std_logic_vector(31 downto 0); -- Dados de entrada 2
            i_DATA3  : in  std_logic_vector(31 downto 0); -- Dados de entrada 3
            i_DATA4  : in  std_logic_vector(31 downto 0); -- Dados de entrada 4
            i_DATA5  : in  std_logic_vector(31 downto 0); -- Dados de entrada 5
            i_DATA6  : in  std_logic_vector(31 downto 0); -- Dados de entrada 6
            i_DATA7  : in  std_logic_vector(31 downto 0); -- Dados de entrada 7
            i_DATA8  : in  std_logic_vector(31 downto 0); -- Dados de entrada 8
            i_DATA9  : in  std_logic_vector(31 downto 0); -- Dados de entrada 9
            i_DATA10 : in  std_logic_vector(31 downto 0); -- Dados de entrada 10
            i_DATA11 : in  std_logic_vector(31 downto 0); -- Dados de entrada 11
            i_DATA12 : in  std_logic_vector(31 downto 0); -- Dados de entrada 12
            i_DATA13 : in  std_logic_vector(31 downto 0); -- Dados de entrada 13
            i_DATA14 : in  std_logic_vector(31 downto 0); -- Dados de entrada 14
            i_DATA15 : in  std_logic_vector(31 downto 0); -- Dados de entrada 15
            i_DATA16 : in  std_logic_vector(31 downto 0); -- Dados de entrada 16
            i_DATA17 : in  std_logic_vector(31 downto 0); -- Dados de entrada 17
            i_DATA18 : in  std_logic_vector(31 downto 0); -- Dados de entrada 18
            i_DATA19 : in  std_logic_vector(31 downto 0); -- Dados de entrada 19
            i_DATA20 : in  std_logic_vector(31 downto 0); -- Dados de entrada 20
            i_DATA21 : in  std_logic_vector(31 downto 0); -- Dados de entrada 21
            i_DATA22 : in  std_logic_vector(31 downto 0); -- Dados de entrada 22
            i_DATA23 : in  std_logic_vector(31 downto 0); -- Dados de entrada 23
            i_DATA24 : in  std_logic_vector(31 downto 0); -- Dados de entrada 24
            i_DATA25 : in  std_logic_vector(31 downto 0); -- Dados de entrada 25
            i_DATA26 : in  std_logic_vector(31 downto 0); -- Dados de entrada 26
            i_DATA27 : in  std_logic_vector(31 downto 0); -- Dados de entrada 27
            i_DATA28 : in  std_logic_vector(31 downto 0); -- Dados de entrada 28
            i_DATA29 : in  std_logic_vector(31 downto 0); -- Dados de entrada 29
            i_DATA30 : in  std_logic_vector(31 downto 0); -- Dados de entrada 30
            i_DATA31 : in  std_logic_vector(31 downto 0); -- Dados de entrada 31
            o_S      : out std_logic_vector(31 downto 0)  -- Saída selecionada
        );
    end component;

    component decoder5to32 is
        port (
           i_SEL : in  std_logic_vector(4 downto 0); -- Sinal de seleção de 5 bits
           o     : out std_logic_vector(31 downto 0) -- Saída de 32 bits
        );
    end component;

    component reg_32bit is
        port (
            i_LOAD  : in  std_logic;
            i_CLR_n : in  std_logic;                  -- Clear/reset
            i_CLK   : in  std_logic;                  -- Clock
            i_D     : in  std_logic_vector(31 downto 0); -- Data input
            o_Q     : out std_logic_vector(31 downto 0)  -- Data output
        );
    end component;

begin

    -- Instância do decodificador
    decoder : decoder5to32
        port map (
            i_SEL => write_reg,
            o     => write_enable
        );

    -- Processo para controlar o sinal de escrita
    process(clk)
    begin
        if rising_edge(clk) then
            for i in 0 to 31 loop
                if regwrite = '1' and write_enable(i) = '1' then
                    reg_file(i) <= write_data;
                end if;
            end loop;
        end if;
    end process;

    -- Atribuição das saídas dos registradores
    process(reg_file)
    begin
        for i in 0 to 31 loop
            reg_outs(i) <= reg_file(i);
        end loop;
    end process;

    -- Mux para selecionar a saída correta para read_data1
    mux_reg_out1 : mux32_32bit
        port map (
            i_SEL    => read_reg1,
            i_DATA0  => reg_outs(0),
            i_DATA1  => reg_outs(1),
            i_DATA2  => reg_outs(2),
            i_DATA3  => reg_outs(3),
            i_DATA4  => reg_outs(4),
            i_DATA5  => reg_outs(5),
            i_DATA6  => reg_outs(6),
            i_DATA7  => reg_outs(7),
            i_DATA8  => reg_outs(8),
            i_DATA9  => reg_outs(9),
            i_DATA10 => reg_outs(10),
            i_DATA11 => reg_outs(11),
            i_DATA12 => reg_outs(12),
            i_DATA13 => reg_outs(13),
            i_DATA14 => reg_outs(14),
            i_DATA15 => reg_outs(15),
            i_DATA16 => reg_outs(16),
            i_DATA17 => reg_outs(17),
            i_DATA18 => reg_outs(18),
            i_DATA19 => reg_outs(19),
            i_DATA20 => reg_outs(20),
            i_DATA21 => reg_outs(21),
            i_DATA22 => reg_outs(22),
            i_DATA23 => reg_outs(23),
            i_DATA24 => reg_outs(24),
            i_DATA25 => reg_outs(25),
            i_DATA26 => reg_outs(26),
            i_DATA27 => reg_outs(27),
            i_DATA28 => reg_outs(28),
            i_DATA29 => reg_outs(29),
            i_DATA30 => reg_outs(30),
            i_DATA31 => reg_outs(31),
            o_S      => read_data1
        );

    -- Mux para selecionar a saída correta para read_data2
    mux_reg_out2 : mux32_32bit
        port map (
            i_SEL    => read_reg2,
            i_DATA0  => reg_outs(0),
            i_DATA1  => reg_outs(1),
            i_DATA2  => reg_outs(2),
            i_DATA3  => reg_outs(3),
            i_DATA4  => reg_outs(4),
            i_DATA5  => reg_outs(5),
            i_DATA6  => reg_outs(6),
            i_DATA7  => reg_outs(7),
            i_DATA8  => reg_outs(8),
            i_DATA9  => reg_outs(9),
            i_DATA10 => reg_outs(10),
            i_DATA11 => reg_outs(11),
            i_DATA12 => reg_outs(12),
            i_DATA13 => reg_outs(13),
            i_DATA14 => reg_outs(14),
            i_DATA15 => reg_outs(15),
            i_DATA16 => reg_outs(16),
            i_DATA17 => reg_outs(17),
            i_DATA18 => reg_outs(18),
            i_DATA19 => reg_outs(19),
            i_DATA20 => reg_outs(20),
            i_DATA21 => reg_outs(21),
            i_DATA22 => reg_outs(22),
            i_DATA23 => reg_outs(23),
            i_DATA24 => reg_outs(24),
            i_DATA25 => reg_outs(25),
            i_DATA26 => reg_outs(26),
            i_DATA27 => reg_outs(27),
            i_DATA28 => reg_outs(28),
            i_DATA29 => reg_outs(29),
            i_DATA30 => reg_outs(30),
            i_DATA31 => reg_outs(31),
            o_S      => read_data2
        );
   
end architecture Behavioral;
