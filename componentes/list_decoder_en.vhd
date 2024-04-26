--=============================
-- Listing 4.2 modificado Eliete
--=============================
library ieee;
use ieee.std_logic_1164.all;
entity decoder4en is
   port(
      s: in  std_logic_vector(1 downto 0);
		enable: in std_logic;
      x: out std_logic_vector(3 downto 0)
   );
end decoder4en;

architecture cond_arch of decoder4en is
begin
    x <= "0000" when enable = '0' else
	      "0001" when s = "00" else
         "0010" when s = "01" else
         "0100" when s = "10" else
         "1000";
end cond_arch;

