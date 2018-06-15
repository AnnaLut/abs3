-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 267
--define ssql_id  = 267

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 267');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (267))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 267');
end;
/

-- ***************************************************************************
-- ETL-24571 UPL - добавить в выгрузку файл по месячному снимоку баланса - трансформированному после внедрения IFRS 9
-- COBUMMFO-7942  Просимо додати до вивантаження місячний знімок балансу - трансформованний після впровадження IFRS9. Доопрацювання стосується ММФО і Міленіуму.
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (267);

Insert into UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (267, 'select bars.gl.kf as KF, a.FDAT, a.ACC, a.RNK, a.OST, a.DOS, a.KOS, a.OSTQ, a.DOSQ, a.KOSQ,
       a.CRDOS, a.CRDOSQ, a.CRKOS, a.CRKOSQ, a.CUDOS, a.CUDOSQ, a.CUKOS, a.CUKOSQ, a.DOS9, a.DOSQ9, a.KOS9, a.KOSQ9, a.KV
  from BARS.AGG_MONBALS9 a
 where a.FDAT = TO_DATE(:param1,''dd/mm/yyyy'')', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Накопительные балансы за месяц IFRS9', '1.0');



-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (267);

Insert into UPL_FILES (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values   (267, 267, 'MONBALS9', 'monbals9', 0, '09', NULL, '10', 0, 'Месячный снимок балансов IFRS9', 17, 'null', 'DELTA', 'GL', 1, NULL, 1, 'monbals9', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (267);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 0, 'KF', 'Код фiлiалу (МФО)', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 1, 'FDAT', 'Дата балансу', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 2, 'ACC', 'Ід. рахунка', 'NUMBER', 24, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 3, 'RNK', 'Ід. клієнта', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 4, 'OST', 'Вихідний залишок по рахунку (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 5, 'DOS', 'Сума дебетових оборотів (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 6, 'KOS', 'Сума кредитових оборотів (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 7, 'OSTQ', 'Вихідний залишок по рахунку (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 8, 'DOSQ', 'Сума дебетових оборотів (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 9, 'KOSQ', 'Сума кредитових оборотів (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 10, 'CRDOS', 'Сума корегуючих дебетових  оборотів (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 11, 'CRDOSQ', 'Сума корегуючих дебетових  оборотів (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 12, 'CRKOS', 'Сума корегуючих кредитових оборотів (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 13, 'CRKOSQ', 'Сума корегуючих кредитових оборотів (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 14, 'CUDOS', 'Сума корегуючих дебетових  оборотів минулого місяця (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 15, 'CUDOSQ', 'Сума корегуючих дебетових  оборотів минулого місяця (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 16, 'CUKOS', 'Сума корегуючих кредитових оборотів минулого місяця (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 17, 'CUKOSQ', 'Сума корегуючих кредитових оборотів минулого місяця (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 18, 'DOS9', 'Сума дебетових оборотів МСФЗ 9 (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 19, 'DOSQ9', 'Сума дебетових оборотів МСФЗ 9 (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 20, 'KOS9', 'Сума кредитових оборотів МСФЗ 9 (номінал)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 21, 'KOSQ9', 'Сума кредитових оборотів МСФЗ 9 (еквівалент)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (267, 22, 'KV', 'Код валюты', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (267);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (267, 'monbals9(ACC,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (267, 'monbals9(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (267, 'monbals9(KF)_$_banks(KF)', 2, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (267, 'monbals9(RNK)_$_customer(RNK)', 3, 121);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (267, 'monbals9(KV)_$_tabval(KV)', 3, 296);


-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (267);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (267, 'monbals9(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (267, 'monbals9(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (267, 'monbals9(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (267, 'monbals9(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (267, 'monbals9(RNK)_$_customer(RNK)', 1, 'RNK');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (267, 'monbals9(KV)_$_tabval(KV)', 1, 'KV');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (267) and group_id != 99;

Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 267, 267);

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
