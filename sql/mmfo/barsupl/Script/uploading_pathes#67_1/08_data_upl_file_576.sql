-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 576
--define ssql_id  = 576

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 576');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (576))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 576');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- новый довідник продуктів
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (576);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (576, 'select id, product_code, product_name, parent_product_id, is_active, 9 as TUP, 9 as P_TUP from bars.deal_product',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Довідник продуктів', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (576);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id,
    nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (576, 576, 'DEAL_PRODUCT', 'dealpd', 0, '09', NULL, '10', 0, 'Довідник продуктів', 576, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'prod', 1, 0);

-- ***********************
-- UPL_COLUMNS
-- ***********************

delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (576);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (576, 1, 'ID', 'Ідентифікатор банківського продукту', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (576, 2, 'PRODUCT_CODE', 'Код продукту (унікальний в межах свого типу угод)', 'VARCHAR2', 35, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (576, 3, 'PRODUCT_NAME', 'Назва продукту', 'VARCHAR2', 300, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (576, 4, 'PRNT_PD', 'Ідентифікатор базового продукту', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (576, 5, 'IS_ACTIVE', 'Признак активності', 'CHAR', 1, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (576, 6, 'TUP', 'TUP для ХД', 'NUMBER', 3, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (576, 7, 'P_TUP', 'PARRENT_TUP для ХД', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (576);

Insert into BARSUPL.UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid)
 Values (576, 'dlprod(PRNTPDID,PRNTTUP)_$_dlprod(ID,TUP)', 1, 576);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (576);

Insert into BARSUPL.UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname)
 Values (576, 'dlprod(PRNTPDID,PRNTTUP)_$_dlprod(ID,TUP)', 1, 'PRNT_PD');
Insert into BARSUPL.UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname)
 Values (576, 'dlprod(PRNTPDID,PRNTTUP)_$_dlprod(ID,TUP)', 2, 'P_TUP');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************

delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (576);

Insert into BARSUPL.UPL_FILEGROUPS_RLN  (group_id, file_id, sql_id) Values  (5, 576, 576);
