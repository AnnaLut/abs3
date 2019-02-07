begin 
  execute immediate 
    ' insert into tips(tip, name) values (''SR'',''Переоцінка за рах. резерву'')';
exception when dup_val_on_index then 
  null;
end;
/

begin
    execute immediate 'insert into tips (TIP, NAME, ORD)
values (''SBD'', ''Рахунок 2560 для виплати субсидій'', 10000)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;	