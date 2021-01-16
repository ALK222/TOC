LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY multiplexor8a1 IS
    GENERIC (
        bits_entradas : POSITIVE := 32
    );
    PORT (
        entrada0 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        entrada1 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        entrada2 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        entrada3 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        entrada4 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        entrada5 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        entrada6 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        entrada7 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
        seleccion : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        salida : OUT STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0)
    );
END multiplexor8a1;

ARCHITECTURE multiplexer8to1Arch OF multiplexor8a1 IS

BEGIN

    salida <= entrada0 WHEN (seleccion = "000") ELSE
        entrada1 WHEN (seleccion = "001") ELSE
        entrada2 WHEN (seleccion = "010") ELSE
        entrada3 WHEN (seleccion = "011") ELSE
        entrada4 WHEN (seleccion = "100") ELSE
        entrada5 WHEN (seleccion = "101") ELSE
        entrada6 WHEN (seleccion = "110") ELSE
        entrada7;

END multiplexer8to1Arch;
