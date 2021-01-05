LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alu IS
    PORT (
        data1 : IN STD_LOGIC_VECTOR (7 downto0);
        data2 : IN STD_LOGIC_VECTOR (7 downto0);
        op : IN STD_LOGIC;
        salida : OUT STD_LOGIC_VECTOR (7 downto0));
END alu;

ARCHITECTURE Behavioral OF alu IS
    SIGNAL salida_aux : signed(7 downto0);
BEGIN
    Salida_aux <= signed(data1) + signed(data2) WHEN op = '0' ELSE
        signed(data1) - signed(data2) WHEN op = '1' ELSE
        (OTHERS => '0');
    Salida <= STD_LOGIC_VECTOR(salida_aux);
END Behavioral;
