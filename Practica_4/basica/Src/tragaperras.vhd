-- Libraries
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Define entity
-----------------------------------------------------------------
--! \author Alejandro Barrachina Argudo
--! \class tragaperras
--! \brief Main file where the components of the slot machine are instanced
--! \par Filename
--!                 tragaperras.vhd
--
-----------------------------------------------------------------
ENTITY tragaperras IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		inicio : IN STD_LOGIC;
		fin : IN STD_LOGIC;
		cont1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		cont2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		leds : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END tragaperras;

-- Define architecture
ARCHITECTURE Behavioral OF tragaperras IS

	-- Define Components

	-----------------------------------------------------------------
	--! \brief clock for the leds and the two counters
	-----------------------------------------------------------------
	COMPONENT divisor
		PORT (
			rst : IN STD_LOGIC;
			clk_entrada : IN STD_LOGIC; -- reloj de entrada de la entity superior
			clk_out : OUT STD_LOGIC; -- reloj que se utiliza en los process de los leds
			clk_out_a : OUT STD_LOGIC; -- reloj del display 1
			clk_out_b : OUT STD_LOGIC); -- reloj del display 2
	END COMPONENT;

	-----------------------------------------------------------------
	--! \brief control unit for the different states of the slot machine
	-----------------------------------------------------------------
	COMPONENT estados
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			ini : IN STD_LOGIC;
			fin : IN STD_LOGIC;
			ctrl_data : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			ctrl : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
	END COMPONENT;

	-----------------------------------------------------------------
	--! \brief data path to connect the different components
	-----------------------------------------------------------------
	COMPONENT ruta_de_datos
		PORT (
			clk_1hleds : IN STD_LOGIC;
			clk_a : IN STD_LOGIC;
			clk_b : IN STD_LOGIC;
			ctrl : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
			display_out_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			display_out_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			ctrl_data : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

	-- Define signals
	-----------------------------------------------------------------
	--! \brief clocks for the leds and the two counters
	-----------------------------------------------------------------
	SIGNAL clk_1hleds, clk_a, clk_b : STD_LOGIC;
	SIGNAL control_link : STD_LOGIC_VECTOR (6 DOWNTO 0);
	-----------------------------------------------------------------
	--! \brief Control unit for the resets and the enablers
	-----------------------------------------------------------------
	SIGNAL control_data_link : STD_LOGIC_VECTOR (1 DOWNTO 0);

BEGIN

	div : divisor
	PORT MAP(
		rst => rst,
		clk_entrada => clk,
		clk_out => clk_1hleds,
		clk_out_a => clk_a,
		clk_out_b => clk_b);

	dp : ruta_de_datos
	PORT MAP(
		clk_1hleds => clk_1hleds,
		clk_a => clk_a,
		clk_b => clk_b,
		ctrl => control_link,
		display_out_a => cont1,
		display_out_b => cont2,
		ctrl_data => control_data_link,
		leds => leds);
	cu : estados
	PORT MAP(
		clk => clk,
		rst => rst,
		ini => inicio,
		fin => fin,
		ctrl_data => control_data_link,
		ctrl => control_link);
END Behavioral;
