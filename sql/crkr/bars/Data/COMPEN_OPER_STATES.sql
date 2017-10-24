prompt Loading COMPEN_OPER_STATES...
begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (0, ''Нова непідтверджена операція'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (10, ''Очікує підтвердження'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (20, ''Підтверджена операція'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (30, ''Операцію відмінено'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (40, ''Виявлено помилку'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

update COMPEN_OPER_STATES set state_name = 'Виявлено помилку та/або потребує розгляду бєк-офісу' where state_id = 40;


commit;
