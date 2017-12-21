-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 147
define ssql_id  = 147,1147,2147

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
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_c as ( select /*+ materialize */ unique trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table in (''CC_TAGS'', ''CD_TAGS'') and coalesce(ref_id, 0) = 0),
 tg_bpk as ( select /*+ materialize */ trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table = ''BPK_TAGS'' and coalesce(ref_id, 0) = 0 and isuse = 1),
    txt as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction
               from bars.nd_txt_update tu
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
select txt.nd, txt.tag, txt.txt, txt.kf, h.nd_type, txt.chgaction
  from txt
  join h on (txt.kf=h.kf and txt.nd=h.nd)
 union all
select b.nd, b.tag, b.value, bars.gl.kf as kf, 4 as nd_type, b.chgaction
  from bars.bpk_parameters_update b
 where b.idupd in ( select max(u.idupd)
                      from dt, bars.bpk_parameters_update u
                      join tg_bpk tg on ( tg.tag = u.tag )
                     where u.effectdate <= dt.dt2
                     group by u.nd, u.tag )');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (147, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
    NULL, 'Значення додаткових реквізитів угод банку', '2.3');
end;
/


declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_c as ( select /*+ materialize */ unique trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table in (''CC_TAGS'', ''CD_TAGS'') and coalesce(ref_id, 0) = 0),
 tg_bpk as ( select /*+ materialize */ trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table = ''BPK_TAGS'' and coalesce(ref_id, 0) = 0 and isuse = 1),
    txt as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction
               from bars.nd_txt_update tu
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
select txt.nd, txt.tag, txt.txt, txt.kf, h.nd_type, txt.chgaction
  from txt
  join h on (txt.kf=h.kf and txt.nd=h.nd)
 union all
select b.nd, b.tag, b.value, bars.gl.kf as kf, 4 as nd_type, b.chgaction
  from bars.bpk_parameters_update b
 where b.idupd in ( select max(u.idupd)
                      from dt, bars.bpk_parameters_update u
                      join tg_bpk tg on ( tg.tag = u.tag )
                     where u.effectdate between dt.dt1 and dt.dt2
                     group by u.nd, u.tag )');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1147, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
    NULL, 'Значення додаткових реквізитів угод банку', '2.3');
end;
/


declare
 l_clob clob;
begin
l_clob:= to_clob('with  dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
    tg_c as ( select /*+ materialize */ unique trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table in (''CC_TAGS'', ''CD_TAGS'') and coalesce(ref_id, 0) = 0
                                                                                                  and tag not in (''INTRT'', ''ND_REST'')),
  tg_bpk as ( select /*+ materialize */ trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table = ''BPK_TAGS'' and coalesce(ref_id, 0) = 0 and isuse = 1
                                                                                                  and tag not in (''INTRT'', ''ND_REST'')),
  tg_c_f as ( select /*+ materialize */ unique trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table in (''CC_TAGS'', ''CD_TAGS'') and coalesce(ref_id, 0) = 0
                                                                                                  and tag in (''INTRT'', ''ND_REST'')),
tg_bpk_f as ( select /*+ materialize */ trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table = ''BPK_TAGS'' and coalesce(ref_id, 0) = 0 and isuse = 1
                                                                                                  and tag in (''INTRT'', ''ND_REST'')),
    txt as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction
               from bars.nd_txt_update tu
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
             select distinct kf, nd, 10 as nd_type from bars.acc_over_update ),
  txt_f as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction
               from bars.nd_txt_update tu
              where tu.idupd in (select max(idupd)
                                   from dt, bars.nd_txt_update u
                                   join tg_c_f tg on ( tg.tag = u.tag )
                                  where u.effectdate <= dt.dt2
                                  group by u.nd, u.tag)),
    h_f as ( select kf, nd, case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as nd_type
               from bars.cc_deal_update cu
              where cu.idupd in (select max(u.idupd) idupd
                                   from bars.cc_deal_update u, txt_f txt, dt
                                  where u.effectdate <= dt.dt2
                                    and u.nd = txt.nd
                                  group by u.nd)
              union
             select distinct kf, nd, 10 as nd_type from bars.acc_over_update )
--delta
select txt.nd, txt.tag, txt.txt, txt.kf, h.nd_type, txt.chgaction
  from txt
  join h on (txt.kf=h.kf and txt.nd=h.nd)
 union all
select b.nd, b.tag, b.value, bars.gl.kf as kf, 4 as nd_type, b.chgaction
  from bars.bpk_parameters_update b
 where b.idupd in ( select max(u.idupd)
                      from dt, bars.bpk_parameters_update u
                      join tg_bpk tg on ( tg.tag = u.tag )
                     where u.effectdate between dt.dt1 and dt.dt2
                     group by u.nd, u.tag )
 union all
--full
select txt.nd, txt.tag, txt.txt, txt.kf, h.nd_type, txt.chgaction
  from txt_f txt
  join h_f h on (txt.kf=h.kf and txt.nd=h.nd)
 union all
select b.nd, b.tag, b.value, bars.gl.kf as kf, 4 as nd_type, b.chgaction
  from bars.bpk_parameters_update b
 where b.idupd in ( select max(u.idupd)
                      from dt, bars.bpk_parameters_update u
                      join tg_bpk_f tg on ( tg.tag = u.tag )
                     where u.effectdate between dt.dt1 and dt.dt2
                     group by u.nd, u.tag )');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2147, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
    NULL, 'Значення додаткових реквізитів угод банку (delta+full по тегу)', '1.0');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (147, 'ccvals(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (147, 'ccvals(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (147, 'ccvals(TAG)_$_cctags(TAG)', 1, 156);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (147, 'ccvals(KF)_$_banks(MFO)', 4, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (147, 'ccvals(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (147, 'ccvals(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (147, 'ccvals(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (147, 'ccvals(TAG)_$_cctags(TAG)', 1, 'TAG');

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
