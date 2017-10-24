prompt Loading COMPEN_PORTFOLIO_STATUS...
begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (0, ''Мігрований'', ''Мігрований вклад. Робота з ним заборонена'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (1, ''Відкритий'', ''Мігрований(фіксований) або новий відкритий в системі'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (-1, ''Мігрований невідомий'', ''Любий невідомий статус при міграції. Старий статус в таблиці compen_portfolio_status_old'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (3, ''Закритий'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (91, ''Блокований П'', ''Блокований у зв''''язку з представленим свідоцтвом на поховання'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (99, ''Блокований'', ''Найвищий рівень блокування'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PORTFOLIO_STATUS (status_id, status_name, description)
values (92, ''Блокований С'', ''Блокований у зв''''язку з оформленням спадщини'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


UPDATE COMPEN_PORTFOLIO_STATUS T SET STATUS_NAME = 'Блокований Поховання'
  WHERE STATUS_ID = 91;
UPDATE COMPEN_PORTFOLIO_STATUS T SET STATUS_NAME = 'Блокований Спадщина'
  WHERE STATUS_ID = 92;
commit;
