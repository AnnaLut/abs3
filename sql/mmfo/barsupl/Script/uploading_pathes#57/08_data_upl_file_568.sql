-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 568
define ssql_id  = 568,1568,2568,3568

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
-- ETL-20616   ANL - разобраться почему поле TIPA в файлах NBU23REZ и REZ_CR имеют разные значения
--                   необходимо убрать ссылку  rez_cr(TIPA,ND,KF)_$_credits(TYPE,ND,KF)  между файлами выгрузки
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

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

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(ACC,KF)_$_account(ACC,KF)',1,102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(RNK,KF)_$_customer(RNK,KF)',1, 121);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(S080)_$_s080fin(S080)',1,134);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(CUSTTYPE)_$_custtype(CUSTTYPE)',1 ,288);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(FDAT)_$_bankdates(FDAT)',1,342);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(S250)_$_kls250(S250)',1,385);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(GRP)_$_grpportf(GRP)',1,386);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values (568, 'rez_cr(KF)_$_banks(MFO)',1,402);


-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(ACC,KF)_$_account(ACC,KF)',1,'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(ACC,KF)_$_account(ACC,KF)',2,'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(RNK,KF)_$_customer(RNK,KF)',1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(RNK,KF)_$_customer(RNK,KF)',2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(S080)_$_s080fin(S080)',1,'S080');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(CUSTTYPE)_$_custtype(CUSTTYPE)',1,'CUSTTYPE');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(FDAT)_$_bankdates(FDAT)',1,'FDAT');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(S250)_$_kls250(S250)',1,'S250');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(GRP)_$_grpportf(GRP)',1,'GRP');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname)  Values (568, 'rez_cr(KF)_$_banks(MFO)',1,'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

--ММФО и РУ отличаются полями KF и LGD_LONG
--begin
--    if  barsupl.bars_upload_utl.is_mmfo > 1 then
--         -- ************* MMFO *************
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 568, 568);
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 568, 1568);
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 568, 568);
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 568, 1568);
--    else
--         -- ************* RU *************
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 568, 2568);
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 568, 3568);
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 568, 2568);
--        Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 568, 3568);
--    end if;
--end;
--/

