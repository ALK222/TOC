ENTITY mux8_1 IS
    PORT (
        sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        datos : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        z : OUT STD_LOGIC);
END mux8_1;

ARCHITECTURE rtl OF mux8_1 IS
BEGIN
    WITH sel SELECT
        z <= datos(0) WHEN "000",
        datos(1) WHEN "001",
        datos(2) WHEN "010",
        datos(3) WHEN "011",
        datos(4) WHEN "100",
        datos(5) WHEN "101",
        datos(6) WHEN "110",
        datos(7) WHEN OTHERS;
    -- z<= data(to_integer(unsigned(sel)))
END rtl; -- rtl
