prompt Скрипт по добавлению поля KF в customer_extern
prompt add KF column
begin
    execute immediate 'alter table bars.customer_extern add kf varchar2(6)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

prompt update existing data
update customer_extern
set kf = bars_sqnc.get_kf(p_ru => substr(id, length(id)-1));

prompt make column not null
begin
    execute immediate 'alter table bars.customer_extern modify kf not null';
exception
    when others then
        if sqlcode = -1442 then null; else raise; end if;
end;
/

prompt set default value
alter table bars.customer_extern modify kf default sys_context('bars_context', 'user_mfo');