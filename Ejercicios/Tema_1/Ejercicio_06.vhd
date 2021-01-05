LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ej06 IS
	PORT (
		clk : IN STD_LOGIC;
		start_stop : IN STD_LOGIC;
		ciclo_rapido : IN STD_LOGIC;
		entrar_agua : OUT STD_LOGIC;
		calentar_agua : OUT STD_LOGIC;
		mover_aspas : OUT STD_LOGIC;
		abrir_cajentin_detergente : OUT STD_LOGIC;
		secar : OUT STD_LOGIC
	);
END ej06;

ARCHITECTURE Behavioral OF ej06 IS

	TYPE tipo_estado IS (inicial, lavado, aclarado, secado);
	SIGNAL estadoActual, estadoSiguiente : tipo_estado;

	SIGNAL contador, contadorSiguiente : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

	SYNC : PROCESS (clk, start_stop)
	BEGIN
		IF (start_stop = '0') THEN
			contador <= (OTHERS => '0');
			estadoActual <= inicial;
		ELSIF rising_edge(clk) THEN
			estadoActual <= estadoSiguiente;
			contador <= contadorSiguiente;
		END IF;
	END PROCESS SYNC;

	COMB : PROCESS (estadoActual, ciclo_rapido, contador)
	BEGIN

		estadoSiguiente <= estadoActual;
		contadorSiguiente <= contador;
		entrar_agua <= '0';
		calentar_agua <= '0';
		mover_aspas <= '0';
		abrir_cajentin_detergente <= '0';
		secar <= '0';

		CASE estadoActual IS

			WHEN inicial =>
				estadoSiguiente <= lavado;

			WHEN lavado =>
				mover_aspas <= '1';
				IF (contador = "00") THEN
					entrar_agua <= '1';
					calentar_agua <= '1';
				ELSIF (contador = "01") THEN
					abrir_cajentin_detergente <= '1';
				END IF;
				IF ((ciclo_rapido = '1' AND contador = "01") OR (ciclo_rapido = '0' AND contador = "11")) THEN
					estadoSiguiente <= aclarado;
					contadorSiguiente <= (OTHERS => '0');
				ELSE
					contadorSiguiente <= contador + 1;
				END IF;

			WHEN aclarado =>
				mover_aspas <= '1';
				IF (contador = "00") THEN
					entrar_agua <= '1';
				END IF;
				IF (ciclo_rapido = '1' OR (ciclo_rapido = '0' AND contador = "01")) THEN
					estadoSiguiente <= secado;
					contadorSiguiente <= (OTHERS => '0');
				ELSE
					contadorSiguiente <= contador + 1;
				END IF;

			WHEN secado =>
				secar <= '1';
				estadoSiguiente <= inicial;

		END CASE;
	END PROCESS COMB;

END Behavioral;
