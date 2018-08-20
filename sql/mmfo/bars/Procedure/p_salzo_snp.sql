

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SALZO_SNP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SALZO_SNP ***

  CREATE OR REPLACE PROCEDURE BARS.P_SALZO_SNP 
 ( p_DAT    date, -- дата
   P_KV     int, -- ¬ал (0-всi)
   p_NB1    varchar2, -- Ѕ/–ахунок_«_(%)-всi
   p_NB2    varchar2, -- Ѕ/–ахунок_ѕќ_(%)-всi
   p_BR     varchAr2  --  од_вiддiленн€(%)-всi
  )
 is

  l_DAT01d_     date      ;
  l_DAT01t_     date      ;
  Di_           number ;   -- accm_calendar.caldt_id%type
  l_caldt_DATE  date   ;   -- accm_calendar.caldt_DATE%type
  BRANCH_       accounts.branch%type ;
  NBS1_         varchar2(4)   ;
  NBS2_         varchar2(4)   ;
 ----------------------
  l_DATLast_    date := Dat_last(trunc(p_DAT, 'mm'), LAST_DAY(p_DAT)); -- останн≥й робочий день м≥с€ц€

  Di1_          number ;   -- accm_calendar.caldt_id%type
  Di2_          number ;   -- accm_calendar.caldt_id%type

  l_DATBank_    date := bankdate;
BEGIN
  execute immediate ' truncate table CCK_AN_TMP ';

  If substr(p_NB1,1,1) not in ('1','2','3','4','5','6','7','8','9') then
     NBS1_ :='1000';
  Else
     NBS1_ := Substr(p_NB1 ||'0000',1,4);
  end if;

  If substr(p_NB2,1,1) not in ('1','2','3','4','5','6','7','8','9') then
     NBS2_ :='9999';
  Else
     NBS2_ := Substr(p_NB2 ||'9999',1,4);
  end if;

  IF nbs2_< nbs1_ THEN RETURN; END IF;
  ----------------------------------------

  if l_DATLast_ = p_DAT and trunc(sysdate) <> p_DAT then -- €кщо останн≥й робочий день м≥с€ц€, то працюЇмо по м≥с€чних SNAP-ах
      --1) Id отч.даты
      l_DAT01t_ := last_day  ( p_DAT) +  1 ; --01 число отчетного мес€ца   - “ќЋя
      l_DAT01d_ := add_months(l_DAT01t_,-1); --01 число след.за отч мес€ца - ƒ»ћј

      --select caldt_ID into Di_ from accm_calendar where caldt_DATE=l_DAT01d_;

      LOGGER.INFO('SALZO ' || l_DAT01d_ ||' '|| Di_ || ' '||
      P_KV || ' '|| NBS1_ || ' '|| NBS2_ ||' '||  P_BR );

      --2) страховочна€ синхронизаци€
      bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);
      BRANCH_ := SYS_CONTEXT('bars_context','user_branch_mask');

      INSERT INTO CCK_AN_TMP ( NLS,  KV,  NBS ,  PR, NAME1,
              N1 ,  N2 ,  N3 ,  N4, N5, PRS, ZAL, ZALQ )
      select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35),
               b.ost   - (b.kos -b.dos )+(b.CUkos -b.CUdos ) N1_VOST  ,
               b.ostq  - (b.kosq-b.dosq)+(b.CUkosq-b.CUdosq) N2_VOSTq ,
               b.dos   - b.CUdos + b.CRdos                   N3_DOS   ,
               b.dosq  - b.CUdosq+ b.CRdosq                  N4_DOSq  ,
               b.Kos   - b.CUKos + b.CRKos                   N5_KOS   ,
               b.Kosq  - b.CUKosq+ b.CRKosq                  PRS_KOSq ,
               b.ost   + (b.CRkos -b.CRdos )                 ZAL_OST  ,
               b.ostq  + (b.CRkosq-b.CRdosq)                 ZALQ_OSTq
        from AGG_MONBALS b, accounts a
        where b.fdat=l_DAT01d_
          and b.ACC=a.acc and a.nbs not like '8%'
          and (b.ostq   <> 0 or
               b.kosq   <> 0 or
               b.dosq   <> 0 OR
               b.CUkosq <> 0 or
               b.CUdosq <> 0 OR
               b.CRdosq <> 0 or
               b.CRkosq <> 0
              )
          AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
          AND A.NBS >= NBS1_
          AND A.NBS <= NBS2_
          AND A.BRANCH LIKE P_BR||'%'
          AND A.BRANCH LIKE BRANCH_;
          commit;
     -- ≥накше - по щоденних
     ------------------------
  elsif l_DATBank_ > p_DAT then
      --select caldt_ID into Di1_ from accm_calendar where caldt_DATE=trunc(p_DAT, 'mm')-1;

      --select caldt_ID into Di2_ from accm_calendar where caldt_DATE=p_DAT;

      --2) страховочна€ синхронизаци€
     -- bars_accm_sync.sync_snap_period('BALANCE', trunc(p_DAT, 'mm')-1, p_DAT);

      l_DAT01t_ := trunc ( p_DAT, 'mm'); --01 число отчетного мес€ца   - “ќЋя
      l_DAT01d_ := add_months(l_DAT01t_,-1); --01 число пред.перед. отч мес€ца

      --select caldt_ID into Di_ from accm_calendar where caldt_DATE=l_DAT01d_;

      LOGGER.INFO('SALZO from ACCM_SNAP_BALANCES ' || p_DAT ||' '|| Di_ || ' '||
      P_KV || ' '|| NBS1_ || ' '|| NBS2_ ||' '||  P_BR );

      --2) страховочна€ синхронизаци€
      bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);

      BRANCH_ := SYS_CONTEXT('bars_context','user_branch_mask');

      INSERT INTO CCK_AN_TMP ( NLS,  KV,  NBS ,  PR, NAME1,
              N1 ,  N2 ,  N3 ,  N4, N5, PRS, ZAL, ZALQ )
      select nls, kv, nbs, isp, name1,
            sum(N1_VOST),   sum(N2_VOSTq),
            sum(N3_DOS),    sum(N4_DOSq),
            sum(N5_KOS),    sum(PRS_KOSq),
            sum(ZAL_OST),   sum(ZALQ_OSTq)
       from (
          select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35) NAME1,
                   sum(b.ost)                            N1_VOST  ,
                   sum(b.ostq)                           N2_VOSTq ,
                   0                                     N3_DOS   ,
                   0                                     N4_DOSq  ,
                   0                                     N5_KOS   ,
                   0                                     PRS_KOSq ,
                   0                                     ZAL_OST  ,
                   0                                     ZALQ_OSTq
            from SNAP_BALANCES b, accounts a
            where b.fdat = trunc(p_DAT, 'mm')-1
              and b.ACC=a.acc and a.nbs not like '8%'
              and (b.ostq   <> 0
                  )
              AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
              AND A.NBS >= NBS1_
              AND A.NBS <= NBS2_
              AND A.BRANCH LIKE P_BR||'%'
              AND A.BRANCH LIKE BRANCH_
          group by a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35)
                union all
          select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35) NAME1,
                   0                                    N1_VOST  ,
                   0                                    N2_VOSTq ,
                   0                                    N3_DOS   ,
                   0                                    N4_DOSq  ,
                   0                                    N5_KOS   ,
                   0                                    PRS_KOSq ,
                   sum(b.ost)                           ZAL_OST  ,
                   sum(b.ostq)                          ZALQ_OSTq
            from SNAP_BALANCES b, accounts a
            where b.fdat = p_DAT
              and b.ACC=a.acc and a.nbs not like '8%'
              and (b.ostq   <> 0
                  )
              AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
              AND A.NBS >= NBS1_
              AND A.NBS <= NBS2_
              AND A.BRANCH LIKE P_BR||'%'
              AND A.BRANCH LIKE BRANCH_
          group by a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35)
                union all
          select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35) NAME1,
                   0                                    N1_VOST  ,
                   0                                    N2_VOSTq ,
                   sum(b.dos)                           N3_DOS   ,
                   sum(b.dosq)                          N4_DOSq  ,
                   sum(b.kos)                           N5_KOS   ,
                   sum(b.kosq)                          PRS_KOSq ,
                   0                                    ZAL_OST  ,
                   0                                    ZALQ_OSTq
            from SNAP_BALANCES b, accounts a
            where b.fdat between trunc(p_DAT, 'mm') and p_DAT
              and b.ACC=a.acc and a.nbs not like '8%'
              and (b.kosq   <> 0 or
                   b.dosq   <> 0
                  )
              AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
              AND A.NBS >= NBS1_
              AND A.NBS <= NBS2_
              AND A.BRANCH LIKE P_BR||'%'
              AND A.BRANCH LIKE BRANCH_
          group by a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35)
                union all -- снимаем корректирующие прошлого мес€уа
          select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35),
                   0                                    N1_VOST  ,
                   0                                    N2_VOSTq ,
                   - b.CRdos                            N3_DOS   ,
                   - b.CRdosq                           N4_DOSq  ,
                   - b.CRKos                            N5_KOS   ,
                   - b.CRKosq                           PRS_KOSq ,
                   + b.CRdos-b.CRKos                    ZAL_OST  ,
                   + b.CRdosq-b.CRKosq                  ZALQ_OSTq
            from AGG_MONBALS b, accounts a
            where b.fdat=l_DAT01d_
              and b.ACC=a.acc and a.nbs not like '8%'
              and (b.CRdosq <> 0 or
                   b.CRkosq <> 0
                  )
              AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
              AND A.NBS >= NBS1_
              AND A.NBS <= NBS2_
              AND A.BRANCH LIKE P_BR||'%'
              AND A.BRANCH LIKE BRANCH_          )
      group by nls, kv, nbs, isp, name1;

      commit;
  else
      BRANCH_ := SYS_CONTEXT('bars_context','user_branch_mask');

      LOGGER.INFO('SALZO from salqnc ' || p_DAT ||' '||
      P_KV || ' '|| NBS1_ || ' '|| NBS2_ ||' '||  P_BR );

      l_DAT01t_ := trunc ( p_DAT, 'mm'); --01 число отчетного мес€ца   - “ќЋя
      l_DAT01d_ := add_months(l_DAT01t_,-1); --01 число пред.перед. отч мес€ца

      --select caldt_ID into Di_ from accm_calendar where caldt_DATE=l_DAT01d_;

      --2) страховочна€ синхронизаци€
      bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);

      INSERT INTO CCK_AN_TMP ( NLS,  KV,  NBS ,  PR, NAME1,
              N1 ,  N2 ,  N3 ,  N4, N5, PRS, ZAL, ZALQ )
      select nls, kv, nbs, isp, name1,
            sum(N1_VOST),   sum(N2_VOSTq),
            sum(N3_DOS),    sum(N4_DOSq),
            sum(N5_KOS),    sum(PRS_KOSq),
            sum(ZAL_OST),   sum(ZALQ_OSTq)
       from (
          select b.NLS,  b.KV, b.NBS, b.ISP, SUBSTR(b.NMS,1,35) NAME1,
                   sum(b.ost)                            N1_VOST  ,
                   sum(b.ostq)                           N2_VOSTq ,
                   0                                     N3_DOS   ,
                   0                                     N4_DOSq  ,
                   0                                     N5_KOS   ,
                   0                                     PRS_KOSq ,
                   0                                     ZAL_OST  ,
                   0                                     ZALQ_OSTq
            from salnqc b
            where b.fdat = trunc(p_DAT, 'mm')-1
              and b.ostq   <> 0
              AND b.KV   = DECODE(P_KV,0, b.KV, P_KV)
              AND b.NBS between NBS1_ AND NBS2_
              AND b.BRANCH LIKE P_BR||'%'
              AND b.BRANCH LIKE BRANCH_
          group by b.NLS,  b.KV, b.NBS, b.ISP, SUBSTR(b.NMS,1,35)
                union all
          select b.NLS,  b.KV, b.NBS, b.ISP, SUBSTR(b.NMS,1,35) NAME1,
                   0                                    N1_VOST  ,
                   0                                    N2_VOSTq ,
                   0                                    N3_DOS   ,
                   0                                    N4_DOSq  ,
                   0                                    N5_KOS   ,
                   0                                    PRS_KOSq ,
                   sum(b.ost)                           ZAL_OST  ,
                   sum(b.ostq)                          ZALQ_OSTq
            from salnqc b
            where b.fdat = p_DAT
              and b.ostq   <> 0
              AND b.KV   = DECODE(P_KV,0, b.KV, P_KV)
              AND b.NBS between NBS1_ AND NBS2_
              AND b.BRANCH LIKE P_BR||'%'
              AND b.BRANCH LIKE BRANCH_
          group by b.NLS,  b.KV, b.NBS, b.ISP, SUBSTR(b.NMS,1,35)
                union all
          select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35) NAME1,
                   0                                    N1_VOST  ,
                   0                                    N2_VOSTq ,
                   sum(b.dos)                           N3_DOS   ,
                   sum(decode(a.kv, 980, b.dos, 0))     N4_DOSq  ,
                   sum(b.kos)                           N5_KOS   ,
                   sum(decode(a.kv, 980, b.kos, 0))     PRS_KOSq ,
                   0                                    ZAL_OST  ,
                   0                                    ZALQ_OSTq
            from saldoa b, accounts a
            where b.fdat between trunc(p_DAT, 'mm') and p_DAT
              and b.ACC=a.acc and a.nbs not like '8%'
              and (b.kos   <> 0 or
                   b.dos   <> 0
                  )
              AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
              AND A.NBS >= NBS1_
              AND A.NBS <= NBS2_
              AND A.BRANCH LIKE P_BR||'%'
              AND A.BRANCH LIKE BRANCH_
          group by a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35)
                union all
          select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35) NAME1,
                   0                                    N1_VOST  ,
                   0                                    N2_VOSTq ,
                   0                                    N3_DOS   ,
                   sum(b.dos)                           N4_DOSq  ,
                   0                                    N5_KOS   ,
                   sum(b.kos)                           PRS_KOSq ,
                   0                                    ZAL_OST  ,
                   0                                    ZALQ_OSTq
            from saldob b, accounts a
            where b.fdat between trunc(p_DAT, 'mm') and p_DAT
              and b.ACC=a.acc and a.nbs not like '8%'
              and (b.kos   <> 0 or
                   b.dos   <> 0
                  )
              AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
              AND A.NBS >= NBS1_
              AND A.NBS <= NBS2_
              AND A.BRANCH LIKE P_BR||'%'
              AND A.BRANCH LIKE BRANCH_
          group by a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35)
              union all -- снимаем корректирующие прошлого мес€уа
          select a.NLS,  a.KV, a.NBS, A.ISP, SUBSTR(A.NMS,1,35),
                   0                                    N1_VOST  ,
                   0                                    N2_VOSTq ,
                   - b.CRdos                            N3_DOS   ,
                   - b.CRdosq                           N4_DOSq  ,
                   - b.CRKos                            N5_KOS   ,
                   - b.CRKosq                           PRS_KOSq ,
                   + b.CRdos-b.CRKos                    ZAL_OST  ,
                   + b.CRdosq-b.CRKosq                  ZALQ_OSTq
            from AGG_MONBALS b, accounts a
            where b.fdat=l_DAT01d_
              and b.ACC=a.acc and a.nbs not like '8%'
              and (b.CRdosq <> 0 or
                   b.CRkosq <> 0
                  )
              AND A.KV   = DECODE(P_KV,0, A.KV, P_KV)
              AND A.NBS >= NBS1_
              AND A.NBS <= NBS2_
              AND A.BRANCH LIKE P_BR||'%'
              AND A.BRANCH LIKE BRANCH_         )
          group by nls, kv, nbs, isp, name1;
      commit;
  end if;

end  P_SALZO_SNP;
/
show err;

PROMPT *** Create  grants  P_SALZO_SNP ***
grant EXECUTE                                                                on P_SALZO_SNP     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SALZO_SNP     to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SALZO_SNP.sql =========*** End *
PROMPT ===================================================================================== 
