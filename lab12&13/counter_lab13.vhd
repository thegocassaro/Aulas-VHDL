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
   -- signal q1_reg, q1_next   : unsigned(7 downto 0);
   signal q0_reg, q0_next   : unsigned(7 downto 0);

   -- signal b_count  : std_logic_vector(7 downto 0);
   signal d_count  : std_logic_vector(7 downto 0);

   -- signal btn_reg, db_reg   : std_logic;
   -- signal db_level, db_tick : std_logic;
   -- signal btn_tick, clr     : std_logic;

begin

   an(7 downto 4)<="111111";
   
   -- instantiate hex display time-multiplexing circuit
   disp_unit : entity work.disp_hex_mux(arch)
      port map(
         clk   => clk,
         reset => '0',

         hex3  => d_count(7 downto 4),
         hex2  => d_count(3 downto 0),  
         -- hex1  => b_count(7 downto 4),  
         -- hex0  => b_count(3 downto 0), 
          
         an    => an(1 downto 0),   --esperado contar de 0 a FF      
         sseg  => sseg
      );

   -- instantiate debouncing circuit
   -- db_unit : entity work.db_fsm(arch)
   --    port map(
   --       clk   => clk,
   --       reset => '0',
   --       sw    => btn(1),
   --       db    => db_level
   --    );

   -- --*****************************************************************
   -- -- edge detection circuits
   -- --*****************************************************************
   -- process(clk)
   -- begin
   --    if (clk'event and clk = '1') then
   --       btn_reg <= btn(1);
   --       db_reg  <= db_level;
   --    end if;
   -- end process;
   -- btn_tick <= (not btn_reg) and btn(1);
   -- db_tick  <= (not db_reg) and db_level;

   --*****************************************************************
   -- two counters
   --*****************************************************************
   -- clr <= btn(0);


   --O jeito q eu entendi que funciona eh q q0_reg eh incrementado (no caso do lab13
   --a cada vez que car_enter apresentar nivel logico 1) e a conta eh interpretada na
   --base binaria, ou seja, começando por "00000000" -> "00000001" -> "00000010" -> ... (q0_reg)
   --Dessa forma, quando queremos pegar unidade e dezena, basta dividirmos o vetor de 8 (d_count 7 downto 0)
   --ao meio: "0000"(dezena) e "0010"(unidade), porem desse jeito ficamos restritos a contar
   --em hexadecimal, ja que _ _ _ _ (2³ 2² 2¹ 2⁰), logo de 0 a 15. A dezena seria hex3
   --e a unidade hex2.


   process(clk)
   begin
      if (clk'event and clk='1') then
         -- q1_reg <= q1_next;
         q0_reg <= q0_next;
      end if;
   end process;
   -- next-state logic for the counter
   -- q1_next <= (others=>'0') when clr='1' else
   --            q1_reg + 1    when btn_tick='1' else
   --            q1_reg;
   q0_next <= (others=>'0') when clr='1' else
              q0_reg + 1    when inc='1' else
              q0_reg - 1    when dec='1' else
              q0_reg;
   --output
   -- b_count <= std_logic_vector(q1_reg);
   d_count <= std_logic_vector(q0_reg);

end arch;
