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
    where file_id in ( 134, 385, 386, 546 );

---
--- ETL-18408 UPL - выгрузить файлы по страховым договорам
---
delete from BARSUPL.UPL_FILEGROUPS_RLN 
    where file_id in ( 350, 351, 352, 353, 354, 355, 356 );

-- UPL - ETL-18652 выгрузить справочник KL_S250 с созданием соответствующей ссылки на nbu23rez
insert into barsupl.upl_filegroups_rln(group_id, file_id, sql_id) values(5, 385, 385);

-- UPL - ETL-18654 выгрузить справочник GRP_PORTFEL с созданием соответствующей ссылки на nbu23rez
insert into barsupl.upl_filegroups_rln(group_id, file_id, sql_id) values(5, 386, 386);


prompt FEEADJTXN0
-- FEEADJTXN0 (feeadjtxn0) / 546 ( ETL-18533 UPL - выгрузить корпроводки по дисконтам ежемесячно в Т0 )
-- новый файл
--
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (7, 546, 546);


---
--- ETL-18408 UPL - выгрузить файлы по страховым договорам
---
prompt Страховые договора

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 350, 350);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 350, 350);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 350, 350);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 350, 350);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 351, 351);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 351, 351);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 351, 351);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 351, 351);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (5, 352, 352);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (5, 353, 353);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (5, 354, 354);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 355, 355);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 355, 355);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 355, 355);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 355, 355);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 356, 356);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 356, 356);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 356, 356);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 356, 356);

--- 
--- UPL - ETL-18729 - выгрузить справочник S080_FIN с созданием соответствующей ссылки на nbu23rez
--- 
prompt 134 справочник S080_FIN
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (5, 134, 134);

--
-- група 99 на тестове вивантаження
--
begin
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = 99;
    -- 99-а група - ETL-17786 - створено вивантаження для звіряння коригуючих проводок 
    --      за період 01/11/2016 - 08/02/2017, запити 99104, 99196
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 104, 99104);
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 196, 99196);

    --ETL-18823 UPL - выгрузить инишиал по файлам 565 (FIN_CUST), 559 (FIN_FM), 560 (FIN_RNK)
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 559, 559);
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 560, 560);
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 565, 565);

end;
/

COMMIT;

