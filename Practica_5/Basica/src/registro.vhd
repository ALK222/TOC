LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY registro IS
	GENERIC (
		n : POSITIVE := 32
	);
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		load : IN STD_LOGIC;
		din : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		dout : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
END registro;

ARCHITECTURE registroArch OF registro IS

BEGIN

	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			dout <= (OTHERS => '0');
		ELSIF rising_edge(clk) THEN
			IF (load = '1') THEN
				dout <= din;
			END IF;
		END IF;
	END PROCESS;

END registroArch;
