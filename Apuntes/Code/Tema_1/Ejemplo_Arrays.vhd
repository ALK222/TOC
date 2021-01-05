TYPE my_array IS ARRAY (3 DOWNTO 0) OF STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL A : my_array;
SIGNAL B : STD_LOGIC_VECTOR(7 DOWNTO 0);

-- Asignaciones a "A", dentro de la arquitectura

A(1) <= B(3 DOWNTO 0);
A(2) <= B(7 DOWNTO 4);

-- Tambien se pueden declarar constantes
CONSTANT M : INTEGER := 32;
SIGNAL A : STD_LOGIC_VECTOR(M - 1 DOWNTO 0);
