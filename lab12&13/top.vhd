library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity estacionamento is
   port(
      clk   : in  std_logic;
      btn   : in  std_logic_vector(2 downto 0);
      an    : out std_logic_vector(7 downto 0);  -- Modifica��es Anselmo e Fabi
      sseg  : out std_logic_vector(7 downto 0);
      led   : out std_logic_vector(1 downto 0)
   );
end estacionamento;

architecture arch of estacionamento is
   signal q0_reg, q0_next   : unsigned(15 downto 0);
   signal count  : std_logic_vector(15 downto 0);
   signal a, b, inc, dec : std_logic;
   signal clr     : std_logic;
begin
   --*****************************************************************
   -- Modifica��es Anselmo e Fabi
   --*****************************************************************
       an(7 downto 4)<="1111";
        
        
   --*****************************************************************
   -- component instantiation
   --*****************************************************************
   -- instantiate hex display time-multiplexing circuit
   disp_unit : entity work.disp_hex_mux
      port map(
         clk   => clk,
         reset => '0',
         hex3  => count(15 downto 12),
         hex2  => count(11 downto 8), 
         hex1  => count(7 downto 4), 
         hex0  => count(3 downto 0), 
         dp_in => "1111",
         an    => an(3 downto 0), 
         sseg  => sseg
      );
   -- instantiate debouncing circuit
   db_unit_1 : entity work.db_fsm(arch)
      port map(
         clk   => clk,
         reset => '0',
         sw    => btn(1),
         db    => a
      );
        
    db_unit_0 : entity work.db_fsm(arch)
         port map(
            clk   => clk,
            reset => '0',
            sw    => btn(0),
            db    => b
         );

   clr <= btn(2);
   
   --fsm
   
  fsm_1: entity work.FSM(Behavioral)
       Port map( 
              s1    => a,  
              s2    => b, 
              INC   => inc,
              DEC   => dec, 
              CLK   => clk 
        );
   led(1) <= inc;
   led(0) <= dec;

   --O jeito q eu entendi que funciona eh q q0_reg eh incrementado (no caso do lab13
   --a cada vez que car_enter apresentar nivel logico 1) e a conta eh interpretada na
   --base binaria, ou seja, começando por "00000000" -> "00000001" -> "00000010" -> ... (q0_reg)
   --Dessa forma, quando queremos pegar unidade e dezena, basta dividirmos o vetor de 8 (d_count 7 downto 0)
   --ao meio: "0000"(dezena) e "0010"(unidade), porem desse jeito ficamos restritos a contar
   --em hexadecimal, ja que _ _ _ _ (2³ 2² 2¹ 2⁰), logo de 0 a 15. A dezena seria hex3
   --e a unidade hex2.

   --contador  
   process(clk)
   begin
      if (clk'event and clk='1') then
         q0_reg <= q0_next;
      end if;
   end process;
   -- next-state logic for the counter

   q0_next <= (others=>'0') when clr='1' else
              q0_reg + 1    when inc='1' else
              q0_reg - 1    when dec='1' else
              q0_reg;
   --output
   count <= std_logic_vector(q0_reg);
end arch;
