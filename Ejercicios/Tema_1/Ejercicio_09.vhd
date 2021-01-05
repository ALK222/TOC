LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ej09 IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		ruido : IN STD_LOGIC;
		chupete : IN STD_LOGIC;
		sonido : OUT STD_LOGIC;
		llanto : OUT STD_LOGIC
	);
END ej09;

ARCHITECTURE Behavioral OF ej09 IS

	TYPE tipo_estado IS (tranquila, habla, dormida, asustada);
	SIGNAL estadoActual, estadoSiguiente : tipo_estado;

BEGIN

	SYNC : PROCESS (clk, rst)
	BEGIN
		IF rising_edge(clk) THEN
			IF rst = '1' THEN
				estadoActual <= tranquila;
			ELSE
				estadoActual <= estadoSiguiente;
			END IF;
		END IF;
	END PROCESS SYNC;

	COMB : PROCESS (estadoActual, ruido, chupete)
	BEGIN

		estadoSiguiente <= estadoActual;
		sonido <= '0';
		llanto <= '0';

		CASE estadoActual IS

			WHEN tranquila =>
				IF (ruido = '1') THEN
					estadoSiguiente <= habla;
				ELSIF (chupete = '1') THEN
					estadoSiguiente <= dormida;
				END IF;

			WHEN habla =>
				sonido <= '1';
				IF (chupete = '1') THEN
					estadoSiguiente <= dormida;
				END IF;

			WHEN dormida =>
				IF (chupete = '0' AND ruido = '1') THEN
					estadoSiguiente <= asustada;
				END IF;

			WHEN asustada =>
				sonido <= '1';
				llanto <= '1';
				IF (ruido = '0' AND chupete = '0') THEN
					estadoSiguiente <= habla;
				ELSIF (ruido = '0' AND chupete = '1') THEN
					estadoSiguiente <= dormida;
				END IF;
		END CASE;
	END PROCESS COMB;

END Behavioral;
