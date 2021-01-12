gen1 : FOR i IN 0 TO M GENERATE
	u : celda PORT MAP(X(i), C(i), C(i + 1), Z(i));
END GENERATE gen1;
