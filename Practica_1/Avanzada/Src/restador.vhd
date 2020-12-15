LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY restador IS
	PORT (
		A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		C : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END restador;

ARCHITECTURE Behavioral OF restador IS

BEGIN

	C <= A - B;

END Behavioral;
