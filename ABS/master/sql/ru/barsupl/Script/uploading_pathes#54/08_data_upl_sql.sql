-- ===================================================================================
-- Module : UPL
-- Date   : 11.07.2017
-- ===================================================================================
-- Запити на вивантаження даних у файли для DWH
-- ===================================================================================

 delete from BARSUPL.UPL_SQL 
    where mod(SQL_ID,1000) IN ( 158 );

delete from BARSUPL.UPL_SQL
	where SQL_ID IN (149, 221, 1221, 171, 7171, 172, 261, 536, 1356, 547);

delete from BARSUPL.UPL_SQL
    where SQL_ID IN (202, 1202, 203, 1203, 205, 206, 566);
--
-- Для запроса 149 docvals добавили наложение условия признака проведенного документа   
--
prompt  Обновление запроса 149 docvals

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (149, 'select ope.REF, ope.TAG, ope.VALUE, ope.KF
  from BARS.OPERW ope,
       barsupl.upl_tag_lists l
 where ref in (select ref
                 from bars.opldok
                where fdat = to_date (:param1, ''dd/mm/yyyy'') and dk = 1 and sos = 5)
   and ope.tag = l.tag
   and l.tag_table = ''OP_FIELD''', 
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 
   'Хранилище реквизитов документов','2.1');

--
--DWH ETL-19133  UPL - выгрузить новое поле в файле deposit (file_id=221) WB
--
prompt  Обновление запроса 221 deposit

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (221, 'select 1 type,
       d.DEPOSIT_ID,
       d.VIDD,
       d.ACC,
       d.KV,
       d.RNK,
       d.DAT_BEGIN,
       d.DAT_END,
       d.MFO_P,
       d.LIMIT,
       d.DATZ,
       d.FREQ,
       d.ND,
       d.BRANCH,
       0 STATUS,
       d.ACC_D,
       d.MFO_D,
       d.NMS_D,
       d.STOP_ID,
       d.KF,
       d.USERID,
       v.BSD,
       d.CNT_DUBL,
       w.VALUE as CASHLESS,
       d.ARCHDOC_ID,
       6 as TUP,
       d.WB
  from bars.dpt_deposit_clos d
 inner
  join bars.dpt_vidd v on (v.vidd = d.vidd)
  left
  join bars.dpt_depositw w on (w.dpt_id = d.deposit_id and w.tag = ''NCASH'')
 where d.idupd in ( select MAX(idupd) idupd
                      from BARS.DPT_DEPOSIT_CLOS
                     where bdate <= TO_DATE(:param1, ''dd/mm/yyyy'')
                       and kf = bars.gl.kf
                     group by deposit_id )
   and d.kf = bars.gl.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Депозитний портфель ФО', '4.2');

prompt  Обновление запроса 1221 deposit   

Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1221, 'select 1 type,
       d.DEPOSIT_ID,
       d.VIDD,
       d.ACC,
       d.KV,
       d.RNK,
       d.DAT_BEGIN,
       d.DAT_END,
       d.MFO_P,
       d.LIMIT,
       d.DATZ,
       d.FREQ,
       d.ND,
       d.BRANCH,
       0 STATUS,
       d.ACC_D,
       d.MFO_D,
       d.NMS_D,
       d.STOP_ID,
       d.KF,
       d.USERID,
       v.BSD,
       d.CNT_DUBL,
       w.VALUE as CASHLESS,
       d.ARCHDOC_ID,
       6 as TUP,
       d.WB
  from bars.dpt_deposit_clos d
 inner
  join bars.dpt_vidd v on (v.vidd = d.vidd)
  left
  join bars.dpt_depositw w on (w.dpt_id = d.deposit_id and w.tag = ''NCASH'')
 where d.idupd in ( select MAX(idupd) idupd
                      from bars.dpt_deposit_clos
                     where bdate between bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 and to_date(:param1, ''dd/mm/yyyy'')
                       and kf = bars.gl.kf
                     group by deposit_id )
   and d.kf = bars.gl.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Депозитний портфель ФО', '4.2');

--
-- 158 (arracc2) ETL-XXX UPL - испарвление выгрузки ЦА (по ЦБ вернуть выгрузку полей ACCR3, ACCUNREC из ММФО)
-- отдельные запроссы для ЦА
prompt  arracc2

--158
declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.effectdate <= dt.dt2 ),
     ac1 as ( select unique a.ACC
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB )
              --union
              --select unique b.ACC_SS
              --  from BARS.PRVN_FIN_DEB b
                ),
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
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
';
l_clob := l_clob || ' union all
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.1');
end;
/

--1158
declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
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
';
l_clob := l_clob || ' union all
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.1');
end;
/


--2158
declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.effectdate <= dt.dt2 ),
     ac1 as ( select unique a.ACC
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB )
              --union
              --select unique b.ACC_SS
              --  from BARS.PRVN_FIN_DEB b
                ),
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
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
';
l_clob := l_clob || ' union all
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.1');
end;
/

--3158
declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
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
';
l_clob := l_clob || ' union all
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (3158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.1');
end;
/

--4158 Зв''язок угода-рахунок для виду 2 (дельта + Full по ЦБ)
declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
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
';
l_clob := l_clob || ' union all
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (4158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (дельта + Full по ЦБ)', '1.0');
end;
/


--- ETL-19131 - ANL - выгрузку договоров по хозяйственной дебиторской задолженности
--- XOZ_REF(171) Картотека дебиторов (предназ по задумке для хоз.деб)
--- новый файл
prompt 171 договора ХДЗ XOZ_REF
Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (171, 'select 21 TYPE, x.id ND, x.KF, x.ACC, x.REF1, x.STMT1, x.REF2, x.MDATE, x.S,
       x.FDAT, x.S0, x.NOTP, x.PRG, x.BU, x.DATZ, x.REFD, a.RNK, a.KV, a.TIP, d1.FDAT
  from BARS.XOZ_REF x
       join BARS.ACCOUNTS a on ( x.acc  = a.acc )
  left join bars.opldok  d1 on ( x.ref2 = d1.ref )',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Картотека дебиторов', '1.0');

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (7171, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                   to_date (:param1, ''dd/mm/yyyy'') dt2,
                   BARS.DAT_NEXT_U(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),-1) as dt3 from dual ),
     a  as ( --счета xoz с измененными остатками кор. проводками
             select b.ACC, a.RNK, a.KV, a.TIP,
                    b.OST  - b.CRDOS  + b.CRKOS  as OST_COR,
                    b.OSTQ - b.CRDOSQ + b.CRKOSQ as OST_COR_UAH
               from dt, BARS.AGG_MONBALS b
               join BARS.ACCOUNTS    a    on ( (a.tip = ''XOZ'' or a.tip = ''W4X'') and a.acc = b.acc )
              where b.fdat = add_months(trunc(dt.dt2,''MM''),-1)
                and ( b.CRDOS <> 0 or b.CRKOS <> 0 )
                and a.daos < trunc(dt.dt2,''MM'')
                and ( a.dazs is null or a.dazs >= trunc(dt.dt2,''MM'')))
select 21 TYPE, x.id ND, x.KF, x.ACC, x.REF1, x.STMT1, x.REF2, x.MDATE, x.S,
       x.FDAT, x.S0, x.NOTP, x.PRG, x.BU,
       case when o1.vob = 96 or o2.vob = 96
            then x.DATZ
            else null
       end as DATZ,
        x.REFD, a.RNK, a.KV, a.TIP,
       d1.FDAT DATF
  from BARS.XOZ_REF x
       join dt on (1=1)
       join a on (a.acc = x.acc)
  left join bars.oper   o1 on ( o1.ref = x.ref1 )
  left join bars.oper   o2 on ( o2.ref = x.ref2 )
  left join bars.opldok d1 on ( d1.ref = x.ref2 )
 where x.datz > dt.dt3 or x.datz is null',
	'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Картотека дебиторов T0', '1.0');

--- ETL-19474 - UPL - добавить в выгрузку для T0 корректирующих проводок по договорам хоз.дебеторки отдельным файлом (по аналогии с MIR.SRC_PRFTADJTXN0)
--- новый файл
prompt 547 корректировки по счетам XOZ
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (547, 'select o.REF, o.STMT, o.KF, o.FDAT, o.S, o.SQ, o.TT, o.DK, o.ACC, d.VDAT
  from BARS.OPLDOK o join BARS.OPER d on ( d.REF = o.REF )
 where o.REF in ( select t.REF
                    from BARS.OPLDOK t
                    join BARS.OPER d on ( d.REF = t.REF )
                   where ( t.FDAT, t.ACC ) in ( select FDAT, ACC
                                                  from BARS.SALDOA
                                                 where ACC in ( select ACC
                                                                  from BARS.ACCOUNTS
                                                                 where (TIP = ''XOZ'' or tip = ''W4X'')
                                                                   and DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                                   and ( DAZS is Null or DAZS > trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') )
                                                              )
                                                   and FDAT >= trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                   and ( DOS <> 0 OR KOS <> 0 )
                                              )
                     and t.SOS = 5
                     and d.VOB = 96
                     and d.VDAT = BARS.DAT_NEXT_U(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),-1)
                )
   and o.TT not like ''PO_''
   and o.TT not like ''ZG_''',
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Коригуючі транзакції по рахунках XOZ (для FineVare)', 
    '1.0');


--- ETL-19131 - ANL - выгрузку договоров по хозяйственной дебиторской задолженности
--- XOZ_PRG(172) Довідник проектів
--- новый файл
prompt 172 справочник XOZ_PRG
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (172, 'select x.PRG, x.NAME, x.DETALI from BARS.XOZ_PRG x',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Довідник проектів', '1.0');

----
---- Обновление запросов 202, 1202, 203, 1203, 205, 206
---- в связи с обьединением таблиц 
---- move data from EBK_GCIF to EBKC_GCIF
---- move data from EBK_SLAVE_CLIENT to EBKC_SLAVE
----

prompt  Обновление запроса 202
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (202, 'select kf, rnk, gcif, insert_date
from bars.ebkc_gcif 
where kf=bars.gl.kf 
and CUST_TYPE in (''I'')', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'ЄБК - майстер-картки рівня банку (full)', '1.1');
prompt  Обновление запроса 1202 
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1202, 'with tpdt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual)
select kf, rnk, gcif, insert_date
from bars.ebkc_gcif, tpdt
where kf=bars.gl.kf and insert_date >= tpdt.dt1
and CUST_TYPE in (''I'')',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
 NULL, 'ЄБК - майстер-картки рівня банку (increment)', '1.1');
prompt  Обновление запроса 203
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (203, 'select kf, rnk, gcif, cust_type, insert_date
from bars.ebkc_gcif
where kf=bars.gl.kf 
and CUST_TYPE in (''P'',''L'')', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'ЄБК - майстер-картки рівня банку для юридичних осіб (full)', '1.1');
prompt  Обновление запроса 1203
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1203, 'with tpdt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual)
select kf, rnk, gcif, cust_type, insert_date
from bars.ebkc_gcif, tpdt
where kf=bars.gl.kf and insert_date >= tpdt.dt1
and CUST_TYPE in (''P'',''L'')', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'ЄБК - майстер-картки рівня банку для юридичних осіб (increment)', '1.1');
prompt  Обновление запроса 205
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (205, 'select gcif, slave_kf kf, slave_rnk rnk
from bars.ebkc_slave
where slave_kf=bars.gl.kf
and CUST_TYPE in (''I'')', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'ЄБК - картки, пов''язані з майстер-картками', '1.1');
prompt  Обновление запроса 206
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (206, 'select gcif, slave_kf kf, cust_type, slave_rnk rnk
from bars.ebkc_slave
where slave_kf=bars.gl.kf
and CUST_TYPE in (''P'',''L'')', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'ЄБК - картки юридичних осіб, пов''язані з майстер-картками', '1.1');

----
---- ETL-19329 UPL - выгрузить договора хоз. дебеторки (файл договоро + t0 + справочники)
---- добавлен новый вид договоров 21-ХДЗ
prompt  Обновление запроса arrtype

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (261, 'select 1 as TYPE_ID, ''Депозити ФО'' as DESCRIPT from dual
 union all
select 2, ''Депозити ЮО'' from dual
 union all
select 3, ''Кредити''  from dual
 union all
select 4, ''БПК'' from dual
 union all
select 5, ''Забезпечення'' from dual
 union all
select 6, ''Текущие счета'' from dual
 union all
select 7, ''Транши'' from dual
 union all
select 8, ''Казначейство'' from dual
 union all
select 9, ''Ценные бумаги'' from dual
 union all
select 10, ''Овердрафты'' from dual
 union all
select 11, ''Договора РКО'' from dual
 union all
select 12, ''Договора абонплати'' from dual
 union all
select 13, ''Віртуальні субдоговора КП'' from dual
 union all
select 14, ''Документарні операції'' from dual
 union all
select 15, ''Дебіторська заборгованістості'' from dual
 union all
select 16, ''Віртуальні субдоговора БПК'' from dual
 union all
select 17, ''Віртуальні договора Фін. Дебіторки'' from dual
 union all
select 18, ''Депозитні сейфи'' from dual
 union all
select 19, ''Депозити КД'' from dual
 union all
select 20, ''Договори страхування'' from dual
 union all
select 21, ''Договори ГДЗ'' from dual', NULL, NULL, 'Види угод', 
    '3.7');

----
---- ETL-19329 UPL - выгрузить договора хоз. дебеторки (файл договоро + t0 + справочники)
----   2. В выгрузке Т0 таблицу acntchg0 (изменненые в первом рабочем числе параметры счетов: ОБ22, Номінальна відстокова ставка, Ефективна відстокова ставка,
----   Параметр R013) расширить счетами ХДЗ, а именно 3510, 3519 и 355 группы 
prompt  Обновление запроса  536 acntchg0

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (536, 'with ACNTR013 as ( select a.ACC
                    from BARS.ACCOUNTS a
                   where (a.NBS in (''9129'', ''3510'', ''3519'')
                      or a.NBS like ''355%'' or a.tip = ''XOZ'' or a.tip = ''W4X'')
                     and a.DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                     and ( a.DAZS is Null or a.DAZS > to_date(:param1,''dd/mm/yyyy'') )
                 ),
     ACNTOB22 as ( select a.KF, a.ACC, a.OB22
                     from BARS.ACCOUNTS a
                    where (a.nbs in (''3600'',''9129'', ''3519'')
                       or a.NBS like ''355%'' or a.tip = ''XOZ'' or a.tip = ''W4X'')
                      and a.DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                 )
select KF, ACC, 13 as PAR_ID, R013 as PAR_VAL
  from ( select KF, ACC, R013
           from BARS.SPECPARAM_UPDATE
          where IDUPD in ( select max(IDUPD)
                            from BARS.SPECPARAM_UPDATE p1
                            join ACNTR013 a
                              on ( a.ACC = p1.ACC )
                           where p1.EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                           group by p1.ACC )
          minus
         select KF, ACC, R013
           from BARS.SPECPARAM_UPDATE
          where IDUPD in ( select max(p0.IDUPD)
                            from BARS.SPECPARAM_UPDATE p0
                            join ACNTR013 a
                              on ( a.ACC = p0.ACC )
                           where p0.EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                           group by p0.ACC )
       )
 union all
select KF, ACC, 10 as PAR_ID, OB22 as PAR_VAL
  from ( select KF, ACC, OB22
           from BARS.ACCOUNTS_UPDATE
          where IDUPD in ( select max(a1.IDUPD)
                             from BARS.ACCOUNTS_UPDATE a1
                             join ACNTOB22 a
                               on ( a.ACC = a1.ACC )
                            where a1.EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                            group by a1.ACC )
          minus
         select KF, ACC, OB22
           from BARS.ACCOUNTS_UPDATE
          where IDUPD in ( select max(a0.IDUPD)
                             from BARS.ACCOUNTS_UPDATE a0
                             join ACNTOB22 a
                               on ( a.ACC = a0.ACC )
                            where a0.EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                            group by a0.ACC )
       )
 union all
select KF, ACC,
       case
         when ID =  0 then 11
         when ID = -2 then 12
         else null
       end as PAR_ID,
       to_char(IR,''FM99999900D009999999999'') as PAR_VAL
  from BARS.INT_RATN_ARC
 where IDUPD in ( select max(ir.IDUPD)
                    from BARS.INT_RATN_ARC ir
                   where ir.EFFECTDATE between trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') and to_date(:param1,''dd/mm/yyyy'')
                     and ir.BDAT < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                     and ir.ID in ( 0, -2 )
                   group by ir.ACC, ir.ID )
   and IR is Not Null', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Змінені параметри рахунків (для FineVare)', 
    '1.6');

----
---- ETL-19167 - UPL - ограничить выгрузку данных в файле inspaymentssc - FACT_DATE должна быть в интервале от предыдущей банковской даты (не включая) и датой выгрузки включительно
----
prompt 356 inspaymentssc
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1356, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select bars.gl.kf as KF, i.ID, 20 as TYPE, i.DEAL_ID, i.PLAN_DATE, i.FACT_DATE, i.PLAN_SUM, i.FACT_SUM, i.PMT_NUM, i.PMT_COMM, i.PAYED
  from BARS.INS_PAYMENTS_SCHEDULE i, dt
 where i.FACT_DATE between dt.dt1 and dt.dt2',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Графік платежів по страховим договорам', '1.0');

--
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
--
prompt  566 выгрузка А7

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (566, 
'SELECT v.BRANCH TOBO,
       v.ACC_NUM AS NLS,
       v.KV AS KV,
       v.REPORT_DATE DATF,
       v.ACC_ID ACC,
       v.SEG_01 DK,
       v.SEG_02 NBS,
       v.SEG_08 KV1,
       v.SEG_04 S181,
       v.SEG_03 R013,
       v.SEG_05 S240,
       v.SEG_06 K030,
       v.SEG_07 R012,
       v.FIELD_VALUE ZNAP,
       v.CUST_ID RNK,
       v.CUST_CODE OKPO,
       v.CUST_NAME NMK,
       v.MATURITY_DATE MDATE,
       acc.isp ISP,
       v.ND ND,
       v.AGRM_NUM CC_ID,
       v.BEG_DT SDATE,
       v.END_DT WDATE,
       v.REF AS REF,
       v.DESCRIPTION COMM
  FROM bars.V_NBUR_#A7_DTL v
       LEFT JOIN bars.accounts acc ON (acc.acc = v.acc_id)
 where report_date = to_date(:param1, ''dd/mm/yyyy'')',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, NULL, 'Дані про структуру активів та пасивів за строками', '1.0');


COMMIT;

