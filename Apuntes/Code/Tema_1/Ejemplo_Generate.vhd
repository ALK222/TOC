COMPONENT comp
    PORT (
        x : IN BIT;
        y : OUT BIT);
END comp;

SIGNAL a, b : BIT_VECTOR(0 TO 7);

gen : FOR i IN 0 TO 7 GENERATE
    u : comp PORT MAP(a(i), b(i));
END GENERATE; -- gen
