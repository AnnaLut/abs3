-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 577
--define ssql_id  = 577

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 577');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (577))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 577');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- новый довідник типы регистров
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (577);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (577, 'select id, register_code, register_name, is_active from bars.register_type',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Довідник типы регистров', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (577);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id,
    nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (577, 577, 'REGISTER_TYPE', 'registertype', 0, '09', NULL, '10', 0, 'Довідник типы регистров', 577, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, 'registertype', 1, 0);

-- ***********************
-- UPL_COLUMNS
-- ***********************

delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (577);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (577, 1, 'ID', 'уникальный ключ', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (577, 2, 'REGISTER_CODE', 'код регистра', 'VARCHAR2', 100, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (577, 3, 'REGISTER_NAME', 'наименование регистра', 'VARCHAR2', 300, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (577, 4, 'IS_ACTIVE', 'статус регистра', 'VARCHAR2', 1, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (577);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (577);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************

delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (577);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (5, 577, 577);
