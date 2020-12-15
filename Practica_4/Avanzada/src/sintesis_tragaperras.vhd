LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY sintesis_tragaperras IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		boton_inicio : IN STD_LOGIC;
		boton_fin : IN STD_LOGIC;
		display : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		leds : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		s_display : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
END sintesis_tragaperras;

ARCHITECTURE tragaperrasArch OF sintesis_tragaperras IS

	COMPONENT tragaperras IS
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			inicio : IN STD_LOGIC;
			fin : IN STD_LOGIC;
			cont1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			cont2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			leds : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT debouncer
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			x : IN STD_LOGIC;
			xDeb : OUT STD_LOGIC;
			xDebFallingEdge : OUT STD_LOGIC;
			xDebRisingEdge : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT displays IS
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
	SIGNAL s_displays : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL inicio, fin : STD_LOGIC;
	SIGNAL cont1, cont2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL display1, display2 : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL reset_n : STD_LOGIC;

BEGIN
	reset_n <= NOT rst;
	debouncerInsts_displayce1 : debouncer PORT MAP(reset_n, clk, boton_inicio, OPEN, OPEN, inicio);
	debouncerInsts_displayce2 : debouncer PORT MAP(reset_n, clk, boton_fin, OPEN, OPEN, fin);
	tragaperrasInsts_displayce : tragaperras PORT MAP(rst, clk, inicio, fin, cont1, cont2, leds);
	displays_inst : displays PORT MAP(rst, clk, cont1, cont2, "0000", "0000", display, s_display);

END tragaperrasArch;
