LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY unidadDeControl IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		control : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
		Zero : IN STD_LOGIC;
		op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		modo : IN STD_LOGIC;
		siguiente : IN STD_LOGIC
	);
END unidadDeControl;

ARCHITECTURE unidadDeControlArch OF unidadDeControl IS

	SIGNAL control_aux : STD_LOGIC_VECTOR(18 DOWNTO 0);
	ALIAS PCWrite : STD_LOGIC IS control_aux(0);
	ALIAS IorD : STD_LOGIC IS control_aux(1);
	ALIAS MemWrite : STD_LOGIC IS control_aux(2);
	ALIAS MemRead : STD_LOGIC IS control_aux(3);
	ALIAS IRWrite : STD_LOGIC IS control_aux(4);
	ALIAS RegDst : STD_LOGIC IS control_aux(5);
	ALIAS MemtoReg : STD_LOGIC IS control_aux(6);
	ALIAS RegWrite : STD_LOGIC IS control_aux(7);
	ALIAS AWrite : STD_LOGIC IS control_aux(8);
	ALIAS BWrite : STD_LOGIC IS control_aux(9);
	ALIAS ALUScrA : STD_LOGIC_VECTOR(1 DOWNTO 0) IS control_aux(11 DOWNTO 10);
	ALIAS ALUScrB : STD_LOGIC_VECTOR(2 DOWNTO 0) IS control_aux(14 DOWNTO 12);
	ALIAS OutWrite : STD_LOGIC IS control_aux(15);
	ALIAS ALUop : STD_LOGIC_VECTOR(1 DOWNTO 0) IS control_aux(17 DOWNTO 16);
	ALIAS SelPC : STD_LOGIC is control_aux(18);

	TYPE states IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16);
	SIGNAL currentState, nextState : states;

BEGIN

	control <= control_aux;

	stateGen :
	PROCESS (currentState, op, zero, modo, siguiente)
	BEGIN

		nextState <= currentState;
		control_aux <= (OTHERS => '0');

		CASE currentState IS

			WHEN S0 =>
				IF (modo = '0' OR (modo = '1' AND siguiente = '1')) THEN
					PCWrite <= '1';
					MemRead <= '1';
					ALUScrB <= "001";
					nextState <= S1;
				END IF;

			WHEN S1 =>
				IRWrite <= '1';
				nextState <= S2;
			WHEN S2 =>
				AWrite <= '1';
				BWrite <= '1';
				IF (op = "000000") THEN -- tipo-R
					nextState <= S8;
				ELSIF (op = "100011") THEN -- lw
					nextState <= S3;
				ELSIF (op = "101011") THEN -- sw
					nextState <= S6;
				ELSIF (op = "000100") THEN --beq
					nextState <= S10;
				ELSIF (op = "010000") THEN -- move con inmediato
					nextState <= S12;
				ELSIF (op = "010010") THEN -- move con registro
					nextState <= S14;
				ELSIF (op = "000010") THEN -- jump
                    nextState <= S16;
				END IF;

			WHEN S3 =>
				ALUScrA <= "01";
				ALUScrB <= "010";
				OutWrite <= '1';
				nextState <= S4;

			WHEN S4 =>
				MemRead <= '1';
				IorD <= '1';
				nextState <= S5;

			WHEN S5 =>
				MemtoReg <= '1';
				RegWrite <= '1';
				nextState <= S0;

			WHEN S6 =>
				ALUScrA <= "01";
				ALUScrB <= "010";
				OutWrite <= '1';
				nextState <= S7;

			WHEN S7 =>
				MemWrite <= '1';
				IorD <= '1';
				nextState <= S0;

			WHEN S8 =>
				ALUScrA <= "01";
				ALUOp <= "10";
				OutWrite <= '1';
				nextState <= S9;

			WHEN S9 =>
				RegDst <= '1';
				RegWrite <= '1';
				nextState <= S0;

			WHEN S10 =>
				ALUScrA <= "01";
				ALUOp <= "01";
				IF (Zero = '0') THEN
					nextState <= S0;
				ELSE
					nextState <= S11;
				END IF;

			WHEN S11 =>
				PCWrite <= '1';
				ALUScrB <= "011";
				nextState <= S0;
			WHEN S12 =>
				ALUScrA <= "10";
				ALUScrB <= "010";
				ALUOp <= "00";
				OutWrite <= '1';
				nextState <= S13;

			WHEN S13 =>
				RegWrite <= '1';
				nextState <= S0;

			WHEN S14 =>
				ALUScrA <= "01";
				ALUScrB <= "100";
				ALUOp <= "00";
				OutWrite <= '1';
				nextState <= S15;

			WHEN S15 =>
				RegWrite <= '1';
				nextState <= S0;
				
			WHEN S16 =>
			SelPC <= '1';
			PCWrite <='1';
			nextState <= S0;	
		END CASE;
	END PROCESS stateGen;

	state :
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
			currentState <= S0;
		ELSIF RISING_EDGE(clk) THEN
			currentState <= nextState;
		END IF;
	END PROCESS state;

END unidadDeControlArch;
