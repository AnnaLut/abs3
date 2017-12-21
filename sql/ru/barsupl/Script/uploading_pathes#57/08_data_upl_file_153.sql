-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 153
define ssql_id  = 153,1153

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
--ETL-19975 UPL - выделить в выгрузке для DWH договора внешних заимствований
-- CC_PROL (153) История пролонгаций сроков погашения
-- добавлено условие на определение nd_type в зависимости от vidd (раньше ставился 3)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (153, 'select cc_.ND, cc_.FDAT, cc_.NPP, cc_.MDATE,  cc_.KF, case d.vidd when 10 then 10 when 110 then 10 else 3 end as nd_type
  from BARS.CC_PROL cc_
       left join bars.cc_deal d on (cc_.nd = d.nd )
 where fdat <= to_date(:param1, ''dd/mm/yyyy'')',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'История пролонгаций сроков погашения', '2.1');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1153, 'select cc_.ND, cc_.FDAT, cc_.NPP, cc_.MDATE,  cc_.KF, case d.vidd when 10 then 10 when 110 then 10 else 3 end as nd_type
  from BARS.CC_PROL cc_
       left join bars.cc_deal d on (cc_.nd = d.nd )
 where fdat = to_date(:param1, ''dd/mm/yyyy'')',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'История пролонгаций сроков погашения', '2.1');

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
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (153, 'ccprol(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (153, 'ccprol(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (153, 'ccprol(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (153, 'ccprol(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (153, 'ccprol(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (153, 'ccprol(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');

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
