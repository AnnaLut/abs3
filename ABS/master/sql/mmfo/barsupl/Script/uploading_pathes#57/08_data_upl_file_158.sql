-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 158
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
-- ETL-20783 UPL - создать новый файл с объедененными договорами credits и kazna
-- (изменилась привязка с credits на credkz)
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
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC1,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC10,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC11,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC12,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC13,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC14,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC2,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC3,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC4,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC5,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC6,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC7,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC8,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC9,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(KF)_$_banks(KF)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC1,KF)_$_accounts(ACC,KF)', 1, 'ACC1');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC1,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC10,KF)_$_accounts(ACC,KF)', 1, 'ACC10');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC10,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC11,KF)_$_accounts(ACC,KF)', 1, 'ACC11');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC11,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC12,KF)_$_accounts(ACC,KF)', 1, 'ACC12');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC12,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC13,KF)_$_accounts(ACC,KF)', 1, 'ACC13');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC13,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC14,KF)_$_accounts(ACC,KF)', 1, 'ACC14');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC14,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC2,KF)_$_accounts(ACC,KF)', 1, 'ACC2');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC2,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC3,KF)_$_accounts(ACC,KF)', 1, 'ACC3');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC3,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC4,KF)_$_accounts(ACC,KF)', 1, 'ACC4');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC4,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC5,KF)_$_accounts(ACC,KF)', 1, 'ACC5');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC5,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC6,KF)_$_accounts(ACC,KF)', 1, 'ACC6');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC6,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC7,KF)_$_accounts(ACC,KF)', 1, 'ACC7');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC7,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC8,KF)_$_accounts(ACC,KF)', 1, 'ACC8');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC8,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC9,KF)_$_accounts(ACC,KF)', 1, 'ACC9');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC9,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');

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
