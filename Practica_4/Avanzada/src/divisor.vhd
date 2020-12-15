----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Hortensia Mecha
-- 
-- Design Name: divisor 
-- Module Name:    divisor - divisor_arch 
-- Project Name: 
-- Target Devices: 
-- Description: Creaci�n de un reloj de 1Hz a partir de
--		un clk de 100 MHz
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY divisor IS
	PORT (
		rst : IN STD_LOGIC;
		clk_entrada : IN STD_LOGIC; -- reloj de entrada de los leds
		clk_out : OUT STD_LOGIC; -- reloj que se utiliza en los process del programa principal
		clk_out_a : OUT STD_LOGIC; -- reloj del display 1
		clk_out_b : OUT STD_LOGIC -- reloj del display 2
	);
END divisor;

ARCHITECTURE divisor_arch OF divisor IS
	SIGNAL cuenta : STD_LOGIC_VECTOR(27 DOWNTO 0);
	SIGNAL cuenta_a : STD_LOGIC_VECTOR(27 DOWNTO 0);
	SIGNAL cuenta_b : STD_LOGIC_VECTOR(27 DOWNTO 0);
	SIGNAL clk_aux : STD_LOGIC;
	SIGNAL clk_aux_b : STD_LOGIC;
	SIGNAL clk_aux_a : STD_LOGIC;

BEGIN
	clk_out <= clk_aux;
	clk_out_a <= clk_aux_a;
	clk_out_b <= clk_aux_b;
	contador :
	PROCESS (rst, clk_entrada)
	BEGIN
		IF (rst = '1') THEN
			cuenta <= (OTHERS => '0');
			cuenta_a <= (OTHERS => '0');
			cuenta_b <= (OTHERS => '0');
			clk_aux <= '0';
			clk_aux_b <= '0';
			clk_aux_a <= '0';
		ELSIF (rising_edge(clk_entrada)) THEN
			IF (cuenta = "0010111110101111000010000000") THEN
				clk_aux <= '1';
				cuenta <= (OTHERS => '0');
			ELSE
				cuenta <= cuenta + '1';
				clk_aux <= '0';
			END IF;
			IF (cuenta_a = "0000000000001000010000000000") THEN
				clk_aux_a <= '1';
				cuenta_a <= (OTHERS => '0');
			ELSE
				cuenta_a <= cuenta_a + '1';
				clk_aux_a <= '0';
			END IF;
			IF (cuenta_b = "0000000000000000000011000000") THEN
				clk_aux_b <= '1';
				cuenta_b <= (OTHERS => '0');
			ELSE
				cuenta_b <= cuenta_b + '1';
				clk_aux_b <= '0';
			END IF;
		END IF;
	END PROCESS contador;

END divisor_arch;
