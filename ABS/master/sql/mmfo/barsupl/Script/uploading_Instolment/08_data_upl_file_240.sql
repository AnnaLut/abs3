-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 240
--define ssql_id  = 240

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 240');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (240))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 240');
end;
/
-- ***************************************************************************
-- TSK-0000806 ANL - анализ выгрузки кредита рассрочка (instalment)
-- COBUINST-14   Вивантаження даних для СД по продукту Instalment
-- новый справочник статусов Instalment
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (240);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (240, 'select o.ST_ID as ID, o.ST_SID as SID, o.ST_NAME as NAME
  from BARS.OW_INST_STATUS_DICT o',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Справочник статусов Instalment', '1.0');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (240);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id,
    nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (240, 240, 'OW_INST_STS', 'ow_inst_sts', 0, '09', NULL, '10', 0, 'Довідник статусів Instalment', 240, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, 'owinststatus', 1, 0);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (240);

Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (240, 1, 'ID', 'Ідентифікатор', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (240, 2, 'SID', 'Мнемонічний код', 'VARCHAR2', 50, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 1, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (240, 3, 'NAME', 'Найменування', 'VARCHAR2', 255, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (240);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (240);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (240);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (5, 240,  240);

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
