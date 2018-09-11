-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 218
--define ssql_id  = 218,1218

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 218');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (218))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 218,1218');
end;
/
-- ***************************************************************************
-- ETL-25581  UPL - добавить выгрузку нового файла intratef - со ставками для ACC, которые установлены будущей датой
-- ETL-25154  ANL - параметр "тип процентной ставки по счету, код процентной ставки, название процентной ставки" (Калошина)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (218,1218);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (218, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select kf, acc, id, bdat, ir, br, op, chgaction
  from ( select /*+ full(i) parallel (i 12) */ i.kf, i.acc, i.id, i.bdat, i.ir, i.br, i.op, i.vid as chgaction,
                row_number() over (partition by i.acc, i.id, trunc(i.bdat) order by idupd desc) rn
           from bars.int_ratn_arc i, dt
          where i.id in (0, 1)
            and i.EFFECTDATE   <= dt.dt2 )
 where rn = 1',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'История изменений % ставок', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1218, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select kf, acc, id, bdat, ir, br, op, chgaction
  from ( select i.kf, i.acc, i.id, i.bdat, i.ir, i.br, i.op, i.vid as chgaction,
                row_number() over (partition by i.acc, i.id, trunc(i.bdat) order by idupd desc) rn
           from bars.int_ratn_arc i, dt
          where i.id in (0, 1)
            and i.GLOBAL_BDATE >= dt.dt1
            and i.EFFECTDATE   <= dt.dt2 )
 where rn = 1',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'История изменений % ставок', '1.0');


--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (218);
Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (218, 218, 'INT_RATN', 'int_ratn', 0, '09', NULL, '10', 0, 'История изменений % ставок', 218, 'null', 'DELTA', 'EVENT', 1, NULL, 1, NULL, 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (218);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 1, 'ACC', 'Идентификатор счета', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 2, 'ID', 'идентификатор типа начисления %', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 3, 'BDAT', 'Дата установки', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 4, 'IR', 'индивидуальная % ставка', 'NUMBER', 22, 12, '999999999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 5, 'BR', 'базовая % ставка', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 6, 'OP', 'операция, между IR и BR', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (218, 7, 'CHGACTION', 'Вид модификации', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (218);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (218, 'intrtn(ACC, KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (218, 'intrtn(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (218, 'intrtn(BR)_$_brates(BR_ID)', 1, 219);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (218);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (218, 'intrtn(ACC, KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (218, 'intrtn(ACC, KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (218, 'intrtn(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (218, 'intrtn(BR)_$_brates(BR_ID)', 1, 'BR');



-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (218);
Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 218,  218);
Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 218, 1218);
Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 218,  218);
Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 218, 1218);

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
