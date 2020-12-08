LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY waiting_leds IS
    PORT (
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END waiting_leds;

ARCHITECTURE behavioral OF waiting_leds IS


signal tmp : std_logic_vector(15 downto 0);
 
 	begin

 		process(clk,rst,tmp)
 		begin
 		if rst = '1' then
 		 tmp <= (others => '0');
 		 else
  			if rising_edge(clk) then 
   				if tmp(15) = '1' then
					tmp(15 downto 1) <= tmp(14 downto 0);
					tmp(0) <= '0';
   				else
					tmp(15 downto 1) <= tmp(14 downto 0);
					tmp(0) <= '1';
   				end if;
 		 	end if;
 		 end if;
 	end process;
 
  	leds <= tmp;

END ARCHITECTURE behavioral;
