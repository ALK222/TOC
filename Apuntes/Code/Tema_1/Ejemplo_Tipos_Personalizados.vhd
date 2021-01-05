TYPE nuevo_tipo1 IS (v1, v2, v3, v4);
TYPE nuevo_tipo2 IS RANGE 0 TO 17;
SIGNAL A : nuevo_tipo1;
SIGNAL B, C : nuevo_tipo2;

-- Asignaciones a señales, dentro dde la arquitectura

A <= v1; -- Asignacion correcta
B <= 17; -- Asignacion correcta
C <= 18; -- Asignacion incorrecta

-- Los records son como Structs de C++

TYPE my_record IS
field_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
field_2 : STD_LOGIC;
END RECORD;

SIGNAL A, C : my_record;
SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0);

-- Asignaciones a "A", dentro de la arquitectura
A.field_1 <= B;
A.field_2 <= B(2);
C <= A; -- Se pueden hacer asignaciones directas o campo a campo
