-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 174
--define ssql_id  = 2174

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 174');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (174))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 2174');
end;
/
-- ***************************************************************************
-- TSK-0001458 UPL - выгрузить два новых параметра КД
-- Необходимо забрать в миррор два параметра: день погашения кредита, flags
-- TSK-0001468   UPL - добавить в 99 группу инишиал по файлам
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (2174);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (2174, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_f as ( select /*+ materialize */ tag, ref_id from barsupl.upl_tag_lists where tag_table = ''CC_TAGS'' and tag =  ''FLAGS'' and coalesce(ref_id, 0) != 0),
   tg_d as ( select /*+ materialize */ unique trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table in (''CC_TAGS'', ''CD_TAGS'') and coalesce(ref_id, 0) != 0 and tag <> ''FLAGS''),
   tg_bpk as ( select /*+ materialize */ trim(tag) tag, ref_id from barsupl.upl_tag_lists where tag_table = ''BPK_TAGS'' and coalesce(ref_id, 0) != 0 and isuse = 1),
  txt_f as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction, tg_f.ref_id
               from bars.nd_txt_update tu
               join tg_f on ( tg_f.tag = tu.tag )
              where tu.idupd in (select max(idupd)
                                   from dt, bars.nd_txt_update u
                                   join tg_f tg on ( tg.tag = u.tag )
                                  where u.effectdate <= dt.dt2
                                  group by u.nd, u.tag)),
    h_f as ( select kf, nd, case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as nd_type
               from bars.cc_deal_update cu
              where cu.idupd in (select max(u.idupd) idupd
                                   from bars.cc_deal_update u, txt_f, dt
                                  where u.effectdate <= dt.dt2
                                    and u.nd = txt_f.nd
                                  group by u.nd)
              union
             select distinct kf, nd, 10 as nd_type from bars.acc_over_update ),
  txt_d as ( select tu.nd, tu.tag, tu.txt, tu.kf, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as chgaction, tg_d.ref_id
               from bars.nd_txt_update tu
               join tg_d on ( tg_d.tag = tu.tag )
              where tu.idupd in (select max(idupd)
                                   from dt, bars.nd_txt_update u
                                   join tg_d tg on ( tg.tag = u.tag )
                                  where u.effectdate >= dt.dt1 and u.effectdate <= dt.dt2
                                  group by u.nd, u.tag)),
    h_d as ( select kf, nd, case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as nd_type
               from bars.cc_deal_update cu
              where cu.idupd in (select max(u.idupd) idupd
                                   from bars.cc_deal_update u, txt_d, dt
                                  where u.effectdate >= dt.dt1 and u.effectdate <= dt.dt2
                                    and u.nd = txt_d.nd
                                  group by u.nd)
              union
             select distinct kf, nd, 10 as nd_type from bars.acc_over_update )

select txt_f.nd, txt_f.tag, txt_f.txt, txt_f.kf, h_f.nd_type, txt_f.chgaction, txt_f.ref_id
  from txt_f
  join h_f on (txt_f.kf=h_f.kf and txt_f.nd=h_f.nd)
 UNION ALL
select txt_d.nd, txt_d.tag, txt_d.txt, txt_d.kf, h_d.nd_type, txt_d.chgaction, txt_d.ref_id
  from txt_d
  join h_d on (txt_d.kf=h_d.kf and txt_d.nd=h_d.nd)
 UNION ALL
select b.nd, b.tag, b.value, bars.gl.kf as kf, 4 as nd_type, b.chgaction, tg_bpk.ref_id
  from bars.bpk_parameters_update b
       join tg_bpk on ( tg_bpk.tag = b.tag )
 where b.idupd in ( select max(u.idupd)
                      from dt, bars.bpk_parameters_update u
                      join tg_bpk tg on ( tg.tag = u.tag )
                     where u.effectdate between dt.dt1 and dt.dt2
                     group by u.nd, u.tag )', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Значення додаткових реквізитів угод банку з довідниками (тег FLAGS full, Others delta)', '1.0');


-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (174);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (174);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (174);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (174);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (174);

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
