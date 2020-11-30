----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2020 09:20:35
-- Design Name: 
-- Module Name: mult8_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY mult8_tb IS
END mult8_tb;

ARCHITECTURE Behavioral OF mult8_tb IS

    -- Component to test
    COMPONENT mult8 IS
        PORT (
            rst : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            ini : IN STD_LOGIC;
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            c : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            fin : out std_logic);
    END COMPONENT;

    -- Input signals
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL ini : STD_LOGIC := '0';
    SIGNAL a : STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL b : STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');

    -- Output Signals

    SIGNAL c : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL fin : STD_LOGIC;
BEGIN

    mul : mult8 PORT MAP(rst => rst, clk => clk, ini => ini, a => a, b => b, c => c, fin => fin);

    clk_proc : PROCESS
    BEGIN
        IF (clk = '1') THEN
            clk <= '0';
        ELSE
            clk <= '1';
        END IF;
        WAIT FOR 30 ns;
    END PROCESS; -- clk_proc

    test : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 100 ns;

        rst <= '0';
        ini <= '1';
        WAIT FOR 50 ns;

        ini <= '0';
        a <= "0000";
        b <= "0000";
        ini <= '1';
        WAIT FOR 2000 ns;
        
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        a <= "0001";
        b <= "0001";
        ini <= '1';

        WAIT FOR 2000 ns;

        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        a <= "0001";
        b <= "0010";
        ini <= '1';
        WAIT FOR 2000 ns;

        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        a <= "0010";
        b <= "1000";
        ini <= '1';
        WAIT FOR 2000 ns;

        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        a <= "1000";
        b <= "0010";
        ini <= '1';
        WAIT FOR 2000 ns;

        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        a <= "1010";
        b <= "0101";
        ini <= '1';
        WAIT FOR 2000 ns;

        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        a <= "1111";
        b <= "1111";
        ini <= '1';
        WAIT FOR 2000 ns;

        WAIT;
    END PROCESS; -- test

END Behavioral;
