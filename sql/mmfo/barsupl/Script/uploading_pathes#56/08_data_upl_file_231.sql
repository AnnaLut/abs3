-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 231
define ssql_id  = 231

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
-- ETL-20520 UPL - Обеспечить выгрузку файла SKRYTRF исходя из условий разных политик РУ и ММФО
-- SKRYNKA_TARIFF
-- Добавлен предикат по KF
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (231, 'with kf as (select /*+ materialize */
                   coalesce( bars_upload.get_param(''KF''),
                            (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))
                           ) kf
              from dual)
select s.tariff, s.name, s.tip, s.o_sk, s.branch, s.basey, s.basem, s.kf
  from bars.skrynka_tariff s,kf
  where kf.kf = s.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.suda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   'begin barsupl.bars_upload_usr.tuda(null); end;', 'Тарифи користування депозитними сейфами', '1.2');

-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
