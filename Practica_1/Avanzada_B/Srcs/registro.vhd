library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro is
  Port (
    rst1  : IN  std_logic;
    clk1  : IN  std_logic;
    load : IN  std_logic;
    E    : IN  std_logic_vector(3 downto 0);
    S    : OUT std_logic_vector(3 downto 0)   
  );
end registro;

architecture Behavioral of registro is

begin

  process(clk1)
  begin
    if (rst1 = '1') then
            S <= "0000";
        elsif (rising_edge(clk1)) then
            if(load = '1') then
                S <= E;
        end if;
    end if;
  end process;

end Behavioral;
