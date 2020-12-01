----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2020 09:12:23
-- Design Name: 
-- Module Name: cintadorMod16 - Behavioral
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY contadorMod16 IS
  PORT (
    rst : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    cuenta : IN STD_LOGIC;
    salida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END contadorMod16;

ARCHITECTURE Behavioral OF contadorMod16 IS
  --COMPONENTS
  COMPONENT sumador
    PORT (
      A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      C : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
  END COMPONENT;
  COMPONENT registro
    PORT (
      rst1 : IN STD_LOGIC;
      clk1 : IN STD_LOGIC;
      load : IN STD_LOGIC;
      E : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
  END COMPONENT;
  --SIGNALS
  SIGNAL carry : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL carry1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
  begin_registro : registro PORT MAP(rst1 => rst, clk1 => clk, load => cuenta, E => carry, S => carry1);
  begin_sumdor : sumador PORT MAP(A => carry1, B => "0011", C => carry);
  salida <= carry1;
END Behavioral;
