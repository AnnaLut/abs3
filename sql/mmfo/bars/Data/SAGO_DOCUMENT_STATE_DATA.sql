begin
    execute immediate 'insert into bars.sago_document_state (ID, NAME)
                       values (9999, ''Створено документ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.sago_document_state (ID, NAME)
                       values (2, ''Створено платіж'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.sago_document_state (ID, NAME)
                       values (12, ''Помилка обробки'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
