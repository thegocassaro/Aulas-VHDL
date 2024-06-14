library ieee;
use ieee.std_logic_1164.all;

entity fsm is
   port(
      clk        : in  std_logic;
      en, cw     : in  std_logic;
      an, sseg   : out std_logic
   );
end fsm;

architecture arch of fsm is

   type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
   signal state_reg, state_next : eg_state_type;

   signal up_squares, down_squares : STD_LOGIC_VECTOR(7 downto 0); 

begin

    -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= s0;
      elsif (clk'event and clk = '1') then
         state_reg <= state_next;
      end if;
   end process;

    up_squares      <= "10011100";
    down_squares    <= "11100010";

   -- next-state logic
   process(state_reg, en, cw)
   begin
      case state_reg is
        when s0 =>
            an <= "01111111";
            sseg <= up_squares;

            if en = '0' then
                state_next <= s0;

            elseif cw = '1' then
                state_next <= s1;

            else
                state_next <= s7;
            end if;

        when s1 =>
            an <= "10111111";
            sseg <= up_squares;

            if en = '0' then
                state_next <= s1;

            elseif cw = '1' then
                state_next <= s2;

            else
                state_next <= s0;
            end if;

        when s2 =>
            an <= "11011111";
            sseg <= up_squares;

            if en = '0' then
                state_next <= s2;

            elseif cw = '1' then
                state_next <= s3;

            else
                state_next <= s1;
            end if; 

        when s3 =>
            an <= "111011111";
            sseg <= up_squares;

            if en = '0' then
                state_next <= s3;

            elseif cw = '1' then
                state_next <= s4;

            else
                state_next <= s2;
            end if; 

        when s4 =>
            an <= "111011111";
            sseg <= down_squares;

            if en = '0' then
                state_next <= s4;

            elseif cw = '1' then
                state_next <= s5;

            else
                state_next <= s3;
            end if; 

        when s5 =>
            an <= "11011111";
            sseg <= down_squares;

            if en = '0' then
                state_next <= s5;

            elseif cw = '1' then
                state_next <= s6;

            else
                state_next <= s4;
            end if; 

        when s6 =>
            an <= "10111111";
            sseg <= down_squares;

            if en = '0' then
                state_next <= s6;

            elseif cw = '1' then
                state_next <= s7;

            else
                state_next <= s5;
            end if;  
        
        when s7 =>
            an <= "01111111";
            sseg <= down_squares;

            if en = '0' then
                state_next <= s7;

            elseif cw = '1' then
                state_next <= s0;

            else
                state_next <= s6;
            end if; 
            
      end case;
      
    end process;

end arch;