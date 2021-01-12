ENTITY celda IS
	PORT (
		x, c_in : IN STD_LOGIC;
		c_out, z : OUT STD_LOGIC);
END celda;

ARCHITECTURE arch OF celda IS
BEGIN
	c_out <= c_in OR x;
	z <= x AND (NOT(c_in));
END arch; -- arch
