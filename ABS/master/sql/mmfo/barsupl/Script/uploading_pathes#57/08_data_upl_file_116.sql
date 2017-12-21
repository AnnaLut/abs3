-- ***************************************************************************
set verify off
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
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
-- ETL-20823 -UPL - ��������� �� ��� � �� ��������� ��������/����� ��� IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, ������� ������ (INTRT), �������� ��������.�������� (ND_REST) � ���������������� �������������
-- ��������� ������ ���� ��� ������������
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0)
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg on ( tg.tag = u1.tag )
                    where (u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate     <  dt.dt2 + 1 )
                       -- coalesce(u1.effectdate, chgdate-1) < dt.dt2 + 1
                    group by u1.rnk, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, '�������� ���������� �������� �볺��� ��', '2.5');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0)
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg on ( tg.tag = u1.tag )
                    where (u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2 )
                       or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 )
                      --and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= dt.dt1
                      --and coalesce(u1.effectdate,u1.chgdate) < dt.dt2 + 1
                    group by u1.rnk, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, '�������� ���������� �������� �볺��� ��', '2.6');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_d as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0 and tag not in (''DDBO'', ''SDBO'')),
   tg_f as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0 and tag     in (''DDBO'', ''SDBO''))
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg_d on ( tg_d.tag = u1.tag )
                    where ((u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2 )
                       or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 ))
                    group by rnk, u1.tag )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg_f on ( tg_f.tag = u1.tag )
                    where (u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate     <  dt.dt2 + 1 )
                    group by u1.rnk, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, '������� + ����� �� ������� ������ ��', '1.5');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (3116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0)
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg on ( tg.tag = u1.tag )
                    where ((u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate      <  dt.dt2 + 1 ))
                      and u1.kf = bars.gl.kf
                      --coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'') + 1
                    group by u1.rnk, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, '�������� ���������� �������� �볺��� ����', '2.6');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (4116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0)
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg on ( tg.tag = u1.tag )
                    where ((u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2 )
                       or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 ))
                      --and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= dt.dt1
                      --and coalesce(u1.effectdate,u1.chgdate) < dt.dt2 + 1
                      and u1.kf = bars.gl.kf
                    group by rnk, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, '�������� ���������� �������� �볺��� ����', '2.7');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (5116, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_d as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0 and tag not in (''DDBO'', ''SDBO'')),
   tg_f as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) = 0 and tag     in (''DDBO'', ''SDBO''))
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg_d on ( tg_d.tag = u1.tag )
                    where ((u1.effectdate >= dt.dt1 and u1.effectdate <= dt.dt2 )
                       or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 ))
                      and u1.kf = bars.gl.kf
                    group by rnk, u1.tag )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from dt, bars.customerw_update u1
                     join tg_f on ( tg_f.tag = u1.tag )
                    where ((u1.effectdate  <= dt.dt2 )
                       or (u1.chgdate      <  dt.dt2 + 1 ))
                      --and coalesce(u1.effectdate, chgdate) < dt.dt2 + 1
                      and u1.kf = bars.gl.kf
                    group by u1.rnk, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, '������� + ����� �� ������� ������ ����', '1.5');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

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
