begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN01'', ''Вкладення готівки з ОК УБ до запасів готівки на зберіганні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN02'', ''Перерахування готівки із запасів готівки на зберіганні до ОК УБ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN03'', ''Одержана готівка від НБУ/УБ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN04'', ''Відправлена готівка до НБУ/УБ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BNZ2'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
