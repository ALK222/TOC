LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ej10 IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		entrada : IN STD_LOGIC;
		salida : OUT STD_LOGIC
	);
END ej10;

ARCHITECTURE Behavioral OF ej10 IS

	TYPE tipo_estado IS (S0, S1, S2, S3);
	SIGNAL estadoActual, estadoSiguiente : tipo_estado;

BEGIN

	SYNC : PROCESS (clk, rst)
	BEGIN
		IF rising_edge(clk) THEN
			IF rst = '1' THEN
				estadoActual <= S0;
			ELSE
				estadoActual <= estadoSiguiente;
			END IF;
		END IF;
	END PROCESS SYNC;

	COMB : PROCESS (estadoActual, entrada)
	BEGIN

		estadoSiguiente <= estadoActual;
		salida <= '0';

		CASE estadoActual IS

			WHEN S0 =>
				IF (entrada = '1') THEN
					estadoSiguiente <= S1;
				END IF;

			WHEN S1 =>
				IF (entrada = '0') THEN
					estadoSiguiente <= S2;
				END IF;

			WHEN S2 =>
				IF (entrada = '0') THEN
					estadoSiguiente <= S0;
				ELSE
					estadoSiguiente <= S3;
				END IF;

			WHEN S3 =>
				IF (entrada = '0') THEN
					estadoSiguiente <= S2;
					salida <= '1';
				ELSE
					estadoSiguiente <= S1;
				END IF;

		END CASE;
	END PROCESS COMB;

END Behavioral;
