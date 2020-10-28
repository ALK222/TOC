--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY simulacion_cerrojo IS
END simulacion_cerrojo;

ARCHITECTURE behavior OF simulacion_cerrojo IS

      -- Declaraci?n del componente que vamos a simular

      COMPONENT cerrojo IS
            PORT (
                  rst : IN STD_LOGIC;
                  clk : IN STD_LOGIC;
                  boton : IN STD_LOGIC;
                  clave : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                  bloqueado : OUT STD_LOGIC;
                  intentos : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
            );
      END COMPONENT;

      --Entradas
      SIGNAL rst : STD_LOGIC;
      SIGNAL clk : STD_LOGIC;
      SIGNAL boton, bloqueado : STD_LOGIC;

      --Salidas
      SIGNAL clave : STD_LOGIC_VECTOR(7 DOWNTO 0);
      SIGNAL intentos : STD_LOGIC_VECTOR(3 DOWNTO 0);

      --Se define el periodo de reloj 
      CONSTANT clk_period : TIME := 50 ns;

BEGIN

      -- Instanciacion de la unidad a simular 

      uut : cerrojo PORT MAP(
            rst => rst,
            clk => clk,
            boton => boton,
            clave => clave,
            bloqueado => bloqueado,
            intentos => intentos
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
            boton <= '0';
            clave <= "00000000";
            WAIT FOR 45 ns;
            -- Dejamos de resetear	
            rst <= '0';
            boton <= '0';
            clave <= "00000000";
            WAIT FOR 150 ns;
            -- Cargamos clave
            rst <= '0';
            boton <= '1';
            clave <= "00110010";
            WAIT FOR 50 ns;
            -- Espera
            rst <= '0';
            boton <= '0';
            clave <= "00110010";
            WAIT FOR 500 ns;
            -- Fallamos clave
            rst <= '0';
            boton <= '1';
            clave <= "00100010";
            WAIT FOR 50 ns;
            -- Espera
            rst <= '0';
            boton <= '0';
            clave <= "00100010";
            WAIT FOR 500 ns;
            -- Fallamos clave
            rst <= '0';
            boton <= '1';
            clave <= "10100010";
            WAIT FOR 50 ns;
            -- Espera
            rst <= '0';
            boton <= '0';
            clave <= "10100010";
            WAIT FOR 500 ns;
            -- Acertamos clave
            rst <= '0';
            boton <= '1';
            clave <= "00110010";
            WAIT FOR 50 ns;
            -- Espera
            rst <= '0';
            boton <= '0';
            clave <= "00110010";
            WAIT FOR 500 ns;
            -- Cargamos clave
            rst <= '0';
            boton <= '1';
            clave <= "11111111";
            WAIT FOR 50 ns;
            -- Espera
            rst <= '0';
            boton <= '0';
            clave <= "11111111";
            WAIT FOR 500 ns;
            -- Fallamos clave
            rst <= '0';
            boton <= '1';
            clave <= "00000000";
            WAIT FOR 50 ns;
            -- Espera
            rst <= '0';
            boton <= '0';
            clave <= "00000000";
            WAIT FOR 500 ns;
            -- Fallamos clave
            rst <= '0';
            boton <= '1';
            clave <= "10000000";
            WAIT FOR 50 ns;
            -- Espera
            rst <= '0';
            boton <= '0';
            clave <= "10000000";
            WAIT FOR 500 ns;
            -- Fallamos clave
            rst <= '0';
            boton <= '1';
            clave <= "11000000";
            WAIT FOR 50 ns;
            -- Espera indefinida
            rst <= '0';
            boton <= '0';
            clave <= "11000000";
            WAIT;
      END PROCESS;

END;
