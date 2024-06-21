library ieee;
use ieee.std_logic_1164.all;

entity top is

port(
    clk, button1, button2   : in std_logic;
    an, sseg                : out std_logic_vector(7 downto 0)
);

end top;


architecture arch_top of top is

constant N : integer := 99999;
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin 

    --divisor de clock
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


    fsm_unit : entity work.fsm_parking_lot(arch_fsm)
    
    port map(

        clk => clk,
        enable => enable,
        an => an,
        sseg => sseg,
        reset => '0',

        button1 => a,
        button2 => b

    );

end arch_top;