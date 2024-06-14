library ieee;
use ieee.std_logic_1164.all;

entity top is
   port(
      clk, sw        : in  std_logic;
      an, sseg       : out std_logic
   );
end top;

architecture arch of top is

constant N : integer := 49999999; --100MHz / 50MHz = 2
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin

    fsm_unit: entity work.fsm(arch)
        port map(
            clk => clk,
            an => an,
            sseg => sseg,
            enable => enable,

            en <= sw(0),
            c2 <= sw(1)
            
        );
    
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

end arch;