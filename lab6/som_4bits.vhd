library ieee;
use ieee.std_logic_1164.all;

entity som_4bits is
    port(
        a : in std_logic_vector (3 downto 0);
        b : in std_logic_vector (3 downto 0);
        sum : out std_logic_vector (3 downto 0);
        co : out std_logic
    );
end som_4bits;

architecture arch_som_4bits of som_4bits is
    signal c0, c1, c2 : std_logic;

begin

    soma_1 : entity work.som_1bit(arch_som_1bit)
        port map(
            a => a(0),
            b => b(0),
            ci => '0',
            co => c0,
            sum => sum(0)
        );
    soma_2 : entity work.som_1bit(arch_som_1bit)
        port map(
            a => a(1),
            b => b(1),
            ci => c0,
            co => c1,
            sum => sum(1)
        );
    soma_3 : entity work.som_1bit(arch_som_1bit)
        port map(
            a => a(2),
            b => b(2),
            ci => c1,
            co => c2,
            sum => sum(2)
        );
    soma_1 : entity work.som_1bit(arch_som_1bit)
        port map(
            a => a(3),
            b => b(3),
            ci => c2,
            co => co,
            sum => sum(3)
        );

end arch_som_4bits;