library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2x1 is
    Port ( 
        b_in :  in std_logic_vector(3 downto 0);
        sub :   in std_logic;
        b_out : out std_logic_vector(3 downto 0)
    );
end mux2x1;

architecture mux_arch of mux2x1 is

begin

    b_out(0) <= b_in(0) when sub = '0' else
                 not b_in(0);
             
    b_out(1) <= b_in(1) when sub = '0' else
                not b_in(1);
                      
    b_out(2) <= b_in(2) when sub = '0' else
                not b_in(2);
                                       
    b_out(3) <= b_in(3) when sub = '0' else
                not b_in(3);

end mux_arch;
