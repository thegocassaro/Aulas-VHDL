library ieee;
use ieee.std_logic_1164.all;

entity top is
    port(
        an : out std_logic_vector(7 downto 0);
        sseg : out std_logic_vector(7 downto 0);
        clk: in std_logic
    );

end top;

architecture top_arch of top is

    constant N : integer := 49999999; 
    signal enable : std_logic;
    signal divide_clk : integer range 0 to N;

-----

    led_mux_unit : entity work.led_mux8(arch)

    port map(

        clk => clk,
        an => an,
        sseg => sseg,
        reset => '0',

        in0 => "10000001",
        in1 => "11001111",
        in2 => "10010010",
        in3 => "10000110",
        in4 => "11001101",
        in5 => "10100101",
        in6 => "10110000",
        in7 => "10001111"
    );

    --divide_clk
    enable <= '1' when divide_clk = N else '0';
     
     PROCESS (clk)
        BEGIN
            IF (clk'EVENT AND clk='1') THEN
                divide_clk <= divide_clk+1;
                IF divide_clk = N THEN
                    divide_clk <= 0;
                END IF;
            END IF;
     END PROCESS;

end top_arch;