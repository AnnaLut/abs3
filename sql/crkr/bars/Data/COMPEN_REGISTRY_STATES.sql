prompt Loading COMPEN_REGISTRY_STATES...
begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (0, ''Плановий'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (1, ''Відправлено в ГРЦ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (2, ''Відправлено в ГРЦ, отримано помилку'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (3, ''Оплата підтверджена'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (4, ''Відмінено'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_REGISTRY_STATES T (STATE_ID, STATE_NAME)
  VALUES (5, ''Формування платежу блоковано'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_REGISTRY_STATES T (STATE_ID, STATE_NAME)
  VALUES (6, ''Помилка при формуванні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_REGISTRY_STATES T (STATE_ID, STATE_NAME)
  VALUES (9, ''Ініційовано відправку в ГРЦ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;
