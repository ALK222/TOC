LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY estados IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		ini : IN STD_LOGIC;
		fin : IN STD_LOGIC;
		ctrl_data : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		ctrl : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END estados;

ARCHITECTURE Behavioral OF estados IS

	ALIAS comp_a_b : STD_LOGIC IS ctrl_data(1);
	ALIAS comp_n_10 : STD_LOGIC IS ctrl_data(0);

	TYPE estados IS (S0, S1, S2, S3, S4);

	SIGNAL current_st, next_st : estados;
	SIGNAL aux_ctrl : STD_LOGIC_VECTOR(6 DOWNTO 0);

	ALIAS cont_rst : STD_LOGIC IS ctrl(0);
	ALIAS cont_enable : STD_LOGIC IS ctrl(1);
	ALIAS seq_rst : STD_LOGIC IS ctrl(2);
	ALIAS seq_enable : STD_LOGIC IS ctrl(3);
	ALIAS mux_leds_a : STD_LOGIC IS ctrl(4);
	ALIAS mux_leds_b : STD_LOGIC IS ctrl(5);
	ALIAS att_rst : STD_LOGIC IS ctrl(6);

BEGIN

	reset : PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			current_st <= S0;
		ELSif rising_edge(clk) then 
			current_st <= next_st;
		END IF;
	END PROCESS; -- reset

	state_change : PROCESS (ini, fin, comp_a_b, comp_n_10, current_st)
	BEGIN
		CASE current_st IS
			WHEN S0 =>
				IF ini = '1' THEN
					next_st <= S1;
				ELSE
					next_st <= S4;
				END IF;
			WHEN S1 =>
				IF fin = '1' THEN
					IF comp_a_b = '1' THEN
						next_st <= S2;
					ELSE
						next_st <= S3;
					END IF;
				ELSE
					next_st <= S1;
				END IF;
			WHEN s2 =>
				IF comp_n_10 = '1' THEN
					next_st <= S0;
				ELSE
					next_st <= S2;
				END IF;
			WHEN S4 =>
			     if ini = '1' then
			         next_st <= S1;
			     else
			         next_st <= S4;
				END IF;
			WHEN OTHERS =>
				IF comp_n_10 = '1' THEN
					next_st <= S0;
				ELSE
					next_st <= S3;
				END IF;
		END CASE;
	END PROCESS; -- state_change

	state_beh : PROCESS (current_st, clk)
	BEGIN
		CASE current_st IS
			WHEN S0 =>
				cont_rst <= '1';
				cont_enable <= '0';
				seq_rst <= '1';
				seq_enable <= '0';
				mux_leds_a <= '1';
				mux_leds_b <= '0';
				att_rst <= '1';
			WHEN S1 =>
				cont_rst <= '0';
				cont_enable <= '1';
				seq_rst <= '1';
				seq_enable <= '0';
				mux_leds_a <= '0';
				mux_leds_b <= '0';
				att_rst <= '0';
			WHEN S2 =>
				cont_rst <= '0';
				cont_enable <= '0';
				seq_rst <= '0';
				seq_enable <= '1';
				mux_leds_a <= '1';
				mux_leds_b <= '1';
				att_rst <= '1';
			WHEN S3 =>
				cont_rst <= '0';
				cont_enable <= '0';
				seq_rst <= '0';
				seq_enable <= '1';
				mux_leds_a <= '0';
				mux_leds_b <= '1';
				att_rst <= '1';
			WHEN S4 =>
			    cont_rst <= '0';
				cont_enable <= '0';
				seq_rst <= '1';
				seq_enable <= '0';
				mux_leds_a <= '1';
				mux_leds_b <= '0';
				att_rst <= '0';
			WHEN OTHERS =>
				ctrl <= (OTHERS => '0');
		END CASE;
	END PROCESS; -- state_beh
END Behavioral; -- Behavioral
