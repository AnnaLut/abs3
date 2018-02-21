-- ***************************************************************************
set verify off
set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 161
define ssql_id  = ###

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
-- ETL-22768 UPL - В выгрузку добавить поле NDG - Реф генерального КД
-- добавлена связка credkz(TYPE,NDG,KF)_$_credkz(TYPE,ND,KF)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(BRANCH)_$_branch(BRANCH)', 2, 103);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(fin23)_$_stanfin23(fin23)', 1, 128);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(kat23)_$_stanfin23(kat23)', 1, 127);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(KF)_$_banks(KF)', 2, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(KF,RNK)_$_custmer(KF,RNK)', 3, 121);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(kv)_$_tabval(kv)', 2, 296);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(obs23)_$_stanobs23(obs23)', 1, 126);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 1, 161);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(USER_ID,KF)_$_staff(ID,KF)', 2, 181);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(USER_ID)_$_staffad(ID)', 2, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(VIDD)_$_credtypes(VIDD)', 2, 301);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (161, 'credkz(TYPE,NDG,KF)_$_credkz(TYPE,ND,KF)', 1, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(fin23)_$_stanfin23(fin23)', 1, 'FIN23');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(kat23)_$_stanfin23(kat23)', 1, 'KAT23');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(KF)_$_banks(KF)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(KF,RNK)_$_custmer(KF,RNK)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(KF,RNK)_$_custmer(KF,RNK)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(kv)_$_tabval(kv)', 1, 'KV');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(obs23)_$_stanobs23(obs23)', 1, 'OBS23');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 1, 'TYPE');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 2, 'NDI');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(USER_ID,KF)_$_staff(ID,KF)', 1, 'USER_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(USER_ID,KF)_$_staff(ID,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(USER_ID)_$_staffad(ID)', 1, 'USER_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(VIDD)_$_credtypes(VIDD)', 1, 'VIDD');

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(TYPE,NDG,KF)_$_credkz(TYPE,ND,KF)', 1, 'TYPE');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(TYPE,NDG,KF)_$_credkz(TYPE,ND,KF)', 2, 'NDG');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (161, 'credkz(TYPE,NDG,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');

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
