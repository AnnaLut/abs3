-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 156
--define ssql_id  = 156

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 156');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (156))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 156');
end;
/
-- ***************************************************************************
--ETL-23254 - UPL - исправить выгрузку SRC_CCTAGS в соответсвтвии с источником(не хватает длины полей)
--
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (156);

 --declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
-- delete from BARSUPL.UPL_FILES where FILE_ID IN (156);

-- ***********************
-- UPL_COLUMNS
-- ***********************
 delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (156);

Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, 
    COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, 
    NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values
   (156, 1, 'TAG', 'Найменування додаткового реквiзиту', 'VARCHAR2', 
    7, NULL, NULL, 'Y', 'N', 
    NULL, NULL, '-', 1, NULL);
	
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, 
    COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, 
    NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values
   (156, 2, 'NAME', 'Коментар додаткового реквiзиту', 'VARCHAR2', 
    50, NULL, NULL, NULL, 'Y', 
    NULL, NULL, '-', NULL, NULL);
COMMIT;


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (156);
--Insert into BARSUPL.UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (560, 'fin_rnk(BRANCH)_$_branch(BRANCH)', 1, 103);


-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (156);
--Insert into BARSUPL.UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (560, 'fin_rnk(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (156);

--Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (1, 560,  560);


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
