library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is

    port(
        an : out std_logic_vector(7 downto 0);
        sseg : out std_logic_vector(7 downto 0);
        clk : in std_logic;
        enable : in std_logic
    );

end fsm;


architecture fsm_arch of fsm is

  type eg_state_type is (s0,s1,s2,s3,s4,s5,s6,s7);
  signal state_reg,state_next : eg_state_type;
  
  begin
  
  --register logic
    process(clk)
        begin
            if(clk'event and clk='1') then
                if(enable='1') then
                    state_reg<=state_next;
                end if;
                
            end if;
    end process;
    
    --logica de geracao proximo estado e saída
    process(state_reg)
        begin
    
            case state_reg is
                when s0=>
                    an <= "01111111";
                    sseg <= "11000000";
                    state_next<=s1;
                 when s1=>
                       an <= "10111111";
                       sseg <= "11111001";
                       state_next<=s2; 
                 when s2=>
                      an <= "11011111";
                      sseg <= "10100100";
                      state_next<=s3;
                when s3=>
                     an <= "11101111";
                     sseg <= "10110000";
                     state_next<=s4;  
             when s4=>
                    an <= "11110111";
                    sseg <= "10011001";
                    state_next<=s5;
              when s5=>
                   an <= "11111011";
                   sseg <= "10010010";
                   state_next<=s6;
            when s6=>
                  an <= "11111101";
                  sseg <= "10000010";
                  state_next<=s7;
             when s7=>
                 an <= "11111110";
                 sseg <= "11111000";
                 state_next<=s0;         
       end case;                                                                                                            
     end process;
     
        

end architecture;
