LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ej12 IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		entrada : IN STD_LOGIC;
		paridad_par : OUT STD_LOGIC
	);
END ej12;

ARCHITECTURE Behavioral OF ej12 IS

	TYPE tipo_estado IS (par, impar);
	SIGNAL estadoActual, estadoSiguiente : tipo_estado;

BEGIN

	SYNC : PROCESS (clk, rst)
	BEGIN
		IF rising_edge(clk) THEN
			IF (rst = '1') THEN
				estadoActual <= par;
			ELSE
				estadoActual <= estadoSiguiente;
			END IF;
		END IF;
	END PROCESS SYNC;

	COMB : PROCESS (estadoActual, entrada)
	BEGIN

		estadoSiguiente <= estadoActual;

		CASE estadoActual IS

			WHEN par =>
				paridad_par <= '1';
				IF (entrada = '1') THEN
					estadoSiguiente <= impar;
				END IF;

			WHEN impar =>
				paridad_par <= '0';
				IF (entrada = '1') THEN
					estadoSiguiente <= par;
				END IF;

		END CASE;
	END PROCESS COMB;

END Behavioral;
