-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов дл€ файла выгрузки (список через зап€тую, без пробелов)
--define sfile_id = 535
--define ssql_id  = 535

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 535');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (535))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 535');
end;
/
-- ***************************************************************************
-- TSK-0001182 UPL - изменение выгрузки “0 (дл€ кредитов Instalment)
-- TSK-0001495 UPL - изменение выгрузки “0 (дл€ кредитов Instalment) - номинальна€ ставка и ставка комиссий
--  COBUINST-14 - ¬ивантаженн€ даних дл€ —ƒ по продукту Instalment
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (535);

declare l_clob clob;
begin
l_clob:= to_clob('with    dt as ( select trunc(to_date (:param1, ''dd/mm/yyyy''),''MM'') dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
               /* действующие договора, измененные с первого числа мес€ца */
    DEALS1 as ( select KF, ND, WDATE, KAT23, VIDD
                  from BARS.CC_DEAL_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.CC_DEAL_UPDATE, dt
                                   where EFFECTDATE between dt.dt1 and dt.dt2
                                   group by ND )
                   and SOS  >= 10
                   and VIDD Not in (3902,3903) ),
               /* состо€ние измененнных договоров на конец прошлого мес€ца */
     DEALS as ( select d.KF, d.ND, case d.VIDD when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as ND_TYPE,
                       NULLIF( d.WDATE, u0.WDATE ) as WDATE,
                       NULLIF( d.KAT23, u0.KAT23 ) as KAT23
                  from BARS.CC_DEAL_UPDATE u0
                  join DEALS1 d on (d.ND = u0.ND)
                 where u0.IDUPD in ( select /*+ index (u1 XAI_CCDEAL_UPDATEPK)*/ max(u1.IDUPD)
                                       from BARS.CC_DEAL_UPDATE u1
                                       join DEALS1 d1 on (d1.ND = u1.ND),
                                            dt
                                      where u1.EFFECTDATE < dt.dt1
                                      group by u1.ND )
                   and u0.SOS  >= 10
                   and u0.VIDD Not in (3902,3903) ),
    ND_TXT as (select t1.KF, t1.ND,
                      case
                        when t1.TAG = ''CPROD''   then 8
                        when t1.TAG = ''VNCRR''   then 9
                        when t1.TAG = ''BUS_MOD'' then 14
                        when t1.TAG = ''SPPI''    then 15
                        when t1.TAG = ''IFRS''    then 16
                        when t1.TAG = ''INTRT''   then 17
                        when t1.TAG = ''ND_REST'' then 18
                        else null
                      end as PAR_ID,
                      t1.TXT as PAR_VAL
                 from BARS.ND_TXT_UPDATE t1
                where t1.IDUPD in ( select max(IDUPD)
                                      from BARS.ND_TXT_UPDATE, dt
                                     where TAG in ( ''CPROD'', ''VNCRR'', ''BUS_MOD'', ''SPPI'', ''IFRS'', ''INTRT'', ''ND_REST'' )
                                       and EFFECTDATE between dt.dt1 and dt.dt2
                                     group by ND, TAG )),
    ACCLST as ( select a.KF, a.ACC, a.MDATE
                  from BARS.ACCOUNTS_UPDATE a, dt
                 where a.IDUPD in ( select max(u.IDUPD)
                                      from dt, BARS.ACCOUNTS_UPDATE u
                                      join BARS.PRVN_FIN_DEB al on ( al.ACC_SS = u.ACC )
                                     where u.EFFECTDATE between dt.dt1 and dt.dt2
                                     group by u.ACC )
              ),
    RECVBL as ( select 17 as ND_TYPE, a.KF, a.ACC as ND, NULLIF( a.MDATE, al0.MDATE ) as WDATE
                  from BARS.ACCOUNTS_UPDATE a,
                       ACCLST al0, dt
                 where a.IDUPD in ( select max(u.IDUPD)
                                      from dt, BARS.ACCOUNTS_UPDATE u
                                      join ACCLST al on ( al.ACC = u.ACC )
                                     where u.EFFECTDATE < dt.dt1
                                     group by u.ACC )
                   and al0.acc = a.acc
                   and NULLIF( a.MDATE, al0.MDATE ) is Not Null
                   and a.DAOS < dt.dt1
              ),
     SCRTD as ( select REF as ND, ACC, ID, ERAT, KF
                  from BARS.CP_DEAL_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.CP_DEAL_UPDATE, dt
                                   where EFFECTDATE < dt.dt1
                                   group by REF )
                   and ACTIVE = 1 ),
     SCRTS as ( select sd.KF, 9 as ND_TYPE, sd.ND, sd.ERAT, sk.VNCRR, sk.KAT23, sk.IR
                  from SCRTD sd
                  join ( select s1.ID
                              , NULLIF( s1.VNCRR, s0.VNCRR ) as VNCRR
                              , NULLIF( s1.KAT23, s0.KAT23 ) as KAT23
                              , NULLIF( s1.IR,    s0.IR    ) as IR
                           from ( select ID, VNCRR, KAT23, IR
                                    from BARS.CP_KOD_UPDATE
                                   where IDUPD in ( select max(IDUPD)
                                                      from BARS.CP_KOD_UPDATE, dt
                                                     where EFFECTDATE < dt.dt1
                                                    group by ID )
                                ) s0
                           join ( select ID, VNCRR, KAT23, IR, DOK
                                    from BARS.CP_KOD_UPDATE
                                   where IDUPD in ( select max(IDUPD)
                                                      from BARS.CP_KOD_UPDATE, dt
                                                     where EFFECTDATE <= dt.dt2
                                                    group by ID )
                                ) s1
                             on ( s1.ID = s0.ID ),
                             dt
                          where DECODE( s1.VNCRR, s0.VNCRR, 1, 0 ) = 0
                             or DECODE( s1.KAT23, s0.KAT23, 1, 0 ) = 0
                             or ( DECODE( s1.IR, s0.IR, 1, 0 ) = 0 AND s1.DOK < dt.dt1 )
                       ) sk
                    on ( sk.ID = sd.ID )
              ),
     SCRTM as ( select m1.KF, 9 as ND_TYPE, m1.ND, NULLIF( m1.MDATE, m0.MDATE ) as WDATE
                  from ( select au.ACC, au.MDATE, sc.KF
                           from BARS.ACCOUNTS_UPDATE au
                           join SCRTD sc
                             on ( sc.ACC = au.ACC )
                          where IDUPD = ( select max(IDUPD)
                                            from BARS.ACCOUNTS_UPDATE a, dt
                                           where a.EFFECTDATE < dt.dt1
                                             and a.ACC = au.ACC
                                           group by a.ACC )
                       ) m0
                  join ( select sc.ND, au.ACC, au.MDATE, sc.KF
                           from BARS.ACCOUNTS_UPDATE au
                           join SCRTD sc
                             on ( sc.ACC = au.ACC )
                          where IDUPD = ( select max(IDUPD)
                                            from BARS.ACCOUNTS_UPDATE a, dt
                                           where EFFECTDATE <= dt.dt2
                                             and a.ACC = au.ACC
                                           group by a.ACC )
                       ) m1
                    on ( m1.ACC = m0.ACC )
                 where NULLIF( m1.MDATE, m0.MDATE ) is Not Null
              ),
               /* договора, измененные с первого числа мес€ца */
    CARDS1 as ( select w.KF, w.ND, w.KAT23, w.DAT_END
                  from BARS.W4_ACC_UPDATE w
                 where w.idupd in ( select max (u.idupd)
                                      from bars.w4_acc_update u, dt
                                     where u.effectdate <= dt.dt2
                                       and u.global_bdate >= dt.dt1
                                     group by u.nd )
                 UNION ALL
                select b.KF, b.ND, b.KAT23, Null
                  from BARS.BPK_ACC_UPDATE b
                 where b.IDUPD in ( select max (u.idupd)
                                    from bars.bpk_acc_update u, dt
                                   where u.effectdate <= dt.dt2
                                     and u.global_bdate >= dt.dt1
                                   group by u.nd )
                   and b.CHGACTION <> ''D''
              ),
               /* состо€ние измененнных договоров на конец прошлого мес€ца */
     CARDS as ( select d.KF, 4 as ND_TYPE, d.ND
                     , NULLIF( d.KAT23,   u0.KAT23   ) as KAT23
                     , NULLIF( d.DAT_END, u0.DAT_END ) as DAT_END
                  from BARS.W4_ACC_UPDATE u0
                  join CARDS1 d on (d.ND = u0.ND)
                 where u0.IDUPD in ( select /*+ index (u1 XAI_W4ACC_UPDATEPK_T) */ max(u1.IDUPD)
                                       from BARS.W4_ACC_UPDATE u1
                                       join CARDS1 d1 on (d1.ND = u1.ND),
                                            dt
                                      where u1.EFFECTDATE < dt.dt1
                                      group by u1.ND )
                 UNION ALL
                select d.KF, 4 as ND_TYPE, d.ND
                     , NULLIF( d.KAT23,   u0.KAT23   ) as KAT23
                     , NULLIF( d.DAT_END, u0.DAT_END ) as DAT_END
                  from BARS.BPK_ACC_UPDATE u0
                  join CARDS1 d on (d.ND = u0.ND)
                 where u0.IDUPD in ( select /*+ index (u1 XAI_BPKACC_UPDATEPK) */max(u1.IDUPD)
                                       from BARS.BPK_ACC_UPDATE u1
                                       join CARDS1 d1 on (d1.ND = u1.ND),
                                            dt
                                      where u1.EFFECTDATE < dt.dt1
                                      group by u1.ND )
              ),
   BPK_TXT as ( select KF, ND_TYPE, ND, PAR_ID, PAR_VAL
                  from ( select t1.KF, 4 as ND_TYPE, t1.ND,
                                case
                                  when t1.TAG = ''VNCRR''   then 9
                                  when t1.TAG = ''BUS_MOD'' then 14
                                  when t1.TAG = ''SPPI''    then 15
                                  when t1.TAG = ''IFRS''    then 16
                                  when t1.TAG = ''INTRT''   then 17
                                  when t1.TAG = ''ND_REST'' then 18
                                  else null
                                end as PAR_ID,
                                t1.VALUE as PAR_VAL,
                                rank() over (partition by t1.nd, t1.tag order by idupd desc) as rn
                           from BARS.BPK_PARAMETERS_UPDATE t1, dt
                          where t1.EFFECTDATE   <= dt.dt2
                            and t1.GLOBAL_BDATE >= dt.dt1
                            and t1.TAG in ( ''VNCRR'', ''BUS_MOD'', ''SPPI'', ''IFRS'', ''INTRT'', ''ND_REST'' ))
                 where rn = 1
              ),
     XOZ   as ( select x.KF, 21 as ND_TYPE, ID as ND, X.MDATE
                  from bars.xoz_ref x
                  join bars.accounts a on (a.acc = x.acc)
                 where X.MDATE is not null ),
               /* договора Instolment, измененные с первого числа мес€ца */
     BPI   as ( select p.KF, p.CHAIN_IDT, p.END_DATE_P, p.SUB_INT_RATE
                  from ( select t.KF, t.CHAIN_IDT, t.END_DATE_P, t.SUB_INT_RATE, t.PLAN_NUM, max(t.PLAN_NUM) over (partition by t.CHAIN_IDT) PN
                           from bars.ow_inst_totals_hist t, dt
                          where t.INS_BD >= dt.dt1
                       ) p
                 where p.PLAN_NUM = p.PN ),
               /* состо€ние измененнных договоров на конец прошлого мес€ца
                  если END_DATE_P изменилс€ */
    BPI0   as ( select p.KF, 23 as ND_TYPE, p.CHAIN_IDT * 100 as ND,
                       p.WDATE, decode(p.WDATE0, p.WDATE, 0, 1) as WDATE_C,
                       p.IR,    decode(p.IR0, p.IR, 0, 1)       as IR_C
                  from ( select t.kf, t.CHAIN_IDT, t.PLAN_NUM,
                                t.END_DATE_P   as WDATE0, bpi.END_DATE_P   as WDATE,
                                t.SUB_INT_RATE as IR0,    bpi.SUB_INT_RATE as IR,
                                max(t.PLAN_NUM) over (partition by t.CHAIN_IDT) PN
                           from bars.ow_inst_totals_hist t
                           join bpi on (BPI.CHAIN_IDT = t.CHAIN_IDT),
                                dt
                          where t.INS_BD < dt.dt1
                       ) p
                 where p.PLAN_NUM = p.PN )
                   --and (decode(p.WDATE0, p.WDATE, 0, 1) = 1
                   --  or decode(p.IR0,    p.IR,    0, 1) = 1) )
select KF, ND_TYPE, ND, 6 as PAR_ID, to_char(WDATE,''dd/mm/yyyy'') as PAR_VAL
  from DEALS
 where WDATE is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 7, to_char(KAT23)
  from DEALS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 6, to_char(WDATE,''dd/mm/yyyy'')
  from RECVBL
 UNION ALL
select t1.KF, case t0.vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as ND_TYPE,
       t1.ND, t1.PAR_ID, t1.PAR_VAL
  from ND_TXT t1
  join BARS.CC_DEAL_UPDATE t0 -- договора кред. €к≥ д≥€ли на ост. роб. день м≥с.
    on ( t0.ND = t1.ND and t0.KF = t1.KF and t0.sos >= 10 )
 where t0.IDUPD in ( select /*+ index (u1 XAI_CCDEAL_UPDATEPK)*/ max(u1.IDUPD)
                       from BARS.CC_DEAL_UPDATE u1
                       join ND_TXT on (ND_TXT.ND = u1.ND and ND_TXT.KF = u1.KF),
                            dt
                      where u1.EFFECTDATE < dt.dt1
                      group by u1.ND )
 UNION ALL
select t1.KF, t1.ND_TYPE, t1.ND, t1.PAR_ID, t1.PAR_VAL
  from BPK_TXT t1
  left join (select w2.nd, w2.kf
               from BARS.W4_ACC_UPDATE w2
              where w2.IDUPD in ( select /*+ no_index (w1 I_KF_IDUPD_ACC_W4ACCSUPD) */ max(w1.IDUPD)
                                    from BARS.W4_ACC_UPDATE w1
                                    join BPK_TXT t2 on (t2.ND = w1.ND and t2.KF = w1.KF),
                                         dt
                                   where w1.EFFECTDATE   < dt.dt1
                                   group by w1.ND )
              union all
             select b2.nd, b2.kf
               from BARS.BPK_ACC_UPDATE b2
              where b2.IDUPD in ( select /*+ no_index (b1 I_KF_IDUPD_ACC_BPKACCSUPD) */ max(b1.IDUPD)
                                    from BARS.BPK_ACC_UPDATE b1
                                    join BPK_TXT t2 on (t2.ND = b1.ND),
                                         dt
                                   where b1.EFFECTDATE   < dt.dt1
                                   group by b1.ND )
             ) w0
      on ( w0.ND = t1.ND and w0.KF = t1.KF)
 where w0.nd is not null
 UNION ALL
select KF, ND_TYPE, ND, 9, VNCRR
  from SCRTS
 where VNCRR is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 7, to_char(KAT23)
  from SCRTS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 11, to_char(IR,''FM99999900D009999999999'')
  from SCRTS
 where IR is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 12, to_char(ERAT,''FM99999900D009999999999'')
  from SCRTS
 where IR is Not Null
 UNION ALL  --параметры по ÷Ѕ
select sd.KF, 9 as ND_TYPE, sd.ND, p.param_id, cw.VALUE as PAR_VAL
  from SCRTD sd
  join bars.cp_refw cw on ( cw.ref = sd.nd )
  join barsupl.t0_upload_params p on (cw.tag = p.param_name and p.object_id = 2)
 where cw.TAG in (''BUS_MOD'', ''SPPI'', ''IFRS'', ''INTRT'', ''ND_REST'')
 UNION ALL
select KF, ND_TYPE, ND, 6, to_char(WDATE,''dd/mm/yyyy'')
  from SCRTM
 UNION ALL
select KF, ND_TYPE, ND, 6, to_char(DAT_END,''dd/mm/yyyy'')
  from CARDS
 where DAT_END is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 7, to_char(KAT23)
  from CARDS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 6, to_char(MDATE,''dd/mm/yyyy'')
  from XOZ
 UNION ALL
select KF, ND_TYPE, ND, 6, to_char(WDATE,''dd/mm/yyyy'')
  from BPI0
 where WDATE_C = 1
 UNION ALL
select KF, ND_TYPE, ND, 11, to_char(IR,''FM99999900D009999999999'')
  from BPI0
 where IR_C = 1');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (535, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
         NULL, '«м≥нен≥ параметри договор≥в (дл€ FineVare)', '2.4');
end;
/


-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (535);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (535);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (535);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (535);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (535);

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
