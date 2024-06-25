library ieee;
use ieee.std_logic_1164.all;

entity top is

port(
    clk                     : in std_logic;
    btn                     : in std_logic_vector(2 downto 0);
    an, sseg                : out std_logic_vector(7 downto 0)
);

end top;


architecture arch_top of top is

constant N : integer := 99999;
signal enable : std_logic;
signal divide_clk : integer range 0 to N;
signal ab : std_logic_vector(1 downto 0);
signal car_enter, car_exit : std_logic;

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
    
    --debounces
    debounce_unit_a : entity work.db_fsm(arch)
    
    port map(
        clk => clk,
        sw => btn(1),
        db => ab(1),
        reset => '0'
    );
    
    debounce_unit_b : entity work.db_fsm(arch)
        
    port map(
        clk => clk,
        sw => btn(0),
        db => ab(0),
        reset => '0'
    );

    --fsm
    fsm_unit : entity work.fsm_parking_lot(arch_fsm)
    
    port map(

        clk => clk,
        enable => enable,
        reset => '0',

        a=>ab(1),
        b=>ab(0),

        car_enter => car_enter,
        car_exit => car_exit

    );
    
    --contador
    contador_unit : entity work.debounce_test(arch)
    
    port map(
        clk => clk,
        inc => car_enter,
        dec => car_exit,
        clr => btn(2),
        an => an,
        sseg => sseg
    );

end arch_top;

--onde eu poderia colocar o edge detecion circuit?