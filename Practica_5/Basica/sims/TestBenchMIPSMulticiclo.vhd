LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestBenchMIPSMulticiclo IS
END TestBenchMIPSMulticiclo;
 
ARCHITECTURE behavior OF TestBenchMIPSMulticiclo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
     
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
   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal R3			: std_logic_vector(31 downto 0);
	signal 	PCout		: std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
  
uut: MIPs_multiciclo PORT MAP ( 
		  clk => clk,
          rst => rst,
		modo=>'0', 
		siguiente => '0',
		R3	=> R3,
		PCout=> PCout);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 200 ns.
       
		rst <= '1';
      wait for 200 ns;	

		rst <= '0';
        
      wait for 100*clk_period;
     
      -- insert stimulus here 

      wait;
   end process;

END;
