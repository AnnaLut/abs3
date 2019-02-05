begin 
  execute immediate 
    ' insert into cp_acctypes(type,name) values (''RD'',''Дивіденти'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into cp_acctypes(type,name) values (''S2'',''Рахунок переоцінки по опціону'')';
exception when dup_val_on_index then 
  null;
end;
/
begin 
  execute immediate 
    ' insert into cp_acctypes(type,name) values (''SR'',''Рахунок переоцінки за рах. резерву'')';
exception when dup_val_on_index then 
  null;
end;
/

commit;
