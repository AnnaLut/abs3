prompt Loading COMPEN_OPER_TYPES...
begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (1, ''PAY_DEP'', ''Виплата компенсаційного вкладу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (2, ''PAY_BUR'', ''Виплата компенсаційного вкладу на поховання'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (8, ''ACT_HER'', ''Оформлення спадщини'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (7, ''DEACT'', ''Відміна актуалізації вкладу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (3, ''WDI'', ''Поповнення вкладу з іншого вкладу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (4, ''WDO'', ''Списання з вкладу на інший вклад'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (5, ''ACT_DEP'', ''Актуалізація вкладу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (6, ''ACT_BUR'', ''Актуалізація вкладу на поховання'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (11, ''CHANGE_D'', ''Зміна документу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (12, ''CHANGE_DA'', ''Зміна документу(автоматично по dbcode)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (13, ''CHANGE_DB'', ''Зміна документу(автоматично по rnk)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (21, ''REBRANCH'', ''Ребранчінг'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

update COMPEN_OPER_TYPES t set t.oper_code = 'DEACT_DEP' where t.type_id = 7;
update COMPEN_OPER_TYPES t set t.oper_code = 'DEACT_BUR', t.text = 'Відміна актуалізації вкладу на поховання' where t.type_id = 8;

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (17, ''ACT_HER'', ''Актуалізація вкладу по спадщині'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (31, ''BEN_ADD'', ''Додавання беніфіціара'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (32, ''BEN_MOD'', ''Модифікація беніфіціара'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (33, ''BEN_DEL'', ''Видалення беніфіціара'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (9, ''REQ_DEACT_DEP'', ''Запит на відміну актуалізації'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (10, ''REQ_DEACT_BUR'', ''Запит на відміну актуалізації на поховання'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 



commit;
