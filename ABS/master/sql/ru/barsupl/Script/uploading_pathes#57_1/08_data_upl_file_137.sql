-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 137
define ssql_id  = 137

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
-- ETL-20823 -UPL - выгрузить из АБС в ХД параметры договора/счёта для IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, Ринкова ставка (INTRT), Референс реструкт.договору (ND_REST) с соответствующими справочниками
-- выгружать только теги без справочников
-- существующий cprefw не использовался, а параметры (VSTRO, PORTF) выгружаются в cp_deal поэтому isuse для этих тегов установлено = 0
-- поскольку CP_REFW не имеет полик и поля KF - в связку добавлена таблица CP_DEAL_UPDATE
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (137, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from barsupl.upl_tag_lists where tag_table = ''CP_TAGS'' and coalesce(ref_id, 0) = 0 and isuse = 1 )
select cw.REF, cw.TAG, cw.VALUE, bars.gl.kf kf, 9 nd_type
  from bars.cp_deal_update cp
  join bars.cp_refw cw on ( cw.ref = cp.ref )
  join tg on ( tg.tag = cw.tag )
 where cp.idupd in ( select MAX(idupd)
                       from bars.cp_deal_update, dt
                      where EFFECTDATE <= dt.dt2
                        and ACTIVE <> 0
                      group by ref )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Додаткові реквізити договорів ЦП', '2.0');


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
   (137, 137, 'CP_REFW', 'cprefw', 0, '09', NULL, '10', 0, 'Додаткові реквізити договорів ЦП', 76, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'cprefw', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (137, 1, 'ND', 'Номер договора(REF сделки по ЦБ)', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (137, 2, 'TAG', 'ТЭГ -мнем.код доп.реквизита', 'VARCHAR2', 10, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (137, 3, 'VALUE', 'Значение доп.реквизита', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (137, 4, 'KF', 'Код филиала', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (137, 5, 'ND_TYPE', 'Тип номера договора (для ключей)', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (137, 'cprefw(KF)_$_banks(KF)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (137, 'cprefw(TAG,KF)_$_cptag(TAG,KF)', 1, 136);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (137, 'cprefw(TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 1, 146);


-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (137, 'cprefw(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (137, 'cprefw(TAG,KF)_$_cptag(TAG,KF)', 1, 'TAG');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (137, 'cprefw(TAG,KF)_$_cptag(TAG,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (137, 'cprefw(TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (137, 'cprefw(TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (137, 'cprefw(TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

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
