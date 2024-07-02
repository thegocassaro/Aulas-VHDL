library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
    Port ( 
           s1 : in STD_LOGIC;
           s2 : in STD_LOGIC;
           INC : out STD_LOGIC;
           DEC : out STD_LOGIC;
           CLK : in STD_LOGIC);
end FSM;

architecture Behavioral of FSM is
    type eg_state_type is (e0, e1, e2, e3, e4, e5, e6, e7, e8);
    signal state_reg, state_next : eg_state_type;
begin

  -- state register
   process(clk)
   begin
      if (clk'event and clk = '1') then
         state_reg <= state_next;
      end if;
   end process;


-- next-state logic
        process(state_reg, S1, S2)
        begin
            case state_reg is
             when e0 =>
                if s1 = '1' then
                    state_next <= e1;
                elsif s2='1' then
                    state_next <= e5;
                else
                    state_next <= e0;
                end if;
             when e1 =>
                if s1 = '0' then
                    state_next <= e0;
                elsif s2='1' then
                    state_next <= e2;
                else
                    state_next <= e1;
                end if;
            when e2 =>
               if s2 = '0' then
                   state_next <= e1;
               elsif s1='1' then
                   state_next <= e2;
               else
                   state_next <= e3;
               end if;
            when e3 =>
              if s2 = '0' then
                  state_next <= e4;
              elsif s1='0' then
                  state_next <= e3;
              else
                  state_next <= e2;
              end if;       
            when e4 =>
              state_next <= e0;
            
            when e5 =>
                 if s2 = '0' then
                     state_next <= e0;
                 elsif s2='1' then
                     state_next <= e6;
                 else
                     state_next <= e5;
                 end if;
            when e6 =>
                if s1 = '0' then
                    state_next <= e5;
                elsif s2='1' then
                    state_next <= e6;
                else
                    state_next <= e7;
                end if;
            when e7 =>
                if s1 = '0' then
                   state_next <= e8;
                elsif s2='0' then
                   state_next <= e7;
                else
                   state_next <= e6;
                end if;       
            when e8 =>
                state_next <= e0;
            end case;
        end process;
   
   
   -- Moore output logic
   process(state_reg)
   begin
      case state_reg is
         when e4 =>
            inc <= '1';
            dec <='0';
         when e8 =>
            dec <= '1';
            inc <='0';
         when others =>
            inc <='0';
            dec <='0';   
      end case;
   end process;




end Behavioral;
