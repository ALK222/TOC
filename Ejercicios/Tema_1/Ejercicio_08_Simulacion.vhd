--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;
ENTITY simu08 IS
END simu08;

ARCHITECTURE behavior OF simu08 IS

	-- Declaraci�n del componente que vamos a simular

	COMPONENT ej08
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			entrada : IN STD_LOGIC;
			salida : OUT STD_LOGIC
		);
	END COMPONENT;

	--Entradas
	SIGNAL rst : STD_LOGIC;
	SIGNAL clk : STD_LOGIC;
	SIGNAL entrada : STD_LOGIC;

	--Salidas
	SIGNAL salida : STD_LOGIC;

	--Se define el periodo de reloj 
	CONSTANT clk_period : TIME := 100 ns;

BEGIN

	-- Instanciacion de la unidad a simular 

	uut : ej08 PORT MAP(
		rst => rst,
		clk => clk,
		entrada => entrada,
		salida => salida
	);

	-- Definicion del process de reloj
	reloj_process : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS;
	--Proceso de estimulos
	stim_proc : PROCESS
	BEGIN
		rst <= '1';
		entrada <= '0';
		WAIT FOR 150 ns;

		rst <= '0';
		entrada <= '1';
		WAIT FOR 2 * clk_period;

		entrada <= '0';
		WAIT FOR clk_period/4;

		entrada <= '1';
		WAIT FOR clk_period;

		entrada <= '0';
		WAIT FOR 2 * clk_period;

		entrada <= '1';
		WAIT FOR clk_period;

		WAIT;
	END PROCESS;

END;
