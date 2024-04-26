--=============================
-- Listing 4.2
--=============================
library ieee;
use ieee.std_logic_1164.all;
entity decoder4 is
   port(
      s: in  std_logic_vector(1 downto 0);
      x: out std_logic_vector(3 downto 0)
   );
end decoder4;

architecture cond_arch of decoder4 is
begin
    x <= "0001" when s = "00" else
         "0010" when s = "01" else
         "0100" when s = "10" else
         "1000";
end cond_arch;


--=============================
-- Listing 4.6
--=============================
architecture sel_arch of decoder4 is
begin
   with s select
     x <= "0001" when "00",
          "0010" when "01",
          "0100" when "10",
          "1000" when others;
end sel_arch;
--=============================
-- Listing 5.2
--=============================
architecture if_arch of decoder4 is
begin
   process(s)
   begin
      if (s="00") then
         x <= "0001";
      elsif (s="01")then
         x <= "0010";
      elsif (s="10")then
         x <= "0100";
      else
         x <= "1000";
      end if;
   end process;
end if_arch;

--=============================
-- Listing 5.7
--=============================
architecture case_arch of decoder4 is
begin
   process(s)
   begin
      case s is
         when "00" =>
            x <= "0001";
         when "01" =>
            x <= "0010";
         when "10" =>
            x <= "0100";
         when others =>
            x <= "1000";
      end case;
   end process;
end case_arch;
