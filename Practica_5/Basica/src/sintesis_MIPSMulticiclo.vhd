LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sintesis_MIPSMulticiclo IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		display_enable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		modo : IN STD_LOGIC;
		siguiente : IN STD_LOGIC
	);
END sintesis_MIPSMulticiclo;

ARCHITECTURE sintesis_MIPSMulticicloArch OF sintesis_MIPSMulticiclo IS

	COMPONENT MIPs_multiciclo
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			modo : IN STD_LOGIC;
			siguiente : IN STD_LOGIC;
			R3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			PCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT DCM_100MHz_10MHz
		PORT (
			CLK_IN1 : IN STD_LOGIC;
			CLK_OUT1 : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT displays
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			digito_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			digito_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			digito_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			digito_3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			display : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			display_enable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT debouncer
		GENERIC (
			FREQ : NATURAL := 10000; -- frecuencia de operacion en KHz
			BOUNCE : NATURAL := 100 -- tiempo de rebote en ms
		);
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			x : IN STD_LOGIC;
			xDeb : OUT STD_LOGIC;
			xDebFallingEdge : OUT STD_LOGIC;
			xDebRisingEdge : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL clk_10MHz : STD_LOGIC;
	SIGNAL R3 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL siguienteDebouncer : STD_LOGIC;

BEGIN

	reloj : DCM_100MHz_10MHz PORT MAP(CLK_IN1 => clk, CLK_OUT1 => clk_10MHz);

	eliminadorRebotesModo : debouncer PORT MAP(rst => rst, clk => clk_10MHz, x => siguiente, xDeb => OPEN, xDebFallingEdge => OPEN, xDebRisingEdge => siguienteDebouncer);

	MIPs : MIPS_multiciclo PORT MAP(clk => clk_10MHz, rst => rst, modo => modo, siguiente => siguienteDebouncer, R3 => R3, PCout => PC);
	displays_i : displays PORT MAP(rst => rst, clk => clk, digito_0 => R3(3 DOWNTO 0), digito_1 => R3(7 DOWNTO 4), digito_2 => "0000", digito_3 => PC(5 DOWNTO 2), display => display, display_enable => display_enable);
END sintesis_MIPSMulticicloArch;
