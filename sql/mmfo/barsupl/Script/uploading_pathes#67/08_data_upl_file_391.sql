-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 391
--define ssql_id  = 391

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 391');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (391))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 391');
end;
/

-- ***************************************************************************
-- TSK-0003337 UPL - здійснити вивантаження параметру K 140
--      добавляется новый тег 'K140'. Для остальных заполняется описание.
--      Необходимо создать новый файл выгрузки cusvalsr
--      Изменить структуру справочника klk140 (добавить поле REF_ID)
--
--      в справочник KL_K140 добавил поле REF_ID, включил его в PK (REF_ID, K140)
--      изменил мастер CKGK на "ctag"
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (391);

Insert into UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (391, 'select 5 as ref_id, kl_.K140, kl_.TXT, kl_.D_OPEN, kl_.D_CLOSE, kl_.D_MODE from BARS.KL_K140 kl_',
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Классификатор НБУ (KL_K140)', '1.1');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (391);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (391, 391, 'KL_K140', 'klk140', 0, '09', NULL, '10', 0, 'НБУ: Ознака приналежност_ до малого б_знесу', 53, 'null', 'WHOLE', 'IP', 1, NULL, 1, 'mtag', 0, 0);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (391);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (391, 1, 'REF_ID', 'ID довідника', 'NUMBER', 3, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (391, 2, 'K140', 'K140', 'CHAR', 1, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (391, 3, 'TXT', 'Опис', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (391, 4, 'D_OPEN', 'Дата відкриття', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (391, 5, 'D_CLOSE', 'Дата закриття', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (391, 6, 'D_MODE', 'Дата модифікації', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (391);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (391);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (391);

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
