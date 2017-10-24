

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F3E.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F3E ***

  CREATE OR REPLACE PROCEDURE BARS.P_F3E 
( dat_     in     DATE
, sheme_   in     varchar2 default 'С'
) is
  l_usr_id        number;
  l_rpt_dt        date;
  kodf_           varchar2(2):='3E';
  /*
  * KODP {DDD NNNNN OO LLLLL VVV HH}
  */
begin

  bars_audit.info( 'P_F3E_NN: Begin for datf = '||to_char(dat_,'dd/mm/yyyy') );

  execute immediate 'alter session set NLS_NUMERIC_CHARACTERS = ''.,'' ';

  execute immediate 'truncate table RNBU_TRACE';

  l_rpt_dt := dat_;

  -- Показатели по Кредитам от НБУ (13__)
  insert all
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV, MDATE )
  values
       ( '102'||lpad(NNNNN,5,'0')||'000000000000', CC_ID
       , KF, ND, RNK, ACC, NLS, KV, WDATE )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV, MDATE )
  values
       ( '103'||lpad(NNNNN,5,'0')||'000000000000', to_char(SDATE,'ddmmyyyy')
       , KF, ND, RNK, ACC, NLS, KV, WDATE )
  select a.ACC
       , a.NLS
       , a.KV
       , d.KF
       , d.ND
       , d.RNK
       , d.CC_ID -- 102
       , d.SDATE -- 103
       , d.WDATE
       , z.NNNNN
    from bars.accounts a
    join bars.nd_acc   r
      on ( r.acc = a.acc )
    join bars.cc_deal  d
      on ( d.ND = r.ND )
    join ( select unique ND, NNNNN
            from ( -- NNNNN OO LLLLL
                   select a.KF, a.RNK, a.ACC, a.NLS, a.KV, a.MDATE
                        , p.CC_IDZ -- 108
                        , p.SDATZ  -- 109
                        , t.S031            as OO
                        , to_number(w.VALUE) as REF_ND
                        , dense_rank() over (order by a.ACC) as LLLLL
                        , n.ND
                        , dense_rank() over (order by n.ND ) as NNNNN
                     from BARS.ACCOUNTS  a
                     join BARS.ACCOUNTSW w
                       on ( w.acc = a.acc and w.tag = 'REF_ND' )
                     join BARS.PAWN_ACC  p
                       on ( p.ACC = a.ACC )
                     join BARS.CC_PAWN  t
                       on ( t.PAWN = p.PAWN )
                     join BARS.ND_ACC n
                       on ( n.ACC = a.ACC )
                    where a.NBS = '9510'
                      and a.DAOS <= l_rpt_dt
                      and ( a.DAZS is null or a.DAZS > l_rpt_dt )
                      and w.VALUE Is Not Null
                 )
         ) z 
      on ( z.ND = d.ND )
    left
    join BARS.AGG_MONBALS bd
      on ( bd.FDAT = trunc(l_rpt_dt,'MM') and bd.ACC = a.ACC )
    join BARS.INT_ACCN i
      on ( i.KF = a.KF and i.ACC = a.ACC and i.ID = 1 )
    left
    join BARS.AGG_MONBALS bi
      on ( bi.FDAT = trunc(l_rpt_dt,'MM') and bi.ACC = i.ACRA )
   where a.NBS in ( '1310','1312','1313','1322','1323' )
     and a.DAOS <= l_rpt_dt
     and ( a.DAZS is null or a.DAZS > l_rpt_dt )
     and d.SDATE <= l_rpt_dt
     and d.WDATE  > l_rpt_dt
     and ( bd.ACC is Not Null or bi.ACC is Not Null ) -- наявні залишки / обороти в звітному міс.
  ;
  
  --
  insert all
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV, MDATE )
  values
       ( '335'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'00000', to_char(DBT_ADJ_KOS)
       , KF, ND, RNK, ACC, NLS, KV, WDATE )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV, MDATE )
  values
       ( '336'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'00000', to_char(INT_ADJ_KOS) 
       , KF, ND, RNK, ACC, NLS, KV, WDATE )
  select ac.KF, ac.RNK, ac.ACC, ac.NLS, ac.KV, ac.MDATE
       , cd.CC_IDZ                                                        -- 108
       , cd.SDATZ                                                         -- 109
       , ct.S031 as OO
       , dense_rank() over (order by ac.ACC) as LLLLL
       , d1.ND
       , d1.CC_ID                                                         -- 102
       , d1.SDATE                                                         -- 103
       , d1.WDATE
       , dense_rank() over (order by d1.ND ) as NNNNN
       , nvl(bd.dos ,0) + nvl(bd.cudos ,0) as DBT_ADJ_KOS                 -- 335                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
       , nvl(bi.dos ,0) + nvl(bi.cudos ,0) as INT_ADJ_KOS                 -- 336
    from BARS.ACCOUNTS  ac
    join BARS.ACCOUNTSW w
      on ( w.ACC = ac.ACC and w.tag = 'REF_ND' )
    join BARS.PAWN_ACC  cd
      on ( cd.ACC = ac.ACC )
    join BARS.CC_PAWN  ct
      on ( ct.PAWN = cd.PAWN )
    join BARS.ND_ACC rc
      on ( rc.ACC = ac.ACC )
    join BARS.CC_DEAL  d1
      on ( d1.ND = rc.ND )
    join BARS.ND_ACC  rd
      on ( rd.ND = rc.ND )
     join BARS.ACCOUNTS ad
       on ( ad.KF = rd.KF and ad.ACC = rd.ACC )
    left
    join BARS.AGG_MONBALS bd
      on ( bd.FDAT = trunc(l_rpt_dt,'MM') and bd.ACC = ad.ACC )
    join BARS.INT_ACCN i
      on ( i.KF = ad.KF and i.ACC = ad.ACC and i.ID = 1 )
    left
    join BARS.AGG_MONBALS bi
      on ( bi.FDAT = trunc(l_rpt_dt,'MM') and bi.ACC = i.ACRA )
    join BARS.CC_DEAL d2
     on ( d2.ND = to_number(w.VALUE) )
   where ac.NBS = '9510'
     and ac.DAOS <= l_rpt_dt
     and ( ac.DAZS is null or ac.DAZS > l_rpt_dt )
     and w.VALUE Is Not Null
     and d1.SDATE <= l_rpt_dt
     and d1.WDATE  > l_rpt_dt
     and ad.NBS in ( '1310','1312','1313','1322','1323' )
     and ad.DAOS <= l_rpt_dt
     and ( ad.DAZS is null or ad.DAZS > l_rpt_dt )
     and ( bd.ACC is Not Null or bi.ACC is Not Null ) -- наявні залишки / обороти в звітному міс.
  ;
--
                  
  -- Показатели по залогам под кредиты НБУ, где залогом выступает кредит
  insert all
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV, MDATE )
  values
       ( '108'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'00000', CC_IDZ
       , KF, null, RNK, ACC, NLS, KV, MDATE )
  into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV, MDATE )
  values
       ( '109'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'00000', to_char(SDATZ,'ddmmyyyy')
       , KF, null, RNK, ACC, NLS, KV, MDATE )
  select a.KF, a.RNK, a.ACC, a.NLS, a.KV, a.MDATE
       , cd.CC_IDZ -- DDD = 108
       , cd.SDATZ  -- DDD = 109
       , ct.S031 as OO
       , to_number(w.VALUE) as REF_ND
       , dense_rank() over (order by r.ND ) as NNNNN
       , dense_rank() over (order by a.ACC) as LLLLL
    from BARS.ACCOUNTS  a
    join BARS.ACCOUNTSW w
      on ( w.acc = a.acc and w.tag = 'REF_ND' )
    join BARS.PAWN_ACC  cd
      on ( cd.ACC = a.ACC )
    join BARS.CC_PAWN  ct
      on ( ct.PAWN = cd.PAWN )
    join BARS.ND_ACC r
      on ( r.ACC = a.ACC )
   where a.NBS = '9510'
     and a.DAOS <= l_rpt_dt
     and ( a.DAZS is null or a.DAZS > l_rpt_dt )
     and w.VALUE Is Not Null
  ;

  -- Показатели по кредитам, которые являются залогами
  insert all
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '307'||NNNNN||OO||LLLLL||'00000', CC_ID
       , KF, ND, RNK )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '308'||NNNNN||OO||LLLLL||'00000', to_char(SDATE,'ddmmyyyy')
       , KF, ND, RNK )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '309'||NNNNN||OO||LLLLL||'00000', to_char(WDATE,'ddmmyyyy')
       , KF, ND, RNK )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '311'||NNNNN||OO||LLLLL||to_char(KV,'FM000')||'00', KREDZ
       , KF, ND, RNK )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '312'||NNNNN||OO||LLLLL||to_char(KV,'FM000')||'00', to_char(DBT_ADJ_BAL)
       , KF, ND, RNK )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '313'||NNNNN||OO||LLLLL||'00000', K014
       , KF, ND, RNK )
  into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '314'||NNNNN||OO||LLLLL||'00000', NMK
       , KF, ND, RNK )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '315'||NNNNN||OO||LLLLL||'00000', OKPO
       , KF, ND, RNK )
  into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '316'||NNNNN||OO||LLLLL||to_char(KV,'FM000')||'00', KAT_Z
       , KF, ND, RNK )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, RNK )
  values
       ( '317'||NNNNN||OO||LLLLL||to_char(KV,'FM000')||'00', S080
       , KF, ND, RNK )
  select KF, KV, ND, RNK, CC_ID, SDATE, WDATE
       , KREDZ, K014, NMK, OKPO, KAT_Z, S080
       , abs( sum( DBT_ADJ_BAL ) ) as DBT_ADJ_BAL
       , NNNNN
       , OO
       , LLLLL
    from ( select d.KF
                , lpad(z.NNNNN,5,'0') as NNNNN
                , z.OO
                , lpad(z.LLLLL,5,'0') as LLLLL
                , a.KV
                , d.ND
                , d.RNK
                , d.CC_ID          -- 307
                , d.SDATE          -- 308
                , d.WDATE          -- 309
                , t.TXT as KREDZ   -- 311
                , nvl(b.ost,0) - nvl(b.cudos,0) + nvl(b.cukos,0) as DBT_ADJ_BAL
                , case
                    when ( k.CUSTTYPE = 2 )
                    then 1
                    when ( k.CUSTTYPE = 3 and k.SED = '91  ')
                    then 2
                    else 3
                  end as K014      -- 313
                , k.NMK            -- 314
                , k.OKPO           -- 315
                , z.TXT as KAT_Z   -- 316
                , d.KAT23 as S080  -- 317
             from ( -- NNNNN OO LLLLL
                   select a.KF, a.RNK, a.ACC, a.NLS, a.KV, a.MDATE
                        , p.CC_IDZ -- 108
                        , p.SDATZ  -- 109
                        , t.S031            as OO
                        , to_number(w.VALUE) as REF_ND
                        , dense_rank() over (order by a.ACC) as LLLLL
                        , n.ND
                        , dense_rank() over (order by n.ND ) as NNNNN
                     from BARS.ACCOUNTS  a
                     join BARS.ACCOUNTSW w
                       on ( w.acc = a.acc and w.tag = 'REF_ND' )
                     join BARS.PAWN_ACC  p
                       on ( p.ACC = a.ACC )
                     join BARS.CC_PAWN  t
                       on ( t.PAWN = p.PAWN )
                     join BARS.ND_ACC n
                       on ( n.ACC = a.ACC )
                    where a.NBS = '9510'
                      and a.DAOS <= l_rpt_dt
                      and ( a.DAZS is null or a.DAZS > l_rpt_dt )
                      and w.VALUE Is Not Null
                  ) z
             join BARS.CC_DEAL d
               on ( d.KF = z.KF and d.ND = z.REF_ND )
             left
             join BARS.ND_TXT t
               on ( t.ND = d.ND and t.TAG = 'KREDZ' )
             left
             join BARS.ND_TXT z
               on ( z.ND = d.ND and z.TAG = 'KAT_Z' )
             join BARS.CUSTOMER k
               on ( k.RNK = d.RNK )
             join BARS.ND_ACC r
               on ( r.KF = d.KF and r.ND = d.ND )
             join BARS.ACCOUNTS a
               on ( a.KF = r.KF and a.ACC = r.ACC )
             left
             join BARS.AGG_MONBALS b
               on ( b.fdat = trunc(l_rpt_dt,'MM') and b.ACC = a.ACC )
            where regexp_like( a.NBS, '^(2\d{2}(2|3|7))' )
         )
   group by KF, KV, ND, RNK, CC_ID, SDATE, WDATE
          , KREDZ, K014, NMK, OKPO, KAT_Z, S080
          , NNNNN, OO, LLLLL
  ;

  -- 332 /333
  insert ALL
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, KV )
  values
       ( '332'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||to_char(KV,'FM000')||'00', to_char(DBT_AMNT)
       , KF, ND, KV )
    into BARS.RNBU_TRACE
       ( KODP, ZNAP, NBUC, ND, KV )
  values
       ( '333'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||to_char(KV,'FM000')||'00', to_char(INT_AMNT)
       , KF, ND, KV )
    select z.NNNNN
         , z.OO
         , z.LLLLL
         , r.ND
         , ak.KF
         , ak.KV
         , Sum( case
             when ( ak.NBS in ('2030','2037','2062','2063','2067','2082','2083','2087'
                              ,'2202','2203','2207','2232','2233','2237')
                    and
                    ad.NBS not in ('2067','2037','2087','2207','2237')
                  )
             then td.S
             else 0
           end ) as DBT_AMNT -- 332
         , sum( case
             when ( ak.NBS in ('2038','2039'
                              ,'2068','2069'
                              ,'2088','2089'
                              ,'2208','2209','2238','2239')
                    and
                    ad.NBS not in ('2069','2039','2089','2209','2239')
                  )
             then td.S
             else 0
           end ) as INT_AMNT -- 333
      from ( -- NNNNN OO LLLLL
             select a.KF, a.RNK, a.ACC, a.NLS, a.KV, a.MDATE
                          , p.CC_IDZ -- 108
                          , p.SDATZ  -- 109
                          , t.S031            as OO
                          , to_number(w.VALUE) as REF_ND
                          , dense_rank() over (order by a.ACC) as LLLLL
                          , n.ND
                          , dense_rank() over (order by n.ND ) as NNNNN
                       from BARS.ACCOUNTS  a
                       join BARS.ACCOUNTSW w
                         on ( w.acc = a.acc and w.tag = 'REF_ND' )
                       join BARS.PAWN_ACC  p
                         on ( p.ACC = a.ACC )
                       join BARS.CC_PAWN  t
                         on ( t.PAWN = p.PAWN )
                       join BARS.ND_ACC n
                         on ( n.ACC = a.ACC )
                      where a.NBS = '9510'
                        and a.DAOS <= l_rpt_dt
                        and ( a.DAZS is null or a.DAZS > l_rpt_dt )
                        and w.VALUE Is Not Null
           ) z
      join BARS.ND_ACC r
        on ( r.ND = z.REF_ND )
      join BARS.ACCOUNTS ak
        on ( ak.ACC = r.ACC )
      join BARS.OPLDOK tk
        on ( tk.KF = ak.KF and tk.ACC = ak.ACC )
      join BARS.OPLDOK td
        on ( td.REF = tk.REF and td.STMT = tk.STMT )
      join BARS.ACCOUNTS ad
        on ( ad.KF = td.KF and ad.ACC = td.ACC )
     where tk.FDAT between trunc(l_rpt_dt,'MM') and l_rpt_dt
       and tk.DK = 1
       and td.DK = 0
  group by z.NNNNN
         , z.OO
         , z.LLLLL
         , r.ND
         , ak.KF
         , ak.KV
  ;
  
  -- Показатели по видам залога под кредиты, которые находятся в залоге
  insert
    when ( TAG = 'ZAL_NAME' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '318'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_TEH' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '319'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_KOL' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '320'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )

    when ( TAG = 'ZAL_OBL' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '324'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_RAJ' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '325'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_GOR' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '326'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_ADR' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '327'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_STAN' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '328'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_DAT' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '329'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_ST_D' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '330'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( TAG = 'ZAL_STRA' )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '331'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), VALUE
         , KF, ND, RNK, ACC, NLS, KV )
    when ( RN = 1 )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '321'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), NMK
         , KF, ND, RNK, ACC, NLS, KV )
    when ( RN = 1 )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '322'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), OKPO
         , KF, ND, RNK, ACC, NLS, KV )
    when ( RN = 1 )
    then
      into BARS.RNBU_TRACE
         ( KODP, ZNAP, NBUC, ND, RNK, ACC, NLS, KV )
      values
         ( '323'||lpad(NNNNN,5,'0')||OO||lpad(LLLLL,5,'0')||'000'||lpad(HH,2,'0'), abs(ADJ_BAL)
         , KF, ND, RNK, ACC, NLS, KV )
  select t.ND, t.KF, t.ACC, t.NLS, t.KV, t.OO, t.LLLLL, t.RNK, t.NMK, t.OKPO, t.ADJ_BAL, t.NNNNN, t.HH
       , lc.TAG
       , lc.VALUE
       , row_number() over (partition by t.ND, t.ACC order by t.ND, t.ACC) as RN
    from ( select unique dr.ND
                , ac.KF, ac.ACC, ac.NLS, ac.KV
                , z.NNNNN
                , z.OO
                , z.LLLLL
                , cs.RNK
                , cs.NMK                                                    -- 321
                , cs.OKPO                                                   -- 322
                , nvl(b.ost,0) - nvl(b.cudos,0) + nvl(b.cukos,0) as ADJ_BAL -- 323
                , dense_rank() over (order by cr.ACC) as HH
           from ( -- NNNNN OO LLLLL
                   select a.KF, a.RNK, a.ACC, a.NLS, a.KV, a.MDATE
                        , p.CC_IDZ -- 108
                        , p.SDATZ  -- 109
                        , t.S031            as OO
                        , to_number(w.VALUE) as REF_ND
                        , dense_rank() over (order by a.ACC) as LLLLL
                        , n.ND
                        , dense_rank() over (order by n.ND ) as NNNNN
                     from BARS.ACCOUNTS  a
                     join BARS.ACCOUNTSW w
                       on ( w.acc = a.acc and w.tag = 'REF_ND' )
                     join BARS.PAWN_ACC  p
                       on ( p.ACC = a.ACC )
                     join BARS.CC_PAWN  t
                       on ( t.PAWN = p.PAWN )
                     join BARS.ND_ACC n
                       on ( n.ACC = a.ACC )
                    where a.NBS = '9510'
                      and a.DAOS <= l_rpt_dt
                      and ( a.DAZS is null or a.DAZS > l_rpt_dt )
                      and w.VALUE Is Not Null
                ) z
           join BARS.ND_ACC   dr
             on ( dr.KF = z.KF and dr.ND = z.REF_ND )
           join BARS.CC_ACCP  cr
             on ( cr.KF = dr.KF and cr.ACCS = dr.ACC  )
           join BARS.ACCOUNTS ac
             on ( ac.KF = cr.KF and ac.ACC = cr.ACC   )
           join bars.customer cs
             on ( cs.RNK = ac.RNK   )
           left
           join BARS.AGG_MONBALS b
             on ( b.fdat = trunc(l_rpt_dt,'MM') and b.ACC = cr.ACC )
          where ac.NBS in ('9030','9031','9500','9520','9521','9523')
            and ac.DAOS <= l_rpt_dt
            and ( ac.DAZS is null or ac.DAZS > l_rpt_dt )
        ) t
    left
    join ( select KF, ACC, TAG, VALUE
             from bars.accountsw
            where TAG in ('ZAL_NAME' -- 318
                         ,'ZAL_TEH'  -- 319
                         ,'ZAL_KOL'  -- 320
                         ,'ZAL_OBL'  -- 324
                         ,'ZAL_RAJ'  -- 325
                         ,'ZAL_GOR'  -- 326
                         ,'ZAL_ADR'  -- 327
                         ,'ZAL_STAN' -- 328
                         ,'ZAL_DAT'  -- 329
                         ,'ZAL_ST_D' -- 330
                         ,'ZAL_STRA' -- 331
                         )
         ) lc
      on ( lc.KF = t.KF and lc.ACC = t.ACC   )
  ;

  delete
    from TMP_NBU
   where kodf = kodf_
     and datf = dat_;

  insert
    into TMP_NBU
       ( KODF, DATF, KODP, ZNAP, NBUC )
  select kodf_, dat_, KODP, ZNAP, NBUC
    from RNBU_TRACE
  ;

  logger.info( 'P_F3E_NN: End for '||to_char(dat_,'dd.mm.yyyy') );

end P_F3E;
/
show err;

PROMPT *** Create  grants  P_F3E ***
grant EXECUTE                                                                on P_F3E           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F3E           to RPBN002;
grant EXECUTE                                                                on P_F3E           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F3E.sql =========*** End *** ===
PROMPT ===================================================================================== 
