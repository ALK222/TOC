LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ruta_de_datos IS
	PORT (
		clk_1hleds : IN STD_LOGIC;
		clk_a : IN STD_LOGIC;
		clk_b : IN STD_LOGIC;
		ctrl : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		display_out_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		display_out_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ctrl_data : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ruta_de_datos;
ARCHITECTURE Behavioral OF ruta_de_datos IS

	COMPONENT cont_mod10
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			enable : IN STD_LOGIC;
			leds : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	END COMPONENT;

	COMPONENT waiting_leds
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT win_leds
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT lose_leds
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT esp_leds
		PORT (
			rst : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			leds : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
	END COMPONENT;

	SIGNAL lose, waiting, win, espera : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ctrl_aux : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL error_s : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1101";
	SIGNAL out_cont_a, out_cont_b, out_cont_n : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

	ALIAS cont_rst : STD_LOGIC IS ctrl(0);
	ALIAS cont_enable : STD_LOGIC IS ctrl(1);
	ALIAS seq_rst : STD_LOGIC IS ctrl(2);
	ALIAS seq_enable : STD_LOGIC IS ctrl(3);
	ALIAS mux_leds_A : STD_LOGIC IS ctrl(4);
	ALIAS mux_leds_B : STD_LOGIC IS ctrl(5);
	ALIAS rst_attract : STD_LOGIC IS ctrl(6);
	ALIAS esp_en : STD_LOGIC IS ctrl(7);
BEGIN

	ctrl_data <= ctrl_aux;
	display_out_a <= out_cont_a;
	display_out_b <= out_cont_b;

	cont_a : cont_mod10
	PORT MAP(
		rst => cont_rst,
		clk => clk_a,
		enable => cont_enable,
		leds => out_cont_a);

	cont_b : cont_mod10
	PORT MAP(
		rst => cont_rst,
		clk => clk_b,
		enable => esp_en,
		leds => out_cont_b);

	cont_n : cont_mod10
	PORT MAP(
		rst => seq_rst,
		clk => clk_1hleds,
		enable => seq_enable,
		leds => out_cont_n);

	cont_n_proc : PROCESS (out_cont_n)
	BEGIN
		IF out_cont_n = "1001" THEN
			ctrl_aux(0) <= '1';
		ELSE
			ctrl_aux(0) <= '0';
		END IF;
	END PROCESS; -- cont_n_proc

	cont_a_b : PROCESS (out_cont_a, out_cont_b)
	BEGIN
		IF out_cont_a = out_cont_b THEN
			ctrl_aux(1) <= '1';
		ELSE
			ctrl_aux(1) <= '0';
		END IF;
	END PROCESS; -- cont_a_b

	wt : waiting_leds
	PORT MAP(
		rst => rst_attract,
		clk => clk_1hleds,
		leds => waiting
	);

	wi : win_leds
	PORT MAP(
		rst => seq_rst,
		clk => clk_1hleds,
		leds => win);

	ls : lose_leds
	PORT MAP(
		rst => seq_rst,
		clk => clk_1hleds,
		leds => lose);
	esp : esp_leds
	PORT MAP(
		rst => seq_rst,
		clk => clk_1hleds,
		leds => espera);

	sqe_leds : PROCESS (win, lose, waiting, espera, ctrl, mux_leds_A, mux_leds_B, clk_a, clk_b, esp_en)
	BEGIN

		IF mux_leds_B = '0' AND mux_leds_A = '0' AND esp_en = '1' THEN -- Se apagan cuando se juega
			leds <= (OTHERS => '0');
		ELSIF mux_leds_B = '0' AND mux_leds_A = '0' AND esp_en = '0' THEN
			leds <= espera;
		ELSIF mux_leds_B = '1' AND mux_leds_A = '1' THEN -- Si ganas activas la secuencia de ganar
			leds <= win;
		ELSIF mux_leds_B = '1' AND mux_leds_A = '0' THEN -- Si pierdes activas la secuencia de perder
			leds <= lose;
		ELSE -- Si no atraes clientes
			leds <= waiting;
		END IF;
	END PROCESS; -- seq_leds

END Behavioral; -- Behavioral
