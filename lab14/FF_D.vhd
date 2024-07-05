library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_D is
    Port ( D : in STD_LOGIC;
           e : in STD_LOGIC;
           Q : out STD_LOGIC;
           clk : in STD_LOGIC);
end FF_D;

architecture Behavioral of FF_D is

begin
process(clk,e)
begin
   if (clk'event and clk='1') then
      if (e='1') then
         Q <= D;
      end if;
   end if;
end process;

end Behavioral;
