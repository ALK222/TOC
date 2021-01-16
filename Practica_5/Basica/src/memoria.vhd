LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY memoria IS
	PORT (
		clk : IN STD_LOGIC;
		ADDR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		MemWrite : IN STD_LOGIC;
		MemRead : IN STD_LOGIC;
		DW : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END memoria;

ARCHITECTURE memoriaArch OF memoria IS

	-- Este componente se ha creado como un IPCore usando un fichero .coe para su inicializaci�n
	--	COMPONENT mem32x512
	--	  PORT (
	--		 clka 	: IN  STD_LOGIC;
	--		 ena 		: IN  STD_LOGIC;
	--		 wea 		: IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
	--		 addra	: IN  STD_LOGIC_VECTOR(8 DOWNTO 0);
	--		 dina		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	--		 douta	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	--	  );
	--	END COMPONENT; 	

	-- Este componente se ha creado en VHDL y la inicializaci�n se indica dentro de la propia memoria
	COMPONENT BlockRam IS
		PORT (
			clka, wea, ena : IN STD_LOGIC;
			addra : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL ena : STD_LOGIC;

BEGIN

	--	mem: mem32x512 PORT MAP(
	--		 clka 	=> clk,
	--		 ena	=> ena,
	--		 wea 	=> wea,
	--		 addra	=> ADDR(10 downto 2), -- Reducimos el tama�o de la memoria a 512 posiciones (datos y direcciones de 4 en 4 bytes)
	--		 dina	=> DW,
	--		 douta	=> DR
	--	  );

	mem : BlockRam PORT MAP(
		clka => clk,
		ena => ena,
		wea => MemWrite,
		addra => ADDR(10 DOWNTO 2), -- Reducimos el tama�o de la memoria a 512 posiciones (datos y direcciones de 4 en 4 bytes)
		dina => DW,
		douta => DR
	);

	ena <= '1' WHEN (MemWrite = '1' OR MemRead = '1') ELSE
		'0';
	wea <= "1" WHEN (MemWrite = '1') ELSE
		"0";
END memoriaArch;
