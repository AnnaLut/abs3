-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- Групи вивантаження файлів даних для DWH
-- ======================================================================================


--
-- UPL - ETL-18652 выгрузить справочник KL_S250 с созданием соответствующей ссылки на nbu23rez
-- UPL - ETL-18654 выгрузить справочник GRP_PORTFEL с созданием соответствующей ссылки на nbu23rez
--
delete from BARSUPL.UPL_FILEGROUPS_RLN 
    where file_id in ( 158, 113, 139 );

--
-- 139 (accpardeb) ETL-18831 UPL -загружать в MIR новые дополнительные параметры счетов (хозяйственная дебиторская задолженность)  
--
prompt  Обновление запроса 139 accpardeb

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 139, 139);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 139, 139);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 139, 139);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 139, 139);

 -- 158 (arracc2) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
 -- добавлено закрытие связок при переносе ФДЗ в архив
 -- объеденены запросы РУ и ЦА
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 158);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 1158);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 158);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 1158);

 -- 113 (RECEIVABLES) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
 -- добавлено закрытие договоров при переносе ФДЗ в архив
 -- для РУ закрытие ФДЗ не установлено - 
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 113, 113);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 113, 1113);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 113, 113);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 113, 1113);
/*
-- для ММФО и РУ разные связи
begin
  --mmfo as ( select case when barsupl.bars_upload_utl.is_mmfo > 1 then 1 else 0 end mmfo  from dual ),
  if barsupl.bars_upload_utl.is_mmfo > 1 then
     -- ************* MMFO *************

     -- 158 (arracc2) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
     -- добавлено закрытие связок при переносе ФДЗ в архив
     -- объеденены запросы РУ и ЦА
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 1158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 1158);

     -- 113 (RECEIVABLES) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
     -- добавлено закрытие договоров при переносе ФДЗ в архив
     -- для РУ закрытие ФДЗ не установлено - 
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 113, 113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 113, 1113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 113, 1113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 113, 1113);
  else
     -- ************* RU *************

     -- 158 (arracc2) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
     -- добавлено закрытие связок при переносе ФДЗ в архив
     -- объеденены запросы РУ и ЦА
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 3158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 3158);

     -- 113 (RECEIVABLES) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
     -- добавлено закрытие договоров при переносе ФДЗ в архив
     -- для РУ закрытие ФДЗ не установлено - 
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 113, 2113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 113, 3113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 113, 2113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 113, 3113);

  end if;
end;
/
*/

--
-- група 99 на тестове вивантаження
--
begin
    -- 99-а група - ETL-17786 - створено вивантаження для звіряння коригуючих проводок 
    --      за період 01/11/2016 - 08/02/2017, запити 99104, 99196

--1. Тег NDBO файла cusvals.
--2. arracc2 - закрытия связок фин.дебиторки
--3. recivebles - закрытие договоров фин. дебиторки.
--4. dpt_agrements - закрытие анулированных доп. соглашений по депоитам.
--5. customer + person для исправления пустых данных о клиентах.
--6. Выгрузить все договора овердрафтов (credits с типом 10) + arracc1

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = 99;
  if barsupl.bars_upload_utl.is_mmfo > 1 then
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 5116);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 201, 99201);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 159, 99159);
  else
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 2116);
  end if;
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 224, 224 );
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 121, 121 );
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 123, 123 );
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 113, 113);
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 158, 158 );
end;
/

COMMIT;

