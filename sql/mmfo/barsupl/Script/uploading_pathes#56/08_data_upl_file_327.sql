-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 327
define ssql_id  = 327

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
-- ETL-19880 : UPL - изменение в выгрузке файлов bpkproect (327) и acc_pkprct (329)
-- ETL-19843 UPL - добавить ссылку с файла 329 на файл 327 по поле VALUE (убрать хвостики для ММФО)
-- Проэкты для карточных договоров
-- новое поле TYPE
-- MASTER_CKGK ='AR'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT,  VERS)
 Values
   (327, 'select bars.gl.kf as KF,
       b.ID,
       b.NAME,
       b.OKPO,
       b.PRODUCT_CODE,
       22 as type
  from BARS.BPK_PROECT b', 
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Проэкты для карточных договоров', '1.1');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values(327, 327, 'BPK_PROECT', 'bpkproect', 0,     '09', NULL, '10', 0, 'Проэкты для карточных договоров',     327, 'null', 'WHOLE', 'ARR', 1,     NULL, 1, 'AR', 1, 1);
 
-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE,     COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,     NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (327, 1, 'KF', 'Код філіалу', 'VARCHAR2',     6, NULL, NULL, 'Y', 'N',     NULL, NULL, '-', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE,     COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,     NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (327, 2, 'ID', 'ID', 'NUMBER',     15, 0, NULL, 'Y', 'N',     NULL, NULL, '0', 2, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE,     COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,     NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (327, 3, 'NAME', 'Назва проєкту', 'VARCHAR2',     100, NULL, NULL, NULL, 'Y',     NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE,     COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,     NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (327, 4, 'OKPO', 'ОКПО клієнта', 'VARCHAR2',     10, NULL, NULL, NULL, 'Y',     NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE,     COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,     NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (327, 5, 'PRODUCT_CODE', 'Код продукту', 'VARCHAR2',     30, NULL, NULL, NULL, 'Y',     NULL, NULL, 'N/A', NULL, NULL);
-- NEW FIELD: 
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE,     COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,     NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (327, 6, 'TYPE', 'Тип', 'NUMBER',     2, 0, NULL,  'Y', 'N' ,    NULL, NULL, NULL, 1, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
delete from BARSUPL.UPL_CONSTRAINTS where file_id =  327 and fk_fileid =261;
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (327, 'bpk_proect(TYPE)_$_arrtype(TYPE_ID)', 1, 261);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
delete from BARSUPL.UPL_CONS_COLUMNS where file_id in ( 327 ) and ( fk_colname in( 'RLN_TYPE', 'TYPE_ID','TYPE'));
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (327, 'bpk_proect(TYPE)_$_arrtype(TYPE_ID)', 1, 'TYPE');   


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
