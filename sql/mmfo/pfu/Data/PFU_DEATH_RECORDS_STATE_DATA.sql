begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''NEW'', ''Нова'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''CHECKED'', ''Перевірена'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_OKPO'', ''Помилка в ІНН'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''PROCESSED'', ''Опрацюваний(у випадку нульової суми)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''DEBET_PAYM_CREATED'', ''Створено платіж на підняття коштів з рахунку клієнта в РУ на транзитний рахунок у ГОУ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''IN_PAY'', ''Готовий до оплати'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC'', ''Рахунок не знайдено'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC_CLOSE'', ''Рахунок закритий'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC_PENS'', ''Пенсіонера не знайдено (по рахунку)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_ACC_OKPO'', ''Рахунок не відповідає по ОКПО'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''ERR_NAME'', ''Рахунок не відповідає по ПІБ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_DEATH_RECORDS_STATE (ID, NAME)
values (''READY_FOR_PAY'', ''Готовий до оплати'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;