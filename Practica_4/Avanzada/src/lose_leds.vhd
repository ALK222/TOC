LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY lose_leds IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END lose_leds;

ARCHITECTURE behavioral OF lose_leds IS

	SIGNAL tmp : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	seq : PROCESS (clk, rst, tmp)
	BEGIN
		IF rst = '1' THEN
			tmp <= "1010101010101010";
		ELSIF rising_edge(clk) THEN
			IF tmp = "0101010101010101" THEN
				tmp <= "1010101010101010";
			ELSE
				tmp <= "0101010101010101";
			END IF;
		END IF;
	END PROCESS; -- seq

	leds <= tmp;

END ARCHITECTURE behavioral;
