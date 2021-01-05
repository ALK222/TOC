LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ej11 IS
	PORT (
		reloj : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		Activa : IN STD_LOGIC;
		A : IN STD_LOGIC;
		P : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ej11;

ARCHITECTURE Behavioral OF ej11 IS

	SIGNAL rstContador : STD_LOGIC;
	SIGNAL salidaRegDespla : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL cuenta : unsigned(2 DOWNTO 0);

BEGIN

	rstContador <= '1' WHEN (rst = '1' OR (Activa = '1' AND cuenta = "101")) ELSE
		'0';

	contador : PROCESS (reloj, rstContador)
	BEGIN
		IF (rstContador = '1') THEN
			cuenta <= (OTHERS => '0');
		ELSIF rising_edge(reloj) THEN
			IF (Activa = '1') THEN
				cuenta <= cuenta + 1;
			END IF;
		END IF;
	END PROCESS contador;

	registro : PROCESS (reloj, rst)
	BEGIN
		IF (rst = '1') THEN
			P <= (OTHERS => '0');
		ELSIF rising_edge(reloj) THEN
			IF (Activa = '1' AND cuenta = "101") THEN
				P <= salidaRegDespla;
			END IF;
		END IF;
	END PROCESS registro;

	regDespla : PROCESS (reloj, rst)
	BEGIN
		IF (rst = '1') THEN
			salidaRegDespla <= (OTHERS => '0');
		ELSIF rising_edge(reloj) THEN
			IF (Activa = '1' AND (to_integer(cuenta) < 5) AND (to_integer(cuenta) > 0)) THEN
				salidaRegDespla <= A & salidaRegDespla(3 DOWNTO 1);
			END IF;
		END IF;
	END PROCESS regDespla;

END Behavioral;
