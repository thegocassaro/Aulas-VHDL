library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_5 is

    port(
        sw: in std_logic_vector(7 downto 0);
        led: out std_logic_vector (2 downto 0)
    );

end top_5;


architecture top_arch of top_5 is

    signal prio_signal : std_logic_vector(1 downto 0);

begin

    prio_encoder32_unit : entity work.prio_encoder32(cond_arch)

    port map(
        r => sw(2 downto 0),
        code => prio_signal
    );

    --fazer um pra cada bit do num, do mais significativo pro menos
    mux_4x1_unit1 : entity work.mux4(case_arch)
    port map(
        s => prio_signal,
        --fazer aqui as opcoes (y3 ou y0 ou y-1, etc..)
        dado(3) => sw(7),   --direita
        dado(2) => sw(4),   --circular
        dado(1) => sw(5),   --esquerda
        dado(0) => sw(6),   --mantem
        
        x => led(2)
    );

    --repetir pro resto dos bits
    mux_4x1_unit2 : entity work.mux4(case_arch)

    port map(
        s => prio_signal,
        dado(3) => sw(6),   --direita
        dado(2) => sw(6),   --circular
        dado(1) => sw(4),   --esquerda
        dado(0) => sw(5),   --mantem
        
        x => led(1)
    );
        
    mux_4x1_unit3 : entity work.mux4(case_arch)

    port map(
        s => prio_signal,
        dado(3) => sw(5),   --direita
        dado(2) => sw(5),   --circular
        dado(1) => sw(3),   --esquerda
        dado(0) => sw(4),   --mantem
        
        x => led(0)
    );

end top_arch;
