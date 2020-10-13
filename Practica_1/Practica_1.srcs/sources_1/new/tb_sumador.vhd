--==================================
-- Alejandro Barrachina Argudo
-- Práctica 1: parte básica
-- TestBench del sumador
--==================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

--=========================
-- Entity
--=========================

ENTITY tb_sumador IS
END tb_sumador;

--=========================
-- Architecture
--=========================

ARCHITECTURE behavioural OF tb_sumador IS
    -- Component to simulate
    COMPONENT sum_4bits
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            c : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    -- IN
    SIGNAL a : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL b : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    -- OUT
    SIGNAL c : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

    -- Unit to simulate
    uut : sum_4bits PORT MAP(a => a, b => b, c => c);

    -- Simulation process
    stim_proc : PROCESS 
    BEGIN
        a <= "0000";
        b <= "0000";
        WAIT FOR 100 ns;
        a <= "0101";
        b <= "0100";
        WAIT FOR 100 ns;
        a <= "0000";
        b <= "0111";
        WAIT FOR 100 ns;
        a <= "0011";
        b <= "1000";
        WAIT FOR 100 ns;
        a <= "1011";
        b <= "1111";
        WAIT FOR 100 ns;
        a <= "1001";
        b <= "0110";
        WAIT;
    END PROCESS; -- stim_proc
END behavioural; -- behavioural    
