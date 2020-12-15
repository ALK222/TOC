LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY waiting_leds IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END waiting_leds;

ARCHITECTURE behavioral OF waiting_leds IS
	SIGNAL tmp : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

	PROCESS (clk, rst, tmp)
	BEGIN
		IF rst = '1' THEN
			tmp <= (OTHERS => '0');
		ELSE
			IF rising_edge(clk) THEN
				IF tmp(15) = '1' THEN
					tmp(15 DOWNTO 1) <= tmp(14 DOWNTO 0);
					tmp(0) <= '0';
				ELSE
					tmp(15 DOWNTO 1) <= tmp(14 DOWNTO 0);
					tmp(0) <= '1';
				END IF;
			END IF;
		END IF;
	END PROCESS;

	leds <= tmp;

END ARCHITECTURE behavioral;
