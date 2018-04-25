-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 560
--define ssql_id  = 560,1560

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 560');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (560))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 560,1560');
end;
/
-- ***************************************************************************
-- ETL-22806 UPL - изменение по агрегированной отчетности (в части констрейнтов)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (560,1560);

 --declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
-- delete from BARSUPL.UPL_FILES where FILE_ID IN (560);

-- ***********************
-- UPL_COLUMNS
-- ***********************
-- delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (560);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (560);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(KF)_$_banks(MFO)', 1, 402);
-- добавлено после отправки uploading_pathes#59
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(KOD,IDF)_$_fin_kod(KOD,IDF)', 1, 569);
Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(KF,OKPO,FDAT)_$_fincalc(KF,OKPO,DAT)', 1, 570);


-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (560);
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(KF)_$_banks(MFO)', 1, 'KF');
-- добавлено после отправки uploading_pathes#59
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(KOD,IDF)_$_fin_kod(KOD,IDF)', 1, 'KOD');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(KOD,IDF)_$_fin_kod(KOD,IDF)', 2, 'IDF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(KF,OKPO,FDAT)_$_fincalc(KF,OKPO,DAT)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(KF,OKPO,FDAT)_$_fincalc(KF,OKPO,DAT)', 2, 'OKPO');
Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(KF,OKPO,FDAT)_$_fincalc(KF,OKPO,DAT)', 3, 'FDAT');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (560);

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
