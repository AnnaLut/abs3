begin
    execute immediate 'alter table SB_P0853 drop constraint CC_SB_P0853';
exception
    when others then
        if sqlcode = -2443 then
            null;
        else
            raise;
        end if;
end;
/
