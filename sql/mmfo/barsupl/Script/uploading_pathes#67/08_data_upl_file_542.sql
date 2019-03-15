-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 542
--define ssql_id  = 542

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 542');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (542))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 542');
end;
/
-- ***************************************************************************
-- TSK-0001285  UPL - отключить выгрузку из АБС файлов субдоговоров кредитных линий и файлов предварительного расчета FNV
-- PRVN_LOSS_DAYS (lossdays)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (542);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (542);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (542, 542, 'PRVN_LOSS_DAYS', 'lossdays', 0, '09', NULL, '10', 0, 'Кількість днів просрочки по договору', 542, 'null', 'WHOLE', 'EVENT', 0, NULL, 1, 'AR', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (542);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (542);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (542);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (542);

--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 542, 542);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 542, 542);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 542, 542);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 542, 542);

/*
begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
    else
         -- ************* RU *************
    end if;
end;
/
*/
