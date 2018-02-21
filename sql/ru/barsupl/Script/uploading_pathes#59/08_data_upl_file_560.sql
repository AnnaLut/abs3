-- ***************************************************************************
set verify off
set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 560
define ssql_id  = 560,1560

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
-- ETL-22476 UPL - изменить выгрузку данных по финотчетности (агрегированная отчетность)
--
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);
Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT,  VERS)
 Values
   (560, 'select bars.gl.kf kf, f.FDAT, f.IDF, f.KOD, f.S, to_char(f.OKPO,''fm99999999999999'') OKPO, f.BRANCH, f.SS
  from BARS.FIN_RNK f
 where idf in (11,12,13)
   AND bars.gl.kf= SUBSTR(f.BRANCH, 2,6)', 
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
    NULL, 'Фiн.звiти клiєнтiв', '1.2');
Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1560, 'with dt        as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
       FIN_CALC  as (
select bars.gl.kf as KF, to_number(c.okpo) OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
  from BARS.FIN_CALCULATIONS f, bars.customer c, dt dt
  where f.rnk=c.rnk and f.rnk>0
  and f.FDAT> = dt.dt1 
  group by bars.gl.kf, to_number(c.okpo), f.DAT
union all   
select bars.gl.kf as KF, F.RNK OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
  from BARS.FIN_CALCULATIONS f, bars.FIN_cust c, dt dt
  where - f.rnk=to_number(c.okpo) and f.rnk<0
  and f.FDAT> = dt.dt1
  group by bars.gl.kf, F.RNK , f.DAT 
  )
select bars.gl.kf kf, f.FDAT, f.IDF, f.KOD, f.S, to_char(f.OKPO,''fm99999999999999'') OKPO, f.BRANCH, f.SS
  from BARS.FIN_RNK f, FIN_CALC c
 where f.idf in (11,12,13)
   AND bars.gl.kf= SUBSTR(f.BRANCH, 2,6)  
   and c.okpo = f.okpo
   and f.fdat=c.dat', 
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
   NULL, 'Фiн.звiти клiєнтiв', '1.2');

 --declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
-- delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
-- delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(IDF,KOD)_$_fin_kod(IDF,KOD)', 1, 569);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(KF)_$_banks(MFO)', 1, 402);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(IDF,KOD)_$_fin_kod(IDF,KOD)', 1, 'IDF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(IDF,KOD)_$_fin_kod(IDF,KOD)', 2, 'KOD');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(KF)_$_banks(MFO)', 1, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (1, 560,  560);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (2, 560, 1560);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (3, 560,  560);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (4, 560, 1560);


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
