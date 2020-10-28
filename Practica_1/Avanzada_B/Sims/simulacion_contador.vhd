--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY simulacion_contador IS
END simulacion_contador;
 
ARCHITECTURE behavior OF simulacion_contador IS 
 
-- Declaraci?n del componente que vamos a simular
   
    component contadorMod16 is
    port (
      rst    : IN  std_logic;
      clk    : IN  std_logic;
      cuenta : IN  std_logic;
      salida : OUT std_logic_vector(3 downto 0)
    );
    end component;

--Entradas
    signal rst : std_logic;
    signal clk : std_logic;
    signal cuenta: std_logic;
		
--Salidas
    signal salida : std_logic_vector(3 downto 0);
   
--Se define el periodo de reloj 
    constant clk_period : time := 50 ns;
 
BEGIN
 
-- Instanciacion de la unidad a simular 

   uut: contadorMod16 PORT MAP (
         rst => rst,
         clk => clk,
		     cuenta => cuenta,
         salida => salida
        );

-- Definicion del process de reloj
reloj_process :process
   begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;
 

--Proceso de estimulos
stim_proc: process
   begin		
-- Se mantiene el rst activado durante 45 ns.
      rst<='1';
      cuenta <= '0';
      wait for 45 ns;
-- Dejamos de resetear	
      rst<='0';
      cuenta <= '0';
      wait for 50 ns;	
-- Activamos cuenta
      rst<='0';
      cuenta <= '1';
      wait for 500 ns;	
-- Desactivamos cuenta
      rst<='0';
      cuenta <= '0';
      wait for 500 ns;	
-- Activamos cuenta para siempre
      rst<='0';
      cuenta <= '1';
      wait;	
end process;

END;