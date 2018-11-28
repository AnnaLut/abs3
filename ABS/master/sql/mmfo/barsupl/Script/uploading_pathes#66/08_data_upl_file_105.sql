-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 105
--define ssql_id  = 105,1105

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 105');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (105))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 105,1105');
end;
/
-- ***************************************************************************
-- TSK-0001458 - UPL - выгрузить два новых параметра КД
--  день погашения кредита
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (105,1105);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (105, 'select acc, id , acra, bars.gl.kf, stp_dat, chgaction, acr_dat, apl_dat, s
from bars.int_accn_update
where idupd in (select max(idupd)
                  from bars.int_accn_update
                 where coalesce(acra,-9999) <> 0
                   and id in (0, 1)
                   and EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                   group by acc, id
               )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок рахунку з рахунком нарахування відсотків', '4.3');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1105, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select acc, id , acra, bars.gl.kf, stp_dat, chgaction, acr_dat, apl_dat, s
        from bars.int_accn_update
        where idupd in (select max(idupd)
                          from bars.int_accn_update, dt
                         where coalesce(acra,-9999) <> 0
                           and id in (0, 1)
                           and EFFECTDATE <= dt2
                           and GLOBAL_BDATE >= dt1
                           group by acc, id
                       )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок рахунку з рахунком нарахування відсотків', '4.5');

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (105);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (105);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 1, 'ACC', 'Внутрішній номер рахунку', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 2, 'ID', 'Код виду відсоткової ставки', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 3, 'ACRA', 'Рахунок нарахування відсотків', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 4, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 5, 'STPDATE', 'Дата закінчення нарахування відсотків', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 6, 'CHGACTION', 'Код оновлення (I/U/D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 7, 'ACR_DAT', 'Дата останнього нарахування', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01/01/0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 8, 'APL_DAT', 'Дата останньї виплати', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01/01/0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (105, 9, 'S', 'Сумма документа/День платежа', 'NUMBER', 38, 30, '99999990D000000000000000000000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);



-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (105);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (105);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (105);

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
