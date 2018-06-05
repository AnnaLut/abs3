-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов дл€ файла выгрузки (список через зап€тую, без пробелов)
--define sfile_id = 266
--define ssql_id  = 266

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 266');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (266))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 266');
end;
/

-- ***************************************************************************
-- ETL-24572       UPL - добавить в выгрузку файл по мес€чному снимоку баланса
-- COBUMMFO-7936   ѕросимо додати до вивантаженн€ м≥с€чний зн≥мок балансу в зв'€зку з впровадженн€м IFRS9. ƒоопрацюванн€ стосуЇтьс€ ћћ‘ќ ≥ ћ≥лен≥уму.
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (266);

Insert into UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (266, 'select bars.gl.kf as KF, a.FDAT, a.ACC, a.RNK, a.OST, a.DOS, a.KOS, a.OSTQ, a.DOSQ, a.KOSQ,
       a.CRDOS, a.CRDOSQ, a.CRKOS, a.CRKOSQ, a.CUDOS, a.CUDOSQ, a.CUKOS, a.CUKOSQ
  from BARS.AGG_MONBALS a
 where a.FDAT = TO_DATE(:param1,''dd/mm/yyyy'')', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Ќакопительные балансы за мес€ц', '1.0');


-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (266);

Insert into UPL_FILES (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values   (266, 266, 'MONBALS', 'monbals', 0, '09', NULL, '10', 0, 'ћес€чный снимок балансов', 17, 'null', 'DELTA', 'GL', 1, NULL, 1, 'monbals', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (266);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 0, 'KF', ' од фiлiалу (ћ‘ќ)', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 1, 'FDAT', 'ƒата балансу', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 2, 'ACC', '≤д. рахунка', 'NUMBER', 24, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 3, 'RNK', '≤д. кл≥Їнта', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 4, 'OST', '¬их≥дний залишок по рахунку (ном≥нал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 5, 'DOS', '—ума дебетових оборот≥в (ном≥нал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 6, 'KOS', '—ума кредитових оборот≥в (ном≥нал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 7, 'OSTQ', '¬их≥дний залишок по рахунку (екв≥валент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 8, 'DOSQ', '—ума дебетових оборот≥в (екв≥валент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 9, 'KOSQ', '—ума кредитових оборот≥в (екв≥валент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 10, 'CRDOS', '—ума корегуючих дебетових  оборот≥в (ном≥нал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 11, 'CRDOSQ', '—ума корегуючих дебетових  оборот≥в (екв≥валент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 12, 'CRKOS', '—ума корегуючих кредитових оборот≥в (ном≥нал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 13, 'CRKOSQ', '—ума корегуючих кредитових оборот≥в (екв≥валент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 14, 'CUDOS', '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (ном≥нал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 15, 'CUDOSQ', '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (екв≥валент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 16, 'CUKOS', '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (ном≥нал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (266, 17, 'CUKOSQ', '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (екв≥валент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (266);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (266, 'monbals(ACC,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (266, 'monbals(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (266, 'monbals(KF)_$_banks(KF)', 2, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (266, 'monbals(RNK)_$_customer(RNK)', 3, 121);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (266);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (266, 'monbals(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (266, 'monbals(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (266, 'monbals(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (266, 'monbals(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (266, 'monbals(RNK)_$_customer(RNK)', 1, 'RNK');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (266) and group_id != 99;

Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 266, 266);

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
