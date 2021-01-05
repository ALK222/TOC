LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ej03 IS
	PORT (
		number : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		overflow : OUT STD_LOGIC
	);
END ej03;

ARCHITECTURE Behavioral OF ej03 IS

	SIGNAL s_3, number_unsigned : unsigned(2 DOWNTO 0);
	SIGNAL result_unsigned : unsigned(4 DOWNTO 0);

BEGIN

	result_unsigned <= unsigned(number) * to_unsigned(3, 3);
	result <= STD_LOGIC_VECTOR(result_unsigned(3 DOWNTO 0));
	overflow <= result_unsigned(4);
END Behavioral;
