library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_som is
    Port ( sw : in STD_LOGIC_VECTOR (8 downto 0);
           led : out STD_LOGIC_VECTOR (4 downto 0));
end top_som;

architecture Behavioral of top_som is

    signal c_out_signal : std_logic_vector(2 downto 0);
    signal b_out_signal : std_logic_vector(3 downto 0);
    signal estouro_signal : std_logic;

begin

--a sw(7 - 4)
--b sw(3 - 0)
--sub sw(8)

    mux_unit : entity work.mux2x1(mux_arch)
    
    port map(
        sub => sw(8),
        
        b_in(0) => sw(0),
        b_in(1) => sw(1),
        b_in(2) => sw(2),
        b_in(3) => sw(3),
        -- acho que daria pra fazer b_in => sw(3 downto 0)
        -- e similarmente           b_out => b_out_signal
        
        b_out(0) => b_out_signal(0),
        b_out(1) => b_out_signal(1),
        b_out(2) => b_out_signal(2),
        b_out(3) => b_out_signal(3)
    );

    som_unit1 : entity work.som_completo(som_arch)
    
    port map(
        a => sw(4),
        b => b_out_signal(0),
        c_in => sw(8),
        
        c_out => c_out_signal(0),
        s => led(0)
    );
    
    som_unit2 : entity work.som_completo(som_arch)
    
    port map(
        a => sw(5),
        b => b_out_signal(1),
        c_in => c_out_signal(0),
        
        c_out => c_out_signal(1),
        s => led(1)
    );
    
    som_unit3 : entity work.som_completo(som_arch)
        
    port map(
        a => sw(6),
        b => b_out_signal(2),
        c_in => c_out_signal(1),
        
        c_out => c_out_signal(2),
        s => led(2)
    );
    
    som_unit4 : entity work.som_completo(som_arch)
        
    port map(
        a => sw(7),
        b => b_out_signal(3),
        c_in => c_out_signal(2),
        
        s => estouro_signal
    );
    
    led(3) <= estouro_signal;
    led(4) <= (sw(7) and b_out_signal(3) and not estouro_signal) or (not sw(7) and not b_out_signal(3) and estouro_signal);

end Behavioral;
