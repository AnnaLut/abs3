begin
update transport_unit_type set  TRANSPORT_TYPE_CODE = 'CREATE_PAYM' , TRANSPORT_TYPE_NAME = 'Создание обратного платежа'  where ID =  6;
end;
/

begin
    execute immediate '
insert into transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
values (13, ''CHECKPAYMBACKSTATE'', ''Опитування статусу платежу на повернення коштів'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into transport_unit_type (ID, TRANSPORT_TYPE_CODE, TRANSPORT_TYPE_NAME, DIRECTION)
values (14, ''GET_CLEAR_ACC'', ''Получение счетов без оборотов'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 



commit;