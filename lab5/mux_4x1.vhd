library ieee;
use ieee.std_logic_1164.all;

entity mux4 is

    port(
        dado : in std_logic_vector(3 downto 0);
        s: in std_logic_vector(1 downto 0);
        x: out std_logic
    );

end mux4;


architecture case_arch of mux4 is

begin

    process(s, dado)
    
    begin
        case s is
            when "00" =>
                x <= dado(0);
            when "01" =>
                x <= dado(1);
            when "10" =>
                x <= dado(2);
            when others =>
                x <= dado(3);

        end case;

    end process;

end case_arch;