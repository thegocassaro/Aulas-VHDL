library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity div_clk is
    Port ( clk : in STD_LOGIC;
           en : out STD_LOGIC);
end div_clk;

architecture Behavioral of div_clk is
constant N : integer := 49999999; 
signal divide_clk : integer range 0 to N;
begin

 PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            divide_clk <= divide_clk+1;
            IF divide_clk = N THEN
                divide_clk <= 0;
            END IF;
        END IF;
 END PROCESS;
 
 en <= '1' when divide_clk = N else '0';

end Behavioral;
