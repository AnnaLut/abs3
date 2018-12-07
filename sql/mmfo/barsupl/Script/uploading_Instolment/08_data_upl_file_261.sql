-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 261
--define ssql_id  = 261

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 261');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (261))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 261');
end;
/
-- ***************************************************************************
-- TSK-0000806 ANL - анализ выгрузки кредита рассрочка (instalment)
-- COBUINST-14   Вивантаження даних для СД по продукту Instalment
-- Добавить новый тип договоров 23-'Договори Instolment під БПК'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (261);

declare l_clob clob;
begin
l_clob:= to_clob('select 1  "TYPE_ID", ''Депозити ФО'' "DESCRIPT" from dual
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
 union all
select 23, ''Договори Instolment під БПК'' from dual');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values  (261, l_clob, NULL, NULL, 'Види угод', '3.9');

end;
/


-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (261);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (261);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (261);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (261);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (261);

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
