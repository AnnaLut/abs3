-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 224
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
-- (удалена связка c 224(dptagrmnts) на 161 (dpttrust))
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

Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(CUST_ID,KF)_$_custmer(RNK,KF)', 1, 121);
--Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(TRUSTEE_ID,KF)_$_dpttrust(ID,KF)', 1, 161);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(CMS_REF, KF)_$_oper(REF,KF)', 1, 196);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(DOC_REF, KF)_$_oper(REF,KF)', 1, 196);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(ND_TYPE,DPT_ID,KF)_$_deposit(TYPE,DEPOSIT_ID,KF)', 1, 221);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(AGRMNT_TYPE)_$_dptagrmtp(ID)', 3, 223);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(BANKDATE)_$_bankdates(FDAT)', 1, 342);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (224, 'dptagrmnts(KF)_$_banks(MFO)', 1, 402);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(AGRMNT_TYPE)_$_dptagrmtp(ID)', 1, 'AGRMNT_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(BANKDATE)_$_bankdates(FDAT)', 1, 'BANKDATE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(CMS_REF, KF)_$_oper(REF,KF)', 1, 'CMS_REF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(CMS_REF, KF)_$_oper(REF,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(CUST_ID,KF)_$_custmer(RNK,KF)', 1, 'CUST_ID');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(CUST_ID,KF)_$_custmer(RNK,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(DOC_REF, KF)_$_oper(REF,KF)', 1, 'DOC_REF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(DOC_REF, KF)_$_oper(REF,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(ND_TYPE,DPT_ID,KF)_$_deposit(TYPE,DEPOSIT_ID,KF)', 2, 'DPT_ID');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(ND_TYPE,DPT_ID,KF)_$_deposit(TYPE,DEPOSIT_ID,KF)', 3, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(ND_TYPE,DPT_ID,KF)_$_deposit(TYPE,DEPOSIT_ID,KF)', 1, 'ND_TYPE');
--Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(TRUSTEE_ID,KF)_$_dpttrust(ID,KF)', 2, 'KF');
--Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (224, 'dptagrmnts(TRUSTEE_ID,KF)_$_dpttrust(ID,KF)', 1, 'TRUSTEE_ID');

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
