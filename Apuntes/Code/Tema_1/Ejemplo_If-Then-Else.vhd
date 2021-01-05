ifthenelse : PROCESS (a, b, c)
BEGIN
    IF a = b THEN
        c <= a OR b;
    ELSIF a < b THEN
        c <= b;
    ELSE
        c <= "0000";
    END IF;
END PROCESS; -- ifthenelse
