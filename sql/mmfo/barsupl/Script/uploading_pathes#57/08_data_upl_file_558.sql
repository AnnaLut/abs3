-- ***************************************************************************
set verify off
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
define sfile_id = 558
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
-- ETL-20783 UPL - ������� ����� ���� � ������������� ���������� credits � kazna
-- (���������� �������� � credits �� credkz)
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
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (558, 'ccrestrhist(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (558, 'ccrestrhist(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (558, 'ccrestrhist(ND_TYPE)_$_arrtype(RLN_TYPE)', 1, 261);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (558, 'ccrestrhist(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (558, 'ccrestrhist(VID_RESTR)_$_ccrstrvid(VID_RESTR)', 1, 151);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (558, 'ccrestrhist(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (558, 'ccrestrhist(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (558, 'ccrestrhist(ND_TYPE)_$_arrtype(RLN_TYPE)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (558, 'ccrestrhist(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (558, 'ccrestrhist(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (558, 'ccrestrhist(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (558, 'ccrestrhist(VID_RESTR)_$_ccrstrvid(VID_RESTR)', 1, 'VID_RESTR');

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
