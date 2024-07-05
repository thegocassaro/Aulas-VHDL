library IEEE;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.ALL;

entity inc_4bits is
    Port ( inc_in : in STD_LOGIC_VECTOR (3 downto 0);
           inc_out : out STD_LOGIC_VECTOR (3 downto 0)
           );
end inc_4bits;

architecture Behavioral of inc_4bits is
begin
    inc_out  <= std_logic_vector(unsigned(inc_in)+1);
end Behavioral;
