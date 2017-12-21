-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 174
define ssql_id  = 174,1174

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
-- Новый файл параметров договоров со справочниками
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (174, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_c as ( select /*+ materialize */ unique trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table in (''CC_TAGS'', ''CD_TAGS'') and coalesce(ref_id, 0) != 0),
 tg_bpk as ( select /*+ materialize */ trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table = ''BPK_TAGS'' and coalesce(ref_id, 0) != 0 and isuse = 1),
    txt as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction, tg_c.ref_id
               from bars.nd_txt_update tu
               join tg_c on ( tg_c.tag = tu.tag )
              where tu.idupd in (select max(idupd)
                                   from dt, bars.nd_txt_update u
                                   join tg_c tg on ( tg.tag = u.tag )
                                  where u.effectdate <= dt.dt2
                                  group by u.nd, u.tag)),
      h as ( select kf, nd, case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as nd_type
               from bars.cc_deal_update cu
              where cu.idupd in (select max(u.idupd) idupd
                                   from bars.cc_deal_update u, txt, dt
                                  where u.effectdate <= dt.dt2
                                    and u.nd = txt.nd
                                  group by u.nd)
              union
             select distinct kf, nd, 10 as nd_type from bars.acc_over_update )
select txt.nd, txt.tag, txt.txt, txt.kf, h.nd_type, txt.chgaction, txt.ref_id
  from txt
  join h on (txt.kf=h.kf and txt.nd=h.nd)
 UNION ALL
select b.nd, b.tag, b.value, bars.gl.kf as kf, 4 as nd_type, b.chgaction, tg_bpk.ref_id
  from bars.bpk_parameters_update b
       join tg_bpk on ( tg_bpk.tag = b.tag )
 where b.idupd in ( select max(u.idupd)
                      from dt, bars.bpk_parameters_update u
                      join tg_bpk tg on ( tg.tag = u.tag )
                     where u.effectdate <= dt.dt2
                     group by u.nd, u.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Значення додаткових реквізитів угод банку з довідниками', '1.0');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1174, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_c as ( select /*+ materialize */ unique trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table in (''CC_TAGS'', ''CD_TAGS'') and coalesce(ref_id, 0) != 0),
 tg_bpk as ( select /*+ materialize */ trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table = ''BPK_TAGS'' and coalesce(ref_id, 0) != 0 and isuse = 1),
    txt as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction, tg_c.ref_id
               from bars.nd_txt_update tu
               join tg_c on ( tg_c.tag = tu.tag )
              where tu.idupd in (select max(idupd)
                                   from dt, bars.nd_txt_update u
                                   join tg_c tg on ( tg.tag = u.tag )
                                  where u.effectdate between dt.dt1 and dt.dt2
                                  group by u.nd, u.tag)),
      h as ( select kf, nd, case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as nd_type
               from bars.cc_deal_update cu
              where cu.idupd in (select max(u.idupd) idupd
                                   from bars.cc_deal_update u, txt, dt
                                  where u.effectdate <= dt.dt2
                                    and u.nd = txt.nd
                                  group by u.nd)
              union
             select distinct kf, nd, 10 as nd_type from bars.acc_over_update )
select txt.nd, txt.tag, txt.txt, txt.kf, h.nd_type, txt.chgaction, txt.ref_id
  from txt
  join h on (txt.kf=h.kf and txt.nd=h.nd)
 union all
select b.nd, b.tag, b.value, bars.gl.kf as kf, 4 as nd_type, b.chgaction, tg_bpk.ref_id
  from bars.bpk_parameters_update b
       join tg_bpk on ( tg_bpk.tag = b.tag )
 where b.idupd in ( select max(u.idupd)
                      from dt, bars.bpk_parameters_update u
                      join tg_bpk tg on ( tg.tag = u.tag )
                     where u.effectdate between dt.dt1 and dt.dt2
                     group by u.nd, u.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Значення додаткових реквізитів угод банку з довідниками', '1.0');



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
 Values (174, 174, 'ND_TXT_R', 'ccvalsr', 0, '09', NULL, '10', 0, 'Доп. реквизиты договоров  со справочником', 174, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'ccvals_r', 1, 1);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (174, 1, 'ND', '№ договора', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (174, 2, 'TAG', 'Код доп. реквизита', 'VARCHAR2', 5, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (174, 3, 'TXT', 'Значение доп. реквизита', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (174, 4, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 4, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (174, 5, 'ND_TYPE', 'Тип договора (кредиты = 3)', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 3, NULL);
Insert into UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (174, 6, 'CHGACTION', 'Код обновления (I/U/D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (174, 7, 'REF_ID', 'ID справочника', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);



-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (174, 'ccvalsr(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (174, 'ccvalsr(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);
--Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (174, 'ccvalsr(TAG)_$_cctags(TAG)', 1, 156);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (174, 'ccvalsr(REF_ID,TXT)_$_busmod(REF_ID,BUSMODID)', 1, 177);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (174, 'ccvalsr(KF)_$_banks(MFO)', 4, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (174, 'ccvalsr(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (174, 'ccvalsr(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (174, 'ccvalsr(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');
--Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (174, 'ccvalsr(TAG)_$_cctags(TAG)', 1, 'TAG');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (174, 'ccvalsr(REF_ID,TXT)_$_busmod(REF_ID,BUSMODID)', 1, 'REF_ID');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (174, 'ccvalsr(REF_ID,TXT)_$_busmod(REF_ID,BUSMODID)', 2, 'TXT');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 174,  174);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 174, 1174);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 174,  174);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 174, 1174);

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
