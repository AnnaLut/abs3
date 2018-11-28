-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 443
--define ssql_id  = 443

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 443');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (443))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 443');
end;
/
-- ***************************************************************************
-- TSK-0000905 UPL - необходимо разработать выгрузку инишиала пдля ставок типа 2 (Пеня/Комиссия)
--  новый файл для разовой выгрузки счетов, с установленными ставками пени
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (443);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (443, 'select i.KF, i.ACC, i.ID, i.BDAT, i.IR, i.BR, i.OP, a.KV
  from bars.int_ratn i
  join bars.accounts a on (i.acc = a.acc and i.kf = a.kf)
 where i.ID = 2',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Счета, с установленными ставками пени (разовый)', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (443);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (443, 443, 'INTRATN2', 'intratn2', 0, '09', NULL, '10', 0, 'Счета, с установленными ставками пени (разовый)', 443, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, 'INTRATN2', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (443);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 1, 'ACC', 'Идентификатор счета', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 2, 'ID', 'идентификатор типа начисления %', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 3, 'BDAT', 'Дата установки', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 4, 'IR', 'индивидуальная % ставка', 'NUMBER', 22, 12, '999999999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 5, 'BR', 'базовая % ставка', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 6, 'OP', 'операция, между IR и BR', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (443, 7, 'KV', 'Код валюты', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (443);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (443);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (443);

/* добавляется в группу 99 в 10_data_upl_filegrps.sql для разовой выгрузки */

