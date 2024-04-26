library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_5 is

    port(

        sw: in std_logic_vector(5 downto 0),
        led: out std_logic_vector (2 downto 0)
    );

end top_5;


architecture top_arch of top_5 is

    signal prio_signal : in std_logic_vector(1 downto 0);

begin

    prio_encoder32_unit : entity work.prio_encoder32(cond_arch)

    port map(
        sw(2 downto 0) => r,
        code => prio_signal
    );

    --fazer um pra cada bit do num, do mais significativo pro menos
    mux_4x1_unit1 : entity work.mux_4x1(case_arch)

    port map(
        prio_signal => s,
        --fazer aqui as opcoes (y3 ou y0 ou y-1, etc..)
        -- yx => dado(0),
        -- yx => dado(1),
        -- yx => dado(2),
        x => led(2)
    );

    --repetir pro resto dos bits

end top_arch;