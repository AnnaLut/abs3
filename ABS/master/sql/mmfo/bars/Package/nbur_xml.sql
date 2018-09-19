CREATE OR REPLACE package BARS.NBUR_XML
is


  --
  -- constants
  --
  g_header_version  constant varchar2(64)  := 'version 2.3  2018.05.04';

  --
  -- types
  --

  --
  -- Службові функції (версія пакету)
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

  --
  --
  --
  procedure SET_XSD
  ( p_file_id     in     nbur_ref_xsd.file_id%type
  , p_scm_dt      in     nbur_ref_xsd.scm_dt%type
  , p_scm_doc     in     blob
  );



end NBUR_XML;
/

show errors;

----------------------------------------------------------------------------------------------------

create or replace package body NBUR_XML
is

  --
  -- constants
  --
  g_body_version  constant varchar2(64) := 'version 3.3  2018.09.18';
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
  -- повертає версію заголовка пакета
  --
  function header_version
     return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' header '||g_header_version||'.';
  end header_version;

  --
  -- повертає версію тіла пакета
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
  function CHK_XML
  ( p_rpt_id      in            nbur_lst_files.file_id%type
  , p_rpt_dt      in            nbur_lst_files.report_date%type
  , p_rpt_body    in out nocopy nbur_lst_files.file_body%type
  ) return varchar2
  is
    title          constant     varchar2(64) := $$PLSQL_UNIT||'.CHK_XML';
    l_scm_url                   nbur_ref_xsd.scm_url%type;
    l_xml                       XMLType;
    l_errmsg                    varchar2(2048);
    E_INVAL_XML_DOC             exception; -- invalid XML document
    pragma exception_init( E_INVAL_XML_DOC, -31154 );
  begin
    
    bars_audit.trace( '%s: Entry with ( rpt_id=%s ).', title, to_char(p_rpt_id) );
    
    begin
      
      select SCM_URL
        into l_scm_url
        from NBUR_REF_XSD
       where ( FILE_ID, SCM_DT ) in ( select FILE_ID, max( SCM_DT )
                                        from NBUR_REF_XSD
                                       where FILE_ID = p_rpt_id
                                         and SCM_DT <= p_rpt_dt 
                                       group by FILE_ID );

      l_xml := XmlType( p_rpt_body ).createSchemaBasedXML( l_scm_url );
      
      l_xml.schemaValidate();
      
    exception
      when NO_DATA_FOUND then
        l_errmsg := null;
      when E_INVAL_XML_DOC then
        l_errmsg := dbms_utility.format_error_stack();
      when others then
        l_errmsg := dbms_utility.format_error_stack();
    end;
    
    bars_audit.trace( '%s: Exit with ( errmsg=%s ).', title, l_errmsg );
    
    return l_errmsg;
    
  end CHK_XML;

  --
  --
  --
  function GET_FILE_HEAD
  ( p_rpt_code           nbur_ref_files.file_code%type
  , p_rpt_date    IN     nbur_lst_files.report_date%type
  , p_kf          in     nbur_lst_files.kf%type
  ) return varchar2
  is
    title     constant   varchar2(64) := $$PLSQL_UNIT||'.GET_FILE_HEAD';
    l_okpo               varchar2(10);
    l_XmlText            varchar2(1024);
  begin

    bars_audit.trace( '%s: Entry with ( p_rpt_code=%s, p_rpt_date=%s, p_kf=%s ).'
                    , title, p_rpt_code, to_char(p_rpt_date,g_dt_fmt), p_kf );

$if ACC_PARAMS.MMFO $then
    l_okpo := BRANCH_ATTRIBUTE_UTL.GET_VALUE( p_branch_code    => '/'||p_kf||'/'
                                            , p_attribute_code => 'OKPO' );
$else
    l_okpo := F_OUROKPO();
$end

    bars_audit.trace( '%s: l_okpo=%s, l_nbu_rpt_dt=%s.', title, l_okpo, to_char(p_rpt_date, g_dt_fmt) );

    l_XmlText := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>';
    l_XmlText := l_XmlText || chr(10) || '<NBUSTATREPORT xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
    l_XmlText := l_XmlText || chr(10) || '  <HEAD>';
    l_XmlText := l_XmlText || chr(10) || '    <STATFORM>F'||p_rpt_code||'X</STATFORM>';
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
    l_rpt_code           nbur_ref_files.file_code%type;
    l_prepare_sql        clob;
  begin

    bars_audit.trace( $$PLSQL_UNIT||'.GET_XML_RECORDSET: Entry with ( p_file_id=%s ).', to_char(p_file_id) );

    l_rpt_code := NBUR_FILES.F_GET_KODF( p_file_id );
    
    if l_rpt_code is not null then
        begin   
            select desc_xml
            into l_prepare_sql
            from NBUR_REF_PREPARE_XML
            where file_code = l_rpt_code and 
                date_start <= p_rpt_dt;
             
            open p_recordset for l_prepare_sql using p_rpt_dt, p_kf;
            
            return;    
        exception
            when no_data_found then
                null;
        end;
    end if;
    
    case l_rpt_code
    when '#3E' then

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
                      and ( bd.ACC is Not Null or bi.ACC is Not Null ) -- наявні залишки / обороти в звітному міс.
                 ) b
              on ( b.ND = d1.ND )
            join CC_DEAL  d2 --
              on ( d2.KF = z.KF  and d2.ND = z.REF_ND )
            join ND_TXT t1
              on ( t1.ND = d2.ND and t1.TAG = 'KREDZ' )
            left
            join ND_TXT t2
              on ( t2.ND = d2.ND and t2.TAG = 'KAT_Z' )
            join CUSTOMER c1 -- реквізити позичальника
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
                 ) tx -- сума погашения по кредиту
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
            join ( -- Показатели по видам залога под кредиты, которые находятся в залоге
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

    when '#F1' then

      open p_recordset
      for select /* XML_RPT_F1 */
                  decode(dd, 11, 'AF1001',
                             12, 'AF1002',
                             41, 'AF1003',
                             42, 'AF1004' )  as EKP
                , obl                        as KU
                , rez                        as K030
                , kod_g                      as K040
                , ckv                        as R030
                , ostf                       as T071
            from ( SELECT /*+ parallel(8) */ obl,
                          (case when dd = '11' and substr(acc_num_db,1,2) in ('26', '29') THEN '12'
                                when dd = '11' and substr(acc_num_db,1,2) not in ('26', '29') THEN '11'
                                when dd = '41' and
                                      (substr(acc_num_cr,1,3) like '262%' or
                                       substr(acc_num_cr,1,4) in ('2900', '2924')) THEN '42'
                                else dd
                           end) dd,
                          rez,
                          ckv,
                          lpad(kod_g, 3, '0') kod_g,
                          to_char(bal) ostf
                     from ( select a.*, u.obl, 
                                   ( case when ((b.atr LIKE '%МВД%' OR b.atr LIKE '%МВС%') AND b.atr NOT LIKE '%РОС%') OR
                                   b.atr LIKE '%УКРА%' OR
                                   b.natio LIKE '%УКР%' OR
                                   b.natio LIKE '%804%' OR
                                   substr(nvl(b.paspn,b.pasp),1,1) in ('А','В','С','Е','?','I','К','М','О','Р','Т','Х')
                  then '1'
                  when ((b.atr LIKE '%МВД%' OR b.atr LIKE '%МВС%') AND b.atr LIKE '%РОС%') OR
                        not (b.atr LIKE '%МВД%' OR b.atr LIKE '%МВС%') OR
                        not (b.natio LIKE '%УКР%' OR b.natio LIKE '%804%')
                  then '2'
                  else c.k030
             end) rez,
             b.pasp, b.paspn,b.atr,
             nvl((case when d.country is not null
                    then d.country
                    else
                     (case when substr(nvl(nvl(trim(p.KOD_G), trim(P.D6#70)), trim(P.D6#E2)),1,1) in ('O','P','О','П') -- додати ще D1#E9 та F1
                           then substr(nvl(nvl(trim(p.KOD_G), trim(P.D6#70)), trim(P.D6#E2)), 2, 3)
                           else substr(nvl(nvl(trim(p.KOD_G), trim(P.D6#70)), trim(P.D6#E2)), 1, 3)
                     end)
                  end), '000') kod_g,
             lpad(to_char(a.kv),3,'0') ckv
        from (
            select /*+leading(r) */ unique t.*,
                (case when substr(t.acc_num_db,1,4) in ('1500','2620','2625','2902','2924') then t.cust_id_db
                      when substr(t.acc_num_cr,1,4) in ('1500','2620','2625','2902','2924') then t.cust_id_cr
                      when t.acc_num_db like '100%' then t.cust_id_cr
                      when t.acc_num_cr like '100%' then t.cust_id_db
                      else t.cust_id_db
                end) rnk,
                (case when substr(t.acc_num_db,1,3) in ('100', '262') or
                           substr(t.acc_num_db,1,4) in ('2900','2902','2924')
                      then t.acc_id_db
                      else t.acc_id_cr
                end) acc,
                (case when substr(t.acc_num_db,1,3) in ('100', '262') or
                           substr(t.acc_num_db,1,4) in ('2900','2902','2924')
                      then t.acc_num_db
                      else t.acc_num_cr
                end) nls,
                (case when R.PR_DEL = 2
                         then '11'
                      when R.PR_DEL = 3
                         then '41'
                      else '00'
                 end) dd
            from NBUR_DM_TRANSACTIONS t
            join NBUR_REF_SEL_TRANS r
            on (t.acc_num_db like r.acc_num_db||'%' and
                t.acc_num_cr like r.acc_num_cr||'%' and
                nvl(t.ob22_db, '00') = nvl(r.ob22_db, nvl(t.ob22_db, '00')) and
                nvl(t.ob22_cr, '00') = nvl(r.ob22_cr, nvl(t.ob22_cr, '00')) and
                t.tt = nvl(r.tt, t.tt) and
                t.kf = nvl(r.mfo, t.kf) and
                not nvl(r.pr_del, 0) = 1)
            join oper o
            on (t.ref = o.ref)
            left outer join (select w.ref,
                                   max((case when w.tag like '%REF%' then trim(w.value) else null end)) ref_m37,
                                   max((case when w.tag like '%REF%' or trim(w.value) is null then null
                                         else  to_date(substr(replace(replace(trim(w.value), ',','/'),
                                               '.','/'),1,10), 'dd/mm/yyyy')
                                       end))  dat_m37
                              from operw w
                              where (w.tag like 'D_REF%' or
                                     w.tag like 'REFT%' or
                                     w.tag like 'D_1PB%' or
                                     w.tag like 'DATT%')
                              group by w.ref) o1
            on (t.ref = o1.ref)
            where t.report_date = p_rpt_dt and
                t.kf = p_kf and
                t.kv <> 980 and
                r.file_id = p_file_id and
                not (t.acc_num_db LIKE '2909%' and t.acc_num_cr LIKE '2909%' and
                     (nvl(t.ob22_cr, '00') <> '24' or lower (o.nazn) like ('%перераховано%для продажу%'))) and
                not (t.acc_num_db like '2620%' and t.acc_num_cr like '2909%' and
                     t.tt like 'DP%' and lower (o.nazn) like ('%з рах%на рах%')) and
                not ((t.acc_num_db LIKE '2809%' OR t.acc_num_db like '2909%') and
                      t.acc_num_cr LIKE '100%' and t.tt in ('M37','MMV','CN3','CN4') and
                      (o1.ref_m37 is not null and o1.ref_m37 = t.ref or o1.dat_m37 is not null))) a
        join NBUR_DM_CUSTOMERS c
        on (a.rnk = c.cust_id)
        join BRANCH u
        on (c.branch = u.branch)
        left outer join NBUR_DM_ADL_DOC_RPT_DTL p
        on (a.ref = p.ref)
        left outer join (select w.ref,
                               max((case when w.tag = 'ATRT' then upper(trim(w.value)) else null end))  atr,
                               max((case when w.tag = 'NATIO' then upper(trim(w.value)) else null end))  natio,
                               max((case when w.tag like '%PASP%' then substr(upper(trim(w.value)),1,20) else null end))  pasp,
                               max((case when w.tag = 'PASPN' then substr(upper(trim(w.value)),1,20) else null end))  paspn
                            from operw w
                            where (w.tag = 'ATRT' or
                                   w.tag = 'NATIO' or
                                   w.tag like '%PASP%')
                            group by w.ref) b
        on (a.ref = b.ref)
        left outer join (SELECT unique ref, '804' country
                           FROM OPERW
                          WHERE tag like '59%'
                            AND (substr(trim(value),1,3) = '/UA' or
                                 instr(UPPER(trim(value)),'UKRAINE') > 0)
                          group by ref) d
        on (a.ref = d.ref)
         )
       where kod_g <> '804'
      );

    when '#XP' then

          open p_recordset
          for select /* XML_RPT_1P */ 'A1P001'                        as EKP
                     , substr(ekp_1,2,3)                 as K040_1 
                     , substr(ekp_1,5,10)                as RCBNK_B010 
                     , substr(ekp_1,26,3)                as K040_2
                     , substr(ekp_1,19,3)                as R030
                     , substr(ekp_1,15,4)                as R020 
                     , substr(ekp_1,22,4)                as R040 
                     , substr(ekp_1,1,1)                 as T023 
                     , substr(ekp_1,29,3)                as Q003_1
                     , RCBNK             as RCBNK_NAME
                     , RCUKRU_2          as RCUKRU_GLB_2
                     , decode(trim(k018),'1','1','2','2','#')  as K018
                     , K020, Q001
                     , RCUKRU_1 as RCUKRU_GLB_1, Q004, T080, T071
              from ( select *
          from ( select substr(kodp,3,30) ekp_1,
                        substr(kodp,1,2) ekp_2, znap 
                   from tmp_nbu
                  where kodf= 'XP'
                    and datf = p_rpt_dt
                    and kf = p_kf
              )
               pivot
              ( max(trim(znap))
                for ekp_2 in ( '10' as RCBNK, '07' as RCUKRU_2, '04' as K018,
                               '05' as K020,  '06' as Q001,     '03' as RCUKRU_1,
                               '99' as Q004, '80' as T080, '71' as T071 )
              )   );

          delete from tmp_nbu
           where kodf ='XP';
    else
      null;
    end case;

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
    l_errmsg             varchar2(2048);
    l_rpt_code           nbur_ref_files.file_code%type;
    l_period_type        nbur_ref_files.period_type%type;
    l_rpt_dt             nbur_lst_files.report_date%type;
    l_day                number;
  begin

    bars_audit.trace( '%s: Entry.', title );

    DBMS_LOB.CREATETEMPORARY( l_clob, TRUE /*, SYS.DBMS_LOB.TRANSACTION*/ );

    l_rpt_code := NBUR_FILES.GET_FILE_CODE_ALT( p_file_id );
    l_period_type := nbur_files.GET_FILE_PERIOD_TYPE(p_file_id);

    --Если месячный файл, то берем первый день календарного месяца
    if (l_period_type = 'M') then
      l_rpt_dt := last_day( p_rpt_dt ) + 1;
    -- якщо декадна дата, то перший календарний день після закінчення декади 
    elsif (l_period_type = 'T') then
      l_day := to_number(to_char(p_rpt_dt, 'dd'));
      
      l_rpt_dt := to_date((case when l_day between 1 and 10 then '11'||to_char(p_rpt_dt, 'mmyyyy')
                                when l_day between 11 and 20 then '21'||to_char(p_rpt_dt, 'mmyyyy')
                                else to_char(last_day( p_rpt_dt ) + 1, 'ddmmyyyy')
                           end), 'ddmmyyyy');
    else      
      l_rpt_dt := DAT_NEXT_U( p_rpt_dt, 1 );
    end if;


    PREPARE_RECORDSET( p_file_id, p_rpt_dt, p_kf, p_vrsn_id, l_rcur );

    l_ctx := dbms_xmlgen.newContext( l_rcur );

--  dbms_xmlgen.setRowSetTag( l_ctx, 'NBUSTATREPORT' );
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

    l_clob := GET_FILE_HEAD( l_rpt_code, l_rpt_dt, p_kf ) || chr(10) || l_clob || '</NBUSTATREPORT>';

    -----------
    -- КОСТИЛІ:

    -- заміна <P1/> на <P1></P1> (для NULL значень)
    l_clob := REGEXP_REPLACE( l_clob, '<([^>]+?)/>', '<\1></\1>' );

    -- вставка атрибуту xsi:nil для елементів ...
    case l_rpt_code
    when '3E'
    then
      l_clob := REGEXP_REPLACE( l_clob, '(<Q007_7|<Q007_8)(></)', '\1 xsi:nil = "true" \2' );
    when '3K'
    then
      l_clob := REGEXP_REPLACE( l_clob, '(<Q007_1)(></)', '\1 xsi:nil = "true" \2' );
      l_clob := REGEXP_REPLACE( l_clob, '(<Q003_2)(></)', '\1 xsi:nil = "true" \2' );
      l_clob := REGEXP_REPLACE( l_clob, '(<Q006)(></)', '\1 xsi:nil = "true" \2' );
    when '2K' 
    then
      l_clob := REGEXP_REPLACE( l_clob, '(<Q007_2)(></)', '\1 xsi:nil = "true" \2' );
      l_clob := REGEXP_REPLACE( l_clob, '(<Q007_3)(></)', '\1 xsi:nil = "true" \2' );
    when 'E8'
    then
      l_clob := REGEXP_REPLACE( l_clob, '(<Q001|<Q029)(></)', '\1 xsi:nil = "true" \2' );
      l_clob := REGEXP_REPLACE( l_clob, '(<Q003_2|<Q007_2)(></)', '\1 xsi:nil = "true" \2' );
    else
      null;
    end case;
    -----------

    l_errmsg := CHK_XML( p_file_id, p_rpt_dt, l_clob );

    if ( l_errmsg is Not Null )
    then
--    bars_audit.error( title||': '||l_errmsg );
      NBUR_FILES.SET_CHK_LOG( p_file_id => p_file_id
                            , p_rpt_dt  => p_rpt_dt
                            , p_kf      => p_kf
                            , p_vrsn_id => p_vrsn_id
                            , p_chk_log => l_errmsg
                            );
    end if;

    p_file_body := l_clob;

    DBMS_LOB.FREETEMPORARY( l_clob );

    bars_audit.trace( '%s: Exit.', title );

  end CRT_FILE;

  --
  --  Registering XSD (XML Schema Definition)
  --
  procedure SET_XSD
  ( p_file_id     in     nbur_ref_xsd.file_id%type
  , p_scm_dt      in     nbur_ref_xsd.scm_dt%type
  , p_scm_doc     in     blob
  ) is
  /**
  <b>SET_XSD</b> - реєстрація XSD схеми для валідації 
  %param p_file_id  - ідентифікатор файлу
  %param p_scm_dt   - дата вступу в дію XSD схеми
  %param p_scm_doc  - файл з XSD схемою
  
  %version 1.1
  %usage   створення місячних знімків балансу.
  */
    title   constant     varchar2(64) := $$PLSQL_UNIT||'.SET_XSD';
    l_rpt_code           nbur_ref_files.file_code%type;
    l_scm_url            nbur_ref_xsd.scm_url%type;
    l_scm_url_old        nbur_ref_xsd.scm_url%type;
  begin
    
    bars_audit.trace( '%s: Entry with ( p_file_id=%s, p_scm_dt=%s ).', title );
    
    case
    when ( p_file_id Is Null )
    then raise_application_error( -20666, 'Value for parameter [p_file_id] must be specified!', true );
    when ( p_scm_dt  Is Null )
    then raise_application_error( -20666, 'Value for parameter [p_scm_dt] must be specified!', true );
    when ( p_scm_doc Is Null or DBMS_LOB.GETLENGTH( p_scm_doc ) = 0 )
    then raise_application_error( -20666, 'Value for parameter [p_scm_doc] must be specified!', true );
    else
      
      l_rpt_code := NBUR_FILES.F_GET_KODF( p_file_id );
      
      if ( l_rpt_code Is Null ) 
      then raise_application_error( -20666, 'Not found report with ID='||to_char(p_file_id), true );
      else l_rpt_code := SubStr( l_rpt_code, 1, 2 );
      end if;
      
    end case;
    
    l_scm_url := 't' || lower( l_rpt_code ) || 'x'||to_char(p_scm_dt,'yyyymmdd')||'.xsd';
    
    begin
      
      insert
        into NBUR_REF_XSD
           ( FILE_ID, SCM_DT, SCM_URL, CHG_USR, CHG_DT )
      values
           ( p_file_id, p_scm_dt, l_scm_url, USER_ID(), SYSDATE );
      
    exception
      when DUP_VAL_ON_INDEX then
        begin
            select SCM_URL
            into l_scm_url_old
            from NBUR_REF_XSD
            where FILE_ID = p_file_id
               and SCM_DT <= p_scm_dt;
            
            DBMS_XMLSCHEMA.DELETESCHEMA( SCHEMAURL     => l_scm_url_old
                                       , DELETE_OPTION => DBMS_XMLSCHEMA.DELETE_CASCADE_FORCE );
        
        exception
          when NO_DATA_FOUND then null;
        end;

        update NBUR_REF_XSD
           set CHG_USR = USER_ID()
             , CHG_DT  = SYSDATE
             , SCM_URL = l_scm_url
         where FILE_ID = p_file_id
           and SCM_DT  = p_scm_dt;
    end;

    DBMS_XMLSCHEMA.REGISTERSCHEMA( schemaurl       => l_scm_url
                                 , schemadoc       => p_scm_doc
                                 , local           => true
                                 , gentypes        => false
                                 , genbean         => false
                                 , gentables       => false
                                 , force           => false
                                 , owner           => 'BARS'
                                 , csid            => NLS_CHARSET_ID( 'UTF8' ) -- 'AL32UTF8'
                                 , enablehierarchy => DBMS_XMLSCHEMA.ENABLE_HIERARCHY_NONE );
    
    bars_audit.info( title||': user '||to_char(USER_ID())||' changed XSD for #'||l_rpt_code );
    
    bars_audit.trace( '%s: Exit.', title );
    
  end SET_XSD;
  
  --
  -- CONVERT_CLOB_TO_BLOB
  --
  procedure CONVERT_CLOB_TO_BLOB
  ( p_clob_data       in out nocopy clob
  , p_blob_data       in out nocopy blob
  , p_blob_csid       in            number default null
  ) is
  /**
  <b>CONVERT_CLOB_TO_BLOB</b> - convert clob to blob
  %param p_clob_data - input  parameter src CLOB
  %param p_blob_data - output parameter dst BLOB
  %param p_blob_csid - input  parameter character set ID for dst BLOB ( default 'UTF8' )
  
  %version 1.0
  %usage   
  */
    title         constant varchar2(64) := $$PLSQL_UNIT||'.CONVERT_CLOB_TO_BLOB';
    l_dst_offset           integer := 1;
    l_src_offset           integer := 1;
    l_blob_csid            number;
    l_lng_context          integer := DBMS_LOB.DEFAULT_LANG_CTX;
    l_wrn                  integer; -- := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
  begin
    
    bars_audit.trace( '%s: Entry.', title );
    
    if ( p_blob_csid Is Null )
    then
      l_blob_csid := NLS_CHARSET_ID('UTF8');
    else
      l_blob_csid := p_blob_csid;
    end if;
    
    DBMS_LOB.CONVERTTOBLOB
    ( dest_lob     => p_blob_data
    , src_clob     => p_clob_data
    , amount       => DBMS_LOB.LOBMAXSIZE
    , dest_offset  => l_dst_offset
    , src_offset   => l_src_offset
    , blob_csid    => l_blob_csid
    , lang_context => l_lng_context
    , warning      => l_wrn );
    
    bars_audit.trace( '%s: Exit.', title );
    
  end CONVERT_CLOB_TO_BLOB;



BEGIN
  v_rpt_dt  := BARS.DAT_NEXT_U( BARS.GL.BD(), -1 );
  v_kf      := SYS_CONTEXT('BARS_CONTEXT','USER_MFO');
  v_vrsn_id := 1;
end NBUR_XML;
/