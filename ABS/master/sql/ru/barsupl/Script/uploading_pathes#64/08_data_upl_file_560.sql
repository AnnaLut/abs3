-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 560
--define ssql_id  = 1560

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 560');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (560))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 1560');
end;
/
-- ***************************************************************************
-- ETL-24968 UPL - Зміна вивантаження файлу FIN_CALC
--  
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (1560);

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
Values (1560, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
FIN_CALC  as ( select bars.gl.kf as KF, to_number(coalesce(c.okpo, fc.okpo)) OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
                from dt, BARS.FIN_CALCULATIONS f
                left join bars.customer c on ( f.rnk = c.rnk and f.rnk > 0)
                left join bars.FIN_cust fc on (-f.rnk = to_number(fc.okpo) and f.rnk<0)
                where f.FDAT >= dt.dt1 
                and (c.rnk is not null or fc.okpo is not null)
                group by bars.gl.kf, to_number(coalesce(c.okpo, fc.okpo)), f.DAT
             )
select bars.gl.kf kf, fi.FDAT, fi.IDF, fi.KOD, fi.S, to_char(fi.OKPO,''fm99999999999999'') OKPO, fi.BRANCH, fi.SS
  from BARS.FIN_RNK fi, FIN_CALC c, dt 
 where fi.idf in (11,12,13)
 and bars.gl.kf= SUBSTR(fi.BRANCH, 2,6)
 and c.okpo = fi.okpo
 and fi.fdat = c.dat', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Фiн.звiти клiєнтiв (дельта)', '2.2');

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (560);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (560);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (560);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (560);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (560);

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
