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
-- ETL-22841   UPL - выгрузить для загрузки в миррор OW_OIC_ATRANSFERS_HIST
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (331);

--Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
-- Values
--   (331, 'select 4 as type, h.id, h.idn, h.kf, h.ref, h.doc_drn, h.doc_orn, h.credit_amount*100 as cred_amt, h.credit_currency as cred_curr, h.anl_synthcode, h.trans_info
--  from bars.OW_OIC_ATRANSFERS_HIST h
-- where (DOC_DRN, ref) in (  select distinct o.value, d.ref
--                              from BARS.OPLDOK d
--                                   join bars.accounts a     on (a.acc = d.acc)
--                                   join bars.operw o on (d.ref = o.ref)
--                             where d.fdat = to_date(:param1,''dd/mm/yyyy'')
--                               and d.sos = 5
--                               and o.tag = ''OWDRN''
--                               --and a.nbs in (''2625'', ''2605'', ''2655'', ''2620'', ''2600'', ''2650'', ''2924'')
--                                   --or (a.nbs in (''2924'') and a.nls like ''1'' || ''%''))
--                         )',
--'begin barsupl.bars_upload_usr.tuda; end;', NULL, 'OpenWay. Імпортовані файли atransfers', '1.0');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (331, 'select /*+ INDEX(h PIDX_KF_REF_OWHIST) */
       distinct 4 as type, h.id, h.idn, h.kf, h.ref, h.doc_drn, h.doc_orn, h.credit_amount*100 as cred_amt, h.credit_currency as cred_curr, h.anl_synthcode, h.trans_info
  from (select ref, kf from BARS.OPLDOK d where sos = 5 and fdat = to_date(:param1,''dd/mm/yyyy'') ) d
  join bars.OW_OIC_ATRANSFERS_HIST h on (h.ref = d.ref and h.kf = d.kf)',
'begin barsupl.bars_upload_usr.tuda; end;', NULL, 'OpenWay. Імпортовані файли atransfers', '1.0');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (331);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (331, 331, 'OW_ATRN_HIST', 'ow_atrn_hist', 0, '09', NULL, '10', 0, 'OpenWay. Імпортовані файли atransfers', 331, 'null', 'DELTA', 'EVENT', 1, NULL, 1, 'owatrnhist', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (331);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 0, 'TYPE', 'Вид угоди', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 1, 'ID', 'ID atransfers', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 2, 'IDN', 'Номер рядка', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 3, 'KF', 'Код філії', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 4, 'REF', 'Референс документу АБС', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 5, 'DOC_DRN', 'Исходный документ в OW', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 6, 'DOC_ORN', 'Operation reference number OW', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 7, 'CRED_AMT', 'Сумма документа в OW', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 8, 'CRED_CURR', 'Валюта документа в OW', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
 Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 9, 'ANL_SYNTHCODE', 'Синтет. код операції OW', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (331, 10, 'TRANS_INFO', 'Додаткова інформація', 'VARCHAR2', 4000, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (331);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (331, 'owtrnh(REF,KF)_$_oper(REF,KF)', 1, 196);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (331, 'owtrnh(CRED_CURR)_$_tabval(KV)', 1, 296);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (331);

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (331, 'owtrnh(REF,KF)_$_oper(REF,KF)', 1, 'REF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (331, 'owtrnh(REF,KF)_$_oper(REF,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (331, 'owtrnh(CRED_CURR)_$_tabval(KV)', 1, 'CRED_CURR');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (331);

-- включаем только в группу 99
--Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values  (1, 331, 331);
--Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values  (2, 331, 331);
--Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values  (3, 331, 331);
--Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values  (4, 331, 331);



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
