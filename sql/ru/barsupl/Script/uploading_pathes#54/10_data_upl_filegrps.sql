-- ======================================================================================
-- Module : UPL
-- Date   : 20.07.2017
-- ======================================================================================
-- Групи вивантаження файлів даних для DWH
-- ======================================================================================

delete from BARSUPL.UPL_FILEGROUPS_RLN
    where file_id in ( 158, 171, 172, 356, 547, 7171, 566 );

--- ETL-19131 - ANL - выгрузку договоров по хозяйственной дебиторской задолженности
--- XOZ_REF(171) Картотека дебиторов (предназ по задумке для хоз.деб)
--- новый файл
prompt 171 договора ХДЗ XOZ_REF
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 171,  171);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 171,  171);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 171,  171);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 171,  171);
prompt 7171 договора ХДЗ XOZ_REF0
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (7, 7171, 7171);
prompt 566 выгрузка А7
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (18, 566, 566);

--- ETL-19131 - ANL - выгрузку договоров по хозяйственной дебиторской задолженности
--- XOZ_PRG(172) Довідник проектів
--- новый файл
prompt 172 справочник XOZ_PRG
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (5, 172, 172);

--- ETL-19474 - UPL - добавить в выгрузку для T0 корректирующих проводок по договорам хоз.дебеторки отдельным файлом (по аналогии с MIR.SRC_PRFTADJTXN0)
--- новый файл
prompt 547 корректировки по счетам XOZ
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (7, 547, 547);

---- ETL-19167
---- UPL - ограничить выгрузку данных в файле inspaymentssc - FACT_DATE должна быть в интервале от предыдущей банковской даты (не включая) и датой выгрузки включительно
prompt 356 inspaymentssc
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 356,  356);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 356,  1356);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 356,  356);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 356,  1356);


-- для ММФО и РУ разные связи
begin
  if barsupl.bars_upload_utl.is_mmfo > 1 then
     -- ************* MMFO *************
     -- 158 (arracc2) ETL-XXX UPL - испарвление выгрузки ЦА (по ЦБ вернуть выгрузку полей ACCR3, ACCUNREC из ММФО)
     -- отдельные запроссы для ЦА
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 3158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 3158);
  else
     -- ************* RU *************
     -- 158 (arracc2) ETL-XXX UPL - испарвление выгрузки ЦА (по ЦБ вернуть выгрузку полей ACCR3, ACCUNREC из ММФО)
     -- отдельные запроссы для ЦА
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 1158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 1158);
  end if;
end;
/


--
-- група 99 на тестове вивантаження
--  UPL - initial upload - 99 группа
begin
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = 99;
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 221, 221 ); --deposit
--  if barsupl.bars_upload_utl.is_mmfo > 1 then
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 5116);
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 201, 99201);
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 159, 99159);
--  else
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 2116);
--  end if;
end;
/

COMMIT;

