LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ej13 IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		entrada : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		desplazamiento : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		salida : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ej13;

ARCHITECTURE Behavioral OF ej13 IS

	SIGNAL salidaYEntrada : STD_LOGIC_VECTOR(14 DOWNTO 0);
	SIGNAL salidaInterna : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

	salidaYEntrada <= salidaInterna & entrada;

	SYNC : PROCESS (clk, rst)
	BEGIN
		IF rising_edge(clk) THEN
			IF (rst = '1') THEN
				salidaInterna <= (OTHERS => '0');
			ELSE
				salidaInterna <= salidaYEntrada(14 - to_integer(unsigned(desplazamiento)) DOWNTO 7 - to_integer(unsigned(desplazamiento)));
			END IF;
		END IF;
	END PROCESS SYNC;

	salida <= salidaInterna;

END Behavioral;
