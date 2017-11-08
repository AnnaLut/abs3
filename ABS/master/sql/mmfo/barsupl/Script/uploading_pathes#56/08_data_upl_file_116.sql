-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 116
define ssql_id  = 116,1116,2116,3116,4116,5116


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
-- ETL-XXX
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (116, 
    'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD'')
                      --and coalesce(u1.effectdate, chgdate) < dt.dt2 + 1
                      and ((u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate      <  dt.dt2 + 1 ))
                    group by u1.rnk, u1.tag )', 
    'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
    NULL, 'Значення додаткових реквізитів клієнта РУ', '2.4');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1116, 
    'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD'')
                      and ((u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2 )
                       or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 ))
                      --and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= dt.dt1
                      --and coalesce(u1.effectdate,u1.chgdate) < dt.dt2 + 1
                    group by rnk, u1.tag )', 
    'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
    NULL, 'Значення додаткових реквізитів клієнта РУ', '2.5');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (2116, 
    'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag not in (''DDBO'', ''SDBO''))
                      and ((u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2 )
                       or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 ))
                    group by rnk, u1.tag )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l, dt
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag in (''DDBO'', ''SDBO''))
                      and ((u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate      <  dt.dt2 + 1 ))
                      --and coalesce(u1.effectdate, chgdate) < dt.dt2 + 1
                    group by u1.rnk, u1.tag )', 
    'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
    NULL, 'Щоденне + повне за певними тегами РУ', '1.4');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (3116, 
    'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD'')
                      --and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'') + 1
                      and ((u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate      <  dt.dt2 + 1 ))
                      and u1.kf = bars.gl.kf
                    group by u1.rnk, u1.tag )', 
    'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
    NULL, 'Значення додаткових реквізитів клієнта ММФО', '2.5');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (4116, 
    'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD'')
                      and ((u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2 )
                       or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 ))
                      --and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= dt.dt1
                      --and coalesce(u1.effectdate,u1.chgdate) < dt.dt2 + 1
                      and u1.kf = bars.gl.kf
                    group by rnk, u1.tag )', 
    'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
    NULL, 'Значення додаткових реквізитів клієнта ММФО', '2.6');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (5116, 
    'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag not in (''DDBO'', ''SDBO''))
                      and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= dt.dt1
                      and coalesce(u1.effectdate,u1.chgdate) < dt.dt2 + 1
                      and u1.kf = bars.gl.kf
                    group by rnk, u1.tag )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag in (''DDBO'', ''SDBO''))
                      and ((u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate      <  dt.dt2 + 1 ))
                      --and coalesce(u1.effectdate, chgdate) < dt.dt2 + 1
                      and u1.kf = bars.gl.kf
                    group by u1.rnk, u1.tag )', 
    'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
    NULL, 'Щоденне + повне за певними тегами ММФО', '1.4');


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
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (1, 116, 3116);
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (2, 116, 4116);
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (3, 116, 3116);
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (4, 116, 4116);
    else
         -- ************* RU *************
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (1, 116, 116);
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (2, 116, 1116);
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (3, 116, 116);
        Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (4, 116, 1116);
    end if;
end;
/

