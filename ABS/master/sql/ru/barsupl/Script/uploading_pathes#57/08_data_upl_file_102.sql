-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 102
define ssql_id  = ####

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
-- ETL-XXX
-- для файла установить CRITICAL_FLG=2
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (102, 102, 'ACC', 'accounts', 0, '09', NULL, '10', 0, 'Счета банка', 2, 'null', 'DELTA', 'GL', 1, NULL, 1, 'acg_stc_itm', 2, 1);


-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

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

/*
--with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, 'dd/mm/yyyy')) + 1 dt1, to_date (:param1, 'dd/mm/yyyy') dt2 from dual )
--with dt as ( select to_date (:param1, 'dd/mm/yyyy') dt1, to_date (:param1, 'dd/mm/yyyy') dt2 from dual )
--with dt as ( select /*+ materialize / to_date (:param1, 'dd/mm/yyyy') dt1, ADD_MONTHS(to_date (:param1, 'dd/mm/yyyy'), 12) dt2 from dual )
--with dt as ( select /* materialize / to_date (:param1, 'dd/mm/yyyy') dt1, bars.glb_bankdate dt2 from dual )
--with dt as ( select /*+ MATERIALIZE noparallel / to_date (:param1, 'dd/mm/yyyy') dt1,
--                                      to_date(val,'MM/DD/YYYY') dt2
--               from bars.params$base
--              where kf=(select val from bars.params$global where par='GLB-MFO') and par='BANKDATE')
*/
