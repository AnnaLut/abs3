-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 329
define ssql_id  = 329,1329

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
-- NEW FIELD 'TYPE' is added
-- MASTER_CKGK=arraccrln, DOMAIN_CODE=ARR
-- for field 'Value': PREFUN = 'TRUNC_E2'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT,  VERS)
 Values
   (329, 'select u.acc, 
       bars.gl.kf, 
       substr(u.value,1,100) value, 
       u.chgaction,
       22 as type
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1
                     where u1.effectdate <= TO_DATE(:param1, ''dd/mm/yyyy'')
                       and u1.tag = ''PK_PRCT''
                     group by u1.acc )',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Зв''язок рахунку із зарплатним проектом за пластиковими картками', 
    '1.1');

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1329, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select u.acc, bars.gl.kf, substr(u.value,1,100) value, u.chgaction, 22 as type
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1, dt
                     where u1.effectdate between dt.dt1 and dt2
                       and u1.tag = ''PK_PRCT''
                     group by u1.acc )
/*   and u.value is not null*/',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
 'Зв''язок рахунку із зарплатним проектом за пластиковими картками', '1.0');


-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values  (329, 329, 'ACC_PKPRCT', 'acc_pkprct', 0, '09', NULL, '10', 0, 'БПК. Зарплатний проект', 329, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'arraccrln', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (329, 1, 'ACC', 'Бухгалтерський рахунок', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 4, 'TRUNC_E2');
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (329, 2, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 3, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (329, 3, 'VALUE', 'Код зарплатного проекту', 'VARCHAR2', 100, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (329, 4, 'CHGACTION', 'Вид зміни (I/U/D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (329, 5, 'TYPE', 'Тип', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
delete from BARSUPL.UPL_CONSTRAINTS where file_id =  329 and fk_fileid in(261, 327);
   
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (329, 'acc_pkprct(TYPE,VALUE,KF)_$_bpk_proect(TYPE,ID,KF)', 1, 327);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (329, 'acc_pkprct(TYPE)_$_arrtype(TYPE_ID)', 1, 261);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
delete from BARSUPL.UPL_CONS_COLUMNS where file_id in ( 329 ) and constr_name='acc_pkprct(TYPE,VALUE,KF)_$_bpk_proect(TYPE,ID,KF)';
delete from BARSUPL.UPL_CONS_COLUMNS where file_id in ( 329 ) and (constr_name='acc_pkprct(TYPE)_$_arrtype(RLN_TYPE)' or fk_colname in( 'RLN_TYPE', 'TYPE_ID','TYPE'));

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (329, 'acc_pkprct(TYPE,VALUE,KF)_$_bpk_proect(TYPE,ID,KF)', 1, 'TYPE');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (329, 'acc_pkprct(TYPE,VALUE,KF)_$_bpk_proect(TYPE,ID,KF)', 2, 'VALUE');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (329, 'acc_pkprct(TYPE,VALUE,KF)_$_bpk_proect(TYPE,ID,KF)', 3, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (329, 'acc_pkprct(TYPE)_$_arrtype(TYPE_ID)', 1, 'TYPE');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
