LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

--entidad

ENTITY tb_sumador IS
END tb_sumador;

--arquitectura

ARCHITECTURE behavioural OF tb_sumador IS

   -- Declaraci?n del componente que vamos a simular

   COMPONENT sumador
      PORT (
         A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         C : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
      );
   END COMPONENT;

   --Entradas
   SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
   SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

   --Salidas
   SIGNAL C : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

   -- Instanciacion de la unidad a simular 
   uut : sumador PORT MAP(
      A => A,
      B => B,
      C => C
   );

   -- Proceso de estimulos
   stim_proc : PROCESS
   BEGIN
      A <= "0000";
      B <= "0000";
      WAIT FOR 100 ns;
      A <= "0101";
      B <= "0100";
      WAIT FOR 100 ns;
      A <= "0000";
      B <= "0111";
      WAIT FOR 100 ns;
      A <= "0011";
      B <= "1000";
      WAIT FOR 100 ns;
      A <= "1011";
      B <= "1111";
      WAIT FOR 100 ns;
      A <= "1001";
      B <= "0110";
      WAIT;
   END PROCESS;

END behavioural;
