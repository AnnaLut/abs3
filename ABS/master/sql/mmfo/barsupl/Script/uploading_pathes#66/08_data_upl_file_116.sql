-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 116
--define ssql_id  = 3116,4116,5116

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 116');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (116))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 3116,4116,5116');
end;
/
-- ***************************************************************************
-- TSK-0000791 UPL - сформировать 99 группу для иништиал выгрузки по файлам (Файл CUSVALS,  tag='EMAIL')
-- + Оптимизация
--   COBUMMFO-9670 Файли щоденного вивантаження Дельта по Києву не вивантажуються з 02.10.2018. По Донецьку та Дніпру також проблема з вивантаженнями за 04.10.
-- По SQL запитам 3116, 4116 видалив умову ... or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 )
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (116,1116,2116,3116,4116,5116,6116);

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0)
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select /*+ index (u1 XAI_CUSTOMERWUPD_EFFDAT)*/ max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg on ( tg.tag = u1.tag )
                    where u1.effectdate  <= dt.dt2
                      and u1.kf = bars.gl.kf
                    group by u1.rnk, u1.tag )', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Значення додаткових реквізитів клієнта ММФО', '2.7');

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0)
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select /*+ index (u1 XAI_CUSTOMERWUPD_EFFDAT)*/ max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg on ( tg.tag = u1.tag )
                    where  u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2
                       and u1.kf = bars.gl.kf
                    group by rnk, u1.tag )', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Значення додаткових реквізитів клієнта ММФО', '2.8');

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (5116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg_f as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and tag =  ''EMAIL'' and coalesce(ref_id, 0) = 0),
     tg_d as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and tag <> ''EMAIL'' and coalesce(ref_id, 0) = 0)

select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select /*+ index (u1 IDX_CUSTOMERWUPD_TAG_VALUE)*/ max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg_f on ( tg_f.tag = u1.tag )
                    where u1.effectdate  <= dt.dt2
                    group by u1.rnk, u1.tag )
union all 
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select /*+ index (u1 XAI_CUSTOMERWUPD_EFFDAT)*/ max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg_d on ( tg_d.tag = u1.tag )
                     where u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2
                    group by u1.rnk, u1.tag )', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Повне вивантаження по тегу EMAIL по усі іншим Дельта', '1.0');


-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (116);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (116);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (116);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (116);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (116);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (1,  116, 116);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (2,  116, 1116);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (3,  116, 116);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (4,  116, 1116);
