-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 347
--define ssql_id  = 347

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 347');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (347))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 347');
end;
/
-- ***************************************************************************
-- TSK-0000907 UPL - выгрузитьтаблицу IND_INFL (индекс инфляции)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (347);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values (347, 'select idat, ir from bars.ind_infl ', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Довідник індекс інфляції', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (347);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, 
    DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, 
    SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (347, 347, 'IND_INFL', 'ind_infl', 0, 
    '09', NULL, '10', 0, 'Довідник індекс інфляції', 
    347, 'null', 'WHOLE', 'EVENT', 1, 
    NULL, 1, 'ind_infl', 0, 0);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (347);

Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, 
    COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, 
    NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values
   (347, 1, 'IDAT', 'Дата', 'DATE', 
    8, NULL, 'ddmmyyyy', 'Y', 'N', 
    NULL, NULL, '31/12/9999', 1, NULL);

Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, 
    COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, 
    NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values
   (347, 2, 'IR', 'Номинальная сумма', 'NUMBER', 
    22, 12, '999999999990D000000000000', NULL, 'Y', 
    NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (347);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (347);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (347);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID)
Values  (5, 347, 347);

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
