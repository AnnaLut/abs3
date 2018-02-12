prompt Удаляем d8_cust_link_groups_update и связанный триггер
prompt Удаляем триггер
begin 
    execute immediate 'drop trigger ti_d8_cust_link_groups';
exception
    when others then
        if sqlcode = -4080 then null; else raise; end if;
end;
/
prompt Удаляем таблицу
begin 
    execute immediate 'drop table d8_cust_link_groups_update';
exception
    when others then
        if sqlcode = -942 then null; else raise; end if;
end;
/