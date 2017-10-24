begin
    execute immediate '
        create sequence s_brm_install_log
        start with 1
        increment by 1
        nocache
        order';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/