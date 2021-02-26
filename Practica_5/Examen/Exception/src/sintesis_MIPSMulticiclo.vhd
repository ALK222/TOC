library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity sintesis_MIPSMulticiclo is
	port( 
		clk		          : in  std_logic;
		rst   		      : in  std_logic;
		display	          : out std_logic_vector(6 downto 0);
		display_enable    : out std_logic_vector(3 downto 0);
		modo		      : in 	std_logic;
		siguiente         : in 	std_logic
	);
end sintesis_MIPSMulticiclo;

architecture sintesis_MIPSMulticicloArch of sintesis_MIPSMulticiclo is

	component MIPs_multiciclo 
	port( 
		clk		          : in  std_logic;
		rst   		      : in  std_logic;
		modo		      : in 	std_logic;
		siguiente         : in 	std_logic;
		R3			: out std_logic_vector(31 downto 0);
		PCout		: out std_logic_vector(31 downto 0)
	);
end component;
	
	component DCM_100MHz_10MHz
		port ( CLK_IN1  : in    std_logic; 
			   CLK_OUT1 : out   std_logic);
	end component;
  
    component displays
        Port ( 
            rst : in STD_LOGIC;
            clk : in STD_LOGIC;       
            digito_0 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_1 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_2 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_3 : in  STD_LOGIC_VECTOR (3 downto 0);
            display : out  STD_LOGIC_VECTOR (6 downto 0);
            display_enable : out  STD_LOGIC_VECTOR (3 downto 0)
         );
    end component;

	component debouncer
	  GENERIC(
		 FREQ   : natural := 10000;  	-- frecuencia de operacion en KHz
		 BOUNCE : natural := 100  		-- tiempo de rebote en ms
	  );
	  PORT (
		 rst: IN std_logic;
		 clk: IN std_logic;
		 x: IN std_logic;
		 xDeb: OUT std_logic;
		 xDebFallingEdge: OUT std_logic;
		 xDebRisingEdge: OUT std_logic
	  );
	END component;
  
    signal clk_10MHz : std_logic;
	signal R3 : std_logic_vector(31 downto 0);
	signal PC : std_logic_vector(31 downto 0);
	signal siguienteDebouncer : std_logic;

begin

	reloj : DCM_100MHz_10MHz port map (CLK_IN1 => clk, CLK_OUT1=> clk_10MHz);

	eliminadorRebotesModo : debouncer port map(rst => rst, clk => clk_10MHz, x => siguiente, xDeb => open, xDebFallingEdge => open, xDebRisingEdge => siguienteDebouncer);
	
	MIPs: MIPS_multiciclo  port map(clk =>  clk_10MHz, rst => rst, modo => modo, siguiente => siguienteDebouncer, R3 => R3, PCout => PC);
		
	
	displays_i : displays port map(rst => rst, clk => clk, digito_0 => R3(3 downto 0), digito_1 => R3(7 downto 4), digito_2 => "0000", digito_3 => PC(5 downto 2), display => display, display_enable => display_enable);
	

end sintesis_MIPSMulticicloArch;