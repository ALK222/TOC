LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY rutaDeDatos IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		control : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
		Zero : OUT STD_LOGIC;
		op : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		R3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END rutaDeDatos;

ARCHITECTURE rutaDeDatosArch OF rutaDeDatos IS

	COMPONENT registro
		GENERIC (
			n : POSITIVE := 32
		);
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			load : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			dout : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT multiplexor2a1
		GENERIC (
			bits_entradas : POSITIVE := 32
		);
		PORT (
			entrada0 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada1 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			seleccion : IN STD_LOGIC;
			salida : OUT STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT multiplexor4a1
		GENERIC (
			bits_entradas : POSITIVE := 32
		);
		PORT (
			entrada0 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada1 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada2 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada3 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			seleccion : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			salida : OUT STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT multiplexor8a1 IS
		GENERIC (
			bits_entradas : POSITIVE := 32
		);
		PORT (
			entrada0 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada1 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada2 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada3 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada4 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada5 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada6 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			entrada7 : IN STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0);
			seleccion : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			salida : OUT STD_LOGIC_VECTOR(bits_entradas - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT memoria IS
		PORT (
			clk : IN STD_LOGIC;
			ADDR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			MemWrite : IN STD_LOGIC;
			MemRead : IN STD_LOGIC;
			DW : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			DR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT bancoDeRegistros
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			RA : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			RB : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			RegWrite : IN STD_LOGIC;
			RW : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			busW : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			busA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			busB : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			R3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ALU
		PORT (
			A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ALUop : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			Zero : OUT STD_LOGIC;
			R : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

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
	ALIAS SelPC : STD_LOGIC IS control_aux(18);
	
	SIGNAL salidaALU : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ALUOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ADDR : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL salidaMem : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL IR : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL OPA : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL OPB : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RW : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL busW : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL signo_extendido : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL desplazado : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL salidaBancoRegA : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL salidaBancoRegb : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal toPC : std_logic_vector(31 downto 0);
    signal dir : std_logic_vector(31 downto 0);
BEGIN

dir <= "000000" & IR(25 downto 0);
	PCout <= PC;
	control_aux <= control;
	op <= IR(31 DOWNTO 26);

	reg_PC : registro port map(clk => clk, rst => rst, load => PCWrite, din => toPC, dout => PC);

	mux_IorD : multiplexor2a1 PORT MAP(entrada0 => PC, entrada1 => ALUOut, seleccion => IorD, salida => ADDR);

	mem : memoria PORT MAP(clk => clk, ADDR => ADDR, MemWrite => MemWrite, MemRead => MemRead, DW => B, DR => salidaMem);

	reg_IR : registro PORT MAP(clk => clk, rst => rst, load => IRWrite, din => salidaMem, dout => IR);

	mux_RW : multiplexor2a1 GENERIC MAP(bits_entradas => 5) PORT MAP(entrada0 => IR(20 DOWNTO 16), entrada1 => IR(15 DOWNTO 11), seleccion => RegDst, salida => RW);

	mux_MDR : multiplexor2a1 PORT MAP(entrada0 => ALUout, entrada1 => salidaMem, seleccion => MemtoReg, salida => busW);

    mux_PC : multiplexor2a1 port map(entrada0 => salidaALU, entrada1 => dir, seleccion => SelPC, salida => toPC);
	-- Extension de signo
	signo_extendido(15 DOWNTO 0) <= IR(15 DOWNTO 0);
	signo_extendido(31 DOWNTO 16) <= x"FFFF" WHEN (IR(15) = '1') ELSE
	x"0000";

	-- <<2
	desplazado <= signo_extendido(29 DOWNTO 0) & "00";

	banco_registros : bancoDeRegistros PORT MAP(clk => clk, rst => rst, RA => IR(25 DOWNTO 21), RB => IR(20 DOWNTO 16), RegWrite => RegWrite, RW => RW, busW => busW, busA => salidaBancoRegA, busB => salidaBancoRegB, R3 => R3);

	reg_A : registro PORT MAP(clk => clk, rst => rst, load => AWrite, din => salidaBancoRegA, dout => A);

	reg_B : registro PORT MAP(clk => clk, rst => rst, load => BWrite, din => salidaBancoRegB, dout => B);

	mux_opA : multiplexor4a1 PORT MAP(entrada0 => PC, entrada1 => A, entrada2 => x"00000000", entrada3 => x"00000000", seleccion => ALUScrA, salida => OPA);

	mux_opB : multiplexor8a1 PORT MAP(entrada0 => B, entrada1 => x"00000004", entrada2 => signo_extendido, entrada3 => desplazado, entrada4 => x"00000000", entrada5 => x"00000000", entrada6 => x"00000000", entrada7 => x"00000000", seleccion => ALUScrB, salida => OPB);

	ALU_i : ALU PORT MAP(A => OPA, B => OPB, ALUop => ALUop, funct => IR(5 DOWNTO 0), Zero => Zero, R => salidaALU);

	reg_ALUout : registro PORT MAP(clk => clk, rst => rst, load => OutWrite, din => salidaALU, dout => ALUout);

END rutaDeDatosArch;
