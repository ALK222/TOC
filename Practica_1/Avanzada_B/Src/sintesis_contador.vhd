LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY sintesis_contador IS
  PORT (
    rst : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    cuenta : IN STD_LOGIC;
    salida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END sintesis_contador;

ARCHITECTURE syn OF sintesis_contador IS

  COMPONENT contadorMod16 IS
    PORT (
      rst : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      cuenta : IN STD_LOGIC;
      salida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

  SIGNAL clk_1Hz : STD_LOGIC;

BEGIN

  divisor :
  PROCESS (rst, clk)
    VARIABLE cuenta : NATURAL RANGE 0 TO 49999999;
  BEGIN
    IF (rst = '1') THEN
      cuenta := 0;
      clk_1Hz <= '0';
    ELSIF (rising_edge(clk)) THEN
      IF (cuenta = 49999999) THEN
        clk_1Hz <= NOT clk_1Hz;
        cuenta := 0;
      ELSE
        cuenta := cuenta + 1;
      END IF;
    END IF;
  END PROCESS divisor;

  contador : contadorMod16 PORT MAP(
    rst => rst,
    clk => clk_1Hz,
    cuenta => cuenta,
    salida => salida
  );

END syn;
