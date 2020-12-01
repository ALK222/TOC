LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY registro IS
  PORT (
    rst : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    load : IN STD_LOGIC;
    E : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END registro;

ARCHITECTURE Behavioral OF registro IS

BEGIN

  PROCESS (clk)
  BEGIN
    IF (rising_edge(clk)) THEN
      IF (rst = '1') THEN
        S <= "0000";
      ELSIF (load = '1') THEN
        S <= E;
      END IF;
    END IF;
  END PROCESS;

END Behavioral;
