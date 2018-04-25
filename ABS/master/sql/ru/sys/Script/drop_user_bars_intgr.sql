prompt Удаляем некорректно созданную схему
begin
    execute immediate 'drop user bars_intgr cascade';
exception
    when others then
        if sqlcode = -1918 then null; else raise; end if;
end;
/