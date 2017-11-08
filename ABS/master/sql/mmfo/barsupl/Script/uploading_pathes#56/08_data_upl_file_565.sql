-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 565
define ssql_id  = 565

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
-- ETL-XXX письмо Харин-->Костыра 17.10.2017 17:46
-- В связи с изменениями в структуре АБС – в таблице FIN_CUST необходимо удалить поле branch
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (565, 'select bars.gl.kf kf, okpo, nmk, custtype, fz, isp, ved, datea
  from BARS.FIN_CUST',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Незарег.Клиенты в анализе Фин.стану', '2.0');


-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 1, 'KF', 'Код філіалу (МФО)', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 2, 'OKPO', 'ОКПО(числовое) или РНК', 'VARCHAR2', 14, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 3, 'NMK', 'Наименование клиента', 'VARCHAR2', 38, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 4, 'CUSTTYPE', 'ОКПО(числовое) или РНК', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 5, 'FZ', 'Форма звiту=" " или M(лат)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
--Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
-- Values   (565, 6, 'BRANCH', 'Код безбалансового відділення', 'VARCHAR2', 30, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 7, 'ISP', 'Ответ.Исполнитель в банке', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 8, 'VED', NULL, 'CHAR', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (565, 9, 'DATEA', 'Дата реєстрації підприемства', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

--Insert into UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (565, 'fin_cust(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (565, 'fin_cust(CUSTTYPE)_$_custtype(CUSTTYPE)', 1, 288);
Insert into UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (565, 'fin_cust(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values   (565, 'fin_cust(VED)_$_ved(VED)', 1, 421);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

--Insert into UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (565, 'fin_cust(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (565, 'fin_cust(CUSTTYPE)_$_custtype(CUSTTYPE)', 1, 'CUSTTYPE');
Insert into UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (565, 'fin_cust(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values   (565, 'fin_cust(VED)_$_ved(VED)', 1, 'VED');

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
