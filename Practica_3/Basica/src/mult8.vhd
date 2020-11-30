LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mult8 IS
    PORT (
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        ini : IN STD_LOGIC;
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        fin : out STD_LOGIC
    );
END mult8;

ARCHITECTURE behavioral OF mult8 IS

    SIGNAL a_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL acc : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal init : std_LOGIC;

BEGIN

    mult : PROCESS (clk, rst)
        TYPE estados IS (set, idle, done);
        VARIABLE next_state, current_state : estados;
        VARIABLE n : STD_LOGIC_VECTOR(3 downto 0);
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
                        c <= acc;
                        fin <= '1';
                    WHEN set =>
                        if(ini = '1') then
                            n := b;
                            a_in <= a;
                            acc <= "00000000"; 
                            fin <= '0';
                            next_state := idle;
                        else
                            next_state := done;
                        end if;
                    WHEN idle =>
                        c<= acc; --Si quieres verlo paso a paso
                        if(n = "0000") then
                            init <= '0';
                            next_state := done;
                        else
                            acc <=  std_logic_vector(unsigned(acc) + unsigned(a_in));
                            n :=  std_logic_vector(unsigned(n) - 1);
                        end if;
                END CASE;
            END IF;
        END IF;
    END PROCESS; -- mult
END behavioral; -- behavioral
