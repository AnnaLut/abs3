-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 555
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
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(ACC,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(ACC_R,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(ACC_RN,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(ACC_R0,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(ACC_R30,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(GRP)_$_grpportf(GRP)', 1, 386);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(RNK,KF)_$_customer(RNK,KF)', 1, 121);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(S080)_$_s080fin(S080)', 1, 134);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(S250)_$_kls250(S250)', 1, 385);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (555, 'nbu23rez(TIPA,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_R,KF)_$_account(ACC,KF)', 1, 'ACC_R');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_R,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_RN,KF)_$_account(ACC,KF)', 1, 'ACC_RN');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_RN,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_R0,KF)_$_account(ACC,KF)', 1, 'ACC_R0');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_R0,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_R30,KF)_$_account(ACC,KF)', 1, 'ACC_R30');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(ACC_R30,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(GRP)_$_grpportf(GRP)', 1, 'GRP');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(RNK,KF)_$_customer(RNK,KF)', 1, 'RNK');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(RNK,KF)_$_customer(RNK,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(S080)_$_s080fin(S080)', 1, 'S080');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(S250)_$_kls250(S250)', 1, 'S250');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(TIPA,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'TIPA');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(TIPA,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (555, 'nbu23rez(TIPA,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');

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
