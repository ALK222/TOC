LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

-------------------------------------------------------------------------------
-- Entidad
-------------------------------------------------------------------------------
ENTITY tb_sumador_exhaustivo IS
END tb_sumador_exhaustivo;

-------------------------------------------------------------------------------
-- Arquitectura
-------------------------------------------------------------------------------

ARCHITECTURE beh OF tb_sumador_exhaustivo IS

  -- Declaracion del componente que vamos a simular
  COMPONENT sumador_4bits
    PORT (
      a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      c : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

  -- Entradas
  SIGNAL a : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
  SIGNAL b : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

  -- Salidas
  SIGNAL c : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL d : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

  -- Instanciacion de la unidad a simular 
  dut : sumador_4bits PORT MAP(
    a => a,
    b => b,
    c => c
  );

  -- Proceso de estimulos
  p_stim : PROCESS
    VARIABLE v_i : NATURAL := 0;
    VARIABLE v_j : NATURAL := 0;
  BEGIN
    i_loop : FOR v_i IN 0 TO 15 LOOP
      j_loop : FOR v_j IN 0 TO 15 LOOP
        a <= STD_LOGIC_VECTOR(to_unsigned(v_i, 4));
        b <= STD_LOGIC_VECTOR(to_unsigned(v_j, 4));
        d <= STD_LOGIC_VECTOR(to_unsigned(v_i, 4) + to_unsigned(v_j, 4));
        WAIT FOR 10 ns;
        ASSERT c = d
        REPORT "Error: suma incorrecta"
          SEVERITY error;
        WAIT FOR 10 ns;
      END LOOP j_loop;
    END LOOP i_loop;
    WAIT;
  END PROCESS p_stim;

END beh;
