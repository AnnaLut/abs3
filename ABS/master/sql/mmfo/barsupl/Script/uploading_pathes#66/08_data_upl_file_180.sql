-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 180
--define ssql_id  = 180

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 180');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (180))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 180');
end;
/
-- ***************************************************************************
-- TSK-0001458 UPL - выгрузить два новых параметра КД
-- Необходимо забрать в миррор два параметра: день погашения кредита, flags
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (180);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
Values (180, 'SELECT 4 as REF_ID, KOD, TXT FROM BARS.V_CC_FLAGS', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Довідник прапори-параметри угод',  '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (180);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (180, 180, 'CCFLAGS', 'ccflags', 0, '09', NULL, '10', 0, 'Довідник прапори-параметри угод', 
    180, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'mtag', 1, 0);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (180);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (180, 0, 'REF_ID', 'Код справочника', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, '0', 0, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (180, 1, 'KOD', 'ID', 'VARCHAR2', 5, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (180, 2, 'TXT', 'Описание', 'VARCHAR2', 60, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (180);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (180);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (180);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID)  Values  (5, 180, 180);



