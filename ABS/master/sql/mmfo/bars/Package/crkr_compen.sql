
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/crkr_compen.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CRKR_COMPEN 
is
  version_header  constant  varchar2(64) := 'version 1.1 26.04.2016 16:24';

  procedure create_recport (p_ID           in varchar2, --int
                            p_FIO          in varchar2,
                            p_COUNTRY      in varchar2, --number
                            p_POSTINDEX    in varchar2,
                            p_OBL          in varchar2,
                            p_RAJON        in varchar2,
                            p_CITY         in varchar2,
                            p_ADDRESS      in varchar2,
                            p_FULLADDRESS  in varchar2,
                            p_ICOD         in varchar2,
                            p_DOCTYPE      in varchar2, --number
                            p_DOCSERIAL    in varchar2,
                            p_DOCNUMBER    in varchar2,
                            p_DOCORG       in varchar2,
                            p_DOCDATE      in varchar2, --date
                            p_CLIENTBDATE  in varchar2, --date
                            p_CLIENTBPLACE in varchar2,
                            p_CLIENTSEX    in varchar2, --number
                            p_CLIENTPHONE  in varchar2,
                            p_REGISTRYDATE in varchar2, --date
                            p_NSC          in varchar2,
                            p_IDA          in varchar2,
                            p_ND           in varchar2,
                            p_SUM          in varchar2, --number
                            p_OST          in varchar2, --number
                            p_DATO         in varchar2, --date
                            p_DATL         in varchar2, --date
                            p_ATTR         in varchar2,
                            p_CARD         in varchar2,
                            p_DATN         in varchar2, --date
                            p_VER          in varchar2,
                            p_STAT         in varchar2,
                            p_tvbv         in varchar2,
                            p_BRANCH       in varchar2,
                            p_KV           in varchar2, --number
                            p_STATUS       in varchar2, --int
                            p_date_import  in varchar2, --date
                            p_benef        in varchar2, --clob
                            p_motion       in varchar2, --clob,
                            p_err         out varchar2,
                            p_ret         out int);

  procedure drop_port_tvbv (p_tvbv         in varchar2,
                            p_kf           in varchar2,
                            p_err         out varchar2,
                            p_ret         out int);

  procedure make_wiring    (p_tvbv         in varchar2,
                            p_summa        in varchar2, --number
                            p_nls          in varchar2,
                            p_kv           in varchar2, --number
                            p_branch       in varchar2,
                            p_date_import  in varchar2, --date
                            p_err         out varchar2,
                            p_ret         out int);

  procedure drop_wiring    (p_tvbv         in varchar2,
                            p_kf           in varchar2,
                            p_date_import  in varchar2,
                            p_err         out varchar2,
                            p_ret         out int);

  function header_version      return varchar2;

  function body_version        return varchar2;

  function b64d (p_s varchar2) return varchar2;


end crkr_compen;
/
CREATE OR REPLACE PACKAGE BODY BARS.CRKR_COMPEN 
as
  version_body  constant  varchar2(64) := 'version 1.1 26.04.2016 16:24';

--

  procedure create_recport (p_ID           in varchar2, --int
                            p_FIO          in varchar2,
                            p_COUNTRY      in varchar2, --number
                            p_POSTINDEX    in varchar2,
                            p_OBL          in varchar2,
                            p_RAJON        in varchar2,
                            p_CITY         in varchar2,
                            p_ADDRESS      in varchar2,
                            p_FULLADDRESS  in varchar2,
                            p_ICOD         in varchar2,
                            p_DOCTYPE      in varchar2, --number
                            p_DOCSERIAL    in varchar2,
                            p_DOCNUMBER    in varchar2,
                            p_DOCORG       in varchar2,
                            p_DOCDATE      in varchar2, --date
                            p_CLIENTBDATE  in varchar2, --date
                            p_CLIENTBPLACE in varchar2,
                            p_CLIENTSEX    in varchar2, --number
                            p_CLIENTPHONE  in varchar2,
                            p_REGISTRYDATE in varchar2, --date
                            p_NSC          in varchar2,
                            p_IDA          in varchar2,
                            p_ND           in varchar2,
                            p_SUM          in varchar2, --number
                            p_OST          in varchar2, --number
                            p_DATO         in varchar2, --date
                            p_DATL         in varchar2, --date
                            p_ATTR         in varchar2,
                            p_CARD         in varchar2,
                            p_DATN         in varchar2, --date
                            p_VER          in varchar2,
                            p_STAT         in varchar2,
                            p_tvbv         in varchar2,
                            p_BRANCH       in varchar2,
                            p_KV           in varchar2, --number
                            p_STATUS       in varchar2, --int
                            p_date_import  in varchar2, --date
                            p_benef        in varchar2, --clob
                            p_motion       in varchar2, --clob
                            p_err         out varchar2,
                            p_ret         out int)
  is

    l_ID             varchar2(4000);
    l_FIO            varchar2(4000);
    l_COUNTRY        varchar2(4000);
    l_POSTINDEX      varchar2(4000);
    l_OBL            varchar2(4000);
    l_RAJON          varchar2(4000);
    l_CITY           varchar2(4000);
    l_ADDRESS        varchar2(4000);
    l_FULLADDRESS    varchar2(4000);
    l_ICOD           varchar2(4000);
    l_DOCTYPE        varchar2(4000);
    l_DOCSERIAL      varchar2(4000);
    l_DOCNUMBER      varchar2(4000);
    l_DOCORG         varchar2(4000);
    l_DOCDATE        varchar2(4000);
    l_CLIENTBDATE    varchar2(4000);
    l_CLIENTBPLACE   varchar2(4000);
    l_CLIENTSEX      varchar2(4000);
    l_CLIENTPHONE    varchar2(4000);
    l_REGISTRYDATE   varchar2(4000);
    l_NSC            varchar2(4000);
    l_IDA            varchar2(4000);
    l_ND             varchar2(4000);
    l_SUM            varchar2(4000);
    l_OST            varchar2(4000);
    l_DATO           varchar2(4000);
    l_DATL           varchar2(4000);
    l_ATTR           varchar2(4000);
    l_CARD           varchar2(4000);
    l_DATN           varchar2(4000);
    l_VER            varchar2(4000);
    l_STAT           varchar2(4000);
    l_tvbv           varchar2(4000);
    l_BRANCH         varchar2(4000);
    l_KV             varchar2(4000);
    l_STATUS         varchar2(4000);
    l_date_import    varchar2(4000);
    l_benef          varchar2(4000);
    l_motion         varchar2(4000);

    l_clob           clob;
--  l_parser         xmlparser.parser := xmlparser.newparser;
    l_parser         xmlparser.parser;
    l_doc            xmldom.domdocument;
    l_ROW            xmldom.domnodelist;
    l_ROWelement     xmldom.DOMNode;
    i                int;

    l_mIDM           varchar2(32)  ; --int
    l_mSUMOP         varchar2(32)  ; --number
    l_mDK            varchar2(32)  ; --int
    l_mDATL          varchar2(32)  ; --date
    l_mTYPO          varchar2(32)  ;
    l_mMARK          varchar2(32)  ;
    l_mVER           varchar2(32)  ; --number
    l_mSTAT          varchar2(32)  ;
    l_mOST           varchar2(32)  ; --number
    l_mZPR           varchar2(32)  ; --number
    l_mDATP          varchar2(32)  ; --date
    l_mPREA          varchar2(32)  ;
    l_mOI            varchar2(32)  ;
    l_mOL            varchar2(32)  ;

    l_IDB            varchar2(32)  ; --int
    l_CODE           varchar2(32)  ;
    l_FIOB           varchar2(256) ;
    l_COUNTRYB       varchar2(32)  ; --int
    l_FULLADDRESSB   varchar2(1024);
    l_ICODB          varchar2(128) ;
    l_DOCTYPEB       varchar2(32)  ; --int
    l_DOCSERIALB     varchar2(32)  ;
    l_DOCNUMBERB     varchar2(32)  ;
    l_DOCORGB        varchar2(256) ;
    l_DOCDATEB       varchar2(32)  ; --date
    l_CLIENTBDATEB   varchar2(32)  ; --date
    l_CLIENTSEXB     varchar2(32)  ;
    l_CLIENTPHONEB   varchar2(128) ;

    l_dDATL          date;
    l_dDATP          date;
    l_dDOCDATEB      date;
    l_dCLIENTBDATEB  date;

  begin

--  p_ret := -1;
--  p_err := 'тест ош';
--  return;

/*
--  логин
    begin
      execute immediate 'begin
                           bars_login.login_user(null,null,null,null);
                         end;';
--  exception when others then
--    bars_audit.error('bars_login.login_user(null,null,null,null)'||
--                     chr(13)||chr(10)||sqlerrm||chr(13)||chr(10)||
--                     replace(dbms_utility.format_error_backtrace,
--                     chr(10),chr(13)||chr(10)));
--    p_ret := -1;
--    p_err := 'bars_login.login_user - error - '||sqlerrm;
--    return;
    end;
*/

    tokf;
--
    bars_audit.info('begin: create_recport');
--  return;

    p_ret := 0;
    p_err := '';

    l_ID           :=  b64d(p_ID          );
    l_FIO          :=  b64d(p_FIO         );
    l_COUNTRY      :=  b64d(p_COUNTRY     );
    l_POSTINDEX    :=  b64d(p_POSTINDEX   );
    l_OBL          :=  b64d(p_OBL         );
    l_RAJON        :=  b64d(p_RAJON       );
    l_CITY         :=  b64d(p_CITY        );
    l_ADDRESS      :=  b64d(p_ADDRESS     );
    l_FULLADDRESS  :=  b64d(p_FULLADDRESS );
    l_ICOD         :=  b64d(p_ICOD        );
    l_DOCTYPE      :=  b64d(p_DOCTYPE     );
    l_DOCSERIAL    :=  b64d(p_DOCSERIAL   );
    l_DOCNUMBER    :=  b64d(p_DOCNUMBER   );
    l_DOCORG       :=  b64d(p_DOCORG      );
    l_DOCDATE      :=  b64d(p_DOCDATE     );
    l_CLIENTBDATE  :=  b64d(p_CLIENTBDATE );
    l_CLIENTBPLACE :=  b64d(p_CLIENTBPLACE);
    l_CLIENTSEX    :=  b64d(p_CLIENTSEX   );
    l_CLIENTPHONE  :=  b64d(p_CLIENTPHONE );
    l_REGISTRYDATE :=  b64d(p_REGISTRYDATE);
    l_NSC          :=  b64d(p_NSC         );
    l_IDA          :=  b64d(p_IDA         );
    l_ND           :=  b64d(p_ND          );
    l_SUM          :=  b64d(p_SUM         );
    l_OST          :=  b64d(p_OST         );
    l_DATO         :=  b64d(p_DATO        );
    l_DATL         :=  b64d(p_DATL        );
    l_ATTR         :=  b64d(p_ATTR        );
    l_CARD         :=  b64d(p_CARD        );
    l_DATN         :=  b64d(p_DATN        );
    l_VER          :=  b64d(p_VER         );
    l_STAT         :=  b64d(p_STAT        );
    l_tvbv         :=  b64d(p_tvbv        );
    l_BRANCH       :=  b64d(p_BRANCH      );
    l_KV           :=  b64d(p_KV          );
    l_STATUS       :=  b64d(p_STATUS      );
    l_date_import  :=  b64d(p_date_import );
    l_benef        :=  b64d(p_benef       );
    l_motion       :=  b64d(p_motion      );

    begin
      insert
      into   COMPEN_portfolio (ID          ,
                               FIO         ,
                               COUNTRY     ,
                               POSTINDEX   ,
                               OBL         ,
                               RAJON       ,
                               CITY        ,
                               ADDRESS     ,
                               FULLADDRESS ,
                               ICOD        ,
                               DOCTYPE     ,
                               DOCSERIAL   ,
                               DOCNUMBER   ,
                               DOCORG      ,
                               DOCDATE     ,
                               CLIENTBDATE ,
                               CLIENTBPLACE,
                               CLIENTSEX   ,
                               CLIENTPHONE ,
                               REGISTRYDATE,
                               NSC         ,
                               IDA         ,
                               ND          ,
                               SUM         ,
                               OST         ,
                               DATO        ,
                               DATL        ,
                               ATTR        ,
                               CARD        ,
                               DATN        ,
                               VER         ,
                               STAT        ,
                               TVBV        ,
                               BRANCH      ,
                               KV          ,
                               STATUS      ,
                               DATE_IMPORT)
                       values (to_number(l_ID)                     , --int     ID
                               l_FIO                               , --        FIO
                               to_number(l_COUNTRY)                , --number  COUNTRY
                               l_POSTINDEX                         , --        POSTINDEX
                               l_OBL                               , --        OBL
                               l_RAJON                             , --        RAJON
                               l_CITY                              , --        CITY
                               l_ADDRESS                           , --        ADDRESS
                               l_FULLADDRESS                       , --        FULLADDRESS
                               l_ICOD                              , --        ICOD
                               to_number(l_DOCTYPE)                , --number  DOCTYPE
                               l_DOCSERIAL                         , --        DOCSERIAL
                               l_DOCNUMBER                         , --        DOCNUMBER
                               l_DOCORG                            , --        DOCORG
                               to_date(l_DOCDATE,'YYYY-MM-DD')     , --date    DOCDATE
                               to_date(l_CLIENTBDATE,'YYYY-MM-DD') , --date    CLIENTBDATE
                               l_CLIENTBPLACE                      , --        CLIENTBPLACE
                               to_number(l_CLIENTSEX)              , --number  CLIENTSEX
                               l_CLIENTPHONE                       , --        CLIENTPHONE
                               to_date(l_REGISTRYDATE,'YYYY-MM-DD'), --date    REGISTRYDATE
                               l_NSC                               , --        NSC
                               l_IDA                               , --        IDA
                               l_ND                                , --        ND
                               to_number(l_SUM)                    , --number  SUM
                               to_number(l_OST)                    , --number  OST
                               to_date(l_DATO,'YYYY-MM-DD')        , --date    DATO
                               to_date(l_DATL,'YYYY-MM-DD')        , --date    DATL
                               l_ATTR                              , --        ATTR
                               l_CARD                              , --        CARD
                               to_date(l_DATN,'YYYY-MM-DD')        , --date    DATN
                               l_VER                               , --        VER
                               l_STAT                              , --        STAT
                               l_tvbv                              , --        TVBV
                               l_BRANCH                            , --        BRANCH
                               to_number(l_KV)                     , --number  KV
                               to_number(l_STATUS)                 , --int     STATUS
                               to_date(l_date_import,'YYYY-MM-DD')); --date    DATE_IMPORT
    exception when others then
      p_ret := -1;
--    tokf;
      bars_audit.error(sqlerrm||' - '||dbms_utility.format_error_backtrace);
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      return;
    end;
--  benef
    begin
      l_clob := l_benef;
      l_parser := xmlparser.newparser;
      xmlparser.parseCLOB(l_parser,l_clob);
      l_doc := xmlparser.getDocument(l_parser);
      l_ROW := xmldom.getelementsbytagname(l_doc,'Row');
      for i in 0..xmldom.getlength(l_ROW)-1
      loop
        l_ROWelement := xmldom.item(l_ROW,i);
        xslprocessor.valueof(l_ROWelement,'IDB/text()'         ,l_IDB         ); --int
        xslprocessor.valueof(l_ROWelement,'CODE/text()'        ,l_CODE        );
        xslprocessor.valueof(l_ROWelement,'FIOB/text()'        ,l_FIOB        );
        xslprocessor.valueof(l_ROWelement,'COUNTRYB/text()'    ,l_COUNTRYB    ); --int
        xslprocessor.valueof(l_ROWelement,'FULLADDRESSB/text()',l_FULLADDRESSB);
        xslprocessor.valueof(l_ROWelement,'ICODB/text()'       ,l_ICODB       );
        xslprocessor.valueof(l_ROWelement,'DOCTYPEB/text()'    ,l_DOCTYPEB    ); --int
        xslprocessor.valueof(l_ROWelement,'DOCSERIALB/text()'  ,l_DOCSERIALB  );
        xslprocessor.valueof(l_ROWelement,'DOCNUMBERB/text()'  ,l_DOCNUMBERB  );
        xslprocessor.valueof(l_ROWelement,'DOCORGB/text()'     ,l_DOCORGB     );
        xslprocessor.valueof(l_ROWelement,'DOCDATEB/text()'    ,l_DOCDATEB    ); --date
        xslprocessor.valueof(l_ROWelement,'CLIENTBDATEB/text()',l_CLIENTBDATEB); --date
        xslprocessor.valueof(l_ROWelement,'CLIENTSEXB/text()'  ,l_CLIENTSEXB  );
        xslprocessor.valueof(l_ROWelement,'CLIENTPHONEB/text()',l_CLIENTPHONEB);

        begin
          l_dDOCDATEB     := to_date(l_DOCDATEB,'YYYY-MM-DD');
        exception when others then
          xmldom.freeDocument(l_doc);
          xmlparser.freeParser(l_parser);
          p_ret := -4;
          p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
          return;
        end;
        begin
          l_dCLIENTBDATEB := to_date(l_CLIENTBDATEB,'YYYY-MM-DD');
        exception when others then
          xmldom.freeDocument(l_doc);
          xmlparser.freeParser(l_parser);
          p_ret := -5;
          p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
          return;
        end;

        begin
          insert
          into   COMPEN_benef (id_compen   ,
                               IDB         ,
                               CODE        ,
                               FIOB        ,
                               COUNTRYB    ,
                               FULLADDRESSB,
                               ICODB       ,
                               DOCTYPEB    ,
                               DOCSERIALB  ,
                               DOCNUMBERB  ,
                               DOCORGB     ,
                               DOCDATEB    ,
                               CLIENTBDATEB,
                               CLIENTSEXB  ,
                               CLIENTPHONEB)
                       values (to_number(l_id)      ,
                               to_number(l_IDB)     ,
                               l_CODE               ,
                               l_FIOB               ,
                               to_number(l_COUNTRYB),
                               l_FULLADDRESSB       ,
                               l_ICODB              ,
                               to_number(l_DOCTYPEB),
                               l_DOCSERIALB         ,
                               l_DOCNUMBERB         ,
                               l_DOCORGB            ,
                               l_dDOCDATEB          , --to_date(l_DOCDATEB,'YYYY-MM-DD')
                               l_dCLIENTBDATEB      , --to_date(l_CLIENTBDATEB,'YYYY-MM-DD')
                               l_CLIENTSEXB         ,
                               l_CLIENTPHONEB);
        exception when others then
          xmldom.freeDocument(l_doc);
          xmlparser.freeParser(l_parser);
          p_ret := -3;
          p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
          return;
        end;
      end loop;
      xmldom.freeDocument(l_doc);
      xmlparser.freeParser(l_parser);
    end;
--  motion
    begin
      l_clob := l_motion;
      l_parser := xmlparser.newparser;
      xmlparser.parseCLOB(l_parser,l_clob);
      l_doc := xmlparser.getDocument(l_parser);
      l_ROW := xmldom.getelementsbytagname(l_doc,'Row');
      for i in 0..xmldom.getlength(l_ROW)-1
      loop
        l_ROWelement := xmldom.item(l_ROW,i);
        xslprocessor.valueof(l_ROWelement,'IDM/text()'  ,l_mIDM  ); --int
        xslprocessor.valueof(l_ROWelement,'SUMOP/text()',l_mSUMOP); --number
        xslprocessor.valueof(l_ROWelement,'DK/text()'   ,l_mDK   ); --int
        xslprocessor.valueof(l_ROWelement,'DATL/text()' ,l_mDATL ); --date
        xslprocessor.valueof(l_ROWelement,'TYPO/text()' ,l_mTYPO );
        xslprocessor.valueof(l_ROWelement,'MARK/text()' ,l_mMARK );
        xslprocessor.valueof(l_ROWelement,'VER/text()'  ,l_mVER  ); --number
        xslprocessor.valueof(l_ROWelement,'STAT/text()' ,l_mSTAT );
        xslprocessor.valueof(l_ROWelement,'OST/text()'  ,l_mOST  ); --number
        xslprocessor.valueof(l_ROWelement,'ZPR/text()'  ,l_mZPR  ); --number
        xslprocessor.valueof(l_ROWelement,'DATP/text()' ,l_mDATP ); --date
        xslprocessor.valueof(l_ROWelement,'PREA/text()' ,l_mPREA );
        xslprocessor.valueof(l_ROWelement,'OI/text()'   ,l_mOI   );
        xslprocessor.valueof(l_ROWelement,'OL/text()'   ,l_mOL   );

        begin
          l_dDATL := to_date(l_mDATL,'YYYY-MM-DD');
        exception when others then
          xmldom.freeDocument(l_doc);
          xmlparser.freeParser(l_parser);
          p_ret := -7;
          p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
          return;
        end;
        begin
          l_dDATP := to_date(l_mDATP,'YYYY-MM-DD');
        exception when others then
          xmldom.freeDocument(l_doc);
          xmlparser.freeParser(l_parser);
          p_ret := -8;
          p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
          return;
        end;

        begin
          insert
          into   COMPEN_motions (id_compen,
                                 IDM      ,
                                 SUMOP    ,
                                 DK       ,
                                 DATL     ,
                                 TYPO     ,
                                 MARK     ,
                                 VER      ,
                                 STAT     ,
                                 OST      ,
                                 ZPR      ,
                                 DATP     ,
                                 PREA     ,
                                 OI       ,
                                 OL)
                         values (to_number(l_id)    ,
                                 to_number(l_mIDM)  ,
                                 to_number(l_mSUMOP),
                                 to_number(l_mDK)   ,
                                 l_dDATL            , --to_date(l_DATL,'YYYY-MM-DD')
                                 l_mTYPO            ,
                                 l_mMARK            ,
                                 to_number(l_mVER)  ,
                                 l_mSTAT            ,
                                 to_number(l_mOST)  ,
                                 to_number(l_mZPR)  ,
                                 l_dDATP            , --to_date(l_DATP,'YYYY-MM-DD')
                                 l_mPREA            ,
                                 l_mOI              ,
                                 l_mOL);
        exception when others then
          xmldom.freeDocument(l_doc);
          xmlparser.freeParser(l_parser);
          p_ret := -2;
          p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
          return;
        end;
      end loop;
      xmldom.freeDocument(l_doc);
      xmlparser.freeParser(l_parser);
    end;
  end create_recport;

--

  procedure drop_port_tvbv (p_tvbv in varchar2,
                            p_kf   in varchar2,
                            p_err out varchar2,
                            p_ret out int)
  is
  begin
    p_ret := 0;
    p_err := '';
    begin
      delete
      from   COMPEN_MOTIONS
      where  id_compen in (select id
                           from   COMPEN_PORTFOLIO
                           where  tvbv=p_tvbv and
                                  substr(branch,2,6)=p_kf);
    exception when others then
      p_ret := -3;
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      return;
    end;
--
    begin
      delete
      from   COMPEN_BENEF
      where  id_compen in (select id
                           from   COMPEN_PORTFOLIO
                           where  tvbv=p_tvbv and
                                  substr(branch,2,6)=p_kf);
    exception when others then
      p_ret := -2;
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      return;
    end;
--
    begin
      delete
      from   COMPEN_PORTFOLIO
      where  tvbv=p_tvbv and
             substr(branch,2,6)=p_kf;
    exception when others then
      p_ret := -1;
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      return;
    end;
  end drop_port_tvbv;

--

  procedure make_wiring (p_tvbv         in varchar2,
                         p_summa        in varchar2, --number
                         p_nls          in varchar2,
                         p_kv           in varchar2, --number
                         p_branch       in varchar2,
                         p_date_import  in varchar2, --date
                         p_err         out varchar2,
                         p_ret         out int)
  is

    l_url_wapp           varchar2(256);
    l_Authorization_val  varchar2(256);
    l_walett_path        varchar2(256);
    l_walett_pass        varchar2(256);
    l_action             varchar2(32);
    g_response           wsm_mgr.t_response;
    l_result             varchar2(32767);

  begin

    p_ret := 0;
    p_err := '';

    l_url_wapp := GetGlobalOption('CA_URL');
    if l_url_wapp is null then
      l_url_wapp := 'http://ca_url_undefined';
    end if;
    if substr(l_url_wapp,-1,1)<>'/' then
      l_url_wapp := l_url_wapp||'/';
    end if;
    l_Authorization_val := 'Basic '||utl_raw.cast_to_varchar2(utl_encode.base64_encode(
                           utl_raw.cast_to_raw(GetGlobalOption('CA_LOGIN')||':'||
                           GetGlobalOption('CA_PASS'))));
    l_walett_path       := GetGlobalOption('CA_WALLET_PATH');
    l_walett_pass       := GetGlobalOption('CA_WALLET_PASS');
    l_action            := 'ca_make_wiring';

    wsm_mgr.prepare_request(p_url          => l_url_wapp         ,
                            p_action       => l_action           ,
                            p_http_method  => wsm_mgr.G_HTTP_POST,
                            p_content_type => wsm_mgr.g_ct_xml   ,
                            p_wallet_path  => l_walett_path      ,
                            p_wallet_pwd   => l_walett_pass);
    wsm_mgr.add_header     (p_name => 'Authorization', p_value => l_Authorization_val);
    wsm_mgr.add_parameter  (p_name => 'summa'        , p_value => p_summa            );
    wsm_mgr.add_parameter  (p_name => 'nls'          , p_value => p_nls              );
    wsm_mgr.add_parameter  (p_name => 'kv'           , p_value => p_kv               );
    wsm_mgr.add_parameter  (p_name => 'branch'       , p_value => p_branch           );
    wsm_mgr.add_parameter  (p_name => 'tvbv'         , p_value => p_tvbv             );
    wsm_mgr.add_parameter  (p_name => 'date_import'  , p_value => p_date_import      );
    wsm_mgr.execute_request(g_response);
    l_result := g_response.cdoc; -- если есть ответ - в clob будет
    if substr(l_result,1,3) in ('400','401','404','500') and length(l_result)>3 then
      p_err := l_result;
      p_ret := -1;
--    rollback;
      return;
    end if;

  end make_wiring;

--

  procedure drop_wiring (p_tvbv         in varchar2,
                         p_kf           in varchar2,
                         p_date_import  in varchar2,
                         p_err         out varchar2,
                         p_ret         out int)
  is

    l_url_wapp           varchar2(256);
    l_Authorization_val  varchar2(256);
    l_walett_path        varchar2(256);
    l_walett_pass        varchar2(256);
    l_action             varchar2(32);
    g_response           wsm_mgr.t_response;
    l_result             varchar2(32767);

  begin

    p_ret := 0;
    p_err := '';

    l_url_wapp := GetGlobalOption('CA_URL');
    if l_url_wapp is null then
      l_url_wapp := 'http://ca_url_undefined';
    end if;
    if substr(l_url_wapp,-1,1)<>'/' then
      l_url_wapp := l_url_wapp||'/';
    end if;
    l_Authorization_val := 'Basic '||utl_raw.cast_to_varchar2(utl_encode.base64_encode(
                           utl_raw.cast_to_raw(GetGlobalOption('CA_LOGIN')||':'||
                           GetGlobalOption('CA_PASS'))));
    l_walett_path       := GetGlobalOption('CA_WALLET_PATH');
    l_walett_pass       := GetGlobalOption('CA_WALLET_PASS');
    l_action            := 'ca_drop_wiring';

    wsm_mgr.prepare_request(p_url          => l_url_wapp         ,
                            p_action       => l_action           ,
                            p_http_method  => wsm_mgr.G_HTTP_POST,
                            p_content_type => wsm_mgr.g_ct_xml   ,
                            p_wallet_path  => l_walett_path      ,
                            p_wallet_pwd   => l_walett_pass);
    wsm_mgr.add_header     (p_name => 'Authorization', p_value => l_Authorization_val);
    wsm_mgr.add_parameter  (p_name => 'tvbv'         , p_value => p_tvbv             );
    wsm_mgr.add_parameter  (p_name => 'kf'           , p_value => p_kf               );
    wsm_mgr.add_parameter  (p_name => 'date_import'  , p_value => p_date_import      );
    wsm_mgr.execute_request(g_response);
    l_result := g_response.cdoc; -- если есть ответ - в clob будет
    if substr(l_result,1,3) in ('400','401','404','500') and length(l_result)>3 then
      p_err := l_result;
      p_ret := -1;
--    rollback;
      return;
    end if;

  end drop_wiring;

--

  function header_version return varchar2
  is
  begin
    return 'Package header crkr_compen '||version_header;
  end header_version;

--

  function body_version return varchar2
  is
  begin
    return 'Package body crkr_compen '||version_body;
  end body_version;

--

  function b64d (p_s varchar2) return varchar2
  is
  begin
    if p_s is not null then
      return utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw(p_s)));
    else
      return null;
    end if;
  end b64d;

end crkr_compen;
/
 show err;
 
PROMPT *** Create  grants  CRKR_COMPEN ***
grant EXECUTE                                                                on CRKR_COMPEN     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/crkr_compen.sql =========*** End ***
 PROMPT ===================================================================================== 
 