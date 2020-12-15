----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 11:56:11
-- Design Name: 
-- Module Name: cont_mod10 - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY cont_mod10 IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		leds : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END cont_mod10;

ARCHITECTURE Behavioral OF cont_mod10 IS
BEGIN

	count : PROCESS (rst, clk, enable)
		VARIABLE numero : STD_LOGIC_VECTOR(3 DOWNTO 0);
	BEGIN
		IF rst = '1' THEN
			numero := (OTHERS => '0');
		ELSE
			IF rising_edge(clk) THEN
				IF enable = '1' THEN
					IF numero = "1001" THEN -- If number is 9, it goes to 0
						numero := (OTHERS => '0');
					ELSE
						numero := STD_LOGIC_VECTOR(unsigned(numero) + 1);
					END IF;
				END IF;
			END IF;
		END IF;
		leds <= numero;
	END PROCESS; -- count
END Behavioral;
