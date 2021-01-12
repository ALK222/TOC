ENTITY red IS
	GENERIC (n : NATURAL := 4);
	PORT (
		x : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		z : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END red;

ARCHITECTURE arch OF red IS

	SIGNAL c : STD_LOGIC_VECTOR(n DOWNTO 0);
	COMPONENT celda
		PORT (
			x, c_in : IN STD_LOGIC;
			c_out, z : OUT STD_LOGIC);
	END COMPONENT;

BEGIN
	gen1 : FOR i IN 0 TO M GENERATE
		u : celda PORT MAP(X(i), C(i), C(i + 1), Z(i));
	END GENERATE gen1;
	C(n) <= '0'; -- Condicion de entorno
END arch; -- arch
