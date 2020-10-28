library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sintesis_contador is
  Port (
    rst    : IN  std_logic;
    clk    : IN  std_logic;
    cuenta : IN  std_logic;
    salida : OUT std_logic_vector(3 downto 0)
  );
end sintesis_contador;

architecture syn of sintesis_contador is
   
    component contadorMod16 is
    port (
      rst    : IN  std_logic;
      clk    : IN  std_logic;
      cuenta : IN  std_logic;
      salida : OUT std_logic_vector(3 downto 0)
    );
    end component;
    
    signal clk_1Hz : std_logic;

begin
 
    divisor:
    PROCESS(rst, clk)
      variable cuenta : natural range 0 to 49999999;
    BEGIN
      IF (rst='1') THEN
        cuenta := 0;
        clk_1Hz<='0';
      ELSIF(rising_edge(clk)) THEN
        IF (cuenta=49999999) THEN 
          clk_1Hz <= not clk_1Hz;
          cuenta := 0;
        ELSE
          cuenta := cuenta + 1;
       END IF;
     END IF;
   END PROCESS divisor;
  
   contador: contadorMod16 PORT MAP (
         rst => rst,
         clk => clk_1Hz,
		     cuenta => cuenta,
         salida => salida
        );

end syn;
