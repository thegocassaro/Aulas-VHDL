library ieee;
use ieee.std_logic_1164.all;

entity fsm_parking_lot is

port(
    clk, enable, reset  : in std_logic;
    a, b                : in std_logic;
    car_enter, car_exit : out std_logic
);

end fsm_parking_lot;


architecture arch_fsm of fsm_parking_lot is

type eg_state_type is (s0, s1, s2, s3);
signal state_reg, state_next : eg_state_type;

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


    -- next-state/output logic
    process(state_reg, a, b)
    begin
        
        state_next <= state_reg;
        car_enter <= '0';
        car_exit <= '0';        

        case state_reg is

            when s0=>
                if a = '1' then 
                    state_next <= s1;
                    car_enter <= '1';   --mealy out

                elsif a = '0' and b = '0' then
                    state_next <= s0;

                else 
                    state_next <= s3;

                end if;

            when s1=>
                if a = '0' then 
                    state_next <= s0;
                    car_exit <= '1';    --mealy out

                elsif a = '1' and b = '0' then
                    state_next <= s1;

                else
                    state_next <= s2;

                end if;


            when s2=>
                if b = '0' then 
                    state_next <= s1;

                elsif a = '1' and b = '1' then
                    state_next <= s2;

                else
                    state_next <= s3;

                end if;

            when s3=>
                if b = '0' then 
                    state_next <= s0;

                elsif a = '0' and b = '1' then
                    state_next <= s3;

                else
                    state_next <= s2;

                end if;

        end case;

    end process;

end arch_fsm;