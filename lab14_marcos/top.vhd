library IEEE;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port(
       sw       : in std_logic_vector(7 downto 0);
       clk      : in std_logic;
       reset    : in std_logic;
       led      : out std_logic_vector(3 downto 0)
    );
end top;

architecture main of top is
    signal enable     : std_logic;
    signal l_4bits    : std_logic_vector(3 downto 0);
    signal c1c0       : std_logic_vector(1 downto 0);
    signal SHR_in     : std_logic;
    signal smux       : std_logic_vector(3 downto 0);
    signal sffd       : std_logic_vector(3 downto 0);
    signal sincre     : std_logic_vector(3 downto 0);
    signal saida_final: std_logic_vector(3 downto 0);
    
begin
    CODIFICADOR : entity work.cod_prio(cond_arch)
        port map(
            r     => sw(7 downto 5),
            pcode => c1c0
        );

    MUX_1 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => sw(3),
            i(2) => sincre(3),
            i(1) => sw(4),
            i(0) => saida_final(3),
            c    => c1c0,
            s    => smux(3)
        );

    MUX_2 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => sw(2),
            i(2) => sincre(2),
            i(1) => saida_final(3),
            i(0) => saida_final(2),
            c    => c1c0,
            s    => smux(2)
        );

    MUX_3 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => sw(1),
            i(2) => sincre(1),
            i(1) => saida_final(2),
            i(0) => saida_final(1),
            c    => c1c0,
            s    => smux(1)
        );

    MUX_4 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => sw(0),
            i(2) => sincre(0),
            i(1) => saida_final(1),
            i(0) => saida_final(0),
            c    => c1c0,
            s    => smux(0)
        );
    
    DIVIDI_CLK : entity work.div_clk(Behavioral)
        port map(
            clk => clk,
            en  => enable
        );

    FLIP_D_1  : entity work.FF_D(Behavioral)
        port map(
            D   => smux(3),
            clk => clk,
            e   => enable,
            Q   => saida_final(3)
        );
    FLIP_D_2  : entity work.FF_D(Behavioral)
        port map(
            D   => smux(2),
            clk => clk,
            e   => enable,
            Q   => saida_final(2)
        );
    FLIP_D_3  : entity work.FF_D(Behavioral)
        port map(
            D   => smux(1),
            clk => clk,
            e   => enable,
            Q   => saida_final(1)
        );
    FLIP_D_4  : entity work.FF_D(Behavioral)
        port map(
            D   => smux(0),
            clk => clk,
            e   => enable,
            Q   => saida_final(0)
        );

    INCREMENTO : entity work.inc_4bits(Behavioral)
        port map(
            inc_in  => saida_final(3 downto 0),
            inc_out => sincre(3 downto 0)
        );
    
    led <= saida_final(3 downto 0);
end main;