-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 9023
--define ssql_id  = 9023,9123

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 9023');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (9023))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 9023,9123');
end;
/

-- ***************************************************************************
-- ETL-23206  UPL - КОНТРОЛЬ РАССИНХРОНИЗАЦИИ ИСТОРИЧЕСКИХ ТАБЛИЦ
-- ETL-23218  UPL - BPK_ACC <-> BPK_ACC_UPDATE
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (9023,9123);

declare cl_0 clob; cl_1 clob;
begin
      cl_0:=to_clob('select KF, ID, STAT_ID, FIELD_NAME, VALUE, STARTDATE, ENDDATE, TBL_NAME
  from BARS.UPDATE_TBL_STAT s
 where s.STAT_ID = barsupl.bars_upload.get_param(''STAT_FILE_ID'')
   and s.FIELD_TYPE=''count_diff''');

      cl_1:=to_clob('begin
  barsupl.bars_upload_usr.tuda;
  BARS.UPDATE_TBL_UTL.CHECK_BPK_ACC_UPDATE;
end;');
      Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
       Values (9023, cl_0, cl_1, NULL, 'Розходженя даних в BPK_ACC <-> BPK_ACC_UPDATE', '1.0');
end;
/


declare cl clob;
begin
cl:=to_clob(
'declare
    id  number;
    cnt number;
begin 
    barsupl.bars_upload_usr.tuda;
    BARS.UPDATE_TBL_UTL.SYNC_BPK_ACC_UPDATE(id, cnt);
end;');
Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (9123, 
'select KF, ID, STAT_ID, FIELD_NAME, VALUE, STARTDATE, ENDDATE, TBL_NAME
  from BARS.UPDATE_TBL_STAT s
 where s.STAT_ID = barsupl.bars_upload.get_param(''STAT_FILE_ID'')
   and s.FIELD_NAME = ''rowcount''',
   cl,
  NULL, 'Синхронізація даних в BPK_ACC <-> BPK_ACC_UPDATE', '1.0');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (9023);

Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
                                ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (9023, 9023, 'BPK_UPD', 'bpkupd', 0, '09', NULL, '10', 0, 'Розходженя даних в BPK_ACC <-> BPK_ACC_UPDATE', 
           9023, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'bpkupd', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (9023);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 1, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 2, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 2, 'ID', 'ID', 'NUMBER', 16, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 3, 'STAT_ID', 'STAT_ID', 'NUMBER', 16, 0, NULL, NULL, 'Y', NULL, NULL, 0, NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 4, 'FIELD_NAME', 'Поле', 'VARCHAR2', 50, NULL, NULL, NULL, 'N', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 5, 'VALUE', 'Значение', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 6, 'STARTDATE', 'Дата начала проверки', 'DATE', 8, NULL, 'ddmmyyyyhh24miss', NULL, 'Y', NULL, NULL, '01010001010101', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 7, 'ENDDATE', 'Дата начала проверки', 'DATE', 8, NULL, 'ddmmyyyyhh24miss', NULL, 'Y', NULL, NULL, '01010001010101', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (9023, 8, 'TBL_NAME', 'Таблица', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (9023);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (85, 9023,  9023);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (86, 9023,  9123);