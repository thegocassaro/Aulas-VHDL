----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:22:43 09/30/2020 
-- Design Name: 
-- Module Name:    demux1_2 - Behavioral 
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
entity demux1_2 is
    Port ( i : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (1 downto 0));
end demux1_2;

architecture Behavioral of demux1_2 is

begin
   y <= '0' & i when sel = '0' else
	      i & '0';

end Behavioral;

