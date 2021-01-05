LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ej04 IS
	PORT (
		a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		odd : OUT STD_LOGIC
	);
END ej04;

ARCHITECTURE RTL OF ej04 IS

	COMPONENT XOR1bit
		PORT (
			x : IN STD_LOGIC;
			y : IN STD_LOGIC;
			z : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL sig1 : STD_LOGIC;
	SIGNAL sig2 : STD_LOGIC;

BEGIN

	unit_10 : XOR1bit
	PORT MAP(
		x => a(0),
		y => a(1),
		z => sig1
	);

	unit_11 : XOR1bit
	PORT MAP(
		x => a(2),
		y => a(3),
		z => sig2
	);

	unit_2 : XOR1bit
	PORT MAP(
		x => sig1,
		y => sig2,
		z => odd
	);

END RTL;

---------------------------
--          XOR
---------------------------
ENTITY XOR1bit IS
	PORT (
		x : IN STD_LOGIC;
		y : IN STD_LOGIC;
		z : OUT STD_LOGIC
	);
END XOR1bit;

ARCHITECTURE Behavioral OF XOR1bit IS

BEGIN

	z <= x XOR y;

END Behavioral;
