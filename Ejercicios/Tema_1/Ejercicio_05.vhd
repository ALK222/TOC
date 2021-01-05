LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY pat_rec IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		x : IN STD_LOGIC;
		z : OUT STD_LOGIC
	);
END pat_rec;

ARCHITECTURE Behavioral OF pat_rec IS

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

	COMB : PROCESS (estadoActual, x)
	BEGIN

		estadoSiguiente <= estadoActual;
		z <= '0';

		CASE estadoActual IS

			WHEN S0 =>
				IF (x = '0') THEN
					estadoSiguiente <= S1;
				END IF;

			WHEN S1 =>
				IF (x = '0') THEN
					estadoSiguiente <= S2;
				ELSE
					estadoSiguiente <= S0;
				END IF;

			WHEN S2 =>
				IF (x = '1') THEN
					estadoSiguiente <= S3;
				END IF;

			WHEN S3 =>
				IF (x = '0') THEN
					estadoSiguiente <= S1;
				ELSE
					estadoSiguiente <= S0;
					z <= '1';
				END IF;

		END CASE;
	END PROCESS COMB;

END Behavioral;
