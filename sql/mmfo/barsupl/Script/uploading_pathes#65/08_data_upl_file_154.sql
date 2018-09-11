-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 154
--define ssql_id  = ###

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 154');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (154))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # ###');
end;
/
-- ***************************************************************************
-- TSK-0000052 UPL-добавити ссилку поля SOUR з таблиці CC_SOURCE в таблицю CCADD.
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
--delete from BARSUPL.UPL_SQL where SQL_ID IN (###);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (154);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (154);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (154);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (154, 'ccadd(FREQ)_$_FREQ(FREQ)', 1, 321);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (154, 'ccadd(FREQP)_$_FREQ(FREQ)', 1, 321);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (154, 'ccadd(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (154, 'ccadd(SOUR)_$_CCSOUR(SOUR)', 1, 293);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (154);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (154, 'ccadd(FREQ)_$_FREQ(FREQ)', 1, 'FREQ');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (154, 'ccadd(FREQP)_$_FREQ(FREQ)', 1, 'FREQP');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (154, 'ccadd(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (154, 'ccadd(SOUR)_$_CCSOUR(SOUR)', 1, 'SOUR');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (154);

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
