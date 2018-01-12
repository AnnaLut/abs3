-- ***************************************************************************
set verify off
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
define sfile_id = 158
define ssql_id  = 158,1158,2158,3158,4158,5158

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
-- ETL-21872  BUG - ����� ������ (����� ������) �� ���. ���������.
-- ETL-22015  UPL - initial upload - 99 ������ (arracc2 - ������ + full �� W4 (��������� �.))
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.effectdate <= dt.dt2 ),
     ac1 as ( select unique a.ACC
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b
                ),
     --����� ��� � ������
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --����� �� ������, ������� �� �������� �� �������� (���� �������� � D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select bpk.ND, 4 ND_TYPE, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null,      null,     null,     null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select REF nd, 9 nd_type, bars.gl.kf, chgaction,
       acc, accd, accp, accr, accs, accr2,
       ACCEXPN, ACCEXPR, NULL,
       null, null, null, null, null, null
  from BARS.CP_DEAL_UPDATE
 where IDUPD in ( select MAX(idupd)
                    from BARS.CP_DEAL_UPDATE, dt
                   where EFFECTDATE <= dt.dt2
                   group by ref )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, '��''���� �����-������� ��� ���� 2 (��� w4 + old + ��� + ��)', '5.3');

end;
/


declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --���������� ����� ��� �� ��������
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --����� ��� � ������
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --����� �� ������, ������� �� �������� �� �������� (���� �������� � D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd )
 union all
select bpk.ND, 4 nd_type, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null,      null,     null,     null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd ) union all
select REF nd, 9 nd_type, bars.gl.kf, CHGACTION,
       acc, accd, accp, accr, accs, accr2,
       ACCEXPN, ACCEXPR, NULL,
       null, null, null, null, null, null
  from BARS.CP_DEAL_UPDATE
 where IDUPD in ( select MAX(idupd)
                    from BARS.CP_DEAL_UPDATE, dt
                   where EFFECTDATE between dt.dt1 and dt.dt2
                   group by ref )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, '��''���� �����-������� ��� ���� 2 (��� w4 + old + ��� + ��)', '5.3');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.effectdate <= dt.dt2 ),
     ac1 as ( select unique a.ACC
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b
                ),
     --����� ��� � ������
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
              group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --����� �� ������, ������� �� �������� �� �������� (���� �������� � D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select bpk.ND, 4 ND_TYPE, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null,      null,     null,     null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select REF nd, 9 nd_type, bars.gl.kf, chgaction,
       acc, accd, accp, accr, accs, accr2,
       ACCEXPN, ACCEXPR, accr3,
       accunrec, null, null, null, null, null
  from BARS.CP_DEAL_UPDATE
 where IDUPD in ( select MAX(idupd)
                    from BARS.CP_DEAL_UPDATE, dt
                   where EFFECTDATE <= dt.dt2
                   group by ref )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, '��''���� �����-������� ��� ���� 2 (��� w4 + old + ��� + ��)', '5.3');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --���������� ����� ��� �� ��������
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --����� ��� � ������
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --����� �� ������, ������� �� �������� �� �������� (���� �������� � D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd )
 union all
select bpk.ND, 4 nd_type, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null,      null,     null,     null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd ) union all
select REF nd, 9 nd_type, bars.gl.kf, CHGACTION,
       acc, accd, accp, accr, accs, accr2,
       ACCEXPN, ACCEXPR, accr3,
       accunrec, null, null, null, null, null
  from BARS.CP_DEAL_UPDATE
 where IDUPD in ( select MAX(idupd)
                    from BARS.CP_DEAL_UPDATE, dt
                   where EFFECTDATE between dt.dt1 and dt.dt2
                   group by ref )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (3158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, '��''���� �����-������� ��� ���� 2 (��� w4 + old + ��� + ��)', '5.3');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --���������� ����� ��� �� ��������
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --����� ��� � ������
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --����� �� ������, ������� �� �������� �� �������� (���� �������� � D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select bpk.ND, 4 nd_type, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null,      null,     null,     null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd ) union all
select REF nd, 9 nd_type, bars.gl.kf, CHGACTION,
       acc, accd, accp, accr, accs, accr2,
       ACCEXPN, ACCEXPR, accr3,
       accunrec, null, null, null, null, null
  from BARS.CP_DEAL_UPDATE
 where IDUPD in ( select MAX(idupd)
                    from BARS.CP_DEAL_UPDATE, dt
                   where EFFECTDATE between dt.dt1 and dt.dt2
                   group by ref )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (4158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, '��''���� �����-������� ��� ���� 2 (������ + Full �� W4) ����', '1.3');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --���������� ����� ��� �� ��������
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --����� ��� � ������
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --����� �� ������, ������� �� �������� �� �������� (���� �������� � D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select bpk.ND, 4 nd_type, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null,      null,     null,     null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd ) union all
select REF nd, 9 nd_type, bars.gl.kf, CHGACTION,
       acc, accd, accp, accr, accs, accr2,
       ACCEXPN, ACCEXPR, NULL,
       null, null, null, null, null, null
  from BARS.CP_DEAL_UPDATE
 where IDUPD in ( select MAX(idupd)
                    from BARS.CP_DEAL_UPDATE, dt
                   where EFFECTDATE between dt.dt1 and dt.dt2
                   group by ref )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (5158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, '��''���� �����-������� ��� ���� 2 (������ + Full �� W4) ��', '1.3');

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
