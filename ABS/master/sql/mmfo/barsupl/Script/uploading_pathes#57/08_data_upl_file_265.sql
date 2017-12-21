-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 265
define ssql_id  = 265,1265

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
-- ETL-20949 - UPL - выгрузить файл с оборотами, которые должны включиться в файл #02 в результате смены балансовых счетов
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (265, 'select to_char(n.KF), n.REPORT_DATE, n.CUST_ID, n.ACC_ID, n.ACC_NUM, n.KV, n.ACC_OB22, n.ACC_TYPE, n.DOS_BAL, n.DOSQ_BAL, n.KOS_BAL, n.KOSQ_BAL, n.OST_BAL,
       n.OSTQ_BAL, n.DOS_REPD, n.DOSQ_REPD, n.KOS_REPD, n.KOSQ_REPD, n.DOS_REPM, n.DOSQ_REPM, n.KOS_REPM, n.KOSQ_REPM, n.OST_REP, n.OSTQ_REP
  from BARS.NBUR_KOR_BALANCES n
 where REPORT_DATE <= to_date(:param1,''dd/mm/yyyy'')',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Таблиця для переходу на новий план рахунків', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1265, 'select to_char(n.KF), n.REPORT_DATE, n.CUST_ID, n.ACC_ID, n.ACC_NUM, n.KV, n.ACC_OB22, n.ACC_TYPE, n.DOS_BAL, n.DOSQ_BAL, n.KOS_BAL, n.KOSQ_BAL, n.OST_BAL,
       n.OSTQ_BAL, n.DOS_REPD, n.DOSQ_REPD, n.KOS_REPD, n.KOSQ_REPD, n.DOS_REPM, n.DOSQ_REPM, n.KOS_REPM, n.KOSQ_REPM, n.OST_REP, n.OSTQ_REP
  from BARS.NBUR_KOR_BALANCES n
 where REPORT_DATE = to_date(:param1,''dd/mm/yyyy'')',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Таблиця для переходу на новий план рахунків', '1.0');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (265, 265, 'KORBAL', 'korbal', 0, '09', NULL, '10', 0, 'Таблиця для переходу на новий план рахунків', 17, 'null', 'DELTA', 'GL', 1, NULL, 1, 'korbal', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 0, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 1, 'REPORT_DATE', 'Звітна дата (дата переходу на нові БР)', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 1, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 3, 'CUST_ID', 'Ід. клієнта', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 3, 'TRUNC_E2');
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 4, 'ACC_ID', 'Ід. рахунку', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4, 'TRUNC_E2');
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 5, 'ACC_NUM', 'Номер рахунку', 'VARCHAR2', 15, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 5, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 6, 'KV', 'Код валюти', 'NUMBER', 3, 0, NULL, 'Y', 'N', NULL, NULL, '0', 6, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 7, 'ACC_OB22','ОВ22 рахунку', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 8, 'ACC_TYPE', 'Старий/Новий', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 9, 'DOS_BAL', 'Сума реальних деб. оборотів (ном) в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 10, 'DOSQ_BAL', 'Сума реальних деб. оборотів (екв) в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 11, 'KOS_BAL', 'Сума реальних кред. оборотів (ном) в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 12, 'KOSQ_BAL', 'Сума реальних кред. оборотів (екв) в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 13, 'OST_BAL', 'Залишок (ном) в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 14, 'OSTQ_BAL', 'Залишок (екв) в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 15, 'DOS_REPD', 'Сума деб. оборотів (ном) для щоденного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 16, 'DOSQ_REPD', 'Сума деб. оборотів (екв) для щоденного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 17, 'KOS_REPD', 'Сума кред. оборотів (ном) для щоденного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 18, 'KOSQ_REPD', 'Сума кред. оборотів (екв) для щоденного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 19, 'DOS_REPM', 'Сума деб. оборотів (ном) для місячного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 20, 'DOSQ_REPM', 'Сума деб. оборотів (екв) для місячного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 21, 'KOS_REPM', 'Сума кред. оборотів (ном) для місячного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 22, 'KOSQ_REPM', 'Сума кред. оборотів (екв) для місячного звіту в день переходу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 23, 'OST_REP', 'Залишок (ном) для звіту', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (265, 24, 'OSTQ_REP', 'Залишок (екв) lkz pdsne ', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (265, 'korbal(ACC_ID,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (265, 'korbal(KF)_$_banks(MFO)', 2, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (265, 'korbal(KV)_$_tabval(KV)', 3, 296);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (265, 'korbal(CUST_ID,KF)_$_custmer(RNK,KF)', 1, 121);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (265, 'korbal(ACC_ID,KF)_$_account(ACC,KF)', 1, 'ACC_ID');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (265, 'korbal(ACC_ID,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (265, 'korbal(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (265, 'korbal(KV)_$_tabval(KV)', 1, 'KV');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (265, 'korbal(CUST_ID,KF)_$_custmer(RNK,KF)', 1, 'CUST_ID');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (265, 'korbal(CUST_ID,KF)_$_custmer(RNK,KF)', 2, 'KF');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

--Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 265,  265);
--Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 265, 1265);
--Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 265,  265);
--Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 265, 1265);

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
