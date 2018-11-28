prompt s_file_archive
begin
    execute immediate 'create sequence s_file_archive
    start with 1
    increment by 1
    nocache';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/