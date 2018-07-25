begin
delete from sw_statuses;
--
Insert into SW_STATUSES(id,value, description) values(-1,'WAITING', 'Ожидает зачисление на клиента с 3720');
insert into sw_statuses(id,value, description) values(0, 'CREATED','Создан МТ199');
insert into sw_statuses(id,value, description) values(1, 'ACSC','Получатель был кредитован');
insert into sw_statuses(id,value, description) values(2, 'RJCT','Транзакция была отклонена');
insert into sw_statuses(id,value, description) values(3, 'ACSP/000','Платеж, Переданный следующему агенту GPI');
insert into sw_statuses(id,value, description) values(4, 'ACSP/001','Платеж, переданный агенту, не относящемуся к GPI');
insert into sw_statuses(id,value, description) values(5, 'ACSP/002','Кредит на счет Получателя не может быть подтвержден в тот же день');
insert into sw_statuses(id,value, description) values(6, 'ACSP/003','Кредит на счет получателя задерживается до получения необходимых документов');
insert into sw_statuses(id,value, description) values(7, 'ACSP/004','Кредит на счет получателя задерживается, ожидаются средства');
end;
/
commit
/

Prompt CREATE INDEX BARS.i_swjournal_uetr ON BARS.SW_JOURNAL;

begin
execute immediate 
'CREATE INDEX BARS.i_swjournal_uetr ON BARS.SW_JOURNAL
(UETR)
LOGGING
TABLESPACE BRSSMLI
STORAGE    (
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )NOPARALLEL';
   exception when others then if sqlcode=-955 then null; else raise; end if;
     
end;
/

