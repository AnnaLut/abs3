begin
  update pfu_filetypes  set NAME = 'Создать платеж', CODE = 'CREATE_PAYM' where ID = 6;
end;
/

begin
    execute immediate 'insert into pfu_filetypes (ID, NAME, CODE)
values (13, ''Проверка статуса платежа на возврат'', ''CHECKPAYMBACKSTATE'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into pfu_filetypes (ID, NAME, CODE)
values (14, ''Получение счетов без оборотов'', ''GET_CLEAR_ACC'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;


begin
    execute immediate 'insert into pfu_filetypes (ID, NAME, CODE)
values (15, ''Блокировка счета по запросу ПЦ'', ''SET_CARD_BLOCK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into pfu_filetypes (ID, NAME, CODE)
values (17, ''Разблокировка счета по запросу ПЦ'', ''SET_CARD_UNBLOCK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;

