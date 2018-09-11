-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 219
--define ssql_id  = 219

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 219');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (219))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # ssql_id');
end;
/
-- ***************************************************************************
-- ETL-25581  UPL - добавить выгрузку нового файла intratef - со ставками для ACC, которые установлены будущей датой
-- ETL-25154  ANL - параметр "тип процентной ставки по счету, код процентной ставки, название процентной ставки" (Калошина)
-- новый справочник "Базовые процентные ставки"
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (219);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (219, 'select b.BR_ID, b.BR_TYPE, b.NAME, b.INUSE
  from BARS.BRATES b',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Базовые процентные ставки', '1.0');


--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (219);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (219, 219, 'BRATES', 'brates', 0, '09', NULL, '10', 0, 'Базовые процентные ставки', 219, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, NULL, 1, 0);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (219);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (219, 1, 'BR_ID', 'Код базовой ставки', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (219, 2, 'BR_TYPE', 'Тип базовой процентной ставки', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (219, 3, 'NAME', 'Название процентной ставки', 'VARCHAR2', 35, NULL, NULL, NULL, 'N', NULL, '35,09,13,10|32,32,32,32', 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (219, 4, 'INUSE', '1 - діюча, 0 - недіюча', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);



-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (219);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (219, 'brates(BR_TYPE)_$_brtypes(BR_TYPE)', 1, 220);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (219);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (219, 'brates(BR_TYPE)_$_brtypes(BR_TYPE)', 1, 'BR_TYPE');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (219);
Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (5, 219, 219);


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
