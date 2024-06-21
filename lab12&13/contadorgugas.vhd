library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity debounce_test is
   port(
      clk  : in  std_logic;
      btn  : in  std_logic;
      an   : out std_logic_vector(7 downto 0);  -- Modificações Anselmo e Fabi
      sseg : out std_logic_vector(7 downto 0)
   );
end debounce_test;

architecture arch of debounce_test is
   signal q1_reg, q1_next   : unsigned(7 downto 0);
   signal q0_reg, q0_next   : unsigned(7 downto 0);
   --signal b_count  : std_logic_vector(7 downto 0);
   signal d_count  : std_logic_vector(7 downto 0);
   signal btn_reg, db_reg   : std_logic;
   signal db_level, db_tick : std_logic;
   signal btn_tick          : std_logic;
begin
   --*****************************************************************
   -- Modificações Anselmo e Fabi
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
         hex3  => d_count(7 downto 4), -- Modificações Anselmo e Fabi --  Está diferente do desenho do livro. Modificamos para ficar igual --
         hex2  => d_count(3 downto 0), -- Modificações Anselmo e Fabi --  Está diferente do desenho do livro. Modificamos para ficar igual --
         hex1 => "0000",
         --hex1  => b_count(7 downto 4), -- Modificações Anselmo e Fabi --  Está diferente do desenho do livro. Modificamos para ficar igual --
         --hex0  => b_count(3 downto 0), -- Modificações Anselmo e Fabi --  Está diferente do desenho do livro. Modificamos para ficar igual --
         hex0 => "0000",
         dp_in => "1011",
         an    => an(3 downto 0),          -- Modificações Anselmo e Fabi --
         sseg  => sseg
      );
   -- instantiate debouncing circuit
   db_unit : entity work.db_fsm(arch)
      port map(
         clk   => clk,
         reset => '0',
         sw    => btn,
         db    => db_level
      );

   --*****************************************************************
   -- edge detection circuits
   --*****************************************************************
   process(clk)
   begin
      if (clk'event and clk = '1') then
         btn_reg <= btn;
         db_reg  <= db_level;
      end if;
   end process;
  -- btn_tick <= (not btn_reg) and btn;
   db_tick  <= (not db_reg) and db_level;

   --*****************************************************************
   -- two counters
   --*****************************************************************
   process(clk)
   begin
      if (clk'event and clk='1') then
         q0_reg <= q0_next;
      end if;
   end process;
   -- next-state logic for the counter
   q0_next <=
              q0_reg + 1    when db_tick='1' else
              q0_reg;
   --output
   d_count <= std_logic_vector(q0_reg);
end arch;