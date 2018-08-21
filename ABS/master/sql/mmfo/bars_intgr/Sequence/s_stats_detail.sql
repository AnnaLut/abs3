prompt create sequence s_stats_detail
begin
    execute immediate '
    create sequence s_stats_detail
    start with 1
    increment by 1
    nocache';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/