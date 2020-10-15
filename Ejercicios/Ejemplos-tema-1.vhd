-- Ejercicio: definir una puerta AND de dos entradas:

ENTITY AND IS
    PORT (
        A : IN BIT;
        B : IN BIT;
        salida : OUT BIT
    );
END AND;
-- Ejercicio: definir un sumador de 4 bits

ENTITY sumador IS
    PORT (
        data1 : IN bit_vector (3 DOWNTO 0);
        data2 : IN bit_vector (3 DOWNTO 0);
        salida : OUT bit_vector (3 DOWNTO 0)
    );
END sumador;
-- Ejercicio: definir un multiplexor

ENTITY multiplexor0 IS
    PORT (
        control : IN bit_vector (2 DOWNTO 0);
        data : IN bit_vector (7 DOWNTO 0);
        output : OUT BIT
    );
END multiplexor0;

-- Ejercicio: definir un multiplexor 8 a 1 con genericos

ENTITY multiplexor1 IS
    GENERIC (N : INTEGER := 3);
    PORT (
        control : IN bit_vector (N - 1 DOWNTO 0);
        data : IN bit_vector (2 ** N - 1 DOWNTO 0);
        output : OUT BIT
    );
END multiplexor1;

-- Ejercicio: arquitectura del sumador

ARCHITECTURE and2 OF AND IS
BEGIN
    salida <= A AND B;
END ARCHITECTURE and2;

-- Ejercicio: arquitectura sumador

ARCHITECTURE adder OF sumador IS
    my_signal : std_logic_vector (3 DOWNTO 0);
BEGIN
    my_signal <= data1 + data2; -- Señal innecesaria, pero así tenemos un ejemplo de asignación
    salida <= my_signal;
END ARCHITECTURE adder;

-- Ejercicio: arquitectura del multiplexor con when-else

ARCHITECTURE multi0 OF multiplexor0 IS
    my_signal <= data(0) WHEN control = "000" ELSE
        data(1) WHEN control = "001" ELSE
        data(2) WHEN control = "010" ELSE
        data(3) WHEN control = "011" ELSE
        data(4) WHEN control = "100" ELSE
        data(5) WHEN control = "101" ELSE
        data(6) WHEN control = "110" ELSE
        data(7);
BEGIN
    salida <= my_signal;
END multi0;

-- Ejercicio: arquitectura del multiplexor con with-select

ARCHITECTURE multi1 OF multiplexor0 IS
    WITH control SELECT
        output data(0) WHEN control = "000",
        data(1) WHEN "001",
        data(2) WHEN "010",
        data(3) WHEN "011",
        data(4) WHEN "100",
        data(5) WHEN "101",
        data(6) WHEN "110",
        data(7) WHEN "111",
        '0' WHEN OTHERS;
BEGIN
    salida <= output;
END multi1;

-- Ejercicio: process de un multiplexor con if then else

mult_if_then_else : PROCESS (data, control)
BEGIN
    IF control = "000" THEN
        salida <= data(0);
    ELSIF control = "001" THEN
        salida <= data(1);
    ELSIF control = "010" THEN
        salida <= data(2);
    ELSIF control = "011" THEN
        salida <= data(3);
    ELSIF control = "100" THEN
        salida <= data(4);
    ELSIF control = "101" THEN
        salida <= data(5);
    ELSIF control = "110" THEN
        salida <= data(6);
    ELSE
        salida <= data(7);
    END IF;
END

-- Ejercicio: process de un multiplexor con case

mult_case : PROCESS (data, control)
BEGIN
    CASE(control) IS
        WHEN "000" => salida <= data(0);
        WHEN "001" => salida <= data(1);
        WHEN "010" => salida <= data(2);
        WHEN "011" => salida <= data(3);
        WHEN "100" => salida <= data(4);
        WHEN "101" => salida <= data(5);
        WHEN "110" => salida <= data(6);
        WHEN OTHERS => salida <= data(7);
    END CASE;
END PROCESS; -- mult_case

-- Ejercicio: biestable con reset sincrono

ENTITY D_FF_SReset IS
    PORT (d, clk, reset, preset : IN BIT, q : OUT BIT);
END D_FF_SReset;

ARCHITECTURE ARCH_SYN OF DFF_SReset IS
BEGIN
    PROCESS (clk, reset, d)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                q <= '0';
            ELSE
                q <= d;
            END IF;
        END IF;
    END PROCESS;
END ARCH_SYN;

-- Ejercicio: biestable con reset asincrono

ENTITY D_FF_ASReset IS
    PORT (
        d, clk, reset : IN BIT;
        q : OUT BIT);
END D_FF_ASReset;

ARCHITECTURE ARCH_ASYNC OF D_FF_ASReset IS
BEGIN
    reset : PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            q <= '0';
        ELSIF rising_edge(clk) THEN
            q <= d;
        END IF;
    END PROCESS; -- reset
END ARCH_ASYNC; -- ARCH_ASYNC

-- Ejercicio: sumandor de 4 bits con cin y cout utilizando IEEE

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY sum4 IS
    PORT (
        data1 : IN std_logic_vector (3 DOWNTO 0);
        data2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        cin : IN std_logic;
        salida : OUT std_logic_vector (3 DOWNTO 0);
        cout : OUT STD_LOGIC);
END sum4;

ARCHITECTURE Behavioral OF sum4 IS

    SIGNAL ms1, ms2, ms3, ms4 : std_logic_vector (4 DOWNTO 0);

BEGIN
    ms1(4 donwto 0) <= '0' & data1;
    ms2(4 DOWNTO 0) <= '0' & data2;
    ms3 <= "0000" & cin;
    ms4 <= ms1 + ms2 + ms3;
    salida <= ms4(3 DOWNTO 0);
    cout <= ms4(4);
END Behavioral; -- Behavioral

-- Ejercicio: sumandor de 8 bits con cin y cout utilizando IEEE
ENTITY sum8 IS
    PORT (
        data1 : IN std_logic_vector (7 DOWNTO 4);
        data2 : IN STD_LOGIC_VECTOR (7 DOWNTO 4);
        cin : IN std_logic;
        salida : OUT std_logic_vector (7 DOWNTO 4);
        cout : OUT STD_LOGIC);
END sum8;

ARCHITECTURE Behavioral OF sum8 IS
    COMPONENT sum4
        PORT (
            data1 : IN std_logic_vector (3 DOWNTO 0);
            data2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            cin : IN std_logic;
            salida : OUT std_logic_vector (3 DOWNTO 0);
            cout : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL carry : std_logic;

BEGIN
    sum1 : sum4 PORT MAP(data1(3 DOWNTO 0), data2(3 DOWNTO 0), cin, salida(3 DOWNTO 0), carry);
    sum2 : sum8 PORT MAP(data1(7 DOWNTO 4), data 2(7 DOWNTO 4), carry, salida(7 DOWNTO 4, cout));
END Behavioral; -- Behavioral

-- Ejercicio: sumador de 8 bits con generate

ARCHITECTURE Behavioral OF sum8 IS
    COMPONENT sum4
        PORT (
            data1 : IN std_logic_vector (3 DOWNTO 0);
            data2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            cin : IN std_logic;
            salida : OUT std_logic_vector (3 DOWNTO 0);
            cout : OUT STD_LOGIC);
    END COMPONENT;
    TYPE my_array IS ARRAY(1 DOWNTO 0) OF STD_LOFIC_VECTOR(3 DOWNTO 0);
    TYPE scarrt IS ARRAY(2downto 0) OF STD_LOGIC;
    SIGNAL scin : scarry;
    SIGNAL scout : scarry;
    SIGNAL ssalida, sdata1, sdata2 : my_array;

BEGIN
    scin(0) <= cin;
    cout <= scout(1);
    gen : FOR i IN 0 TO i GENERATE
        sdata1(i) <= data1((4 * i + 3) DOWNTO (4 * i));
        sdata2(i) <= data2((4 * i + 3) DOWNTO (4 * i));
        salida((4 * i + 3) DOWNTO (4 * i)) <= ssalida(i);
        sum : sum4 PORT MAP(sdata1(i), sdata2(i), scin(i), ssalida(i), scout(i));
        scin(i + 1) <= scout(i);
    END GENERATE gen;

END Behavioral; -- Behavioral

-- Ejercicio: maquina de estados finitos tipo moore
COMB : PROCESS (ESTADO, E)
BEGIN
    CASE(ESTADO) IS
        WHEN S0 => O <= '0';
        IF (E = '0') THEN
            SIG_ESTADO <= S1;
        ELSE
            SIG_ESTADO <= S0;
        END IF;
        WHEN S1 => O <= '0';
        IF (E = '0') THEN
            SIG_ESTADO <= S1;
        ELSE
            SIG_ESTADO <= S2;
        END IF;
        WHEN S2 => O <= '0';
        IF (E = '0') THEN
            SIG_ESTADO <= S1;
        ELSE
            SIG_ESTADO <= S3;
        END IF;
        WHEN S3 => O <= '0';
        IF (E = '0') THEN
            SIG_ESTADO <= S1;
        ELSE
            SIG_ESTADO <= S4;
        END IF;
    END CASE;
END PROCESS; -- COMB

-- Ejercicio: maquina de estados finitos tipo mealy

mealy : PROCESS (ESTADO, E)
BEGIN
    CASE(ESTADO) IS
        WHEN S0 => O <= '0';
        IF (E = '0') THEN
            SIG_ESTADO <= S1;
        ELSE
            SIG_ESTADO <= S0;
        END IF;
        WHEN S1 => O <= '0';
        IF (E = '0') THEN
            SIG_ESTADO <= S1;
        ELSE
            SIG_ESTADO <= S2;
        END IF;
        WHEN S2 => O <= '0';
        IF (E = '0') THEN
            SIG_ESTADO <= S1;
            O <= '0';
        ELSE
            SIG_ESTADO <= S0;
            O <= '1';
        END IF;
    END CASE;
END PROCESS; -- mealy

-- Ejercicio: sumador de 4*N bits con generate

ARCHITECTURE Behavioral OF sumN IS
    COMPONENT sum4
        PORT (
            data1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            data2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            cin : IN STD_LOGIC;
            salida : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            cout : : OUT STD_LOGIC);
    END COMPONENT;
    TYPE my_array IS ARRAY (N - 1 DOWNTO 0) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    TYPE scarry IS ARRAY (N DOWNTO 0) OF STD_LOGIC;
    SIGNAL scin : scarry;
    SIGNAL scout : scarry;
    SIGNAL ssalida, sdata1, sdata2 : my_array;

BEGIN
    scin(0) <= cin;
    cout <= scout(N - 1);
    gen : FOR i IN 0 TO N - 1 GENERATE
        sdata1(i) <= data1((4 * i + 3) DOWNTO (4 * i));
        sdata2(i) <= data2((4 * i + 3) DOWNTO (4 * i));
        salida((4 * i + 3) DOWNTO (4 * i)) <= ssalida(i);
        sum : sum4 PORT MAP(sdata1(i), sdata2(i), scin(i), scout(i));
        scin(i + 1) <= scout(i);
    END GENERATE gen;
END Behavioral; -- Behavioral

-- Ejercicio: Máquina de estados finitos FSM

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY FSM IS
    PORT (
        reset, E, clk : IN BIT;
        O : OUT BIT);
END FSM;

ARCHITECTURE ARCH OF FSM IS
    TYPE ESTADOS IS (S1, S2, S3, S4);
    SIGNAL Estado, SIG_ESTADO : ESTADOS;
BEGIN
    SYNC : PROCESS (clk, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                ESTADO <= S1;
            ELSE
                ESTADO <= SIG_ESTADO;
            END IF;
        END IF;
    END PROCESS; -- SYNC
    COMB : PROCESS (ESTADO, E)
    BEGIN
        CASE(ESTADO) IS

            WHEN S1 => O <= '0';
            IF E = '0' THEN
                SIG_ESTADO <= S2;
            ELSE
                SIG_ESTADO <= S1;
            END IF;
            WHEN S2 => O <= '0';
            IF (E = '0') THEN
                SIG_ESTADO <= S3;
            ELSE
                SIG_ESTADO <= S1;
            END IF;
            WHEN S3 => O <= '0';
            IF (E = '0') THEN
                SIG_ESTADO <= S3;
            ELSE
                SIG_ESTADO <= S4;

            END IF;
            WHEN S4 => O <= '1';
            IF (E = '0') THEN
                SIG_ESTADO <= S2;
            ELSE
                SIG_ESTADO <= S1;
            END IF;
        END CASE;
    END PROCESS; -- COMB
END ARCHITECTURE; -- ARCH
