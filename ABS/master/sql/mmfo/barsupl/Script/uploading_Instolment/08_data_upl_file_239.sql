-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 239
--define ssql_id  = 239,1239

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 239');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (239))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 239,1239');
end;
/
-- ***************************************************************************
-- TSK-0000806 ANL - анализ выгрузки кредита рассрочка (instalment)
-- COBUINST-14   Вивантаження даних для СД по продукту Instalment
-- новый 'Зв'язок рахунків з угодами Інстолмент'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (239,1239);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (239, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select p.CHAIN_IDT as ND, p.ACC, p.KF, 23 as ND_TYPE, p.CHGACTION
  from ( select u.*, row_number() over (partition by u.CHAIN_IDT, u.ACC order by u.idupd desc) rn
           from bars.w4_acc_inst_update u, dt
          where u.EFFECTDATE <= dt.dt2
       ) p
 where rn = 1',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Зв''язок рахунків з угодами Інстолмент', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1239, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select p.CHAIN_IDT as ND, p.ACC, p.KF, 23 as ND_TYPE, p.CHGACTION
  from ( select u.*, row_number() over (partition by u.CHAIN_IDT, u.ACC order by u.idupd desc) rn
           from bars.w4_acc_inst_update u, dt
          where u.GLOBALBD   >= dt.dt1
            and u.EFFECTDATE <= dt.dt2
       ) p
 where rn = 1',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Зв''язок рахунків з угодами Інстолмент', '1.0');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (239);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id,
    nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (239, 239, 'ARRACC7', 'arracc7', 0, '09', NULL, '10', 0, 'Зв''язок рахунків з угодами Інстолмент', 239, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'arraccrln', 1, 1);



-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (239);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (239, 1, 'ND', 'Номер договора', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (239, 2, 'ACC', 'Внутренний номер счета', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (239, 3, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (239, 4, 'ND_TYPE', 'Тип договора', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (239, 5, 'CHGACTION', 'Тип изменений', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (239);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (239, 'arracc7(ACC,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (239, 'arracc7(KF)_$_banks(KF)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (239, 'arracc7(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 1, 237);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (239);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (239, 'arracc7(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (239, 'arracc7(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (239, 'arracc7(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (239, 'arracc7(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (239, 'arracc7(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (239, 'arracc7(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (239);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 239,  239);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 239, 1239);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 239,  239);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 239, 1239);

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
