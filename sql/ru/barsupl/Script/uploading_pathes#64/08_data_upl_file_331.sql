-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 331
--define ssql_id  = 331

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 331');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (331))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 331');
end;
/

-- ***************************************************************************
-- ETL-24516 UPL - изменить выгрузку OW_OIC_ATRANSFERS_HIST (добавить фильтр по балансовым)
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (331);

declare l_clob clob;
begin
l_clob:= to_clob('select distinct 4 as type, h.id, h.idn, h.kf, h.ref, h.doc_drn, h.doc_orn, h.credit_amount*100 as cred_amt, h.credit_currency as cred_curr, h.anl_synthcode, h.trans_info
  from BARS.OPLDOK d 
  inner join bars.OW_OIC_ATRANSFERS_HIST h on (h.ref = d.ref and h.kf = d.kf)
  inner join bars.accounts a on A.ACC = d.acc and A.NBS in (''2625'', ''2620'', ''2605'', ''2600'', ''2655'', ''2650'', ''2904'')
  where d.sos = 5 and d.fdat = to_date(:param1,''dd/mm/yyyy'')');
Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
Values (331, l_clob, 'begin barsupl.bars_upload_usr.tuda; end;', NULL, 'OpenWay. Імпортовані файли atransfers', '1.0');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (331);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (331);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (331);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (331);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (331);

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

--322669	453068243
--302076	11393063
--311647	29875450
--337568	24383789
--335106	101317124
--325796	53920950
--354507	6589188
--313957	24966274
--353553	27735809
--352457	14214322
--300465	59110901
--351823	83243032
--304665	43681167
--328845	17709429
--324805	418121

