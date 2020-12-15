----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 12:18:47
-- Design Name: 
-- Module Name: tragaperras_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY tragaperras_tb IS
	--  Port ( );
END tragaperras_tb;

ARCHITECTURE Behavioral OF tragaperras_tb IS
	COMPONENT tragaperras IS
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			inicio : IN STD_LOGIC;
			fin : IN STD_LOGIC;
			cont1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			cont2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			leds : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
	END COMPONENT;

	SIGNAL rst : STD_LOGIC := '0';
	SIGNAL clk : STD_LOGIC := '0';
	SIGNAL inicio : STD_LOGIC := '0';
	SIGNAL fin : STD_LOGIC := '0';
	SIGNAL leds : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL cont1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL cont2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

	CONSTANT clk_period : TIME := 10 ns;

BEGIN

	tp : tragaperras
	PORT MAP(
		rst => rst,
		clk => clk,
		inicio => inicio,
		fin => fin,
		leds => leds,
		cont1 => cont1,
		cont2 => cont2
	);

	clk_process : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS; -- clk_process

	Stimulus : PROCESS
	BEGIN

		rst <= '1';
		WAIT FOR 60 ns;

		rst <= '0';
		WAIT FOR 2 ms;

		inicio <= '1';
		WAIT FOR 20 ms;

		inicio <= '0';
		WAIT FOR 20 ms;

		fin <= '1';
		WAIT FOR 2000 ms;

		fin <= '0';
		WAIT FOR 200 ns;

		rst <= '1';
		WAIT FOR 60 ns;

		rst <= '0';
		--WAIT FOR 60 ns;

		--inicio <= '1';
		--WAIT FOR 60 ns;

		--inicio <= '0';
		--WAIT FOR 150 ns;

		--fin <= '1';
		--WAIT FOR 60 ns;

		--fin <= '0';
		--WAIT FOR 2000 ns;

	END PROCESS; -- Stimulus
END Behavioral; -- Behavioral
