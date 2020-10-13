--=============================
-- Alejandro Barrachina Argudo
-- Práctica 1: parte básica
-- Sumador
--=============================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY sum IS
    PORT (
        A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        C : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END sum;

ARCHITECTURE Behavioral OF sum IS
BEGIN
    C <= A + B;
END Behavioral; -- Behavioral
