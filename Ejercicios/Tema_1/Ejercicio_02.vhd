LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ej02 IS
	PORT (
		a : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		z : OUT STD_LOGIC
	);
END ej02;

ARCHITECTURE Behavioral OF ej02 IS

	SIGNAL primo : STD_LOGIC;
	SIGNAL menor4yPar : STD_LOGIC;
	SIGNAL mayor8eImpar : STD_LOGIC;

BEGIN

	primo <= '1' WHEN (to_integer(unsigned(a)) = 2 OR
		to_integer(unsigned(a)) = 3 OR
		to_integer(unsigned(a)) = 5 OR
		to_integer(unsigned(a)) = 7 OR
		to_integer(unsigned(a)) = 11 OR
		to_integer(unsigned(a)) = 13) ELSE
		'0';

	menor4yPar <= '1' WHEN (to_integer(unsigned(a)) < 4 AND a(0) = '0') ELSE
		'0';

	mayor8eImpar <= '1' WHEN (to_integer(unsigned(a)) > 8 AND a(0) = '1') ELSE
		'0';

	z <= primo OR menor4yPar OR mayor8eImpar;

END Behavioral;
