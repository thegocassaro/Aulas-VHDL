----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:57:38 09/30/2020 
-- Design Name: 
-- Module Name:    decodificador4_2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity codificador4_2 is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : out  STD_LOGIC_VECTOR (1 downto 0);
           Active : out  STD_LOGIC);
end codificador4_2;

architecture cond_arch of codificador4_2 is

begin
	Active <= '0' when x = "0000" else
				'1';
	y <= "11" when x = "1000" else
        "10" when x = "0100" else
        "01" when x = "0010" else
        "00"; --x = "0001" ou x = "0000"
end cond_arch;

