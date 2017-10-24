begin
    execute immediate 'insert into cm_operstatus (ID, NAME)
values (99, ''Очікує підтвердження'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into cm_opertype (ID, NAME, CLIENTTYPE)
values (9, ''Заміна основної картки'', 2)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into cm_opertype (ID, NAME, CLIENTTYPE)
values (11, ''Новий МКК'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into cm_opertype (ID, NAME, CLIENTTYPE)
values (12, ''Персоналізація МКК'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/