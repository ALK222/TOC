LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY cerrojo IS
	PORT (
		rst : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		boton : IN STD_LOGIC;
		clave : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		bloqueado : OUT STD_LOGIC;
		intentos : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
END cerrojo;

ARCHITECTURE arch OF cerrojo IS

	TYPE estados IS (ini_st, tres_st, dos_st, uno_st, fin_st);
	SIGNAL current_st, next_st : estados;
	SIGNAL s_key : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_tries : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL s_boton_deb : STD_LOGIC;
	SIGNAL s_clk : STD_LOGIC;

BEGIN
	s_clk <= clk;
	p_reg : PROCESS (s_clk, rst)
	BEGIN
		IF (rst = '1') THEN
			s_key <= "00000000";
			current_st <= ini_st;
		ELSE
			IF (rising_edge(s_clk)) THEN
				current_st <= next_st;
				IF s_boton_deb = '1' AND current_st = ini_st THEN
					s_key <= clave;
				END IF;
			END IF;
		END IF;
	END PROCESS; -- p_reg
	p_next_state : PROCESS (current_st, boton, clave, s_key)
	BEGIN
		CASE(current_st) IS

			-- Inital case
			WHEN ini_st =>
			intentos <= "0100";
			bloqueado <= '1';
			IF (boton = '1') THEN
				next_st <= tres_st;
			ELSE
				next_st <= current_st;
			END IF;
			-- Three state
			WHEN tres_st =>
			intentos <= "0011";
			IF (boton = '1' AND s_key = clave) THEN
				next_st <= ini_st;
			ELSE
				IF (boton = '1') THEN
					next_st <= dos_st;
				ELSE
					next_st <= current_st;
				END IF;
			END IF;
			-- Two state
			WHEN dos_st =>
			intentos <= "0010";
			IF (boton = '1' AND s_key = clave) THEN
				next_st <= ini_st;
			ELSE
				IF (boton = '1') THEN
					next_st <= uno_st;
				ELSE
					next_st <= current_st;
				END IF;
			END IF;
			-- One state
			WHEN uno_st =>
			intentos <= "0001";
			IF (boton = '1' AND s_key = clave) THEN
				next_st <= ini_st;
			ELSE
				IF (boton = '1') THEN
					next_st <= fin_st;
				ELSE
					next_st <= current_st;
				END IF;
			END IF;
			-- Final state
			WHEN fin_st =>
			IF (s_key = "11111111") THEN
				next_st <= ini_st;
			ELSE
				next_st <= current_st;
				intentos <= "0000";
				bloqueado <= '1';
			END IF;
			WHEN OTHERS =>
			intentos <= "0000";
			next_st <= ini_st;
		END CASE;
	END PROCESS; -- p_next_state
END arch; -- arch
