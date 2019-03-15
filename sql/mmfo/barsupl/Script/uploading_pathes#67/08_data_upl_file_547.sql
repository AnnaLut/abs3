-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов дл€ файла выгрузки (список через зап€тую, без пробелов)
--define sfile_id = 547
--define ssql_id  = 547

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 547');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (547))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 547');
end;
/
-- ***************************************************************************
-- TSK-0001285  UPL - отключить выгрузку из јЅ— файлов субдоговоров кредитных линий и файлов предварительного расчета FNV
-- PROFIT_ADJ_TXOZ (prfxoz0)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (547);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (547);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (547, 547, 'PROFIT_ADJ_TXOZ', 'prfxoz0', 0, '09', NULL, '10', 0, 'Коригуючі транзакції по рахунках XOZ (для FineVare)', 547, 'null', 'DELTA', 'GL', 0, NULL, 1, 'prfxoz0', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (547);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (547);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (547);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (547);

--Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (7, 547, 547);

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
