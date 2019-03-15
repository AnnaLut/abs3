begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (11, ''Помилка запиту'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (12, ''Помилка підпису'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (13, ''Помилка при створенні документів'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (14, ''Помилки при оплаті'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (1, ''Запит отримано'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (2, ''Підпис перевірено'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (3, ''Документи створено'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (4, ''Оплачено'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
