--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY simulacion_contador IS
END simulacion_contador;

ARCHITECTURE behavior OF simulacion_contador IS

	-- Declaraci?n del componente que vamos a simular

	COMPONENT contadorMod16 IS
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			cuenta : IN STD_LOGIC;
			salida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	--Entradas
	SIGNAL rst : STD_LOGIC;
	SIGNAL clk : STD_LOGIC;
	SIGNAL cuenta : STD_LOGIC;

	--Salidas
	SIGNAL salida : STD_LOGIC_VECTOR(3 DOWNTO 0);

	--Se define el periodo de reloj 
	CONSTANT clk_period : TIME := 50 ns;

BEGIN

	-- Instanciacion de la unidad a simular 

	uut : contadorMod16 PORT MAP(
		rst => rst,
		clk => clk,
		cuenta => cuenta,
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
		-- Se mantiene el rst activado durante 45 ns.
		rst <= '1';
		cuenta <= '0';
		WAIT FOR 45 ns;
		-- Dejamos de resetear	
		rst <= '0';
		cuenta <= '0';
		WAIT FOR 50 ns;
		-- Activamos cuenta
		rst <= '0';
		cuenta <= '1';
		WAIT FOR 500 ns;
		-- Desactivamos cuenta
		rst <= '0';
		cuenta <= '0';
		WAIT FOR 500 ns;
		-- Activamos cuenta para siempre
		rst <= '0';
		cuenta <= '1';
		WAIT;
	END PROCESS;

END;
