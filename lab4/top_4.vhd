library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port (
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           sseg : out STD_LOGIC_VECTOR (7 downto 0));
end top_level;


architecture Behavioral of top_level is

    signal display_in_0_and_4  :   std_logic_vector(7 downto 0);
    signal display_in_1_and_5  :   std_logic_vector(7 downto 0);
    signal display_in_2_and_6  :   std_logic_vector(7 downto 0);
    signal display_in_3_and_7  :   std_logic_vector(7 downto 0);
   
begin

    led_mux_unit    :   entity work.led_mux8(arch)

    port map(
        clk                 =>  clk,
        reset               =>  '0',
        an(7 downto 0)      =>  an(7 downto 0),
        sseg(7 downto 0)    =>  sseg(7 downto 0),
       
        in0                 =>  display_in_0_and_4,
        in4                 =>  display_in_0_and_4,
       
        in1                 =>  display_in_1_and_5,
        in5                 =>  display_in_1_and_5,
       
        in2                 =>  display_in_2_and_6,
        in6                 =>  display_in_2_and_6,
       
        in3                 =>  display_in_3_and_7,
        in7                 =>  display_in_3_and_7
    );
   
    --tenho que escrever 4 vezes
    hex_to_sseg_unit_1 :   entity work.hex_to_sseg(arch)
   
    port map(
        hex(3 downto 0)     =>  sw(3 downto 0),
        dp                  =>  '1',
        sseg                =>  display_in_0_and_4
       
    );
   
   
    hex_to_sseg_unit_2 :   entity work.hex_to_sseg(arch)
       
    port map(
        hex(3 downto 0)     =>  sw(7 downto 4),
        dp                  =>  '1',
        sseg                =>  display_in_1_and_5
       
    );
   
    hex_to_sseg_unit_3 :   entity work.hex_to_sseg(arch)
       
    port map(
        hex(3 downto 0)     =>  sw(11 downto 8),
        dp                  =>  '1',
        sseg                =>  display_in_2_and_6
       
    );
     
     hex_to_sseg_unit_4 :   entity work.hex_to_sseg(arch)
       
    port map(
        hex(3 downto 0)     =>  sw(15 downto 12),
        dp                  =>  '1',
        sseg                =>  display_in_3_and_7
       
    );  

end Behavioral;