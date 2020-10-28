ENTITY cerrojo IS
    PORT (
        rst : IN STD_LOGIC;
        clk_c : IN STD_LOGIC;
        boton : IN STD_LOGIC;
        clave : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        bloqueado : OUT STD_LOGIC;
        intentos : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END cerrojo;

ARCHITECTURE arch OF cerrojo IS

    TYPE estados IS (ini_st, tres_st, dos_st, uno_st, fin_st)
    SIGNAL current_st, next_st : estados;
    SIGNAL s_key : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL s_tries : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL s_boton_deb : STD_LOGIC;
    SIGNAL s_clk : STD_LOGIC;

    COMPONENT conv_7seg IS
        PORT (
            x : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            display : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;
    COMPONENT debouncer IS
        PORT (
            rst : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            x : IN STD_LOGIC;
            xDeb : OUT STD_LOGIC;
            xDebFallingEdge : OUT STD_LOGIC;
            xDebRisingEdge : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    begin_conv_7seg : conv_7seg PORT MAP(x => s_tries, display => dsp);
    begin_debouncer : debouncer PORT MAP(rst => rst, x => boton, clk => clk_c, xDebFallingEdge => s_boton_deb);
    s_clk <= clk_c;
    p_reg : PROCESS (s_clk, rst)
    BEGIN
        IF (rst = '0') THEN
            s_key <= '0';
            current_st <= init_st;
        ELSE
            IF (rising_edge(s_clk)) THEN
                current_st <= next_st;
                IF s_boton_deb = '1' AND current_st = ini_st THEN
                    s_key <= key;
                END IF;
            END IF;
        END IF;
    END PROCESS; -- p_reg
    p_next_state : PROCESS (current_state, boton, key, s_key)
    BEGIN
        CASE(current_state) IS

            -- Inital case
            WHEN init_st =>
            led <= '1';
            s_tries <= "1010";
            IF (s_boton_deb = '1') THEN
                next_st <= tres_st;
            ELSE
                next_st <= current_st;
            END IF;
            -- Three state
            WHEN tres_st =>
            led <= '0';
            s_tries <= "0011";
            IF (s_boton_deb = '1' AND s_key = key) THEN
                next_st <= init_st;
            ELSE
                IF (s_boton_deb = '1') THEN
                    next_st <= dos_st;
                ELSE
                    next_st <= current_st;
                END IF;
            ELSE
                next_st <= current_st;
            END IF;
            -- Two state
            WHEN dos_st =>
            led <= '0';
            s_tries <= "0010";
            IF (s_boton_deb = '1' AND s_key = key) THEN
                next_st <= init_st;
            ELSE
                IF (s_boton_deb = '1')
                    next_st <= uno_st;
                ELSE
                    next_st <= current_st;
                END IF;
            END IF;
            -- One state
            WHEN uno_st =>
            led <= '0';
            s_tries <= "0001";
            IF (s_boton_deb = '1' AND s_key = key) THEN
                next_st <= init_st;
            ELSE
                IF (s_boton_deb = '1') THEN
                    next_st <= fin_st;
                ELSE
                    next_st <= current_st;
                END IF;
            END IF;
            -- Final state
            WHEN fin_st =>
            led <= '0';
            s_tries <= "1000";
            next_state <= current_st;
            WHEN OTHERS =>
            s_tries <= '0';
            led <= '1';
            next_st <= ini_st;
        END CASE;
    END PROCESS; -- p_next_state
END arch; -- arch
