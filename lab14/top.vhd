library ieee;
use ieee.std_logic_1164.all;

entity top is

    port(
        clk : in std_logic;
        sw  : in std_logic_vector(7 downto 0);
        led : out std_logic_vector(3 downto 0)
    );

end top;

architecture arch of top is

signal enable       : std_logic;
signal cod_out      : std_logic_vector(1 downto 0);
signal inc_out      : std_logic_vector(3 downto 0);
signal mux_out      : std_logic_vector(3 downto 0);
signal reg          : std_logic_vector(3 downto 0);

begin

div_clk_unit : entity work.div_clk(Behavioral)

port map(
    clk => clk,
    en => enable
);

cod_unit : entity work.cod_prio(cond_arch)

port map(
    r => sw(2 downto 0),
    pcode => cod_out
);

inc_unit : entity work.inc_4bits(Behavioral)

port map(
    inc_in => reg,
    inc_out => inc_out
);

--muxes

mux_unit_3 : entity work.mux_4x1(cond_arch)

port map(
    i(3) => sw(7);  --L3
    i(2) => inc_out(3);
    i(1) => sw(3);  --SHR_in
    i(0) => reg(3);
    c => cod_out;
    s => mux_out(3);
);

mux_unit_2 : entity work.mux_4x1(cond_arch)

port map(
    i(3) => sw(6);  --L2
    i(2) => inc_out(2);
    i(1) => reg(3);
    i(0) => reg(2);
    c => cod_out;
    s => mux_out(2);
);

mux_unit_1 : entity work.mux_4x1(cond_arch)

port map(
    i(3) => sw(5);  --L1
    i(2) => inc_out(1);
    i(1) => reg(2);
    i(0) => reg(1);
    c => cod_out;
    s => mux_out(1);
);

mux_unit_0 : entity work.mux_4x1(cond_arch)

port map(
    i(3) => sw(4);  --L0;
    i(2) => inc_out(0);
    i(1) => reg(1);
    i(0) => reg(0);
    c => cod_out;
    s => mux_out(0);
);

--register

FF_unit_3 : entity work.FF_D(Behavioral)

port map(
    D => mux_out(3),
    Q => reg(3),
    e => enable,
    clk => clk
);

FF_unit_2 : entity work.FF_D(Behavioral)

port map(
    D => mux_out(2),
    Q => reg(2),
    e => enable,
    clk => clk
);

FF_unit_1 : entity work.FF_D(Behavioral)

port map(
    D => mux_out(1),
    Q => reg(1),
    e => enable,
    clk => clk
);

FF_unit_0 : entity work.FF_D(Behavioral)

port map(
    D => mux_out(0),
    Q => reg(0),
    e => enable,
    clk => clk
);

--led

led <= reg;

end arch;
