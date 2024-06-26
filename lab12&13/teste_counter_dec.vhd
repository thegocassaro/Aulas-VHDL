library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity counter is
   port(
      clk  : in  std_logic;
      inc, dec : in std_logic;
      clr  : in  std_logic;

      an   : out std_logic_vector(7 downto 0);
      sseg : out std_logic_vector(7 downto 0)
   );
end counter;

architecture arch of counter is
   signal unit0, unit1, unit2 : unsigned(3 downto 0); --3 units pra 3 casas decimais/ vetor unsigned de 4 pra poder contar ate 9 (> 2³)
   signal unit0_next          : unsigned(3 downto 0);
   signal dec2, dec1, dec0 : std_logic_vector(3 downto 0);

   begin

    --itera unidade display

   process(clk)
   begin
      if (clk'event and clk='1') then
         unit0 <= unit0_next;
      end if;
   end process;


   unit0_next <=  unit0 + 1  when inc='1' else
                  unit0 - 1  when dec='1' else
                  unit0;
   

   if unit0 = '9' and inc = '1' then
         unit1 <= unit1 + 1;
         unit0 <= (others=>'0');
      end if;
   if unit1 = '9' and unit0 = '9' and inc = '1' then
         unit2 <= unit2 + 1;
         unit1 <= (others=>'0');
         unit0 <= (others=>'0');
      end if;
   --repete para subtracao
   --e faz um pro clear tb


   dec2 <= std_logic_vector(unit2);
   dec1 <= std_logic_vector(unit1);
   dec0 <= std_logic_vector(unit0);

   end arch;