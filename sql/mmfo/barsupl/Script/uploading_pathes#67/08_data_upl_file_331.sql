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
-- TSK-0003185 UPL - змінити вигрузку OW_ATRN_HIST
--  У вигрузку файлу OW_ATRN_HIST добавити нові поля  CREDIT_ANLACCOUNT, DEBIT_ANLACCOUNT.
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (331);

declare l_clob clob;
begin
l_clob:= to_clob('select distinct 4 as type, h.id, h.idn, h.kf, h.ref, h.doc_drn, h.doc_orn,
       h.credit_amount*100 as cred_amt, h.credit_currency as cred_curr, h.anl_synthcode,
       h.credit_anlaccount as cred_anl, h.debit_anlaccount as deb_anl,
       translate(h.trans_info, chr(10)||chr(13)||chr(9), ''   '') trans_info
  from BARS.OPLDOK d
 inner join bars.OW_OIC_ATRANSFERS_HIST h on (h.ref = d.ref and h.kf = d.kf)
 inner join bars.accounts a on A.ACC = d.acc and A.NBS in (''2625'', ''2620'', ''2605'', ''2600'', ''2655'', ''2650'', ''2904'')
 where d.sos = 5 and d.fdat = to_date(:param1,''dd/mm/yyyy'')');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (331, l_clob, 'begin barsupl.bars_upload_usr.tuda; end;', NULL, 'OpenWay. Імпортовані файли atransfers', '1.3');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (331);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (331);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 0, 'TYPE', 'Вид угоди', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 1, 'ID', 'ID atransfers', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 2, 'IDN', 'Номер рядка', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 3, 'KF', 'Код філії', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 4, 'REF', 'Референс документу АБС', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 5, 'DOC_DRN', 'Исходный документ в OW', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 6, 'DOC_ORN', 'Operation reference number OW', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 7, 'CRED_AMT', 'Сумма документа в OW', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 8, 'CRED_CURR', 'Валюта документа в OW', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 9, 'ANL_SYNTHCODE', 'Синтет. код операції OW', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 10, 'CRED_ANL', 'Счет кредита', 'VARCHAR2', 30, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 11, 'DEB_ANL', 'Счет дебета', 'VARCHAR2', 30, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 12, 'TRANS_INFO', 'Додаткова інформація', 'VARCHAR2', 4000, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);


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
