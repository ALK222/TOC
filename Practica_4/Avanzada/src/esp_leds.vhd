----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 09:37:23
-- Design Name: 
-- Module Name: esp_leds - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY esp_leds IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END esp_leds;

ARCHITECTURE Behavioral OF esp_leds IS
	SIGNAL tmp : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	seq : PROCESS (clk, rst, tmp)
	BEGIN
		IF rst = '1' THEN
			tmp <= "1111111100000000";
		ELSIF rising_edge(clk) THEN
			IF tmp = "1111111100000000" THEN
				tmp <= "0000000011111111";
			ELSE
				tmp <= "1111111100000000";
			END IF;
		END IF;
	END PROCESS; -- seq

	leds <= tmp;
END Behavioral;
