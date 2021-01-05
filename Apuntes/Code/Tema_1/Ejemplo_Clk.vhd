clk_process : PROCESS ()
BEGIN
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
END PROCESS; -- clk_process
