LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY sintesis_cerrojo IS
  PORT (
    rst : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    boton : IN STD_LOGIC;
    clave : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    bloqueado : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    display : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    s_display : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
  );
END sintesis_cerrojo;

ARCHITECTURE cerrojoArch OF sintesis_cerrojo IS

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

  COMPONENT debouncer
    PORT (
      rst : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      x : IN STD_LOGIC;
      xDeb : OUT STD_LOGIC;
      xDebFallingEdge : OUT STD_LOGIC;
      xDebRisingEdge : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT conv_7seg IS
    PORT (
      x : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      display : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
  END COMPONENT;

  SIGNAL st : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL salidaDebouncer, bloqueado_aux : STD_LOGIC;

BEGIN

  debouncerInstance : debouncer PORT MAP(NOT rst, clk, boton, OPEN, OPEN, salidaDebouncer);
  cerrojoInstance : cerrojo PORT MAP(rst, clk, salidaDebouncer, clave, bloqueado_aux, st);
  conv_7segInstance : conv_7seg PORT MAP(st, display);
  bloqueado <= (OTHERS => bloqueado_aux);
  s_display <= "1110";

END cerrojoArch;
