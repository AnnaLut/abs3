-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 232
define ssql_id  = 232

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
-- ETL-20517  UPL - отрезать хвост SKRY.N_SK (uploading_pathes#56)
-- SKRYNKA
-- Добавлен предикат по KF
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (232, 'with kf as (select /*+ materialize */
                   coalesce( bars_upload.get_param(''KF''),
                            (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))
                           ) kf
              from dual)
select s.o_sk, s.n_sk, s.snum, s.keyused, s.isp_mo, s.keynumber, s.branch, s.kf
  from bars.skrynka s,kf
  where kf.kf = s.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.suda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   'begin barsupl.bars_upload_usr.tuda(null); end;', 'Портфель депозитних сейфів', '1.2');

-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID=232 and COL_NAME= 'N_SK' ;

Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (232, 2, 'N_SK', 'Номер сейфу (системний референс)', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, 'TRUNC_E2');

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************

