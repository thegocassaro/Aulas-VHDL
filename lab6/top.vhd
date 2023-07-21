library ieee;
use ieee.std_logic_1164.all;

entity top is

    port(
        sw : in std_logic_vector (8 downto 0),
        led : out std_logic_vector (4 downto 0)
    );

end top;

architecture main of top is
    signal estouro : std_logic;
    signal a : std_logic_vector (3 downto 0);
    signal sum : std_logic_vector (3 downto 0);

begin
    mode : entity work.mux(arch_mux)
        port map (
            mode => sw(8),
            num_in => sw(7 downto 4),
            num_out => a
        );

    som_sub : entity work.som_4bits(arch_som_4bits)
        port map(
            a => a,
            b => sw(3 downto 0),
            sum => sum,
            co => estouro
        );

    led <= sum when estouro = '0' else
        "10000";

end main;