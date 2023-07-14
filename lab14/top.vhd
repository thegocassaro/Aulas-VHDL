library ieee;
use ieee.std_logic_1164.all;

entity top is

    port(

        sw : in std_logic_vector (7 downto 0),
        led : out std_logic_vector (3 downto 0)

    );

end top;

architecture mux_top_arch of top is
begin

    MUX_4x1_1 : entity work.mux_4x1(cond_arch)

    port map(



    );

end mux_top_arch;

--codificador de prioridade
architecture cod_prio_top_arch of top is
begin

    port map(

        r(2) => sw(6),

    );

end cod_prio_top_arch;