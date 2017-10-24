-- ===================================================================================
-- Module : UPL
-- Date   : 09.06.2017
-- ===================================================================================
-- Запити на вивантаження даних у файли для DWH
-- ===================================================================================

delete from BARSUPL.UPL_SQL 
    where mod(SQL_ID,1000) IN ( 113, 158, 111, 116, 164 );

delete from BARSUPL.UPL_SQL
	where SQL_ID IN (139, 235, 1224, 230, 231, 232, 236, 560, 6201, 99201, 99159, 1123 );

--
-- 139 (accpardeb) ETL-18831 UPL -загружать в MIR новые дополнительные параметры счетов (хозяйственная дебиторская задолженность)  
--
prompt  Обновление запроса 139 accpardeb

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (139, 'select s.acc, s.kf,  s.DEB01, s.DEB02, s.DEB03 
  from bars.specparam_int s,
       bars.accounts a
 where s.acc = a.acc
   and (a.dazs is null or a.dazs >= to_date(:param1, ''dd/mm/yyyy''))
   and a.nbs in (''3510'', ''3519'', ''3550'', ''3551'', ''3552'', ''3553'', ''3554'', ''3555'', ''3556'', ''3557'', ''3558'', ''3559'')', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', '', 'Додаткові параметри рахунків господарської дебиторської заборгованості', 
    '1.0');



--
-- Обновление запросов 235 для ММФО выгрузка SKRYNKA_ND 'договора аренды сейфов'
-- перед выгрузкой выйти на уровень '/' и наложить фильтр по KF из-за 
-- n.kf = kf.kf + suda + tuda
prompt  Обновление запросов 235

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (235, 'with kf as (select /*+ materialize */
                   coalesce( bars_upload.get_param(''KF''),
                            (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))
                           ) kf
              from dual)
select 18 type_id, ND, N_SK, SOS, FIO, DOKUM, ISSUED, ADRES, DAT_BEGIN, DAT_END, TEL, DOVER, NMK,
       DOV_DAT1, DOV_DAT2, DOV_PASP, MFOK, NLSK, CUSTTYPE, O_SK, ISP_DOV, NDOV, NLS, NDOC,
       DOCDATE, SDOC, TARIFF, FIO2, ISSUED2, ADRES2, PASP2, OKPO1, OKPO2, S_ARENDA, S_NDS,
       SD, KEYCOUNT, PRSKIDKA, PENY, DATR2, MR2, MR, DATR, ADDND, AMORT_DATE, BRANCH,
       n.KF, DAT_CLOSE, DEAL_CREATED, IMPORTED, RNK
  from bars.skrynka_nd n, kf
 where n.kf = kf.kf',
'begin execute immediate ''begin barsupl.bars_upload_usr.suda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
'begin barsupl.bars_upload_usr.tuda(null); end;', 'Угоди оренди депозитних сейфів', 
    '1.1');

--
-- Перед выгрузкой договоров аренды сейфов представится регионом а не слешом
--
prompt  Перед выгрузкой договоров аренды сейфов представится регионом

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (230, 'select o_sk, name, s*100 s, branch, kf, etalon_id, cell_count
  from bars.skrynka_tip', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Види депозитних сейфів', 
    '1.1');

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (231, 'select tariff, name, tip, o_sk, branch, basey, basem, kf
  from bars.skrynka_tariff', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Тарифи користування депозитними сейфами', 
    '1.1');

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (232, 'select o_sk, n_sk, snum, keyused, isp_mo, keynumber, branch, kf
  from bars.skrynka', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Портфель депозитних сейфів', 
    '1.1');

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (236, 'select 18 type_id, nd, ref, rent, branch, kf
  from bars.skrynka_nd_ref', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Платіжні документи за угодами оренди депозитних сейфів', 
    '1.1');

--
-- Обновление запроса 1224 для ММФО выгрузка DPT_AGREEMENTS
-- должны выгружаться отмененные договора
prompt  Обновление запросов 1224

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1224, 'select 1 as nd_type, ag.kf, ag.agrmnt_id, ag.agrmnt_date, ag.agrmnt_num, ag.agrmnt_type, ag.dpt_id,
       ag.cust_id, ag.bankdate, ag.trustee_id, ag.transfer_bank, ag.transfer_account, ag.amount_cash,
       ag.amount_cashless, ag.amount_interest, ag.date_begin, ag.date_end, ag.agrmnt_state, ag.comiss_ref,
       ag.undo_id, ag.doc_ref, ag.comiss_reqid, ag.rate_value, ag.rate_date
  from bars.dpt_agreements ag,
       (select kf, agrmnt_id
          from bars.dpt_agreements
         where kf = bars.gl.kf
           and bankdate = to_date(:param1, ''dd/mm/yyyy'')) ad
 where (ag.agrmnt_id = ad.agrmnt_id or ag.undo_id = ad.agrmnt_id)
   and ag.kf = ad.kf',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
'Портфель додаткових угод по депозитним договорам ФО', 
    '1.2');

--
-- 158 (arracc2) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
-- добавлено закрытие связок при переносе ФДЗ в архив
-- объеденены запросы РУ и ЦА
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
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.0');
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
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.0');
end;
/


--
-- 113 (RECEIVABLES) ETL-18961 UPL - изменить выгрузку arracc2 и receivables с учет закрывающихся договоров финансовой дебиторской задолженности
-- добавлено закрытие договоров при переносе ФДЗ в архив
-- для РУ закрытие ФДЗ не установлено 
prompt  RECEIVABLES

declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --все счета ФДЗ по маппингу
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
';
l_clob := l_clob || 'select 17 as ND_TYPE,
       a.ACC as ND,
       a.KF,
       a.DAOS  as SDATE,
       a.MDATE as WDATE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then ac3.CLS_DT
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Null )                             then a.DAZS
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Not Null AND p.DAZS Is Not Null )  then greatest(a.DAZS,p.DAZS)
         else Null
       end     as DATE_CLOSE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then 15
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Null )                             then 15
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Not Null AND p.DAZS Is Not Null )  then 15
         else 10
       end     as SOS,
       a.NlS   as CC_ID,
       a.RNK,
       a.BRANCH
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join BARS.ACCOUNTS p          on ( p.ACC = f.ACC_SP )
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
   (113, l_clob, 'begin
  barsupl.bars_upload_usr.tuda;
  BARS.prvn_flow.ADD_FIN_DEB( to_date(:param1,''dd/mm/yyyy'') );
  commit;
  exception when
      others then
       if sqlcode = -6550
           then null;
           else raise;
       end if;
end;', NULL, 'Фінансова дебіторська заборгованість (full)', '1.4');
end;
/

--1113
declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select /*+ materialise */ au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
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
';
l_clob := l_clob || 'select 17 as ND_TYPE,
       a.ACC as ND,
       a.KF,
       a.DAOS  as SDATE,
       a.MDATE as WDATE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then ac3.CLS_DT
         when ( a.DAZS is Not Null AND f.ACC_SP is Null )                             then a.DAZS
         when ( a.DAZS is Not Null AND f.ACC_SP is Not Null AND p.DAZS is Not Null )  then greatest(a.DAZS,p.DAZS)
         else Null
       end     as DATE_CLOSE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then 15
         when ( a.DAZS is Not Null AND f.ACC_SP is Null )                             then 15
         when ( a.DAZS is Not Null AND f.ACC_SP is Not Null AND p.DAZS is Not Null )  then 15
         else 10
       end     as SOS,
       a.NlS   as CC_ID,
       a.RNK,
       a.BRANCH
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join BARS.ACCOUNTS p          on ( p.ACC = f.ACC_SP )
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
   (1113, l_clob, 'begin
 barsupl.bars_upload_usr.tuda;
 BARS.prvn_flow.ADD_FIN_DEB( to_date(:param1,''dd/mm/yyyy'') );
 commit;
 exception
  when others then
   if sqlcode = -6550
     then null;
     else raise;
   end if;
end;', NULL, 'Фінансова дебіторська заборгованість (part)', '1.4');

end;
/


---
--- CUSVALS Ремонтируем запросы *116
--- update  BARSUPL.UPL_SQL  set  SQL_TEXT = replace (SQL_TEXT, 'trim(u1.tag) = l.tag', 'u1.tag = trim(l.tag)' ) where sql_id in (3116,4116);
-- полная выгрузка тега NDBO
prompt CUSVALS
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD'')
                      --and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'') + 1
                      and ((u1.effectdate  <= to_date (:param1, ''dd/mm/yyyy'') )
                       or (u1.chgdate      <  to_date (:param1, ''dd/mm/yyyy'') + 1 ))
                    group by u1.rnk, u1.tag )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
NULL, 'Значення додаткових реквізитів клієнта', '2.4');

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1116, 'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
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
                    group by rnk, u1.tag )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
NULL, 'Значення додаткових реквізитів клієнта', '2.5');

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2116, 'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag not in (''NDBO''))
                      and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= dt.dt1
                      and coalesce(u1.effectdate,u1.chgdate) < dt.dt2 + 1
                    group by rnk, u1.tag )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag in (''NDBO''))
                      and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'') + 1
                    group by u1.rnk, u1.tag )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
NULL, 'Щоденне вивантаження + повне ЛИШЕ за вказаними тегами', '1.3');

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (3116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD'')
                      --and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'') + 1
                      and ((u1.effectdate  <= to_date (:param1, ''dd/mm/yyyy'') )
                       or (u1.chgdate      <  to_date (:param1, ''dd/mm/yyyy'') + 1 ))
                      and u1.kf = bars.gl.kf
                    group by u1.rnk, u1.tag )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
NULL, 'Значення додаткових реквізитів клієнта', '2.5');

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (4116, 'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
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
                    group by rnk, u1.tag )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
NULL, 'Значення додаткових реквізитів клієнта', '2.6');

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (5116, 'with   dt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, dt
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag not in (''NDBO''))
                      and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= dt.dt1
                      and coalesce(u1.effectdate,u1.chgdate) < dt.dt2 + 1
                      and u1.kf = bars.gl.kf
                    group by rnk, u1.tag )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1
                    where u1.tag in (select tag
                                       from barsupl.upl_tag_lists l
                                      where l.tag_table = ''CUST_FIELD''
                                        and l.tag in (''NDBO''))
                      and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'') + 1
                      and u1.kf = bars.gl.kf
                    group by u1.rnk, u1.tag )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
NULL, 'Щоденне вивантаження + повне ЛИШЕ за вказаними тегами', '1.3');



---
--- OVERS 111
--- ETL-19061 UPL - Изменить выгрузку по овердрафтам - из ММФО не присылать овердрафты из старого модуля
prompt OVERS
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (111, 'with mmfo as ( select case when barsupl.bars_upload_utl.is_mmfo > 1 then 1 else 0 end mmfo  from dual )
select unique 10 TYPE, o.datd, o.sd, o.ndoc, o.datd2, o.fin23, o.obs23,
        o.kat23, o.k23, o.nd, a.kf, a.kv, a.branch, a.rnk,
        decode(o.chgaction, ''D'', o.EFFECTDATE, Null ) as DATE_CLOSE
    from mmfo,
         BARS.ACC_OVER_UPDATE o
         join BARS.ACCOUNTS a on ( o.acc = a.acc )
    where o.idupd in ( select MAX(idupd)
                        from BARS.ACC_OVER_UPDATE
                        where EFFECTDATE <= TO_DATE(:param1, ''dd/mm/yyyy'')
                            and ACC = ACCO
                        group by ACC, ND)
      and coalesce(o.sos,0) <> 110
      and mmfo.mmfo = 0', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Угоди овердрафту', 
    '3.5');

---
--- ARRACC5 164
--- ETL-19061 UPL - Изменить выгрузку по овердрафтам - из ММФО не присылать овердрафты из старого модуля
prompt ARRACC5
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (164, 'with mmfo as ( select case when barsupl.bars_upload_utl.is_mmfo > 1 then 1 else 0 end mmfo  from dual ),
     ovr  as ( select /*+ MATERIALIZE */ nd, acc, kf
                 from mmfo, BARS.ACC_OVER_UPDATE
                    UNPIVOT EXCLUDE NULLS (acc FOR acc_typ IN (acc      AS ''acc'',
                                                               acco     AS ''acco'',
                                                               acc_9129 AS ''acc_9129'',
                                                               acc_8000 AS ''acc_8000'',
                                                               acc_2067 AS ''acc_2067'',
                                                               acc_2069 AS ''acc_2069'',
                                                               acc_2096 AS ''acc_2096'',
                                                               acc_3739 AS ''acc_3739'',
                                                               acc_3600 AS ''acc_3600'' )
                                           )
                where idupd in ( select MAX(idupd)
                                   from BARS.ACC_OVER_UPDATE
                                  where EFFECTDATE <= TO_DATE (:param1, ''dd/mm/yyyy'')
                                    and ACC = ACCO
                                  group by ACC, ND )
                  and chgaction <> ''D''
                  and coalesce(sos,0) <> 110
                  and mmfo.mmfo = 0)
select nd, acc, kf, 10 nd_type, ''I'' chgaction
  from ovr
 where 0 not in (coalesce(acc,0),coalesce(nd,0))
union
select u.nd, u.acc, u.kf, 10 nd_type, ''I'' chgaction
  from bars.nd_acc_update u join ovr o on u.nd=o.nd
 where u.idupd in ( select MAX(u1.IDUPD)
                      from BARS.ND_ACC_UPDATE u1, ovr o
                     where u1.EFFECTDATE <= TO_DATE(:param1,''dd/mm/yyyy'')
                       and u1.nd = o.nd
                     group by u1.acc, u1.nd )
   and u.chgaction <> ''D''', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок угод із рахунками за угодами овердрафту', '1.2');

--
-- ETL-18983 BUG - Выгрузка fin_rnk из ММФО. Нет разделения клиентов по РУ (Дублируются данные по всем РУ ) +  обрезаны OKPO
-- 
prompt FIN_RNK
Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values  (560, 'select bars.gl.kf kf, f.FDAT, f.IDF, f.KOD, f.S, to_char(f.OKPO,''fm99999999999999'') OKPO, f.BRANCH, f.SS
  from BARS.FIN_RNK f
 where idf in (1,2)
   AND bars.gl.kf= SUBSTR(f.BRANCH, 2,6)', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Фiн.звiти клiєнтiв', '1.1');

--
-- CREDITS
-- ETL-19018 UPL - initial upload - 99 группа (Выгрузить все договора овердрафтов (credits с типом 10) + arracc5)
prompt CREDITS
declare
  l_clob clob;
begin
l_clob := 'select case cc.vidd when 10 then 10 when 110 then 10 else 3 end as arrtype,
       cc.nd, cc.SOS, cc.CC_ID, cc.SDATE, cc.WDATE, RNK, cc.VIDD, cc.LIMIT,
       cc.BRANCH, cc.KF, cc.IR, cc.PROD, cc.SDOG, cc.FIN23, cc.NDI, cc.OBS23, cc.KAT23,
       case when nt.TXT = ''1'' then ''0'' else ''1'' end as RESTORE_FLAG,
       case when cc.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39 ) then 1 else 0 end as CRD_FACILITY,
       cc.K23, s.GPK_TYPE, s.KV, nvl(s.istval,0) as ISTVAL, cc.user_id
  from bars.cc_deal_update  cc
  join bars.cc_vidd v
    on ( v.vidd = cc.vidd )
  left
  join bars.nd_txt nt
    on ( nt.ND = cc.ND and nt.TAG = ''I_CR9'' )
  left
  join ( select n.nd, a.vid as GPK_TYPE, a.kv, s.ISTVAL
           from BARS.ND_ACC    n,
                BARS.ACCOUNTS  a,
                BARS.SPECPARAM s
          where n.acc = a.acc
            and a.nls like ''899%''
            and a.acc = s.acc(+)
       ) s
    on ( s.nd = cc.nd )
 where cc.idupd = ( select max(IDUPD)
                      from BARS.CC_DEAL_UPDATE cu
                     where cu.ND = cc.ND
                       and cu.EFFECTDATE between bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                                             and to_date(:param1,''dd/mm/yyyy'') )
  and cc.sos > 0
  and v.custtype in (2,3)
  and v.tipd = 1
  and v.vidd Not In (137,237,337, 10, 110)
union all
';
l_clob := l_clob || 'select case cc.vidd when 10 then 10 when 110 then 10 else 3 end as arrtype,
       cc.nd, cc.SOS, cc.CC_ID, cc.SDATE, cc.WDATE, RNK, cc.VIDD, cc.LIMIT,
       cc.BRANCH, cc.KF, cc.IR, cc.PROD, cc.SDOG, cc.FIN23, cc.NDI, cc.OBS23, cc.KAT23,
       case when nt.TXT = ''1'' then ''0'' else ''1'' end as RESTORE_FLAG,
       case when cc.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39 ) then 1 else 0 end as CRD_FACILITY,
       cc.K23, s.GPK_TYPE, s.KV, nvl(s.istval,0) as ISTVAL, cc.user_id
  from bars.cc_deal_update  cc
  join bars.cc_vidd v
    on ( v.vidd = cc.vidd )
  left
  join bars.nd_txt nt
    on ( nt.ND = cc.ND and nt.TAG = ''I_CR9'' )
  left
  join ( select n.nd, a.vid as GPK_TYPE, a.kv, s.ISTVAL
           from BARS.ND_ACC    n,
                BARS.ACCOUNTS  a,
                BARS.SPECPARAM s
          where n.acc = a.acc
            and a.nls like ''899%''
            and a.acc = s.acc(+)
       ) s
    on ( s.nd = cc.nd )
 where cc.idupd = ( select max(idupd)
                      from BARS.CC_DEAL_UPDATE cu
                     where cu.ND = cc.ND
                       and cu.vidd In (10, 110)
                       and cu.EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'') )
  and cc.sos > 0
  and v.custtype in (2,3)
  and v.tipd = 1
  and v.vidd In (10, 110)';

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (99201, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Дельта по кредитам и полная по овердрафтам', '1.0');
end;
/

--
-- ARRACC1
-- ETL-19018 UPL - initial upload - 99 группа
-- Выгрузить все договора овердрафтов (credits с типом 10) + arracc1 (только ММФО)
prompt ARRACC1
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (99159, 'select unique u.ND, u.ACC,
       BARS.GL.KF,
       decode(d.vidd, 26, 19, 10, 10, 110, 10, 3) as ND_TYPE,
       u.CHGACTION
  from BARS.ND_ACC_UPDATE  u,
       BARS.CC_DEAL_UPDATE d,
       BARS.CC_VIDD        v,
       BARS.ACCOUNTS       a
where u.idupd in ( select MAX(u1.IDUPD)
                      from BARS.ND_ACC_UPDATE u1
                     where global_bdate >= bars_upload_usr.get_last_work_date(to_date(:param1,''dd/mm/yyyy'')) + 1
                        and EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                     group by u1.acc, u1.nd )
   and u.nd   = d.nd
   and v.vidd not in (137,237,337,10,110)
   and d.vidd = v.vidd
   and v.custtype <> 1
   and a.acc = u.acc
   and a.rnk = d.rnk
union all
select unique acc as nd,
              acc,
              bars.gl.kf,
              5 nd_type,
              u1.chgaction
  from bars.pawn_acc_update u1
where u1.idupd in
       (  select MAX (u1.idupd) idupd
            from bars.pawn_acc_update u1
           where u1.effectdate between bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                                   and to_date (:param1, ''dd/mm/yyyy'')
           group by u1.acc )
union all
select unique u.ND, u.ACC,
       BARS.GL.KF,
       decode(d.vidd, 26, 19, 10, 10, 110, 10, 3) as ND_TYPE,
       u.CHGACTION
  from BARS.ND_ACC_UPDATE  u,
       BARS.CC_DEAL_UPDATE d,
       BARS.CC_VIDD        v,
       BARS.ACCOUNTS       a
where u.idupd in ( select MAX(u1.IDUPD)
                      from BARS.ND_ACC_UPDATE u1
                     where u1.EFFECTDATE <= TO_DATE(:param1,''dd/mm/yyyy'')
                     group by u1.acc, u1.nd )
   and u.nd   = d.nd
   and v.vidd not in (10,110)
   and d.vidd = v.vidd
   and v.custtype <> 1
   and a.acc = u.acc
   and a.rnk = d.rnk', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
NULL, 'Дельта + полная овердрафтов', '1.0');


--
-- PERSON
-- ETL-18821 BUG - ФЛ приходят в customer, но не приходят в person. 
prompt PERSON
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1123, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tabc as ( select cu.rnk
                 from bars.customer_update cu, dt
                where global_bdate >= dt.dt1
                  and (effectdate <= dt.dt2 or (effectdate > dt.dt2 and chgaction = 1))
                  and cu.custtype = 3
                group by rnk
             ),
     tabw as (select cwu.rnk
                from bars.customerw_update cwu, dt
                where cwu.chgdate >= dt1
                  and coalesce(cwu.effectdate,cwu.chgdate) < dt2+1
                  and cwu.tag in (select tag
                                    from barsupl.upl_tag_lists l
                                   where l.tag_table = ''CUST_FIELD'')
                group by cwu.rnk
             ),
     tabp as ( select cu.rnk
                 from bars.person_update cu, dt
                where cu.global_bdate >= dt.dt1
                  and (cu.effectdate <= dt.dt2 or (cu.effectdate > dt.dt2 and cu.chgaction = ''I''))
                group by cu.rnk
             ),
        t as (select rnk from tabc union select rnk from tabp union select rnk from tabw)
select u.rnk, u.sex, u.bday, u.passp, u.numdoc, u.ser, u.pdate, u.teld, u.telw, bars.gl.kf, u.organ
  from bars.person_update u
 where u.idupd in (select max(cu.idupd)
                     from bars.person_update cu, t, dt
                    where cu.rnk = t.rnk
                      and ( cu.effectdate   <= dt.dt2
                       or ( cu.global_bdate >= dt.dt1 and cu.chgaction = ''I''))
                    group by cu.rnk)', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
	NULL, 'Клієнти - фізичні особи', '3.6');


COMMIT;
