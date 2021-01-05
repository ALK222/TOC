LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY sum8 IS PORT (
    data1 : IN STD_LOGIC_VECTOR (7 downto0);
    data2 : IN STD_LOGIC_VECTOR (7 downto0);
    cin : IN STD_LOGIC;
    cout : OUT STD_LOGIC;
    salida : outSTD_LOGIC_VECTOR (7 downto0));
END sum8;

ARCHITECTURE Behavioral OF sum8 IS
    SIGNAL misennal1 : signed (8 downto0);
    SIGNAL tmp : signed(0 downto0);
BEGIN
    tmp(0) <= cin;
    misennal1 <= signed(data1(7) & data1) + signed(data2(7) & data2) + tmp;
    salida <= STD_LOGIC_VECTOR(misennal1(7 downto0));
    cout <= misennal1(8);
END Behavioral;
