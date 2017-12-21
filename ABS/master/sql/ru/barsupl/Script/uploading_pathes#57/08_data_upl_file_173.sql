-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 173
define ssql_id  = 173,1173,2173

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
-- Новый файл параметров счетов со справочниками
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (173, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) != 0)
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction, tg.ref_id
  from BARS.ACCOUNTSW_UPDATE u join tg on (tg.tag = u.tag)
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg on ( tg.tag = u1.tag )
                     where u1.effectdate <= dt.dt2
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Значение доп. реквизитов счета со справочником', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1173, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) != 0)
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction, tg.ref_id
  from BARS.ACCOUNTSW_UPDATE u join tg on (tg.tag = u.tag)
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg on ( tg.tag = u1.tag )
                     where u1.effectdate between dt.dt1 and dt.dt2
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Значение доп. реквизитов счета со справочником', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2173, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_d as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) != 0 and tag != ''DATEOFKK''),
   tg_f as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) != 0 and tag  = ''DATEOFKK'')
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction, tg_d.ref_id
  from BARS.ACCOUNTSW_UPDATE u join tg_d on (tg_d.tag = u.tag)
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg_d on ( tg_d.tag = u1.tag )
                     where u1.effectdate between dt.dt1 and dt.dt2
                     group by u1.acc, u1.tag )
union all
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction, tg_f.ref_id
  from BARS.ACCOUNTSW_UPDATE u join tg_f on (tg_f.tag = u.tag)
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg_f on ( tg_f.tag = u1.tag )
                     where u1.effectdate <= dt.dt2
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Значение доп. реквизитов счета со справочником (delta+full по тегу)', '1.0');
  
  
--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);
Insert into UPL_FILES (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values (173, 173, 'ACCVAL_R', 'accvalr', 0, '09', NULL, '10', 0, 'Значения доп. реквизитов счета со справочником', 85, 'null', 'DELTA', 'GL', 1, NULL, 1, 'accval_r', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (173, 1, 'ACC', 'Внутренний номер счета', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (173, 2, 'KF', 'Код филиала', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (173, 3, 'TAG', 'Код доп. реквизита счета', 'CHAR', 8, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (173, 4, 'VALUE', 'Значение доп. реквизита счета', 'CHAR', 254, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (173, 5, 'CHGACTION', 'Код обновления (I/U/D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (173, 6, 'REF_ID', 'ID справочника', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (173, 'accvalsr(KF)_$_banks(KF)', 1, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (173, 'accvalsr(ACC, KF)_$_acc(ACC,KF)', 1, 102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (173, 'accvalsr(TAG)_$_acctags(TAG)', 1, 117);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (173, 'accvalsr(REF_ID,VALUE)_$_busmod(REF_ID,BUSMODID)', 1, 177);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (173, 'accvalsr(KF)_$_banks(KF)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (173, 'accvalsr(ACC, KF)_$_acc(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (173, 'accvalsr(ACC, KF)_$_acc(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (173, 'accvalsr(TAG)_$_acctags(TAG)', 1, 'TAG');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (173, 'accvalsr(REF_ID,VALUE)_$_busmod(REF_ID,BUSMODID)', 1, 'REF_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (173, 'accvalsr(REF_ID,VALUE)_$_busmod(REF_ID,BUSMODID)', 2, 'VALUE');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 173, 173);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 173, 1173);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 173, 173);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 173, 1173);



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
