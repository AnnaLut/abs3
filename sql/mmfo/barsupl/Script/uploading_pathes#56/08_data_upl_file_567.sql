-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 567
define ssql_id  = 567

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: &&sfile_id');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (&&sfile_id))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # &&ssql_id');
end;
/
-- ***************************************************************************
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (567, 
'WITH
 VER as(
 SELECT max(lst.VERSION_ID) maxver
   FROM bars.NBUR_REF_FILES ref JOIN 
        bars.NBUR_LST_FILES lst
            ON (lst.FILE_ID = ref.ID)
   WHERE lst.report_date = to_date(:param1, ''dd/mm/yyyy'')
   and ref.FILE_CODE = ''#A7'' 
   AND lst.FILE_STATUS IN (''FINISHED'', ''BLOCKED'')
 )
 SELECT 
       lst.FILE_NAME,
       lst.VERSION_ID,
       to_date(to_char(lst.START_TIME,''ddmmyyyyhh24miss'')
            ,''ddmmyyyyhh24miss'') as START_TIME,
       to_date(to_char(lst.FINISH_TIME,''ddmmyyyyhh24miss'')
            ,''ddmmyyyyhh24miss'') as FINISH_TIME, 
       lst.KF
   FROM ver ver,
        bars.NBUR_REF_FILES ref JOIN 
        bars.NBUR_LST_FILES lst
            ON (lst.FILE_ID = ref.ID)
   WHERE lst.report_date = to_date(:param1, ''dd/mm/yyyy'')
   and ref.FILE_CODE = ''#A7'' 
   and lst.FILE_STATUS IN (''FINISHED'', ''BLOCKED'')
   and lst.VERSION_ID = VER.maxver',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, NULL, 'Дані про структуру активів та пасивів за строками', '1.1');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (567, 567, 'A7_upl_file', 'a7_upl_file', 0, '09', NULL, '10', 0, 'Файл-Дані про структуру активів та пасивів за строками', 565, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'a7file', 0, 1);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 1, 'FILE_NAME', 'Ім`я сформованого файлу', 'CHAR', 12, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 2, 'VERSION_ID', 'Ід. версії файлу', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, '0', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 3, 'START_TIME', 'Дата початку формування', 'DATE', 14, NULL, 'ddmmyyyyhh24miss', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 4, 'FINISH_TIME', 'Дата закiнчення формування', 'DATE', 14, NULL, 'ddmmyyyyhh24miss', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 5, 'KF', 'Код фiлiалу (МФО)', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 2, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************





