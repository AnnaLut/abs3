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
-- COBUMMFO-8636   Просимо додати новий файл OW_ATRN_HIST в щоденне вивантаження для сховища даних. Оновлення стосується і ММФО і Міленіуму
-- привязка к группам выгрузки
-- TSK-0000185 UPL - удалить лишний символ перевода каретки в поле TRANS_INFO в файле ow_atrn_hist
-- удалить ссылку на oper
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (331);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (331, 'select distinct 4 as type, h.id, h.idn, h.kf, h.ref, h.doc_drn, h.doc_orn,
       h.credit_amount*100 as cred_amt, h.credit_currency as cred_curr, h.anl_synthcode, 
       replace(h.trans_info, chr(10)||chr(13)||chr(9), ''   '') trans_info
  from BARS.OPLDOK d
  inner join bars.OW_OIC_ATRANSFERS_HIST h on (h.ref = d.ref and h.kf = d.kf)
  inner join bars.accounts a on A.ACC = d.acc and A.NBS in (''2625'', ''2620'', ''2605'', ''2600'', ''2655'', ''2650'', ''2904'')
  where d.sos = 5 and d.fdat = to_date(:param1,''dd/mm/yyyy'')', 'begin barsupl.bars_upload_usr.tuda; end;',
  NULL, 'OpenWay. Імпортовані файли atransfers', '1.1');

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
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (331);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (331, 'owtrnh(CRED_CURR)_$_tabval(KV)', 1, 296);
--Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (331, 'owtrnh(REF,KF)_$_oper(REF,KF)', 1, 196);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (331);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (331, 'owtrnh(CRED_CURR)_$_tabval(KV)', 1, 'CRED_CURR');
--Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (331, 'owtrnh(REF,KF)_$_oper(REF,KF)', 2, 'KF');
--Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (331, 'owtrnh(REF,KF)_$_oper(REF,KF)', 1, 'REF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (331);

Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (1, 331,  331);
Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (2, 331,  331);
Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (3, 331,  331);
Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (4, 331,  331);

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


