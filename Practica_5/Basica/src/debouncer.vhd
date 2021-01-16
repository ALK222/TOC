LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY debouncer IS
  GENERIC (
    FREQ : NATURAL := 10000; -- frecuencia de operacion en KHz
    BOUNCE : NATURAL := 50 -- tiempo de rebote en ms
  );
  PORT (
    rst : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    x : IN STD_LOGIC;
    xDeb : OUT STD_LOGIC;
    xDebFallingEdge : OUT STD_LOGIC;
    xDebRisingEdge : OUT STD_LOGIC
  );
END debouncer;

ARCHITECTURE debouncerArch OF debouncer IS

  SIGNAL XSyncAnterior : STD_LOGIC;
  SIGNAL XSync : STD_LOGIC;

  CONSTANT timeOut : unsigned (22 DOWNTO 0) := to_unsigned((BOUNCE * FREQ) - 1, 23);
  SIGNAL count : unsigned (22 DOWNTO 0);

  TYPE states IS (waitingPression, pressionDebouncing, waitingDepression, depressionDebouncing);
  SIGNAL state, next_state : states;
  SIGNAL startTimer, timerEnd : STD_LOGIC;

BEGIN

  synchronizer :
  PROCESS (rst, clk)
    VARIABLE aux1 : STD_LOGIC;
  BEGIN
    IF (rst = '1') THEN
      XSyncAnterior <= '1';
      XSync <= '1';
    ELSIF (RISING_EDGE(clk)) THEN
      XSync <= XSyncAnterior;
      XSyncAnterior <= x;
    END IF;
  END PROCESS synchronizer;

  timer :
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      count <= (OTHERS => '0');
    ELSIF (RISING_EDGE(clk)) THEN
      IF (startTimer = '1') THEN
        count <= (OTHERS => '0');
      ELSIF (timerEnd = '0') THEN
        count <= count + 1;
      END IF;
    END IF;
  END PROCESS timer;

  timerEnd <= '1' WHEN (count = timeOut) ELSE
    '0';

  CU_sync :
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      state <= waitingPression;
    ELSIF (RISING_EDGE(clk)) THEN
      state <= next_state;
    END IF;
  END PROCESS CU_sync;

  CU_comb :
  PROCESS (state, xSync, timerEnd)
  BEGIN

    xDeb <= '1';
    xDebFallingEdge <= '0';
    xDebRisingEdge <= '0';
    startTimer <= '0';
    next_state <= state;

    CASE state IS

      WHEN waitingPression =>
        IF (xSync = '0') THEN
          xDebFallingEdge <= '1';
          startTimer <= '1';
          next_state <= pressionDebouncing;
        END IF;

      WHEN pressionDebouncing =>
        xDeb <= '0';
        IF (timerEnd = '1') THEN
          next_state <= waitingDepression;
        END IF;

      WHEN waitingDepression =>
        xDeb <= '0';
        IF (xSync = '1') THEN
          xDebRisingEdge <= '1';
          startTimer <= '1';
          next_state <= depressionDebouncing;
        END IF;

      WHEN depressionDebouncing =>
        IF (timerEnd = '1') THEN
          next_state <= waitingPression;
        END IF;

    END CASE;
  END PROCESS CU_comb;
END debouncerArch;
