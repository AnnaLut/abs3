-- ***************************************************************************
set verify off
set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 570
define ssql_id  = 570,1570

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
-- ETL-22476 UPL - изменить выгрузку данных по финотчетности (агрегированная отчетность)
--
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (570, 'select bars.gl.kf as KF, to_char(to_number(c.okpo),''fm99999999999999'') OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
  from BARS.FIN_CALCULATIONS f, bars.customer c
  where f.rnk=c.rnk
  group by bars.gl.kf, to_char(to_number(c.okpo),''fm99999999999999'') , f.DAT
union all   
select bars.gl.kf as KF, to_char(to_number(c.okpo),''fm99999999999999'') OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
  from BARS.FIN_CALCULATIONS f, bars.FIN_cust c
  where - f.rnk=to_number(c.okpo)
  group by bars.gl.kf, to_char(to_number(c.okpo),''fm99999999999999'') , f.DAT 
', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'История изменения формы отчета клиента "Агрегована звітність"', '1.0');

 
 Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1570, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select bars.gl.kf as KF, to_char(to_number(c.okpo),''fm99999999999999'') OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
  from BARS.FIN_CALCULATIONS f, bars.customer c, dt dt
  where f.rnk=c.rnk and f.rnk>0
  and f.FDAT> = dt.dt1 
  group by bars.gl.kf, to_char(to_number(c.okpo),''fm99999999999999'') , f.DAT
union all   
select bars.gl.kf as KF, to_char(to_number(c.okpo),''fm99999999999999'') OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
  from BARS.FIN_CALCULATIONS f, bars.FIN_cust c, dt dt
  where - f.rnk=to_number(c.okpo) and f.rnk<0
  and f.FDAT> = dt.dt1
  group by bars.gl.kf, to_char(to_number(c.okpo),''fm99999999999999'') , f.DAT 
', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'История изменения формы отчета клиента "Агрегована звітність" (дельта)', '1.0');

 --declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, 
    order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (570, 570, 'FIN_CALC', 'fin_calc', 0, '09', NULL, '10', 0, 'История изменения формы отчета клиента "Агрегована звітність" ', 
    570, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, NULL, 1, 1);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (570, 1, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 0, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (570, 2, 'OKPO', 'ОКПО клієнта', 'CHAR', 10, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (570, 3, 'DAT', 'Звітна дата', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (570, 4, 'FDAT', 'Дата формування', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (570, 5, 'DATD', 'Дата та час розрахунку', 'DATE', 14, NULL, 'ddmmyyyyhh24miss', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);



-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (1, 570,  570);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (2, 570, 1570);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (3, 570,  570);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (4, 570, 1570);


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
