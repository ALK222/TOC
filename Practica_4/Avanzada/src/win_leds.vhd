LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY win_leds IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END win_leds;

ARCHITECTURE behavioral OF win_leds IS

	SIGNAL tmp : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

	seq : PROCESS (clk, rst, tmp)
	BEGIN
		IF rst = '1' THEN
			tmp <= (OTHERS => '0');
		ELSIF rising_edge(clk) THEN
			IF tmp = "0000000000000000" THEN
				tmp <= "1111111111111111";
			ELSE
				tmp <= "0000000000000000";
			END IF;
		END IF;
	END PROCESS; -- seq

	leds <= tmp;

END ARCHITECTURE behavioral;
