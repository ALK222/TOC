----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Hortensia Mecha
-- 
-- Design Name: divisor 
-- Module Name:    divisor - divisor_arch 
-- Project Name: 
-- Target Devices: 
-- Description: Creación de un reloj de 1Hz a partir de
--		un clk de 100 MHz
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;

entity divisor is
    port (
        rst : IN STD_LOGIC;
			clk_entrada : IN STD_LOGIC; -- reloj de entrada de los leds
			clk_out : OUT STD_LOGIC; -- reloj que se utiliza en los process del programa principal
			clk_out_a : OUT STD_LOGIC; -- reloj del display 1
			clk_out_b : OUT STD_LOGIC -- reloj del display 2
    );
end divisor;

architecture divisor_arch of divisor is
 SIGNAL cuenta: std_logic_vector(27 downto 0);
 SIGNAL cuenta_a : std_logic_vector(27 downto 0);
 SIGNAL cuenta_b: std_logic_vector(27 downto 0);
 SIGNAL clk_aux: std_logic;
 SIGNAL clk_aux_b : std_logic;
 SIGNAL clk_aux_a : std_logic;
  
  begin

 
clk_out<=clk_aux;
clk_out_a<=clk_aux_a;
clk_out_b<=clk_aux_b;
  contador:
  PROCESS(rst, clk_entrada)
  BEGIN
    IF (rst='1') THEN
      cuenta<= (OTHERS=>'0');
      cuenta_a<= (OTHERS=>'0');
      cuenta_b<= (OTHERS=>'0');
      clk_aux<='0';
      clk_aux_b <= '0';
      clk_aux_a <= '0';
    ELSIF(rising_edge(clk_entrada)) THEN
      IF (cuenta="0010111110101111000010000000") THEN 
      	clk_aux <= '1';
        cuenta<= (OTHERS=>'0');
      ELSE
        cuenta <= cuenta+'1';
	   clk_aux<='0';
      END IF;
      if(cuenta_a="0000000000001000010000000000") then
        clk_aux_a <= '1';
        cuenta_a <= (others => '0');
      else
        cuenta_a <= cuenta_a + '1';
        clk_aux_a <= '0';
      END IF;
      if(cuenta_b="0000000000000000000011000000") then
        clk_aux_b <= '1';
        cuenta_b <= (others => '0');
      else
        cuenta_b <= cuenta_b + '1';
        clk_aux_b <= '0';
       end if;
    END IF;
  END PROCESS contador;

end divisor_arch;
