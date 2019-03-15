-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 541
--define ssql_id  = 541

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 541');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (541))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 541');
end;
/
-- ***************************************************************************
-- TSK-0001285  UPL - отключить выгрузку из АБС файлов субдоговоров кредитных линий и файлов предварительного расчета FNV
-- PRVN_AUTOMATIC_EVENT (lossevent)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (541);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (541);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (541, 541, 'PRVN_AUTOMATIC_EVENT', 'lossevent', 0, '09', NULL, '10', 0, 'Події дефолту', 541, 'null', 'WHOLE', 'EVENT', 0, NULL, 1, 'lossevent', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (541);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (541);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (541);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (541);

--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 541, 541);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 541, 541);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 541, 541);
--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 541, 541);

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
