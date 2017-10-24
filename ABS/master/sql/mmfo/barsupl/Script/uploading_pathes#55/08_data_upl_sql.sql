-- ===================================================================================
-- Module : UPL
-- Date   : 11.07.2017
-- ===================================================================================
-- Запити на вивантаження даних у файли для DWH
-- ===================================================================================

/*
--**********************************
prompt дублирование файла 535 agrmchg0
prompt ТОЛЬКО ДЛЯ ТЕСТА
begin
    insert into barsupl.upl_sql (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
     select 7535, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS
       from barsupl.upl_sql
      where sql_id = 535;
    exception
      when dup_val_on_index then null;
      when others then raise;
end;
/
--**********************************
*/

delete from BARSUPL.UPL_SQL
    where SQL_ID IN (7535, 535, 6221, 7171,
                     544, 7544,
                     113, 1113,
                     158, 1158, 2158, 3158, 4158, 5158,
                     566, 567,
                     360 );
--
--ETL-19590  BUG - в файле Deposit не обрезается признак региона 
-- запрос для разовой выгрузки данных с 24/07/2017
prompt  Обновление запроса 6221 deposit

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (6221, 'select 1 type,
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
                     where bdate between to_date(''24/07/2017'', ''dd/mm/yyyy'') and to_date(:param1, ''dd/mm/yyyy'')
                       and kf = bars.gl.kf
                     group by deposit_id )
   and d.kf = bars.gl.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Депозитний портфель ФО', 
    '2.0');

--
--ETL-19646  BUG - в Т0 не приходят корпроводки договоров ХДЗ
-- 
prompt  Обновление запроса 7171 XOZ_REF0

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
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
select unique 21 TYPE, x.id ND, x.KF, x.ACC, x.REF1, x.STMT1, x.REF2, x.MDATE, x.S as s0,
       x.FDAT, x.S0 as s, x.NOTP, x.PRG, x.BU,
       decode( o2.vob, 96, x.DATZ, null) as DATZ,
       x.REFD, a.RNK, a.KV, a.TIP,
       decode( o2.vob, 96, d1.FDAT, null) as DATF
  from BARS.XOZ_REF x
       join dt on (1=1)
       join a on (a.acc = x.acc)
  left join bars.oper   o1 on ( o1.ref = x.ref1 )
  left join bars.oper   o2 on ( o2.ref = x.ref2 )
  left join bars.opldok d1 on ( d1.ref = x.ref2 and d1.acc = x.acc )
 where x.fdat <= dt.dt3
   and ( x.datz >= dt.dt3
    or x.datz is null)', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Картотека дебиторов T0', 
    '1.1');

--
--ETL-19646  BUG - в Т0 не приходят корпроводки договоров ХДЗ
-- добавлен в выгрузку параметр MDATE по договорам ХДЗ
--
prompt  Обновление запроса 535 AGRM_CHANGES
declare
  l_clob clob;
begin
l_clob := 'with DEAL0 as ( select ND, WDATE, KAT23, case vidd when 10 then 10 when 110 then 10 else 3 end as ND_TYPE0
                  from BARS.CC_DEAL_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.CC_DEAL_UPDATE
                                   where EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                   group by ND )
                   and SOS  >= 10
                   and VIDD Not in (3902,3903) ),
     DEALS as ( select d1.KF, d1.ND,
                        case d1.vidd when 10 then 10 when 110 then 10 else 3 end as ND_TYPE,
                       NULLIF( d1.WDATE, d0.WDATE ) as WDATE,
                       NULLIF( d1.KAT23, d0.KAT23 ) as KAT23
                  from DEAL0 d0
                  join ( select KF, ND, WDATE, KAT23, vidd
                           from BARS.CC_DEAL_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.CC_DEAL_UPDATE
                                            where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                            group by ND )
                            and SOS  >= 10
                            and VIDD Not in (3902,3903)
                       ) d1
                    on ( d1.ND = d0.ND )
                 where NULLIF( d1.WDATE, d0.WDATE ) is Not Null
                    or NULLIF( d1.KAT23, d0.KAT23 ) is Not Null ),
    ACCLST as ( select ACC
                  from BARS.ACCOUNTS a
                  join BARS.FIN_DEBT f
                    on ( SubStr(f.NBS_N,1,4) = a.NBS AND SubStr(f.nbs_N,5,2) = a.OB22 )
                 where a.DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                   and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              ),
';

l_clob := l_clob || '    RECVBL as ( select 17 as ND_TYPE
                     , r1.KF
                     , r1.ACC as ND
                     , NULLIF( r1.MDATE, r0.MDATE ) as WDATE
                  from ( select a.ACC, a.MDATE
                           from BARS.ACCOUNTS_UPDATE a
                          where a.IDUPD in ( select max(u.IDUPD)
                                               from BARS.ACCOUNTS_UPDATE u
                                               join ACCLST al
                                                 on ( al.ACC = u.ACC )
                                              where u.EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                              group by u.ACC )
                       ) r0
                  join ( select a.KF, a.ACC, a.MDATE
                           from BARS.ACCOUNTS_UPDATE a
                          where a.IDUPD in ( select max(u.IDUPD)
                                               from BARS.ACCOUNTS_UPDATE u
                                               join ACCLST al
                                                 on ( al.ACC = u.ACC )
                                              where u.EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                              group by u.ACC )
                       ) r1
                    on ( r1.ACC = r0.ACC )
                 where NULLIF( r1.MDATE, r0.MDATE ) is Not Null ),
     SCRTD as ( select REF as ND, ACC, ID, ERAT
                  from BARS.CP_DEAL_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.CP_DEAL_UPDATE
                                   where EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                   group by REF )
                   and ACTIVE = 1 ),
';

l_clob := l_clob || '     SCRTS as ( select BARS.GL.KF, 9 as ND_TYPE, sd.ND, sd.ERAT
                     , sk.VNCRR, sk.KAT23, sk.IR
                  from SCRTD sd
                  join ( select s1.ID
                              , NULLIF( s1.VNCRR, s0.VNCRR ) as VNCRR
                              , NULLIF( s1.KAT23, s0.KAT23 ) as KAT23
                              , NULLIF( s1.IR,    s0.IR    ) as IR
                           from ( select ID, VNCRR, KAT23, IR
                                    from BARS.CP_KOD_UPDATE
                                   where IDUPD in ( select max(IDUPD)
                                                      from BARS.CP_KOD_UPDATE
                                                     where EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                    group by ID )
                                ) s0
                           join ( select ID, VNCRR, KAT23, IR, DOK
                                    from BARS.CP_KOD_UPDATE
                                   where IDUPD in ( select max(IDUPD)
                                                      from BARS.CP_KOD_UPDATE
                                                     where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                                    group by ID )
                                ) s1
                             on ( s1.ID = s0.ID )
                          where DECODE( s1.VNCRR, s0.VNCRR, 1, 0 ) = 0
                             or DECODE( s1.KAT23, s0.KAT23, 1, 0 ) = 0
                             or ( DECODE( s1.IR, s0.IR, 1, 0 ) = 0 AND s1.DOK < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') )
                       ) sk
                    on ( sk.ID = sd.ID )
              ),
';

l_clob := l_clob || '     SCRTM as ( select BARS.GL.KF, 9 as ND_TYPE,
                       m1.ND, NULLIF( m1.MDATE, m0.MDATE ) as WDATE
                  from ( select au.ACC, au.MDATE
                           from BARS.ACCOUNTS_UPDATE au
                           join SCRTD sc
                             on ( sc.ACC = au.ACC )
                          where IDUPD = ( select max(IDUPD)
                                            from BARS.ACCOUNTS_UPDATE a
                                           where a.EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                             and a.ACC = au.ACC
                                           group by a.ACC )
                       ) m0
                  join ( select sc.ND, au.ACC, au.MDATE
                           from BARS.ACCOUNTS_UPDATE au
                           join SCRTD sc
                             on ( sc.ACC = au.ACC )
                          where IDUPD = ( select max(IDUPD)
                                            from BARS.ACCOUNTS_UPDATE a
                                           where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                             and a.ACC = au.ACC
                                           group by a.ACC )
                       ) m1
                    on ( m1.ACC = m0.ACC )
                 where NULLIF( m1.MDATE, m0.MDATE ) is Not Null
              ),
     OVERS as ( select o1.KF, 10 as ND_TYPE, o1.ND
                     , NULLIF( o1.KAT23, o0.KAT23 ) as KAT23
                  from ( select ND, KAT23
                           from BARS.ACC_OVER_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.ACC_OVER_UPDATE
                                            where EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                              and ACC = ACCO
                                            group by ACC, ND )
                       ) o0
                  join ( select KF, ND, KAT23
                           from BARS.ACC_OVER_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.ACC_OVER_UPDATE
                                            where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                              and ACC = ACCO
                                            group by ACC, ND )
                       ) o1
                    on ( o1.ND = o0.ND )
                 where NULLIF( o1.KAT23, o0.KAT23 ) is Not Null ),
';

l_clob := l_clob || '    CARDS0 as ( select ND, KAT23, DAT_END
                  from BARS.W4_ACC_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.W4_ACC_UPDATE
                                   where EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                   group by ND )
                 UNION ALL
                select ND, KAT23, Null
                  from BARS.BPK_ACC_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.BPK_ACC_UPDATE
                                   where EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                   group by ND )
                   and CHGACTION <> ''D'' ),
     CARDS as ( select BARS.GL.KF, 4 as ND_TYPE, w1.ND
                     , NULLIF( w1.KAT23,   w0.KAT23   ) as KAT23
                     , NULLIF( w1.DAT_END, w0.DAT_END ) as DAT_END
                 from CARDS0 w0
                 join ( select ND, KAT23, DAT_END
                          from BARS.W4_ACC_UPDATE
                         where IDUPD in ( select max(IDUPD)
                                            from BARS.W4_ACC_UPDATE
                                           where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                           group by ND )
                         UNION ALL
                        select ND, KAT23, Null
                          from BARS.BPK_ACC_UPDATE
                         where IDUPD in ( select max(IDUPD)
                                            from BARS.BPK_ACC_UPDATE
                                           where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                           group by ND )
                           and CHGACTION <> ''D''
                      ) w1
                   on ( w1.ND = w0.ND )
                where NULLIF( w1.KAT23,   w0.KAT23   ) is Not Null
                   or NULLIF( w1.DAT_END, w0.DAT_END ) is Not Null ),
';

l_clob := l_clob || '     XOZ   as ( select x.KF, 21 as ND_TYPE, ID as ND, X.MDATE
                  from bars.xoz_ref x
                  join bars.accounts a on (a.acc = x.acc)
                 where X.MDATE is not null )
select KF, ND_TYPE, ND,
       6, to_char(WDATE,''dd/mm/yyyy'')
  from DEALS
 where WDATE is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       7, to_char(KAT23)
  from DEALS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       6, to_char(WDATE,''dd/mm/yyyy'')
  from RECVBL
 UNION ALL
select BARS.GL.KF, t0.ND_TYPE0 as ND_TYPE, t1.ND,
       case
         when t1.TAG = ''CPROD'' then 8
         when t1.TAG = ''VNCRR'' then 9
         else null
       end as PAR_ID,
       t1.TXT as PAR_VAL
  from BARS.ND_TXT_UPDATE t1
  join DEAL0 t0 -- договора кред. які існували на ост. роб. день міс.
    on ( t0.ND = t1.ND )
 where t1.IDUPD in ( select max(IDUPD)
                       from BARS.ND_TXT_UPDATE
                      where TAG in ( ''CPROD'', ''VNCRR'' )
                        and EFFECTDATE between trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') and to_date(:param1,''dd/mm/yyyy'')
                      group by ND, TAG )
 UNION ALL
select BARS.GL.KF, 4 as ND_TYPE, b1.ND,
       9 as PAR_ID,
       b1.VALUE as PAR_VAL
  from BARS.BPK_PARAMETERS_UPDATE b1
  join CARDS0 b0 -- договора БПК які існували на ост. роб. день міс.
    on ( b0.ND = b1.ND )
 where b1.IDUPD in ( select max(IDUPD)
                       from BARS.BPK_PARAMETERS_UPDATE
                      where TAG in ( ''VNCRR'' )
                        and EFFECTDATE between trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') and to_date(:param1,''dd/mm/yyyy'')
                      group by ND, TAG )
 UNION ALL
select KF, ND_TYPE, ND,
       9, VNCRR
  from SCRTS
 where VNCRR is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       7, to_char(KAT23)
  from SCRTS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       11, to_char(IR,''FM99999900D009999999999'')
  from SCRTS
 where IR is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       12, to_char(ERAT,''FM99999900D009999999999'')
  from SCRTS
 where IR is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       6, to_char(WDATE,''dd/mm/yyyy'')
  from SCRTM
 UNION ALL
select KF, ND_TYPE, ND,
       7, to_char(KAT23)
  from OVERS
 where KAT23 is Not Null
  UNION ALL
select KF, ND_TYPE, ND, 6,
       to_char(DAT_END,''dd/mm/yyyy'')
  from CARDS
 where DAT_END is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 7,
       to_char(KAT23)
  from CARDS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       6, to_char(MDATE,''dd/mm/yyyy'')
  from XOZ';

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (535, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Змінені параметри договорів (для FineVare)', 
    '2.1');
end;
/

--
--     ETL-19708   UPL - выгрузка графиков ФЛ
--
prompt  544 выгрузка графиков ФЛ
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (544, 'select 3 as ND_TYPE, 13 as PRVN_TP, bars.gl.kf as KF,
       p.ID,   p.ND,   p.FDAT, p.SS,
       p.SPD,  p.SN,   p.SK,   p.LIM1,
       p.LIM2, p.DAT1, p.DAT2, p.SPN,
       p.SNO,  p.SP,   p.SN1,  p.SN2,
       p.MDAT
  from BARS.PRVN_FLOW_DETAILS   p
  join BARS.PRVN_FLOW_DEALS_VAR v
    on ( v.ID = p.ID and v.ZDAT = p.MDAT )
 where to_date(:param1,''dd/mm/yyyy'') = BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1)
   and p.MDAT = add_months(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),1)
   and Not ( p.SS  = 0 and p.SPD = 0 and p.SN = 0 and p.SK  = 0 and
             p.SPN = 0 and p.SNO = 0 and p.SP = 0 and p.SN1 = 0 and p.SN2 = 0 )
   and ( v.VIDD in ( 1, 2, 3, 11, 12, 13 )
         or
         vidd between 1500 and 1599 )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Таблиця грош.потоків КД-угод для сховища', 
    '1.6');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (7544, 'select 3 as ND_TYPE, 13 as PRVN_TP, bars.gl.kf as KF,
       p.ID,   p.ND,   p.FDAT, p.SS,
       p.SPD,  p.SN,   p.SK,   p.LIM1,
       p.LIM2, p.DAT1, p.DAT2, p.SPN,
       p.SNO,  p.SP,   p.SN1,  p.SN2,
       p.MDAT
  from BARS.PRVN_FLOW_DETAILS   p
  join BARS.PRVN_FLOW_DEALS_VAR v
    on ( v.ID = p.ID and v.ZDAT = p.MDAT )
 where p.MDAT = trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
   and Not ( p.SS  = 0 and p.SPD = 0 and p.SN = 0 and p.SK  = 0 and
             p.SPN = 0 and p.SNO = 0 and p.SP = 0 and p.SN1 = 0 and p.SN2 = 0 )
   and ( v.VIDD in ( 1, 2, 3, 11, 12, 13 )
         or
         vidd between 1500 and 1599 )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Таблиця грошових потоків субугод КД (для FineVare)', 
    '1.5');

--
--ETL-19709 UPL - доработать выгрузку ФДЗ в части выделения в отдельные договора
--
prompt  113 RECEIVABLES
declare
  l_clob clob;
begin
l_clob := 'with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --все счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC  -- все тела
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC  -- все просрочки, которые не привязаны в PRVN_FIN_DEB
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
     --счета ФДЗ в архиве с датой выноса в архив (считаем датой закрытия договора), по которым разрушена связь в PRVN_FIN_DEB
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT --все тела
                from BARS.PRVN_FIN_DEB_ARCH b
              union
              select unique b.ACC_SP, b.CLS_DT        -- все просрочки, которые не привязаны в PRVN_FIN_DEB
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
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

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
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
end;', NULL, 'Фінансова дебіторська заборгованість (full)', '1.5');
end;
/

prompt  1113 RECEIVABLES
declare
  l_clob clob;
begin
l_clob :='with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select /*+ materialise */ au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
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
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
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

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
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
end;', NULL, 'Фінансова дебіторська заборгованість (part)', '1.5');
end;
/

--
--ETL-19709 UPL - доработать выгрузку ФДЗ в части выделения в отдельные договора
--
prompt  158 ARRACC2
declare
  l_clob clob;
begin
l_clob :='with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
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
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
';

l_clob := l_clob || '       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
 'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.2');
end;
/

prompt  1158 ARRACC2
declare
  l_clob clob;
begin
l_clob :='with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
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
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
';

l_clob := l_clob || '       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', 
    '5.2');
end;
/

prompt  2158 ARRACC2
declare
  l_clob clob;
begin
l_clob :='with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
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
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
';

l_clob := l_clob || '       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.2');
end;
/

prompt  3158 ARRACC2
declare
  l_clob clob;
begin
l_clob :='with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
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
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
';

l_clob := l_clob || '       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
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
   and a.DAOS <= dt.dt2';
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (3158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + РКО + ЦП)', '5.2');
end;
/

prompt  4158 ARRACC2
declare
  l_clob clob;
begin
l_clob :='with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac1 as ( select unique a.ACC
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
              union
              select unique a.ACC
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b
                ),
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
';

l_clob := l_clob || '       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (4158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
   'Зв''язок угода-рахунок для виду 2 (дельта + Full по ФДЗ) ММФО', '1.2');
end;
/

prompt  5158 ARRACC2
declare
  l_clob clob;
begin
l_clob :='with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac1 as ( select unique a.ACC
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
              union
              select unique a.ACC
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b
                ),
     --счета ФДЗ в архиве
     ac2 as ( select unique b.ACC_SS as acc, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
              union
              select unique b.ACC_SP, b.CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
';

l_clob := l_clob || '       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
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
   and a.DAOS <= dt.dt2';

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (5158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
 'Зв''язок угода-рахунок для виду 2 (дельта + Full по ФДЗ) РУ', '1.2');
end;
/

--
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
--
prompt  566 выгрузка А7

Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (566, 
'WITH
 VER as(
 SELECT max(lst.VERSION_ID) maxver
   FROM bars.NBUR_REF_FILES ref JOIN 
        bars.NBUR_LST_FILES lst
            ON (lst.FILE_ID = ref.ID)
   WHERE lst.report_date = to_date(:param1, ''dd/mm/yyyy'')
   and ref.FILE_CODE = ''#A7'' 
   AND lst.FILE_STATUS IN (''FINISHED'', ''BLOCKED'')
 )
    SELECT v.BRANCH TOBO,
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
       v.DESCRIPTION COMM,
       v.KF
  FROM ver ver,
       bars.V_NBUR_#A7_DTL v
       LEFT JOIN bars.accounts acc ON (acc.acc = v.acc_id)
  where report_date = to_date(:param1, ''dd/mm/yyyy'') 
        and v.VERSION_ID = ver.maxver',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, NULL, 'Дані про структуру активів та пасивів за строками', '1.0');

--567:
Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (567, 
'WITH
 VER as(
 SELECT max(lst.VERSION_ID) maxver
   FROM bars.NBUR_REF_FILES ref JOIN 
        bars.NBUR_LST_FILES lst
            ON (lst.FILE_ID = ref.ID)
   WHERE lst.report_date = to_date(:param1, ''dd/mm/yyyy'')
   and ref.FILE_CODE = ''#A7'' 
   AND lst.FILE_STATUS IN (''FINISHED'', ''BLOCKED'')
 )
 SELECT 
       lst.FILE_NAME,
       lst.VERSION_ID,
       to_date(to_char(lst.START_TIME,''ddmmyyyyhh24miss'')
            ,''ddmmyyyyhh24miss'') as START_TIME,
       to_date(to_char(lst.FINISH_TIME,''ddmmyyyyhh24miss'')
            ,''ddmmyyyyhh24miss'') as FINISH_TIME, 
       lst.KF
   FROM ver ver,
        bars.NBUR_REF_FILES ref JOIN 
        bars.NBUR_LST_FILES lst
            ON (lst.FILE_ID = ref.ID)
   WHERE lst.report_date = to_date(:param1, ''dd/mm/yyyy'')
   and ref.FILE_CODE = ''#A7'' 
   and lst.FILE_STATUS IN (''FINISHED'', ''BLOCKED'')
   and lst.VERSION_ID = VER.maxver',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, NULL, 'Дані про структуру активів та пасивів за строками', '1.0');

/*
--
-- письмо Демкович от 29.08.2017 20:20
-- прерывать выгрузку Т0 при несбалансированной картотеке bars.xoz.STOP_T0
-- "закомментировано, поскольку нет заявки"
prompt  Обновление запроса 360 PRE_T0

declare
  l_clob clob;
begin
  l_clob := 
q'{declare
  l_report_date    date;  -- звітна дата
  l_lind varchar2(4000);
begin
  barsupl.bars_upload_usr.tuda;
  l_report_date := trunc(to_date(:param1,'dd/mm/yyyy'),'MM');

  select listagg(d1.nd,',') within group (order by d1.nd) as li_nd
-- запит максимально приближено саме до тексту запиту в Z23.pkg
--  для запобігання помилки, яка була в Одесі,
--  коли для угоди не було знайдено рахунку TIP='LIM'
  into l_lind
  from bars.cc_deal d1
  where d1.vidd in (1,2,3,11,12,13) and d1.sdate < to_date(l_report_date,'dd-mm-yyyy')
        and d1.nd not in (
            select d.nd
            from bars.cc_deal d join bars.nd_acc c on d.kf=c.kf and d.nd=c.nd
                join bars.accounts a on d.kf=a.kf and c.acc=a.acc and a.tip='LIM'
            where d.nd=d1.nd
        );

  if l_lind is not null then
--    bars_audit.error('Для угод(и) '||l_lind||' не заведено рахунку виду LIM (8999) ...');
    raise_application_error('-20000','Для угод(и) '||l_lind||' не заведено рахунку виду LIM (8999) ...');
  end if;

-- картотека хоз.деб. должны быть без расхождений
  l_report_date := dat_next_u(trunc(to_date(:param1,'dd/mm/yyyy'),'MM'), -1);
  bars.xoz.STOP_T0(null, l_report_date);
end;}';
 
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (360, 'select 1 as fl from dual where 1=2', l_clob, 
    null, 'Перевірка коректності вхідних даних для розрахунку резервів', '1.0');
end;
/
*/

COMMIT;

