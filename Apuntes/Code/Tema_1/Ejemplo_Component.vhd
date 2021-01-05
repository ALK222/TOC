ARCHITECTURE arch_name OF entity_name IS
    COMPONENT component_name
        PORT ( < IO_ports_list >);
    END COMPONENT;
    --declaración de señales;
    begincomponent_i : component_name
    PORT MAP( < s1 >, < s2 >, ..., < sn >);
END arch_name;
