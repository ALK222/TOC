LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexor2a1 IS
	GENERIC (
		bits_entradas : POSITIVE := 32
	);
	PORT (
		entrada0 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
		entrada1 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
		seleccion : IN STD_LOGIC;
		salida : OUT STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0)
	);
END multiplexor2a1;

ARCHITECTURE multiplexor2a1Arch OF multiplexor2a1 IS

BEGIN

	salida <= entrada0 WHEN (seleccion = '0') ELSE
		entrada1;

END multiplexor2a1Arch;
