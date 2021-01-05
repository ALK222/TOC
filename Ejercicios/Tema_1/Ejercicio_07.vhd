LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ej07 IS
	PORT (
		clk : IN STD_LOGIC;
		start_stop : IN STD_LOGIC;
		dar_cera : IN STD_LOGIC;
		salida_agua : OUT STD_LOGIC;
		salida_aire : OUT STD_LOGIC;
		mover_rollos : OUT STD_LOGIC;
		salida_jabon : OUT STD_LOGIC;
		encerar : OUT STD_LOGIC
	);
END ej07;

ARCHITECTURE Behavioral OF ej07 IS

	TYPE tipo_estado IS (inicial, jabon, rodillo, agua, secar, cera);
	SIGNAL estadoActual, estadoSiguiente : tipo_estado;

	SIGNAL contador, contadorSiguiente : STD_LOGIC_VECTOR(0 DOWNTO 0);

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

	COMB : PROCESS (estadoActual, dar_cera, contador)
	BEGIN

		estadoSiguiente <= estadoActual;
		contadorSiguiente <= contador;
		salida_agua <= '0';
		salida_aire <= '0';
		mover_rollos <= '0';
		salida_jabon <= '0';
		encerar <= '0';

		CASE estadoActual IS

			WHEN inicial =>
				estadoSiguiente <= jabon;

			WHEN jabon =>
				salida_jabon <= '1';
				estadoSiguiente <= rodillo;

			WHEN rodillo =>
				mover_rollos <= '1';
				IF (contador = "1") THEN
					estadoSiguiente <= agua;
					contadorSiguiente <= (OTHERS => '0');
				ELSE
					contadorSiguiente <= contador + 1;
				END IF;

			WHEN agua =>
				salida_agua <= '1';
				estadoSiguiente <= secar;

			WHEN secar =>
				salida_aire <= '1';
				IF (dar_cera = '1') THEN
					estadoSiguiente <= cera;
				ELSE
					estadoSiguiente <= inicial;
				END IF;

			WHEN cera =>
				IF (contador = "1") THEN
					estadoSiguiente <= inicial;
					contadorSiguiente <= (OTHERS => '0');
				ELSE
					contadorSiguiente <= contador + 1;
				END IF;

		END CASE;
	END PROCESS COMB;

END Behavioral;
