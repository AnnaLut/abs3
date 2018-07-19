-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 102
--define ssql_id  = 102,1102,6102

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 102');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (102))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 102,1102,6102');
end;
/
-- ***************************************************************************
-- ����� ������ �������� �� ���� ��� ���� ������ '300%', '301%'
-- COBUPRVNIXIII-25  ��� ����������� ������ ������� �� DWH, ����������� ����� ������������ ���� ������� 300% �� 301%
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (102,1102,6102);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select /* parallel */
       u.acc,
       u.kf,
       u.nls,
       u.kv,
       u.branch,
       acc.nbs,
       u.daos,
       u.nms,
       u.lim,
       u.pap,
       u.tip,
       u.vid,
       u.dazs,
       u.accc,
       u.blkd,
       u.blkk,
       u.rnk,
       nvl(u.ob22, acc.ob22) ob22,
       u.mdate,
       nvl (s1.initiator, ''0'') initcode,
       u.effectdate,
       u.globalbd,
       u.nbs
  from bars.accounts acc,
       (select *
          from bars.accounts_update au1
         where idupd in (
                         select max(idupd) idupd
                           from bars.accounts_update au21, dt
                          where au21.idupd in (
                                                select max(idupd)
                                                  from bars.accounts_update au22, dt
                                                 where effectdate <= dt2
                                                 group by acc
                                                union all
                                                select max(idupd)  --�� ��������� ���������� ������ ������� ��������� ������ ��� ���
                                                  from bars.accounts_update au25, bars.accounts a, dt
                                                 where (a.nls like ''14%''   or a.nls like ''31%''  or a.nls like ''32%'' or
                                                        a.nls like ''33%''   or a.nls like ''41%''  or a.nls like ''42%'' or
                                                        a.nls like ''3541%'' or a.nls like ''300%'' or a.nls like ''301%'')
                                                   and au25.acc = a.acc
                                                   and au25.effectdate <= dt2
                                                 group by a.acc
                                                union all
                                                select max(idupd) --�������� ������ ������ � ��������������
                                                  from bars.accounts_update au23, dt
                                                 where globalbd >= dt2
                                                   and daos <= dt2
                                                 group by acc, au23.globalbd
                                                having sum( case when chgaction in (1,4) then 1 else 0 end ) > 0
                                                    or (min(chgaction) = 0 and coalesce(max(dazs),to_date(''01/01/1900'',''dd/mm/yyyy'')) <= max(dt2))
                                               )
                          group by acc
                        )
       ) u,
       bars.specparam_cp_ob s1
 where acc.acc = u.acc
   and acc.acc = s1.acc(+)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (102, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, '����� �����', '7.10');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select /* parallel */
       u.acc,
       u.kf,
       u.nls,
       u.kv,
       u.branch,
       acc.nbs,
       u.daos,
       u.nms,
       u.lim,
       u.pap,
       u.tip,
       u.vid,
       u.dazs,
       u.accc,
       u.blkd,
       u.blkk,
       u.rnk,
       u.ob22,
       u.mdate,
       nvl (s1.initiator, ''0'') initcode,
       u.effectdate,
       u.globalbd,
       u.nbs
  from bars.accounts acc,
       (select *
          from bars.accounts_update au1
         where idupd in (
                         select max(idupd) idupd
                           from bars.accounts_update au21, dt
                          where au21.idupd in (
                                                select max(idupd)
                                                  from bars.accounts_update au22, dt
                                                 where globalbd >= dt1
                                                   and effectdate <= dt2
                                                 group by acc
                                                union all
                                                select max(idupd)  --�� ��������� ���������� ������ ������� ��������� ������ ��� ���
                                                  from bars.accounts_update au25, bars.accounts a, dt
                                                 where (a.nls like ''14%''   or a.nls like ''31%''  or a.nls like ''32%'' or
                                                        a.nls like ''33%''   or a.nls like ''41%''  or a.nls like ''42%'' or
                                                        a.nls like ''3541%'' or a.nls like ''300%'' or a.nls like ''301%'')
                                                   and au25.acc = a.acc
                                                   and au25.effectdate <= dt2
                                                 group by a.acc
                                                union all
                                                select max(idupd) --�������� ������ ������ � ��������������
                                                  from bars.accounts_update au23, dt
                                                 where globalbd >= dt1
                                                   and daos <= dt2
                                                 group by acc, au23.globalbd
                                                having sum( case when chgaction in (1,4) then 1 else 0 end ) > 0
                                                    or (min(chgaction) = 0 and coalesce(max(dazs),to_date(''01/01/1900'',''dd/mm/yyyy'')) <= max(dt2))
                                               )
                          group by acc
                        )
       ) u,
       bars.specparam_cp_ob s1
 where acc.acc = u.acc
   and acc.acc = s1.acc(+)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (1102, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, '����� �����', '7.10');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with glbd as (select max(to_date(val,''MM/DD/YYYY'')) glbd from bars.params$base p where par=''BANKDATE''),
       dt as ( select /*+ materialize */ BARS.DAT_NEXT_U(glbd.glbd, -3) dt1, glbd.glbd dt2 from glbd )
select /* parallel */
       u.acc,
       u.kf,
       u.nls,
       u.kv,
       u.branch,
       acc.nbs,
       u.daos,
       u.nms,
       u.lim,
       u.pap,
       u.tip,
       u.vid,
       u.dazs,
       u.accc,
       u.blkd,
       u.blkk,
       u.rnk,
       u.ob22,
       u.mdate,
       nvl (s1.initiator, ''0'') initcode,
       u.effectdate,
       u.globalbd,
       u.nbs
  from bars.accounts acc,
       (select *
          from bars.accounts_update au1
         where idupd in (
                         select max(idupd) idupd
                           from bars.accounts_update au21--, dt
                          where au21.idupd in (
                                                select max(idupd)
                                                  from bars.accounts_update au22, dt
                                                 where globalbd >= dt1
                                                   and effectdate <= dt2
                                                 group by acc
                                                union all
                                                select max(idupd)  --�� ��������� ���������� ������ ������ �������� �� ����
                                                  from bars.accounts_update au25, bars.accounts a, dt
                                                 where (a.nls like ''14%''   or a.nls like ''31%''  or a.nls like ''32%'' or
                                                        a.nls like ''33%''   or a.nls like ''41%''  or a.nls like ''42%'' or
                                                        a.nls like ''3541%'' or a.nls like ''300%'' or a.nls like ''301%'')
                                                   and au25.acc = a.acc
                                                   and au25.effectdate <= dt2
                                                 group by a.acc
                                                union all
                                                select max(idupd) --�������� ������ ������ � ��������������
                                                  from bars.accounts_update au23, dt
                                                 where globalbd >= dt1
                                                   and daos <= dt2
                                                 group by acc, au23.globalbd
                                                having sum( case when chgaction in (1,4) then 1 else 0 end ) > 0
                                                    or (min(chgaction) = 0 and coalesce(max(dazs),to_date(''01/01/1900'',''dd/mm/yyyy'')) <= max(dt2))
                                               )
                          group by acc
                        )
       ) u,
       bars.specparam_cp_ob s1
 where acc.acc = u.acc
   and acc.kf = u.kf
   and acc.acc = s1.acc(+)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (6102, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
    NULL, '����� ����� �� ���������� �� -3 ��� �� ���������� �� (��� IFRS9)', '2.1');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (102);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (102);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (102);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (102);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (102);

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
