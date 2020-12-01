LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mult8b IS
    PORT (
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        ini : IN STD_LOGIC;
        a : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
        fin : OUT STD_LOGIC
    );
END mult8b;

ARCHITECTURE behavioral OF mult8b IS

    SIGNAL a_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL acc : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL init : STD_LOGIC;

BEGIN

    mult : PROCESS (clk, rst)
        TYPE estados IS (set, idle, done);
        VARIABLE next_state, current_state : estados;
        VARIABLE n : STD_LOGIC_VECTOR(3 DOWNTO 0);
        VARIABLE signo_a : STD_LOGIC;
        VARIABLE signo_b : STD_LOGIC;
        VARIABLE signo_final : STD_LOGIC;

    BEGIN
        init <= ini;
        IF (rst = '1') THEN
            a_in <= (OTHERS => '0');
            acc <= (OTHERS => '0');
            c <= (OTHERS => '0');
            init <= '1';
            fin <= '0';
            next_state := set;
        ELSE
            IF (clk'event AND clk = '1') THEN
                current_state := next_state;
                CASE current_state IS
                    WHEN done =>
                        next_state := done;
                        c(7 DOWNTO 0) <= acc;
                        c(8) <= signo_final;
                        fin <= '1';
                        IF (ini = '1') THEN
                            next_state := set;
                        END IF;
                    WHEN set =>
                        IF (ini = '1') THEN
                            n := b(3 DOWNTO 0);
                            signo_b := b(4);
                            a_in <= a(3 DOWNTO 0);
                            signo_a := a(4);
                            acc <= "00000000";
                            fin <= '0';
                            next_state := idle;
                            IF (signo_a = signo_b) THEN
                                signo_final := '0';
                            ELSE
                                signo_final := '1';
                            END IF;
                        ELSE
                            next_state := set;
                        END IF;
                    WHEN idle =>
                        c(7 DOWNTO 0) <= acc; --Si quieres verlo paso a paso
                        c(8) <= signo_final;
                        IF (n = "0000") THEN
                            init <= '0';
                            next_state := done;
                        ELSE
                            acc <= STD_LOGIC_VECTOR(unsigned(acc) + unsigned(a_in));
                            n := STD_LOGIC_VECTOR(unsigned(n) - 1);
                        END IF;
                END CASE;
            END IF;
        END IF;
    END PROCESS; -- mult
END behavioral; -- behavioral
