CREATE OR REPLACE function BARS.F_NBU_RPT_XML_ROW
( p_rpt_code    IN     varchar2
, p_rpt_date    IN     date
) RETURN varchar2_list
  PIPELINED
IS
  /**
  <b>F_NBU_RPT_XML_ROW</b> - 
  %param p_rpt_code - 
  %param p_rpt_date - 

  %version 1.5 (02/03/2017)
  %usage   
  */
  g_dt_fmt    constant varchar2(10) := 'dd.mm.yyyy';
  
  l_okpo               varchar2(10);
  l_frst_dt            date; -- 
  l_last_dt            date; -- 
  l_prvn_dt            date; -- 
  l_nbu_dt             date; --    �������� ���� ���
  l_is_dt_in           integer            :=1;
  l_ret_val            varchar2(4000 byte);
  l_rec                pls_integer := 0;
  l_rpt_code           char(2);
BEGIN
  
  bars_audit.info( $$PLSQL_UNIT||': Entry with ( p_rpt_code='||p_rpt_code||
                                 ', p_rpt_date='||to_char(p_rpt_date,g_dt_fmt)||' ).' );
  
  dbms_application_info.set_action( $$PLSQL_UNIT );
  
  l_frst_dt := add_months(trunc(p_rpt_date,'MM'),-1);
  
  l_last_dt := last_day(l_frst_dt);
  
  l_prvn_dt := l_last_dt + 1;
  
  -- BARS.BARS_CONTEXT.SUBST_MFO(BARS.F_OURMFO_G());

  l_okpo := f_ourokpo();
  
  l_rpt_code := upper( substr( trim(p_rpt_code), instr(trim(p_rpt_code),'#')+1, 2 ) );
  
--    �������� ���� ���
   l_nbu_dt := p_rpt_date;
   loop
      l_nbu_dt := l_nbu_dt+1;
      select count(*)   into l_is_dt_in
        from holiday
       where kv =980 and holiday =l_nbu_dt;

      exit when l_is_dt_in =0; 
   end loop;
-------------------------------------------------------------------------------
  bars_audit.info( $$PLSQL_UNIT||': l_frst_dt=' ||to_char(l_frst_dt,g_dt_fmt)||
                                 ', l_last_dt=' ||to_char(l_last_dt,g_dt_fmt)||
                                 ', l_prvn_dt=' ||to_char(l_prvn_dt,g_dt_fmt)||
                                 ', l_okpo='    ||l_okpo                     ||
                                 ', l_rpt_code='||l_rpt_code );
  
  pipe row ( '<?xml version="1.0" encoding="utf-8" standalone="yes"?>' );
  pipe row ( '<NBUSTATREPORT xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' );
  pipe row ( '  <HEAD>' );
  pipe row ( '    <STATFORM>F'||l_rpt_code||'X</STATFORM>' );
  pipe row ( '    <EDRPOU>'||l_okpo||'</EDRPOU>' );
  pipe row ( '    <REPORTDATE>'||to_char(l_nbu_dt,g_dt_fmt)||'</REPORTDATE>' );
  pipe row ( '  </HEAD>' );
  
  if ( l_rpt_code = '3E' )
  then
  
    for d in 
    ( SELECT XMLElement( "DATA" -- If value is null, then no element is created for that value
                       , XMLForest( NN,      EKP,     Q003_1,  Q003_3,  Q007_2,  IDS031, Q003_2,  Q007_1
                                  , T070_14, T070_15, T070_16, T070_17, Q003_5,  Q007_5, Q007_6,  T070_10
                                  , T071,    IDK014,  Q001_4,  K020_2,  S080_1,  S080_2, IDR030,  T070_12
                                  , T070_13, Q001_5,  Q001_6,  Q020_3,  T070_11
                                  )
                       , XMLElement("Q015_3",Q015_3)
                       , XMLElement("Q015_4",Q015_4)
                       , XMLElement("KU_2",  KU_2  )
                       , XMLElement("Q002_4",Q002_4)
                       , XMLElement("Q002_5",Q002_5)
                       , XMLElement("Q002_6",Q002_6)
                       , XMLElement("Q007_7",XMLAttributes(nvl2(Q007_7,null,'true') as "xsi:nil"),Q007_7)
                       , XMLElement("Q007_8",XMLAttributes(nvl2(Q007_8,null,'true') as "xsi:nil"),Q007_8)
                       , XMLElement("F017_2",F017_2)
                       , XMLElement("F018_2",F018_2)
                       ) AS XML_ROW
        FROM ( select /* XML_RPT_3E */ 1              as NN
                    , 'A3E001'                        as EKP
                    , z.NNNNN                         as Q003_1  --
                    , z.CC_IDZ                        as Q003_3  -- 108
                    , to_char(z.SDATZ,g_dt_fmt)       as Q007_2  -- 109
                    , z.S031                          as IDS031  --
                    , d1.CC_ID                        as Q003_2  -- 102
                    , to_char(d1.SDATE,g_dt_fmt)      as Q007_1  -- 103
                    , 0                               as T070_14 -- 
                    , b.DBT_ADJ_KOS                   as T070_15 -- 335
                    , b.INT_ADJ_KOS                   as T070_16 -- 336
                    , 0                               as T070_17 -- 
                    , d2.CC_ID                        as Q003_5  -- 307
                    , to_char(d2.SDATE,g_dt_fmt)      as Q007_5  -- 308
                    , to_char(d2.WDATE,g_dt_fmt)      as Q007_6  -- 309
                    , t1.TXT                          as T070_10 -- 311
                    , db.DBT_ADJ_BAL                  as T071    -- 312
                    , case
                        when ( c1.CUSTTYPE = 2 )
                        then 1
                        when ( c1.CUSTTYPE = 3 and c1.SED = '91  ')
                        then 2
                        else 3
                      end                             as IDK014  -- 313
                    , c1.NMK                          as Q001_4  -- 314
                    , c1.OKPO                         as K020_2  -- 315
                    , t2.TXT                          as S080_1  -- 316
                    , rz.S080                         as S080_2  -- 317
                    , nvl(tx.CCY_ID  ,db.KV)          as IDR030  -- 
                    , nvl(tx.DBT_AMNT,  0  )          as T070_12 -- 332
                    , nvl(tx.INT_AMNT,  0  )          as T070_13 -- 333
                    , ct.ZAL_NAME                     as Q001_5  -- 318
                    , ct.ZAL_TEH                      as Q015_3  -- 319
                    , ct.ZAL_KOL                      as Q015_4  -- 320
                    , cc.NMK                          as Q001_6  -- 321
                    , cc.OKPO                         as Q020_3  -- 322
                    , abs( nvl(cb.ost,  0) 
                         - nvl(cb.crDos,0)
                         + nvl(cb.crKos,0) )          as T070_11 -- 323
                    , ct.ZAL_OBL                      as KU_2    -- 324
                    , ct.ZAL_RAJ                      as Q002_4  -- 325
                    , ct.ZAL_GOR                      as Q002_5  -- 326
                    , ct.ZAL_ADR                      as Q002_6  -- 327
                    , ct.ZAL_STAN                     as F017_2  -- 328
                    , ct.ZAL_DAT                      as Q007_7  -- 329
                    , ct.ZAL_ST_D                     as F018_2  -- 330
                    , ct.ZAL_STRA                     as Q007_8  -- 331
                 from ( -- NNNNN OO LLLLL
                        select a.KF     as KF
                             , a.RNK    as RNK_9500
                             , a.ACC    as ACC_9500
                             , a.NLS    as NLS_9500
                             , a.KV     as KV_9500
                             , p.CC_IDZ as CC_IDZ
                             , p.SDATZ  as SDATZ
                             , t.S031
                             , to_number(w.VALUE) as REF_ND
                             , dense_rank() over (order by a.ACC) as LLLLL
                             , n.ND
                             , dense_rank() over (order by n.ND ) as NNNNN
                          from ACCOUNTS  a
                          join ACCOUNTSW w
                            on ( w.acc = a.acc and w.tag = 'REF_ND' )
                          join PAWN_ACC  p
                            on ( p.ACC = a.ACC )
                          join CC_PAWN  t
                            on ( t.PAWN = p.PAWN )
                          join ND_ACC n
                            on ( n.ACC = a.ACC )
                         where a.NBS = '9510'
                           and a.DAOS <= l_last_dt
                           and lnnvl( a.DAZS < l_frst_dt )
                           and w.VALUE Is Not Null
                      ) z
                 join CC_DEAL  d1 --
                   on ( d1.KF = z.KF and d1.ND = z.ND )
                 join ( select rd.ND
                             , nvl(bd.dos ,0) + nvl(bd.crdos ,0) as DBT_ADJ_KOS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                             , nvl(bi.dos ,0) + nvl(bi.crdos ,0) as INT_ADJ_KOS
                          from ND_ACC   rd
                          join ACCOUNTS ad
                            on ( ad.KF = rd.KF and ad.ACC = rd.ACC )
                          left
                          join AGG_MONBALS bd
                            on ( bd.FDAT = l_frst_dt and bd.ACC = ad.ACC )
                          join INT_ACCN i
                            on ( i.KF = ad.KF and i.ACC = ad.ACC and i.ID = 1 )
                          left
                          join AGG_MONBALS bi
                            on ( bi.FDAT = l_frst_dt and bi.ACC = i.ACRA )
                         where ad.NBS in ( '1310','1312','1313','1322','1323' )
                           and ad.DAOS <= l_last_dt
                           and lnnvl( ad.DAZS < l_frst_dt )
                           and ( bd.ACC is Not Null or bi.ACC is Not Null ) -- ����� ������� / ������� � ������� ��.
                      ) b
                   on ( b.ND = d1.ND )
                 join CC_DEAL  d2 -- 
                   on ( d2.KF = z.KF  and d2.ND = z.REF_ND )
                 join ND_TXT t1
                   on ( t1.ND = d2.ND and t1.TAG = 'KREDZ' )
                 left
                 join ND_TXT t2
                   on ( t2.ND = d2.ND and t2.TAG = 'KAT_Z' )
                 join CUSTOMER c1 -- �������� ������������
                   on ( c1.RNK = d2.RNK )
                 left
                 join ( select r.ND
                             , ak.KV as CCY_ID
                             , sum( case
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
                                                       ,'2208','2209'
                                                       ,'2238','2239')
                                             and
                                             ad.NBS not in ('2039','2069','2089','2209','2239')
                                           )
                                      then td.S
                                      else 0
                                    end ) as INT_AMNT -- 333
                          from ND_ACC r
                          join ACCOUNTS ak
                            on ( ak.KF = r.KF and ak.ACC = r.ACC )
                          join OPLDOK tk
                            on ( tk.KF = ak.KF and tk.ACC = ak.ACC )
                          join OPLDOK td
                            on ( td.REF = tk.REF and td.STMT = tk.STMT )
                          join ACCOUNTS ad
                            on ( ad.KF = td.KF and ad.ACC = td.ACC )
                          join OPER dc
                            on ( dc.KF = tk.KF and dc.REF = tk.REF )
                         where tk.FDAT between l_frst_dt and l_last_dt
                           and tk.DK = 1
--                         and tk.SOS = 5
--                         and tk.TT <> '096'
                           and td.DK = 0
                           and dc.VDAT between l_frst_dt and l_last_dt
                           and dc.VOB not in ( 96, 99 )
                           and dc.SOS = 5
                         group by r.ND, ak.KV
                      ) tx -- ���� ��������� �� ������� 
                   on ( tx.ND = d2.ND )
                 join ( select r.ND
                             , a.KV
                             , abs( sum( nvl(b.ost,0) - nvl(b.crdos,0) + nvl(b.crkos,0) ) ) as DBT_ADJ_BAL -- 312
                          from ND_ACC   r
                          join ACCOUNTS a
                            on ( a.KF = r.KF and a.ACC = r.ACC )
                          left
                          join AGG_MONBALS b
                            on ( b.FDAT = l_frst_dt and b.ACC = a.ACC )
                         where regexp_like( a.NBS, '^(2\d{2}(2|3|7))' )
                         group by r.ND, a.KV
                      ) db
                   on ( db.ND = d2.ND )
                 join ( -- ���������� �� ����� ������ ��� �������, ������� ��������� � ������ 
                        select unique dr.ND
                             , ac.KF  as CLT_KF
                             , ac.ACC as CLT_ACC
                             , ac.RNK as CLT_RNK
                          from ND_ACC   dr
                          join CC_ACCP  cr
                            on ( cr.KF = dr.KF and cr.ACCS = dr.ACC  )
                          join ACCOUNTS ac
                            on ( ac.KF = cr.KF and ac.ACC = cr.ACC   )
                         where ac.NBS in ('9030','9031','9500','9520','9521','9523')
                           and ac.DAOS <= l_last_dt
                           and lnnvl( ac.DAZS < l_frst_dt )
                      ) cl
                   on ( cl.ND = d2.ND )
                 left
                 join CUSTOMER cc 
                   on ( cc.RNK = cl.CLT_RNK )
                 left
                 join AGG_MONBALS cb
                   on ( cb.fdat = l_frst_dt and cb.ACC = cl.CLT_ACC )
                 left
                 join (select KF, ACC
                            , ZAL_NAME, ZAL_TEH
                            , ZAL_KOL,  ZAL_OBL
                            , ZAL_RAJ,  ZAL_GOR
                            , ZAL_ADR,  ZAL_STAN
                            , replace(ZAL_DAT,'/','.') as ZAL_DAT
                            , ZAL_ST_D, ZAL_STRA 
                         from ( select KF, ACC, TAG, VALUE
                                  from ACCOUNTSW
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
                              )
                        pivot ( max(VALUE) for TAG in ('ZAL_NAME' as ZAL_NAME, 'ZAL_TEH'  as ZAL_TEH
                                                       ,'ZAL_KOL'  as ZAL_KOL,  'ZAL_OBL'  as ZAL_OBL
                                                       ,'ZAL_RAJ'  as ZAL_RAJ,  'ZAL_GOR'  as ZAL_GOR
                                                       ,'ZAL_ADR'  as ZAL_ADR,  'ZAL_STAN' as ZAL_STAN
                                                       ,'ZAL_DAT'  as ZAL_DAT,  'ZAL_ST_D' as ZAL_ST_D
                                                       ,'ZAL_STRA' as ZAL_STRA)
                              ) 
                      ) ct
                   on ( ct.KF = cl.CLT_KF and ct.ACC = cl.CLT_ACC )
                 left
                 join ( select unique ND, S080
                          from NBU23_REZ
                         where FDAT = l_prvn_dt
                           and ID like 'CCK%'
                      ) rz
                   on ( rz.ND = d2.ND )
                where d1.SDATE <= l_last_dt
                  and d1.WDATE  > l_last_dt )
    ) loop
      
      l_rec := l_rec + 1;
      dbms_application_info.set_client_info( 'Processing #'||to_char(l_rec)||' row' );
      
      l_ret_val := '  '||d.XML_ROW.getStringVal();
      l_ret_val := regexp_replace(l_ret_val,'<DATA><','<DATA>'||chr(10)||'    <');
      l_ret_val := regexp_replace(l_ret_val,'></DATA>','>'||chr(10)||'  </DATA>');
  --  l_ret_val := regexp_replace(l_ret_val,'><[^/]','>'||chr(10)||'    <');
  --  l_ret_val := regexp_replace(l_ret_val,'<([^<>]+?)/>','<\1></\1>') -- ����� <P1/> �� <P1></P1> ��� NULL �������
      pipe row ( CONVERT( l_ret_val, 'UTF8' ) );
      
    end loop;
    
  elsif  ( l_rpt_code = '3K' )   then

    for d in 
    ( SELECT XMLElement( "DATA" -- If value is null, then no element is created for that value
                       , XMLElement("EKP", EKP)
                       , XMLElement("Q003_1",Q003_1)
                       , XMLElement("F091",F091)
                       , XMLElement("R030",R030 )
                       , XMLElement("T071",T071)
                       , XMLElement("K020",K020)
                       , XMLElement("K021",K021)
                       , XMLElement("Q001",Q001)
                       , XMLElement("Q024",Q024)
                       , XMLElement("D100",D100)
                       , XMLElement("S180",S180)
                       , XMLElement("F089",F089)
                       , XMLElement("F092",F092)
                       , XMLElement("Q003_2",XMLAttributes(nvl2(Q003_2,null,'true') as "xsi:nil"),Q003_2)
                       , XMLElement("Q007_1",XMLAttributes(nvl2(Q007_1,null,'true') as "xsi:nil"),Q007_1)
                       , XMLElement("Q006",XMLAttributes(nvl2(Q006,null,'true') as "xsi:nil"),Q006)
                       ) AS XML_ROW
       from ( select /* XML_RPT_3K */ 'A3K001'                        as EKP
                     , EKP_2                 as Q003_1 
                     , F091                 as F091
                     , R030                 as R030
                     , T071                 as T071
                     , K020                 as K020 
                     , K021                 as K021 
                     , Q001                 as Q001 
                     , Q024                 as Q024
                     , D100                 as D100
                     , S180                 as S180
                     , F089                 as F089
                     , F092                 as F092
                     , Q003                 as Q003_2
                     , Q007                 as Q007_1
                     , Q006                 as Q006
              from ( select *
          from ( select substr(kodp,5,3) ekp_2,
                        substr(kodp,1,4) ekp_1, znap 
                   from tmp_nbu
                  where kodf= l_rpt_code
                    and datf =p_rpt_date
              )
               pivot
              ( max(trim(znap))
                for ekp_1 in ( 'F091' as F091, 'R030' as R030, 'T071' as T071,
                               'K020' as K020, 'K021' as K021, 'Q001' as Q001,
                               'Q024' as Q024, 'D100' as D100, 'S180' as S180,
                               'F089' as F089, 'F092' as F092, 
                               'Q003' as Q003, 'Q007' as Q007, 'Q006' as Q006 )
              )   )
            )
    ) loop
      
      l_rec := l_rec + 1;
      dbms_application_info.set_client_info( 'Processing #'||to_char(l_rec)||' row' );
      
      l_ret_val := '  '||d.XML_ROW.getStringVal();
      l_ret_val := regexp_replace(l_ret_val,'<DATA><','<DATA>'||chr(10)||'    <');
      l_ret_val := regexp_replace(l_ret_val,'></DATA>','>'||chr(10)||'  </DATA>');
--    -- ������� �������� xsi:nil ��� �������� Q007_1 
--      l_ret_val := REGEXP_REPLACE( l_ret_val, '(<Q007_1)(></)', '\1 xsi:nil = "true" \2' );

      pipe row ( CONVERT( l_ret_val, 'UTF8' ) );
                   --res := convert (res,'CL8MSWIN1251');      
    end loop;
    
  else
    
    bars_audit.info( $$PLSQL_UNIT||': invalid report type.' );
    
  end if;
  
  pipe row ( '</NBUSTATREPORT>' );
  
  dbms_application_info.set_client_info( null );
  dbms_application_info.set_action( null );
  
  bars_audit.info( $$PLSQL_UNIT||': Exit.' );
  
  return;
  
END F_NBU_RPT_XML_ROW;
/

create or replace public synonym F_NBU_RPT_XML_ROW for BARS.F_NBU_RPT_XML_ROW;
grant execute on F_NBU_RPT_XML_ROW to RPBN002;
