-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 580
--define ssql_id  = 580

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 580');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (580))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 580');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- SMB_RATES
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************

delete from BARSUPL.UPL_SQL where SQL_ID IN (580);

declare l_clob clob;
begin
l_clob:= to_clob('with  dt as ( select /*+ materialize */
                     bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                     to_date (:param1, ''dd/mm/yyyy'') dt2,
                     bars.gl.kf,
                     BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1) - to_date (:param1, ''dd/mm/yyyy'') last_work_day
                from dual )
select o.type_id as nd_type,
       o.object_id as nd,
       o.kf,
       dt.dt2 as bdat,
       --coalesce(barsupl.get_interest_rate(o.object_id, dt.dt2), 0) as ir1,
       coalesce(bars.get_smb_interest_rate_for_dwh(o.object_id, dt.dt2), 0) as ir,
       p.calculation_type
  from dt,
       barsupl.tmp_upl_dm_objects o
  join bars.smb_deposit p on (p.id = o.object_id)
 where o.type_id = 25               /* только для депозитов по требованию */
   and lnnvl(o.close_date < dt.dt2) /* (o.close_date is null or o.close_date >= dt.dt2) */
   and o.START_DATE <= dt.dt2
   and lnnvl(p.is_individual_rate = 1) /* (p.is_individual_rate is null or p.is_individual_rate = 0) */
   and (
       (     p.calculation_type = 2 /* с типом 2 считать только за последний день месяца или при закрытии/завершении */
        and (dt.last_work_day = 0
         or  o.close_date = dt.dt2
         or  o.expiry_date = dt.dt2))
    or lnnvl(p.calculation_type = 2)
       )');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (580, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, '% ставки депозитов ММСБ', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************

delete from BARSUPL.UPL_FILES where FILE_ID IN (580);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (580, 580, 'SMB_RATES', 'smb_rates', 0, '09', NULL, '10', 0, '% ставки депозитів ММСБ', 580, 'null', 'DELTA', 'EVENT', 1, NULL, 1, 'SMB_RATES', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (580);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (580, 1, 'ND_TYPE', 'Вид угоди', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (580, 2, 'ND', 'Ідентифікатор угоди', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (580, 3, 'KF', 'Код філіалу', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (580, 4, 'BDAT', 'Звітна дата', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '01.01.0001', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (580, 5, 'IR', '% ставка', 'NUMBER', 38, 30, 'fm99999990D000000000000000000000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (580, 6, 'CALC_TYPE', 'Тип нарахування', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (580);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (580, 'smbrates(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (580, 'smbrates(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 1, 571);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (580);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (580, 'smbrates(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (580, 'smbrates(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (580, 'smbrates(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (580, 'smbrates(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (580);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (1, 580, 580);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (2, 580, 580);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (3, 580, 580);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (4, 580, 580);
