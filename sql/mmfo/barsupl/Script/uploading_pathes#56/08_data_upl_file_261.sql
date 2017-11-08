-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 261
define ssql_id  = 261

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
-- ETL-19880  UPL - изменение в выгрузке файлов bpkproect (327) и acc_pkprct (329)
-- NEW TYPE: 22, 'Зарплатный проект'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (261, 
'select 1  "TYPE_ID", ''Депозити ФО'' "DESCRIPT" from dual
 union all
select 2, ''Депозити ЮО'' from dual
 union all
select 3, ''Кредити''  from dual
 union all
select 4, ''БПК'' from dual
 union all
select 5, ''Забезпечення'' from dual
 union all
select 6, ''Текущие счета'' from dual
 union all
select 7, ''Транши'' from dual
 union all
select 8, ''Казначейство'' from dual
 union all
select 9, ''Ценные бумаги'' from dual
 union all
select 10, ''Овердрафты'' from dual
 union all
select 11, ''Договора РКО'' from dual
 union all
select 12, ''Договора абонплати'' from dual
 union all
select 13, ''Віртуальні субдоговора КП'' from dual
 union all
select 14, ''Документарні операції'' from dual
 union all
select 15, ''Дебіторська заборгованістості'' from dual
 union all
select 16, ''Віртуальні субдоговора БПК'' from dual
 union all
select 17, ''Віртуальні договора Фін. Дебіторки'' from dual
 union all
select 18, ''Депозитні сейфи'' from dual
 union all
select 19, ''Депозити КД'' from dual
 union all
select 20, ''Договори страхування'' from dual
 union all
select 21, ''Договори ГДЗ'' from dual
 union all
select 22, ''Зарплатні проекти'' from dual
', NULL, NULL, 'Види угод', 
    '3.8');

-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************



