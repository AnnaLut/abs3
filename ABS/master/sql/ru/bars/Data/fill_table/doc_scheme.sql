SET DEFINE OFF;

exec bc.home;

begin
  insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
  values ('WB_CREATE_DEPOSIT', 'ЗАЯВКА ПРО ВІДКРИТТЯ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 0, null, null,null, null, null, 1, 'WB_CREATE_DEPOSIT.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='ЗАЯВКА ПРО ВІДКРИТТЯ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', FILE_NAME='WB_CREATE_DEPOSIT.frx' where id ='WB_CREATE_DEPOSIT';
end;
/

begin
  insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
  values ('WB_DENY_AUTOLONGATION', 'ЗАЯВКА ПРО ВІДМОВУ ВІД АВТОМАТИЧНОЇ ПРОГОЛОНГАЦІЇ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 0, null, null,null, null, null, 1, 'WB_DENY_AUTOLONGATION.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='ЗАЯВКА ПРО ВІДМОВУ ВІД АВТОМАТИЧНОЇ ПРОГОЛОНГАЦІЇ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', FILE_NAME='WB_DENY_AUTOLONGATION.frx' where id ='WB_DENY_AUTOLONGATION';
end; 
/

begin
  insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
  values ('WB_CHANGE_ACCOUNT', 'ЗАЯВКА ПРО ЗМІНУ РАХУНКУ ВИПЛАТИ ТІЛА ТА ВІДСОТКІВ ПО ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 0, null, null,null, null, null, 1, 'WB_CHANGE_ACCOUNT.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='ЗАЯВКА ПРО ЗМІНУ РАХУНКУ ВИПЛАТИ ТІЛА ТА ВІДСОТКІВ ПО ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', FILE_NAME='WB_CHANGE_ACCOUNT.frx' where id ='WB_CHANGE_ACCOUNT';
end;
/

commit;

begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_NLS_P', 'ММСБ Заява на відкр. рах. ФОП', 0, 0 );
exception
  when dup_val_on_index then
    update DOC_SCHEME
       set NAME = 'ММСБ Заява на відкр. рах. ФОП'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_NLS_P';
end;
/

begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_NLS_L', 'ММСБ Заява на відкр. рах. ЮО', 0, 0 );
exception
  when dup_val_on_index then 
    update DOC_SCHEME
       set NAME = 'ММСБ Заява на відкр. рах. ЮО'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_NLS_L';
end;
/
--ACC_TP_STATEMENT_SPD
begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_TP_STATEMENT_SPD', 'ММСБ Заява на відкр. рах. ЮОЗаява про підключення Тарифного пакету ФОП', 0, 0 );
exception
  when dup_val_on_index then 
    update DOC_SCHEME
       set NAME = 'Заява про підключення Тарифного пакету ФОП'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_TP_STATEMENT_SPD';
end;
/
--ACC_TP_STATEMENT_UO
begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_TP_STATEMENT_UO', 'Заява про підключення Тарифного пакету ЮО', 0, 0 );
exception
  when dup_val_on_index then 
    update DOC_SCHEME
       set NAME = 'Заява про підключення Тарифного пакету ЮО'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_TP_STATEMENT_UO';
end;
/
--ACC_TP_STATEMENT_SPD_CONF
begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_TP_STATEMENT_SPD_CONF', 'Заява про підтвердження Тарифного пакету (ФОП)', 0, 0 );
exception
  when dup_val_on_index then 
    update DOC_SCHEME
       set NAME = 'Заява про підтвердження Тарифного пакету (ФОП)'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_TP_STATEMENT_SPD_CONF';
end;
/

--ACC_TP_STATEMENT_UO_CONF
begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_TP_STATEMENT_UO_CONF', 'Заява про підтвердження Тарифного пакету (ЮО)', 0, 0 );
exception
  when dup_val_on_index then 
    update DOC_SCHEME
       set NAME = 'Заява про підтвердження Тарифного пакету (ЮО)'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_TP_STATEMENT_UO_CONF';
end;
/

COMMIT;