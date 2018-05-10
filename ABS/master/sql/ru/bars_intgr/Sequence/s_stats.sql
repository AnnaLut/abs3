prompt create sequence s_stats
begin
    execute immediate q'[
create sequence bars_intgr.s_stats
start with 1
increment by 1
nocache
    ]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
