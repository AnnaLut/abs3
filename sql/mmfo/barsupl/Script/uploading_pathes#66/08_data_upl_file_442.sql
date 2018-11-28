-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 442
--define ssql_id  = 442

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 442');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (442))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 442');
end;
/
-- ***************************************************************************
-- TSK-0000905 UPL - необходимо разработать выгрузку инишиала пдля ставок типа 2 (Пеня/Комиссия)
--  новый файл для разовой выгрузки графиков процентных ставок пени
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (442);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (442, 'select distinct e.KF, e.BR_ID, e.BDATE, e.KV, e.RATE, e.BR_TP, e.BRANCH
  from bars.int_ratn i,
       bars.br_normal_edit e
 where i.ID = 2
   and i.br = e.br_id',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'История изменений % ставок пени (разовый)', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (442);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (442, 442, 'BRN2', 'brn2', 0, '09', NULL, '10', 0, 'История изменений % ставок пени (разовый)', 442, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, 'BRN2', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (442);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (442, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (442, 1, 'BR_ID', 'Код базовой ставки', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (442, 2, 'BDATE', 'Дата установки', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (442, 3, 'KV', 'Код валюты', 'NUMBER', 3, 0, NULL, 'Y', 'N', NULL, NULL, '0', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (442, 4, 'RATE', 'Ставка', 'NUMBER', 22, 12, '999999999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (442, 5, 'BR_TP', 'Код базовой ставки', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (442, 6, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (442);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (442);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (442);

/* добавляется в группу 99 в 10_data_upl_filegrps.sql для разовой выгрузки */
