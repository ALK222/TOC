ENTITY decoder_1 IS
    PORT (
        sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        res : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END decoder_1;

ARCHITECTURE rtl OF decoder_1 IS
BEGIN
    res <= "00000001" WHEN sel = "000" ELSE
        "00000010" WHEN sel = "001" ELSE
        "00000100" WHEN sel = "010" ELSE
        "00001000" WHEN sel = "011" ELSE
        "00010000" WHEN sel = "100" ELSE
        "00100000" WHEN sel = "101" ELSE
        "01000000" WHEN sel = "110" ELSE
        "10000000";
    p_decode : PROCESS (sel)
    BEGIN
        res <= (OTHERS => '0');
        res(to_integer(unsigned(sel))) <= '1';
    END PROCESS; -- p_decode
END rtl;
