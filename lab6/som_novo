library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity som_completo is
    Port ( 
        a :     in std_logic;
        b :     in std_logic;
        c_in :  in std_logic;
        
        c_out : out std_logic;
        s :     out std_logic
           );
end som_completo;

architecture som_arch of som_completo is

begin

    s <= a xor b xor c_in;
    c_out <= (a and b) or (a and c_in) or (b and c_in); 

end som_arch;
