ENTITY priority_encoder IS
    PORT (
        sel : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        code : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END priority_encoder;

ARCHITECTURE rtl OF priority_encoder IS
BEGIN
    code <= "111" WHEN sel(7) = '1' ELSE
        "110" WHEN sel(6) = '1' ELSE
        "101" WHEN sel(5) = '1' ELSE
        "100" WHEN sel(4) = '1' ELSE
        "011" WHEN sel(3) = '1' ELSE
        "010" WHEN sel(2) = '1' ELSE
        "001" WHEN sel(1) = '1' ELSE
        "000" WHEN sel(0) = '1' ELSE
        "---"; -- --- es el simbolo de don't care en VHDL
    END rtl; -- rtl
