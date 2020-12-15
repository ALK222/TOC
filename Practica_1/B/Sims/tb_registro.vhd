--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;
ENTITY tb_registro IS
END tb_registro;

ARCHITECTURE behavior OF tb_registro IS

	-- Declaraci?n del componente que vamos a simular

	COMPONENT registro
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			load : IN STD_LOGIC;
			E : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	--Entradas
	SIGNAL rst : STD_LOGIC;
	SIGNAL clk : STD_LOGIC;
	SIGNAL E : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL load : STD_LOGIC;

	--Salidas
	SIGNAL S : STD_LOGIC_VECTOR(3 DOWNTO 0);

	--Se define el periodo de reloj 
	CONSTANT clk_period : TIME := 50 ns;

BEGIN

	-- Instanciacion de la unidad a simular 

	uut : registro PORT MAP(
		rst => rst,
		clk => clk,
		load => load,
		E => E,
		S => S
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
		load <= '0';
		E <= "0000";
		WAIT FOR 45 ns;
		-- Dejamos de resetear	
		rst <= '0';
		load <= '0';
		E <= "0000";
		WAIT FOR 50 ns;
		-- Cargamos el valor "1101" en el registro
		rst <= '0';
		load <= '1';
		E <= "1101";
		WAIT FOR 50 ns;
		-- Mantenemos el valor durante 100 ns
		rst <= '0';
		load <= '0';
		E <= "0000";
		WAIT FOR 100 ns;
		-- Cargamos el valor "0011" en el registro 
		rst <= '0';
		load <= '1';
		E <= "0011";
		WAIT FOR 50 ns;
		-- Mantenemos el valor para siempre
		rst <= '0';
		load <= '0';
		E <= "0000";
		WAIT;
	END PROCESS;

END;
