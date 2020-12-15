LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY displays IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		digito_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		digito_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		digito_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		digito_3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		display : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		display_enable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
END displays;

ARCHITECTURE Behavioral OF displays IS

	COMPONENT conv_7seg
		PORT (
			x : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			display : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
	END COMPONENT;

	SIGNAL display_0 : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL display_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL display_2 : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL display_3 : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL contador_refresco : STD_LOGIC_VECTOR (19 DOWNTO 0);
BEGIN

	conv_7seg_digito_0 : conv_7seg PORT MAP(x => digito_0, display => display_0);
	conv_7seg_digito_1 : conv_7seg PORT MAP(x => digito_1, display => display_1);
	conv_7seg_digito_2 : conv_7seg PORT MAP(x => digito_2, display => display_2);
	conv_7seg_digito_3 : conv_7seg PORT MAP(x => digito_3, display => display_3);

	display <= display_0 WHEN (contador_refresco(19 DOWNTO 18) = "00") ELSE
		display_1 WHEN (contador_refresco(19 DOWNTO 18) = "01") ELSE
		display_2 WHEN (contador_refresco(19 DOWNTO 18) = "10") ELSE
		display_3;

	PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF (rst = '1') THEN
				contador_refresco <= (OTHERS => '0');
			ELSE
				contador_refresco <= contador_refresco + 1;
			END IF;
		END IF;
	END PROCESS;

	display_enable <= "1110" WHEN (contador_refresco(19 DOWNTO 18) = "00") ELSE
		"1101" WHEN (contador_refresco(19 DOWNTO 18) = "01") ELSE
		"1011" WHEN (contador_refresco(19 DOWNTO 18) = "10") ELSE
		"0111";

END Behavioral;
