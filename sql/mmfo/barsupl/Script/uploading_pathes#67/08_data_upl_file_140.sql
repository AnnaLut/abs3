-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 140
--define ssql_id  = 140

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 140');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (140))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 140');
end;
/
-- ***************************************************************************
-- TSK-0003475 UPL - добавить gk для поля BASEY (ссылка на мастер basey)  в файлах cp, acra
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (140);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (140);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (140);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (140);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (140, 'cp(BASEY)_$_basey(ID)', 1, 410);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (140, 'cp(DOX)_$_cpdoh(DOX)', 1, 165);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (140, 'cp(IDT)_$_cptype(TYPE_ID)', 1, 524);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (140, 'cp(KV)_$_tabval(KV)', 1, 296);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (140, 'cp(fin23)_$_stanfin23(fin23)', 1, 128);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (140, 'cp(kat23)_$_stankat23(kat23)', 1, 127);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (140);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (140, 'cp(BASEY)_$_basey(ID)', 1, 'BASEY');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (140, 'cp(DOX)_$_cpdoh(DOX)', 1, 'DOX');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (140, 'cp(IDT)_$_cptype(TYPE_ID)', 1, 'IDT');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (140, 'cp(KV)_$_tabval(KV)', 1, 'KV');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (140, 'cp(fin23)_$_stanfin23(fin23)', 1, 'FIN23');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (140, 'cp(kat23)_$_stankat23(kat23)', 1, 'KAT23');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (140);

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
