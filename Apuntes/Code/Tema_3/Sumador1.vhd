LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY adder IS
    PORT (
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ci : IN STD_LOGIC;
        sum : OUT STD_LOGIC_VECTOR(7 downto0);
        co : OUT STD_LOGIC);
END adder;

ARCHITECTURE rtl OF adder IS
    SIGNAL a_i, b_i, sum_i : STD_LOGIC_VECTOR(8 downto0);
BEGIN
    a_i <= '0' & a;
    b_i <= '0' & b;
    sum_i <= a_i + b_i + ci;
    sum <= sum_i(7 DOWNTO 0);
    co <= sum_i(8);
END rtl;
