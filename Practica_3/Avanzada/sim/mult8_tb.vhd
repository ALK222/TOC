--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY simulacion IS
END simulacion;

ARCHITECTURE behavior OF simulacion IS

      -- Declaraci?n del componente que vamos a simular

      COMPONENT mult8b
            PORT (
                  rst : IN STD_LOGIC;
                  clk : IN STD_LOGIC;
                  ini : IN STD_LOGIC;
                  fin : OUT STD_LOGIC;
                  a : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
                  b : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
                  c : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
            );
      END COMPONENT;

      --Entradas
      SIGNAL rst : STD_LOGIC;
      SIGNAL clk : STD_LOGIC;
      SIGNAL inicio : STD_LOGIC;
      SIGNAL a_in, b_in : STD_LOGIC_VECTOR(4 DOWNTO 0);

      --Salidas
      SIGNAL fin : STD_LOGIC;
      SIGNAL r : STD_LOGIC_VECTOR(8 DOWNTO 0);

      --Se define el periodo de reloj 
      CONSTANT clk_period : TIME := 50 ns;

BEGIN

      -- Instanciacion de la unidad a simular 

      uut : mult8b PORT MAP(
            rst => rst,
            clk => clk,
            ini => inicio,
            fin => fin,
            a => a_in,
            b => b_in,

            c => r
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
            inicio <= '0';
            a_in <= "00000";
            b_in <= "00000";
            WAIT FOR 45 ns;
            -- Dejamos de resetear	
            rst <= '0';
            inicio <= '0';
            a_in <= "00000";
            b_in <= "00000";
            WAIT FOR 150 ns;
            -- Cargamos datos
            rst <= '0';
            inicio <= '1';
            a_in <= "01000";
            b_in <= "00011";
            WAIT FOR 100 ns;
            -- Espera calculo
            inicio <= '0';
            a_in <= "00000";
            b_in <= "00000";
            WAIT FOR 1000 ns;
            -- Cargamos datos
            rst <= '0';
            inicio <= '1';
            a_in <= "01000";
            b_in <= "10011";
            WAIT FOR 100 ns;
            -- Espera calculo
            inicio <= '0';
            a_in <= "00000";
            b_in <= "00000";
            WAIT FOR 1000 ns;
            -- Cargamos datos
            rst <= '0';
            inicio <= '1';
            a_in <= "11000";
            b_in <= "00011";
            WAIT FOR 100 ns;
            -- Espera calculo
            inicio <= '0';
            a_in <= "00000";
            b_in <= "00000";
            WAIT FOR 1000 ns;
            -- Cargamos datos
            rst <= '0';
            inicio <= '1';
            a_in <= "11000";
            b_in <= "10011";
            WAIT FOR 100 ns;
            -- Espera indefinida
            inicio <= '0';
            a_in <= "00000";
            b_in <= "00000";
            WAIT;
      END PROCESS;

END;
