
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_xml.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NBUR_XML 
is

  --
  -- constants
  --
  g_header_version  constant varchar2(64)  := 'version 1.1  2017.03.15';

  --
  -- types
  --

  --
  -- ������� ������� (����� ������)
  --
  function header_version return varchar2;
  function body_version   return varchar2;

  --
  --
  --
  procedure CRT_FILE
  ( p_file_id     in     nbur_lst_files.file_id%type
  , p_rpt_dt      in     nbur_lst_files.report_date%type
  , p_kf          in     nbur_lst_files.kf%type
  , p_vrsn_id     in     nbur_lst_files.version_id%type
  , p_file_body      out clob
  );



end NBUR_XML;
/
CREATE OR REPLACE PACKAGE BODY BARS.NBUR_XML 
is
  
  --
  -- constants
  --
  g_body_version  constant varchar2(64) := 'version 1.5  2017.04.11';
  g_dt_fmt        constant varchar2(10) := 'dd.mm.yyyy';
  
  --
  -- types
  --
  
  --
  -- variables
  --
  v_rpt_dt                    nbur_lst_files.report_date%type;
  v_kf                        nbur_lst_files.kf%type;
  V_vrsn_id                   nbur_lst_files.version_id%type;
  
  -- 
  -- ������� ����� ��������� ������
  -- 
  function header_version 
     return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' header '||g_header_version||'.';

  end header_version;
  
  --
  -- ������� ����� ��� ������
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' body ' || g_body_version || '.';
  end body_version;
  
  --
  -- set report parameters for retrieving XML data in VIEW
  --
  procedure SET_RPT_PARM
  ( p_rpt_dt       in     nbur_lst_files.report_date%type
  , p_kf           in     nbur_lst_files.kf%type
  , p_vrsn_id      in     nbur_lst_files.version_id%type
  ) is
    title       constant  varchar2(60) := $$PLSQL_UNIT||'.SET_RPT_PARM';
  begin
    
    bars_audit.trace( '%s: Entry with ( p_rpt_dt=%s, p_kf=%s, p_vrsn_id=%s ).'
                    , title, to_char(p_rpt_dt,'dd/mm/yyyy'), p_kf, to_char(p_vrsn_id) );
    
    v_rpt_dt  := p_rpt_dt;
    v_kf      := p_kf;
    v_vrsn_id := p_vrsn_id;
    
    bars_audit.trace( '%s: Exit.', title );
    
  end SET_RPT_PARM;
  
  --
  --
  --
  function GET_RPT_DT
    return nbur_lst_files.report_date%type
  is
  begin
    return v_rpt_dt;
  end GET_RPT_DT;
  
  --
  --
  --
  function GET_KF
    return nbur_lst_files.kf%type
  is
  begin
    return v_kf;
  end GET_KF;
  
  --
  --
  --
  function GET_VRSN_ID
    return nbur_lst_files.version_id%type
  is
  begin
    return V_vrsn_id;
  end GET_VRSN_ID;
  
  --
  --
  --
  function SET_RPT_PARM
  ( p_rpt_dt       in     nbur_lst_files.report_date%type
  , p_kf           in     nbur_lst_files.kf%type
  , p_vrsn_id      in     nbur_lst_files.version_id%type
  ) return signtype
  is
    title       constant  varchar2(60) := $$PLSQL_UNIT||'.SET_RPT_PARM';
    l_XmlType             xmltype;
  begin
    
    SET_RPT_PARM
    ( p_rpt_dt  => p_rpt_dt
    , p_kf      => p_kf
    , p_vrsn_id => p_vrsn_id
    );
    
    return 1;
    
  end SET_RPT_PARM;
  
  --
  --
  --
  function GET_FILE_HEAD
  ( p_file_id     in     nbur_lst_files.file_id%type
  , p_rpt_date    IN     nbur_lst_files.report_date%type
  , p_kf          in     nbur_lst_files.kf%type
  ) return varchar2
  is
    title     constant   varchar2(64) := $$PLSQL_UNIT||'.GET_FILE_HEAD';
    l_rpt_code           nbur_ref_files.file_code%type;
    l_okpo               varchar2(10);
    l_XmlText            varchar2(1024);
  begin
    
    bars_audit.trace( '%s: Entry', title );
    
    l_rpt_code := NBUR_FILES.F_GET_KODF( p_file_id );
    
    -- 
$if ACC_PARAMS.MMFO $then
    l_okpo := BRANCH_ATTRIBUTE_UTL.GET_VALUE( p_branch_code    => '/'||p_kf||'/'
                                            , p_attribute_code => 'OKPO' );
$else
    l_okpo := F_OUROKPO();
$end
    
    bars_audit.trace( '%s: l_rpt_code=%s, l_okpo=%s.', title, l_rpt_code, l_okpo );
    
    l_XmlText := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>';
    l_XmlText := l_XmlText || chr(10) || '<NBUSTATREPORT xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
    l_XmlText := l_XmlText || chr(10) || '  <HEAD>';
    l_XmlText := l_XmlText || chr(10) || '    <STATFORM>F'||SubStr(l_rpt_code,2,2)||'X</STATFORM>';
    l_XmlText := l_XmlText || chr(10) || '    <EDRPOU>'||l_okpo||'</EDRPOU>';
    l_XmlText := l_XmlText || chr(10) || '    <REPORTDATE>'||to_char(p_rpt_date,g_dt_fmt)||'</REPORTDATE>';
    l_XmlText := l_XmlText || chr(10) || '  </HEAD>';
    
    bars_audit.trace( '%s: Exit with => %s', title,  chr(10)||l_XmlText );
    
    return l_XmlText;
    
  end GET_FILE_HEAD;
  
  
  --
  --
  --
  function GET_FILE_BODY
  ( p_rpt_code    IN     nbur_ref_files.file_code%type
  , p_rpt_date    IN     nbur_lst_files.report_date%type
  ) return xmltype
  is
    l_file_body          XmlType;
  begin
    
    bars_audit.trace( $$PLSQL_UNIT||'.GET_FILE_BODY: Entry' );
    
    -- l_file_body := appendChildXML( GET_FILE_HEAD( p_rpt_code, p_rpt_date ), 'NBUSTATREPORT', l_file_body );
    -- dbms_xmldom.appendchild(v_node1, v_node2);
    
    bars_audit.info( $$PLSQL_UNIT||'.GET_FILE_BODY: Exit with:' ||CHR(10)|| dbms_lob.substr( l_file_body.getClobVal(), 4000 ) );
    
    return l_file_body;
    
  end GET_FILE_BODY;
   
  --
  -- GET_REPORT_RECORDSET
  --
  procedure PREPARE_RECORDSET
  ( p_file_id     in     nbur_lst_files.file_id%type
  , p_rpt_dt      in     nbur_lst_files.report_date%type
  , p_kf          in     nbur_lst_files.kf%type
  , p_vrsn_id     in     nbur_lst_files.version_id%type
  , p_recordset      out sys_refcursor
  ) is
    l_frst_dt            date; -- 
    l_last_dt            date; -- 
    l_prvn_dt            date; -- 
  begin
    
    bars_audit.trace( $$PLSQL_UNIT||'.GET_XML_RECORDSET: Entry with ( p_file_id=%s ).', to_char(p_file_id) );
  
    l_frst_dt := add_months(trunc(p_rpt_dt,'MM'),-1);
    
    l_last_dt := last_day(l_frst_dt);
    
    l_prvn_dt := l_last_dt + 1;
  
    open p_recordset
    for select /* XML_RPT_3E */ 1              as NN
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
             , cc.OKPO                         as K020_3  -- 322
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
                    and ( bd.ACC is Not Null or bi.ACC is Not Null ) -- ������ ������� / ������� � ������� ��.
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
                    and tk.SOS = 5
                    and tk.TT <> '096'
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
           and d1.WDATE  > l_last_dt;
  
  END PREPARE_RECORDSET;
  
  --
  --
  --
  procedure CRT_FILE
  ( p_file_id     in     nbur_lst_files.file_id%type
  , p_rpt_dt      in     nbur_lst_files.report_date%type
  , p_kf          in     nbur_lst_files.kf%type
  , p_vrsn_id     in     nbur_lst_files.version_id%type
  , p_file_body      out clob
  ) is
    title     constant   varchar2(64) := $$PLSQL_UNIT||'.CRT_FILE';
    l_ctx                dbms_xmlgen.ctxHandle;
    l_clob               clob;
    l_rcur               SYS_REFCURSOR;
    l_xml                xmltype;
  begin
    
    bars_audit.trace( '%s: Entry.', title );
    
    DBMS_LOB.CREATETEMPORARY( l_clob, TRUE /*, SYS.DBMS_LOB.TRANSACTION*/ );
    
    PREPARE_RECORDSET( p_file_id, p_rpt_dt, p_kf, p_vrsn_id, l_rcur );
    
    l_ctx := dbms_xmlgen.newContext( l_rcur );
    
    dbms_xmlgen.setRowSetTag( l_ctx, NULL );
    dbms_xmlgen.setRowTag( l_ctx, 'DATA' );
    dbms_xmlgen.setNullHandling( l_ctx, dbms_xmlgen.EMPTY_TAG ); -- NULL_ATTR - Sets xsi:nil="true".
    
    l_xml := dbms_xmlgen.getxmltype(l_ctx);
    
    if ( l_xml Is Not Null )
    then
      
      -- l_clob := XMLSerialize( DOCUMENT l_xml AS CLOB );
      l_clob := l_xml.getclobval();
      
    else
      bars_audit.info( title||': getxmltype return Null' );
    end if;
    
    dbms_xmlgen.closeContext(l_ctx);
    
    CLOSE l_rcur;
    
    l_clob := GET_FILE_HEAD( p_file_id, p_rpt_dt, p_kf ) || chr(10) || l_clob || '</NBUSTATREPORT>';
    
    -- �����˲:
    
    -- ����� <P1/> �� <P1></P1> (��� NULL �������)
    l_clob := REGEXP_REPLACE( l_clob, '<([^>]+?)/>', '<\1></\1>' );
    
    -- ������� �������� xsi:nil ��� �������� Q007_7 �� Q007_8
--  l_clob := REGEXP_REPLACE( l_clob, '(<Q007_7|<Q007_8)([^ xsi:nil])', '\1 xsi:nil = "true" \2' );
    l_clob := REGEXP_REPLACE( l_clob, '(<Q007_7|<Q007_8)(></)', '\1 xsi:nil = "true" \2' );
    
    p_file_body := l_clob;
    
    DBMS_LOB.FREETEMPORARY( l_clob );

    bars_audit.trace( '%s: Exit.', title );
    
  end CRT_FILE;



BEGIN
  v_rpt_dt  := BARS.DAT_NEXT_U( BARS.GL.BD(), -1 );
  v_kf      := SYS_CONTEXT('BARS_CONTEXT','USER_MFO');
  v_vrsn_id := 1;
end NBUR_XML;
/
 show err;
 
PROMPT *** Create  grants  NBUR_XML ***
grant EXECUTE                                                                on NBUR_XML        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nbur_xml.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 