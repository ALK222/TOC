----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2020 09:34:31
-- Design Name: 
-- Module Name: MIPs_multiciclo_core - Behavioral
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

ENTITY MIPS_multiciclo IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		modo : IN STD_LOGIC;
		siguiente : IN STD_LOGIC;
		R3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MIPS_multiciclo;

ARCHITECTURE MIPSMulticicloArch OF MIPS_multiciclo IS

	COMPONENT unidadDeControl IS
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			control : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
			Zero : IN STD_LOGIC;
			op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			modo : IN STD_LOGIC;
			siguiente : IN STD_LOGIC
		);
	END COMPONENT;

	COMPONENT rutaDeDatos IS
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			control : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
			Zero : OUT STD_LOGIC;
			op : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
			R3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			PCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL control : STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL Zero : STD_LOGIC;
	SIGNAL op : STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN
	UC : unidadDeControl PORT MAP(clk => clk, rst => rst, control => control, Zero => Zero, op => op, modo => modo, siguiente => siguiente);

	RD : rutaDeDatos PORT MAP(clk => clk, rst => rst, control => control, Zero => Zero, op => op, R3 => R3, PCout => PCout);

END MIPSMulticicloArch;
