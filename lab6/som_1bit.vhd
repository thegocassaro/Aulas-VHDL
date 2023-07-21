library ieee;
use ieee.std_logic_1164.all;

entity som_1bit is
    port(
        a : in std_logic;
        b : in std_logic;
        ci : in std_logic;
        co : out std_logic;
        sum : out std_logic
    );
end som_1bit;

architecture arch_som_1bit of som_1bit is

begin

    sum <= a xor b xor ci;
    co <= (a and b) or (a and ci) or (b and ci);

end arch_som_1bit;

