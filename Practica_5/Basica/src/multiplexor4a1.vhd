LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexor4a1 IS
	GENERIC (
		bits_entradas : POSITIVE := 32
	);
	PORT (
		entrada0 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
		entrada1 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
		entrada2 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
		entrada3 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
		seleccion : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		salida : OUT STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0)
	);
END multiplexor4a1;

ARCHITECTURE multiplexor4a1Arch OF multiplexor4a1 IS

BEGIN

	salida <= entrada0 WHEN (seleccion = "00") ELSE
		entrada1 WHEN (seleccion = "01") ELSE
		entrada2 WHEN (seleccion = "10") ELSE
		entrada3;

END multiplexor4a1Arch;
