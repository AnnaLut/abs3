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

