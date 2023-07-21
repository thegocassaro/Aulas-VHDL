library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port(
        mode : in std_logic;
        num_in : in std_logic_vector (3 downto 0);
        num_out : out std_logic_vector (3 downto 0)
    );
end mux;

architecture arch_mux of mux is

begin

    num_out <= num_in when mode = '0' else
        not num_in; 

end arch_mux;