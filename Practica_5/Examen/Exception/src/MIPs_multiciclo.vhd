----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2020 09:34:31
-- Design Name: 
-- Module Name: MIPs_multiciclo_core - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_multiciclo is
	port( 
		clk		          : in  std_logic;
		rst   		      : in  std_logic;
		modo		      : in 	std_logic;
		siguiente         : in 	std_logic;
		R3			: out std_logic_vector(31 downto 0);
		PCout		: out std_logic_vector(31 downto 0)
	);
end MIPS_multiciclo;

architecture MIPSMulticicloArch of MIPS_multiciclo is

	component unidadDeControl is
		port( 
			clk		    : in  std_logic;
			rst 		: in  std_logic;
			control	    : out std_logic_vector(15 downto 0);
			Zero		: in  std_logic;
			op			: in  std_logic_vector(5 downto 0);
			modo		: in  std_logic;
			siguiente   : in  std_logic
		);
	end component;

	component rutaDeDatos is
		port( 
			clk		    : in  std_logic;
			rst 		: in  std_logic;
			control	    : in  std_logic_vector(15 downto 0);
			Zero		: out std_logic;
			op			: out std_logic_vector(5 downto 0);
			R3			: out std_logic_vector(31 downto 0);
			PCout		: out std_logic_vector(31 downto 0)
		);
	end component;
	signal control : std_logic_vector(15 downto 0);
	signal Zero	: std_logic;
	signal op : std_logic_vector(5 downto 0);
	
begin
    UC : unidadDeControl port map(clk => clk, rst => rst, control => control, Zero => Zero, op => op, modo => modo, siguiente => siguiente);
		
	RD: rutaDeDatos port map(clk => clk, rst => rst, control => control, Zero => Zero, op => op, R3 => R3, PCout => PCout);

end MIPSMulticicloArch;
