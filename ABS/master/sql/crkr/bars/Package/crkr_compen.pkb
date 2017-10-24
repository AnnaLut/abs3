create or replace package body crkr_compen
as
  version_body  constant  varchar2(64) := 'version 1.57 31.03.2017 16:18';

--типы
  type t_let_rec   is record (ukr_num  varchar2(2),
                              ukr_let  varchar2(1),
                              rus_let  varchar2(1),
                              eng_let  varchar2(1));
  type t_let_table is table of t_let_rec index by binary_integer;
--глобальные переменные
  g_let_table      t_let_table; /* таблица соответствия букв */

--

  procedure fill_let_table
  is
    l  t_let_rec;
  begin
    l.ukr_num := '01'; l.ukr_let := chr(192); l.eng_let := chr(65); g_let_table(0)  := l;
    l.ukr_num := '02'; l.ukr_let := chr(193); l.eng_let := '';      g_let_table(1)  := l;
    l.ukr_num := '03'; l.ukr_let := chr(194); l.eng_let := chr(66); g_let_table(39) := l;
    l.ukr_num := '03'; l.ukr_let := chr(194); l.eng_let := chr(86); g_let_table(2)  := l;
    l.ukr_num := '03'; l.ukr_let := chr(194); l.eng_let := chr(87); g_let_table(3)  := l;
    l.ukr_num := '04'; l.ukr_let := chr(195); l.eng_let := chr(71); g_let_table(4)  := l;
    l.ukr_num := '05'; l.ukr_let := chr(165); l.eng_let := '';      g_let_table(5)  := l;
    l.ukr_num := '06'; l.ukr_let := chr(196); l.eng_let := chr(68); g_let_table(6)  := l;
    l.ukr_num := '07'; l.ukr_let := chr(197); l.eng_let := chr(69); g_let_table(7)  := l;
    l.ukr_num := '08'; l.ukr_let := chr(170); l.eng_let := '';      g_let_table(8)  := l;
    l.ukr_num := '09'; l.ukr_let := chr(198); l.eng_let := chr(74); g_let_table(9)  := l;
    l.ukr_num := '10'; l.ukr_let := chr(199); l.eng_let := chr(90); g_let_table(10) := l;
    l.ukr_num := '11'; l.ukr_let := chr(200); l.eng_let := '';      g_let_table(11) := l;
    l.ukr_num := '12'; l.ukr_let := chr(178); l.eng_let := chr(73); g_let_table(12) := l;
    l.ukr_num := '13'; l.ukr_let := chr(175); l.eng_let := '';      g_let_table(13) := l;
    l.ukr_num := '14'; l.ukr_let := chr(201); l.eng_let := '';      g_let_table(14) := l;
    l.ukr_num := '15'; l.ukr_let := chr(202); l.eng_let := chr(75); g_let_table(15) := l;
    l.ukr_num := '15'; l.ukr_let := chr(202); l.eng_let := chr(81); g_let_table(16) := l;
    l.ukr_num := '16'; l.ukr_let := chr(203); l.eng_let := chr(76); g_let_table(17) := l;
    l.ukr_num := '17'; l.ukr_let := chr(204); l.eng_let := chr(77); g_let_table(18) := l;
    l.ukr_num := '18'; l.ukr_let := chr(205); l.eng_let := chr(72); g_let_table(19) := l;
    l.ukr_num := '18'; l.ukr_let := chr(205); l.eng_let := chr(78); g_let_table(20) := l;
    l.ukr_num := '19'; l.ukr_let := chr(206); l.eng_let := chr(79); g_let_table(21) := l;
    l.ukr_num := '20'; l.ukr_let := chr(207); l.eng_let := '';      g_let_table(22) := l;
    l.ukr_num := '21'; l.ukr_let := chr(208); l.eng_let := chr(80); g_let_table(23) := l;
    l.ukr_num := '21'; l.ukr_let := chr(208); l.eng_let := chr(82); g_let_table(24) := l;
    l.ukr_num := '22'; l.ukr_let := chr(209); l.eng_let := chr(67); g_let_table(25) := l;
    l.ukr_num := '22'; l.ukr_let := chr(209); l.eng_let := chr(83); g_let_table(26) := l;
    l.ukr_num := '23'; l.ukr_let := chr(210); l.eng_let := chr(84); g_let_table(27) := l;
    l.ukr_num := '24'; l.ukr_let := chr(211); l.eng_let := chr(85); g_let_table(28) := l;
    l.ukr_num := '24'; l.ukr_let := chr(211); l.eng_let := chr(89); g_let_table(29) := l;
    l.ukr_num := '25'; l.ukr_let := chr(212); l.eng_let := chr(70); g_let_table(30) := l;
    l.ukr_num := '26'; l.ukr_let := chr(213); l.eng_let := chr(88); g_let_table(31) := l;
    l.ukr_num := '27'; l.ukr_let := chr(214); l.eng_let := '';      g_let_table(32) := l;
    l.ukr_num := '28'; l.ukr_let := chr(215); l.eng_let := '';      g_let_table(33) := l;
    l.ukr_num := '29'; l.ukr_let := chr(216); l.eng_let := '';      g_let_table(34) := l;
    l.ukr_num := '30'; l.ukr_let := chr(217); l.eng_let := '';      g_let_table(35) := l;
    l.ukr_num := '31'; l.ukr_let := chr(220); l.eng_let := '';      g_let_table(36) := l;
    l.ukr_num := '32'; l.ukr_let := chr(222); l.eng_let := '';      g_let_table(37) := l;
    l.ukr_num := '33'; l.ukr_let := chr(223); l.eng_let := '';      g_let_table(38) := l;
  end;

--

  procedure create_recport (p_record       in clob    ,
                            p_err         out varchar2,
                            p_ret         out int)
  is
    l_rec            clob;
    l_ben            clob;
    l_mot            clob;
    TYPE             RBM is record (recbenefmotion clob);
    type             t_RBM is table of RBM;
    l_recbm          t_RBM := t_RBM();
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
    l_percent        varchar2(4000);
    l_kkname         varchar2(4000);
    l_ob22           varchar2(4000);
    l_STATUS         varchar2(4000);
    l_date_import    varchar2(4000);
    l_benef          varchar2(4000);
    l_motion         varchar2(4000);

    L_dDOCDATE       date;
    L_dCLIENTBDATE   date;
    L_dREGISTRYDATE  date;
    L_dDATO          date;
    L_dDATN          date;
    L_dDATE_IMPORT   date;

    l_clob           clob;
--  l_parser         xmlparser.parser := xmlparser.newparser;
    l_parser         xmlparser.parser;
    l_doc            xmldom.domdocument;
    l_ROW            xmldom.domnodelist;
    l_ROWelement     xmldom.DOMNode;
    l_i              int;

    l_mIDCOMPEN      varchar2(32)  ; --int
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

    l_n              int;
    iBen             number;
    iMot             number;
    l_all            int;
    l_dbcode         varchar2(32);

    l_status_id      compen_portfolio_status.status_id%type;

  begin

    tokf;
    bars_audit.trace('crkr_compen.create_recport: begin ');

    p_ret := 0;
    p_err := '';

--  bars_audit.info('p_record(1)    1-4000 = '||substr(p_record,   1,4000));
--  bars_audit.info('p_record(2) 4001-8000 = '||substr(p_record,4001,4000));
    l_clob := b64d(p_record);
--  bars_audit.info('crkr_compen.create_recport: clob: '||substr(l_clob,1,3500));
--  bars_audit.info('l_clob(1)    1-4000 = '||substr(l_clob,   1,4000));
--  bars_audit.info('l_clob(2) 4001-8000 = '||substr(l_clob,4001,4000));
    l_n    := 0;
    if instr(l_clob,'<rec><')>0 then
      if instr(l_clob,'><benef><')*instr(l_clob,'><motion><')>0 then
        l_all := 3;
      else
        l_all := 2;
      end if;
      loop
        l_i := instr(l_clob,'><rec><');
        if l_i>0 then
          l_recbm.extend;
          l_n := l_n + 1;
          l_recbm(l_n).recbenefmotion := substr(l_clob,1,l_i);
          l_clob := substr(l_clob,l_i+1);
        else
          exit;
        end if;
      end loop;
      if length(l_clob)>0 then
        l_recbm.extend;
        l_n := l_n + 1;
        l_recbm(l_n).recbenefmotion := l_clob;
        p_ret := l_n;
      end if;
    else -- instr(l_clob,'><motion><')>0 then
      l_all := 1;
      loop
        l_i := instr(l_clob,'><motion><');
        if l_i>0 then
          l_recbm.extend;
          l_n := l_n + 1;
          l_recbm(l_n).recbenefmotion := substr(l_clob,1,l_i);
          l_clob := substr(l_clob,l_i+1);
        else
          exit;
        end if;
      end loop;
      if length(l_clob)>0 then
        l_recbm.extend;
        l_n := l_n + 1;
        l_recbm(l_n).recbenefmotion := l_clob;
        p_ret := l_n;
      end if;
    end if;
--  bars_audit.info('l_all = '||l_all);

    for i in 1..l_n
    loop
      if l_all=3 then
        iBen  := instr(l_recbm(i).recbenefmotion,'><benef><');
        iMot  := instr(l_recbm(i).recbenefmotion,'><motion><');
        l_rec := replace(substr(l_recbm(i).recbenefmotion,1,iBen),chr(38)||'gt;','>');
        l_ben := replace(substr(l_recbm(i).recbenefmotion,iBen+1,iMot-iBen),chr(38)||'gt;','>');
        l_mot := substr(l_recbm(i).recbenefmotion,iMot+1);
      elsif l_all=2 then
        iBen  := instr(l_recbm(i).recbenefmotion,'><benef><');
        l_rec := replace(substr(l_recbm(i).recbenefmotion,1,iBen),chr(38)||'gt;','>');
        l_ben := replace(substr(l_recbm(i).recbenefmotion,iBen+1),chr(38)||'gt;','>');
        l_mot := null;
      else --l_all=1 then
        l_rec := null;
        l_ben := null;
        l_mot := l_recbm(i).recbenefmotion;
      end if;

--    bars_audit.info('l_rec = '||substr(l_rec,1,4000));
--    bars_audit.info('l_ben = '||substr(l_ben,1,4000));
--    bars_audit.info('l_mot = '||substr(l_mot,1,4000));

--    выгребание из l_rec
      if l_rec is not null then
        l_clob := l_rec;
        l_parser := xmlparser.newparser;
        xmlparser.parseCLOB(l_parser,l_clob);
        l_doc := xmlparser.getDocument(l_parser);
        l_ROW := xmldom.getelementsbytagname(l_doc,'rec');
        for i in 0..xmldom.getlength(l_ROW)-1
        loop
          l_ROWelement := xmldom.item(l_ROW,i);
          xslprocessor.valueof(l_ROWelement,'ID/text()'          ,l_ID          ); --int
          xslprocessor.valueof(l_ROWelement,'FIO/text()'         ,l_FIO         );
          xslprocessor.valueof(l_ROWelement,'COUNTRY/text()'     ,l_COUNTRY     ); --int
          xslprocessor.valueof(l_ROWelement,'POSTINDEX/text()'   ,l_POSTINDEX   );
          xslprocessor.valueof(l_ROWelement,'OBL/text()'         ,l_OBL         );
          xslprocessor.valueof(l_ROWelement,'RAJON/text()'       ,l_RAJON       );
          xslprocessor.valueof(l_ROWelement,'CITY/text()'        ,l_CITY        );
          xslprocessor.valueof(l_ROWelement,'ADDRESS/text()'     ,l_ADDRESS     );
          xslprocessor.valueof(l_ROWelement,'FULLADDRESS/text()' ,l_FULLADDRESS );
          xslprocessor.valueof(l_ROWelement,'ICOD/text()'        ,l_ICOD        );
          xslprocessor.valueof(l_ROWelement,'DOCTYPE/text()'     ,l_DOCTYPE     ); --int
          xslprocessor.valueof(l_ROWelement,'DOCSERIAL/text()'   ,l_DOCSERIAL   );
          xslprocessor.valueof(l_ROWelement,'DOCNUMBER/text()'   ,l_DOCNUMBER   );
          xslprocessor.valueof(l_ROWelement,'DOCORG/text()'      ,l_DOCORG      );
          xslprocessor.valueof(l_ROWelement,'DOCDATE/text()'     ,l_DOCDATE     ); --date
          xslprocessor.valueof(l_ROWelement,'CLIENTBDATE/text()' ,l_CLIENTBDATE ); --date
          xslprocessor.valueof(l_ROWelement,'CLIENTBPLACE/text()',l_CLIENTBPLACE);
          xslprocessor.valueof(l_ROWelement,'CLIENTSEX/text()'   ,l_CLIENTSEX   );
          xslprocessor.valueof(l_ROWelement,'CLIENTPHONE/text()' ,l_CLIENTPHONE );
          xslprocessor.valueof(l_ROWelement,'REGISTRYDATE/text()',l_REGISTRYDATE); --date
          xslprocessor.valueof(l_ROWelement,'ND/text()'          ,l_ND          );
          xslprocessor.valueof(l_ROWelement,'SUM/text()'         ,l_SUM         ); --number
          xslprocessor.valueof(l_ROWelement,'OST/text()'         ,l_OST         ); --number
          xslprocessor.valueof(l_ROWelement,'DATO/text()'        ,l_DATO        ); --date
          xslprocessor.valueof(l_ROWelement,'DATL/text()'        ,l_DATL        ); --date
          xslprocessor.valueof(l_ROWelement,'ATTR/text()'        ,l_ATTR        );
          xslprocessor.valueof(l_ROWelement,'CARD/text()'        ,l_CARD        ); --int
          xslprocessor.valueof(l_ROWelement,'DATN/text()'        ,l_DATN        ); --date
          xslprocessor.valueof(l_ROWelement,'VER/text()'         ,l_VER         ); --int
          xslprocessor.valueof(l_ROWelement,'STAT/text()'        ,l_STAT        );
          xslprocessor.valueof(l_ROWelement,'BRANCH/text()'      ,l_BRANCH      );
          xslprocessor.valueof(l_ROWelement,'TVBV/text()'        ,l_TVBV        );
          xslprocessor.valueof(l_ROWelement,'NSC/text()'         ,l_NSC         );
          xslprocessor.valueof(l_ROWelement,'IDA/text()'         ,l_IDA         );
          xslprocessor.valueof(l_ROWelement,'STATUS/text()'      ,l_STATUS      ); --int
          xslprocessor.valueof(l_ROWelement,'KV/text()'          ,l_KV          ); --int
          xslprocessor.valueof(l_ROWelement,'PERCENT/text()'     ,l_percent     ); --number
          xslprocessor.valueof(l_ROWelement,'KKNAME/text()'      ,l_kkname      );
          xslprocessor.valueof(l_ROWelement,'OB22/text()'        ,l_ob22        );
          xslprocessor.valueof(l_ROWelement,'DATE_IMPORT/text()' ,l_DATE_IMPORT ); --date

          begin
            l_dDOCDATE     := to_date(l_DOCDATE,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -2;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dCLIENTBDATE := to_date(l_CLIENTBDATE,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -3;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dREGISTRYDATE := to_date(l_REGISTRYDATE,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -4;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dDATO := to_date(l_DATO,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -5;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dDATL := to_date(l_DATL,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -6;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dDATN := to_date(l_DATN,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -7;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dDATE_IMPORT := to_date(l_DATE_IMPORT,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -8;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;

          begin
--          bars_audit.info('l_ID = '||l_ID||', l_ND = '||l_ND||', l_DOCTYPE = '||l_DOCTYPE||', l_DOCSERIAL = '||l_DOCSERIAL||', l_DOCNUMBER = '||l_DOCNUMBER);
            l_dbcode := f_dbcode(to_number(l_DOCTYPE),l_DOCSERIAL,l_DOCNUMBER);
            l_status_id := to_number(l_STATUS);
            if l_status_id > 1 then
              insert into compen_portfolio_status_old values (to_number(l_ID), l_status_id);
              l_status_id := -1; --вклад з невідомим статусом
            end if;

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
                                     OSTASVO     ,
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
                                     percent     ,
                                     kkname      ,
                                     ob22        ,
                                     STATUS      ,
                                     dbcode      ,
                                     DATE_IMPORT,
                                     branch_crkr)
                             values (to_number(l_ID)       , --int
                                     l_FIO                 , --
                                     to_number(l_COUNTRY)  , --number
                                     l_POSTINDEX           , --
                                     l_OBL                 , --
                                     l_RAJON               , --
                                     l_CITY                , --
                                     l_ADDRESS             , --
                                     l_FULLADDRESS         , --
                                     l_ICOD                , --
                                     to_number(l_DOCTYPE)  , --number
                                     l_DOCSERIAL           , --
                                     l_DOCNUMBER           , --
                                     l_DOCORG              , --
                                     l_dDOCDATE            , --date
                                     l_dCLIENTBDATE        , --date
                                     l_CLIENTBPLACE        , --
                                     l_CLIENTSEX           , --
                                     l_CLIENTPHONE         , --
                                     l_dREGISTRYDATE       , --date
                                     l_NSC                 , --
                                     l_IDA                 , --
                                     l_ND                  , --
                                     to_number(l_SUM)      , --number
                                     to_number(l_OST)      , --number
                                     to_number(l_OST)      , --number
                                     l_dDATO               , --date
                                     l_dDATL               , --date
                                     l_ATTR                , --
                                     to_number(l_CARD)     , --int
                                     l_dDATN               , --date
                                     to_number(l_VER)      , --int
                                     l_STAT                , --
                                     l_tvbv                , --
                                     l_BRANCH              , --
                                     to_number(l_KV)       , --number
                                     to_number(l_percent)  , --number
                                     l_kkname              , --
                                     l_ob22                , --
                                     l_status_id           , --int
                                     l_dbcode              , --
                                     l_dDATE_IMPORT,
                                     l_BRANCH);        --date
          exception when dup_val_on_index then
            null;
                    when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -1;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
        end loop;
        xmldom.freeDocument(l_doc);
        xmlparser.freeParser(l_parser);
      end if;

--    выгребание из l_ben -- benef
      if l_ben is not null then
        l_clob := l_ben;
--      bars_audit.info('l_clob(1)    1-4000 = '||substr(l_clob,   1,4000));
--      bars_audit.info('l_clob(2) 4001-8000 = '||substr(l_clob,4001,4000));
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
            p_ret := -9;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dCLIENTBDATEB := to_date(l_CLIENTBDATEB,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -10;
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
          exception when dup_val_on_index then
            null;
                    when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -11;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
        end loop;
        xmldom.freeDocument(l_doc);
        xmlparser.freeParser(l_parser);
      end if;

--    выгребание из l_mot -- motion
      if l_mot is not null then
--      bars_audit.info('l_mot(1) 0001-4000 = '||substr(l_mot,1,4000));
        l_clob := l_mot;
        l_parser := xmlparser.newparser;
        xmlparser.parseCLOB(l_parser,l_clob);
        l_doc := xmlparser.getDocument(l_parser);
        l_ROW := xmldom.getelementsbytagname(l_doc,'Row');
        for i in 0..xmldom.getlength(l_ROW)-1
        loop
          l_ROWelement := xmldom.item(l_ROW,i);
          xslprocessor.valueof(l_ROWelement,'ID_COMPEN/text()',l_mIDCOMPEN); --int
          xslprocessor.valueof(l_ROWelement,'IDM/text()'      ,l_mIDM     ); --int
          xslprocessor.valueof(l_ROWelement,'SUMOP/text()'    ,l_mSUMOP   ); --number
          xslprocessor.valueof(l_ROWelement,'DK/text()'       ,l_mDK      ); --int
          xslprocessor.valueof(l_ROWelement,'DATL/text()'     ,l_mDATL    ); --date
          xslprocessor.valueof(l_ROWelement,'TYPO/text()'     ,l_mTYPO    );
          xslprocessor.valueof(l_ROWelement,'MARK/text()'     ,l_mMARK    );
          xslprocessor.valueof(l_ROWelement,'VER/text()'      ,l_mVER     ); --number
          xslprocessor.valueof(l_ROWelement,'STAT/text()'     ,l_mSTAT    );
          xslprocessor.valueof(l_ROWelement,'OST/text()'      ,l_mOST     ); --number
          xslprocessor.valueof(l_ROWelement,'ZPR/text()'      ,l_mZPR     ); --number
          xslprocessor.valueof(l_ROWelement,'DATP/text()'     ,l_mDATP    ); --date
          xslprocessor.valueof(l_ROWelement,'PREA/text()'     ,l_mPREA    );
          xslprocessor.valueof(l_ROWelement,'OI/text()'       ,l_mOI      );
          xslprocessor.valueof(l_ROWelement,'OL/text()'       ,l_mOL      );

          begin
            l_dDATL := to_date(l_mDATL,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -12;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
          begin
            l_dDATP := to_date(l_mDATP,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -13;
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
                           values (to_number(l_mIDCOMPEN), --l_id
                                   to_number(l_mIDM)     ,
                                   to_number(l_mSUMOP)   ,
                                   to_number(l_mDK)      ,
                                   l_dDATL               , --to_date(l_DATL,'YYYY-MM-DD')
                                   l_mTYPO               ,
                                   l_mMARK               ,
                                   to_number(l_mVER)     ,
                                   l_mSTAT               ,
                                   to_number(l_mOST)     ,
                                   to_number(l_mZPR)     ,
                                   l_dDATP               , --to_date(l_DATP,'YYYY-MM-DD')
                                   l_mPREA               ,
                                   l_mOI                 ,
                                   l_mOL);
          exception when dup_val_on_index then
            bars_audit.warning('crkr_compen.create_recport: DUP no insert '||l_mIDCOMPEN||
                               ' '||l_mIDM);
            null;
                    when others then
            bars_audit.warning('crkr_compen.create_recport: ERR no insert '||l_mIDCOMPEN||
                               ' '||l_mIDM||' '||sqlerrm||' - '||
                               dbms_utility.format_error_backtrace);
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -14;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            return;
          end;
        end loop;
        xmldom.freeDocument(l_doc);
        xmlparser.freeParser(l_parser);
      end if;

    end loop;
    commit;
    bars_audit.trace('crkr_compen.create_recport: end');

  end create_recport;

--

  procedure drop_port_tvbv (p_tvbv in varchar2,
                            p_kf   in varchar2,
                            p_err out varchar2,
                            p_ret out int)
  is
    i              int;
    l_compen_list  number_list default number_list();
  begin
    tokf;
    bars_audit.info('crkr_compen.drop_port_tvbv: tvbv='||p_tvbv);
    bars_audit.info('crkr_compen.drop_port_tvbv: kf='  ||p_kf);
    bars_audit.info('crkr_compen.drop_port_tvbv: begin');
--  bars_audit.info('drop_port_tvbv(0): p_tvbv = '||p_tvbv);
--  bars_audit.info('drop_port_tvbv(0): p_kf = '  ||p_kf);
    p_ret := 0;
    p_err := '';

    select id BULK COLLECT
    into   l_compen_list
    from   COMPEN_PORTFOLIO
    where  tvbv=p_tvbv             and
           substr(branch,2,6)=p_kf and
           status=0;

    bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_MOTIONS begin');
    begin
      forall i in l_compen_list.FIRST..l_compen_list.LAST
      delete from COMPEN_MOTIONS
      where id_compen = l_compen_list(i);
--    delete
--    from   COMPEN_MOTIONS
--    where  id_compen in (select id
--                         from   COMPEN_PORTFOLIO
--                         where  tvbv=p_tvbv             and
--                                substr(branch,2,6)=p_kf and
--                                status=0);
      bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_MOTIONS - '||sql%rowcount);
    exception when others then
      p_ret := -3;
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      bars_audit.error('crkr_compen.drop_port_tvbv: '||p_err);
      rollback;
      return;
    end;
    bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_MOTIONS end');
--
    bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_BENEF begin');
    begin
      forall i in l_compen_list.FIRST..l_compen_list.LAST
      delete from COMPEN_BENEF
      where id_compen = l_compen_list(i);
--    delete
--    from   COMPEN_BENEF
--    where  id_compen in (select id
--                         from   COMPEN_PORTFOLIO
--                         where  tvbv=p_tvbv             and
--                                substr(branch,2,6)=p_kf and
--                                status=0);
      bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_BENEF - '||sql%rowcount);
    exception when others then
      p_ret := -2;
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      bars_audit.error('crkr_compen.drop_port_tvbv: '||p_err);
      rollback;
      return;
    end;
    bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_BENEF end');
--
    bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_PORTFOLIO begin');
    begin
/*
      begin
        execute immediate 'drop INDEX IDX_COMPEN_PORTFOLIO_DBCODE';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COMPEN_PORTFOLIO_ICOD';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COMPEN_PORTFOLIO_RNK';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COMPEN_PORTFOLIO_TVBV';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COMPEN_P_BRANCHACT_RNK_BUR';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COMPEN_P_BRANCH_CRKR_OB22';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COMPEN_P_OB22';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COPMEN_PORTFOLIO_LFIO_NSC';
      exception when others then
        null;
      end;
      begin
        execute immediate 'drop INDEX IDX_COMPEN_PORTFOLIO_BRANCHACT';
      exception when others then
        null;
      end;
*/
      begin
        execute immediate 'alter table COMPEN_BENEF   DISABLE constraint FK_COMPEN_BENEF_PORTFOLIO';
      exception when others then
        null;
      end;
      begin
        execute immediate 'alter table COMPEN_MOTIONS              DISABLE constraint FK_COMPEN_MOTIONS_PORTFOLIO';
      exception when others then
        null;
      end;

      begin
        execute immediate 'alter table COMPEN_OPER                 DISABLE constraint FK_COMPEN_OPER_BOUND_ID';
      exception when others then
        null;
      end;
      begin
        execute immediate 'alter table COMPEN_OPER                 DISABLE constraint FK_COMPEN_OPER_COMPEN_ID';
      exception when others then
        null;
      end;
      begin
        execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD DISABLE constraint FK_DBCODE_COMPEN_ID';
      exception when others then
        null;
      end;

      forall i in l_compen_list.FIRST..l_compen_list.LAST
      delete from COMPEN_PORTFOLIO
      where id = l_compen_list(i);

--    delete
--    from   COMPEN_PORTFOLIO
--    where  tvbv=p_tvbv             and
--           substr(branch,2,6)=p_kf and
--           status=0;

      p_ret := sql%rowcount;
      bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_PORTFOLIO - '||sql%rowcount);
/*
      begin
        execute immediate 'CREATE INDEX IDX_COMPEN_PORTFOLIO_DBCODE    ON COMPEN_PORTFOLIO (DBCODE)';
      exception when others then
        null;
      end;
      begin
        execute immediate 'CREATE INDEX IDX_COMPEN_PORTFOLIO_ICOD      ON COMPEN_PORTFOLIO (ICOD)';
      exception when others then
        null;
      end;
      begin
        execute immediate 'CREATE INDEX IDX_COMPEN_PORTFOLIO_RNK       ON COMPEN_PORTFOLIO (RNK)';
      exception when others then
        null;
      end;
      begin
        execute immediate 'CREATE INDEX IDX_COMPEN_PORTFOLIO_TVBV      ON COMPEN_PORTFOLIO (TVBV, SUBSTR("BRANCH",2,6))';
      exception when others then
        null;
      end;
      begin
        execute immediate 'CREATE INDEX IDX_COMPEN_P_BRANCHACT_RNK_BUR ON COMPEN_PORTFOLIO (BRANCHACT_BUR, RNK_BUR)';
      exception when others then
        null;
      end;
      begin
        execute immediate 'CREATE INDEX IDX_COMPEN_P_BRANCH_CRKR_OB22  ON COMPEN_PORTFOLIO (BRANCH_CRKR, OB22)';
      exception when others then
        null;
      end;
--    begin
--      execute immediate 'CREATE INDEX IDX_COMPEN_P_OB22              ON COMPEN_PORTFOLIO (OB22)';
--    exception when others then
--      null;
--    end;
      begin
        execute immediate 'CREATE INDEX IDX_COPMEN_PORTFOLIO_LFIO_NSC  ON COMPEN_PORTFOLIO (LOWER("FIO"))';
      exception when others then
        null;
      end;
      begin
        execute immediate 'CREATE INDEX IDX_COMPEN_PORTFOLIO_BRANCHACT ON COMPEN_PORTFOLIO (BRANCHACT)';
      exception when others then
        null;
      end;
*/
      begin
        execute immediate 'alter table COMPEN_BENEF                MODIFY constraint FK_COMPEN_BENEF_PORTFOLIO ENABLE NOVALIDATE';
      exception when others then
        null;
      end;
      begin
        execute immediate 'alter table COMPEN_OPER                 MODIFY constraint FK_COMPEN_OPER_BOUND_ID   ENABLE NOVALIDATE';
      exception when others then
        null;
      end;
      begin
        execute immediate 'alter table COMPEN_OPER                 MODIFY constraint FK_COMPEN_OPER_COMPEN_ID  ENABLE NOVALIDATE';
      exception when others then
        null;
      end;
      begin
        execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD MODIFY constraint FK_DBCODE_COMPEN_ID       ENABLE NOVALIDATE';
      exception when others then
        null;
      end;
      i := 0;
      while i<3711
      loop
        begin
          execute immediate 'alter table COMPEN_MOTIONS MODIFY constraint FK_COMPEN_MOTIONS_PORTFOLIO ENABLE NOVALIDATE';
          exit;
        exception when others then
--        хвосты после JOBа
          delete
          from   COMPEN_MOTIONS
          where  substr(to_char(id_compen),1,6)=p_kf and
                 id_compen not in (select id
                                   from   COMPEN_PORTFOLIO
                                   where  tvbv<>p_tvbv and
                                          substr(branch,2,6)=p_kf);
--                                 where  tvbv<>p_tvbv            and
--                                        substr(branch,2,6)=p_kf and
--                                        status=0);
          if sql%rowcount=0 then
            i := i+1;
          end if;
        end;
      end loop;
      if i=3711 then
        p_ret := -7;
        p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
        bars_audit.error('crkr_compen.drop_port_tvbv: '||p_err);
        rollback;
        return;
      end if;
--    commit;
    exception when others then
      p_ret := -1;
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      bars_audit.error('crkr_compen.drop_port_tvbv: '||p_err);
      rollback;
      return;
    end;
    bars_audit.info('crkr_compen.drop_port_tvbv: delete from COMPEN_PORTFOLIO end');
    bars_audit.info('crkr_compen.drop_port_tvbv: end');

  end drop_port_tvbv;

--

  procedure fix_port_tvbv  (p_tvbv in varchar2,
                            p_kf   in varchar2,
                            p_err out varchar2,
                            p_ret out int)
  is
  begin
    tokf;
    bars_audit.info('crkr_compen.fix_port_tvbv: tvbv='||p_tvbv);
    bars_audit.info('crkr_compen.fix_port_tvbv: kf='  ||p_kf);
    bars_audit.info('crkr_compen.fix_port_tvbv: begin');
    p_ret := 0;
    p_err := '';
    begin
      bars_audit.info('crkr_compen.fix_port_tvbv: update COMPEN_PORTFOLIO: begin');
--    update COMPEN_PORTFOLIO
--    set    status=1
--    where  tvbv=p_tvbv and
--           substr(branch,2,6)=p_kf and
--           status<=1;
      update COMPEN_PORTFOLIO
      set    status=1,
             ob22=replace(ob22,'23','01')
      where  tvbv=p_tvbv and
             substr(branch,2,6)=p_kf and
             status<=1;
      p_ret := sql%rowcount;
      bars_audit.info('crkr_compen.fix_port_tvbv: update COMPEN_PORTFOLIO - '||sql%rowcount);
    exception when others then
      p_ret := -1;
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      return;
    end;
    bars_audit.info('crkr_compen.fix_port_tvbv: end');

  end fix_port_tvbv;

--

  procedure make_wiring (p_tvbv         in varchar2,
                         p_summa        in varchar2, --number
                         p_nls          in varchar2,
                         p_ob22         in varchar2,
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

    tokf;
    bars_audit.info('crkr_compen.make_wiring: begin');

--  bars_audit.info('p_tvbv       ='||p_tvbv       );
--  bars_audit.info('p_summa      ='||p_summa      );
--  bars_audit.info('p_nls        ='||p_nls        );
--  bars_audit.info('p_kv         ='||p_kv         );
--  bars_audit.info('p_branch     ='||p_branch     );
--  bars_audit.info('p_date_import='||p_date_import);

    p_ret := 0;
    p_err := '';

    l_url_wapp := GetGlobalOption('CA_URL');
    if l_url_wapp is null then
--    l_url_wapp := 'http://ca_url_undefined';
      l_url_wapp := 'http://10.10.10.101:9088/barsroot/api/cagrc';
    end if;
    if substr(l_url_wapp,-1,1)<>'/' then
      l_url_wapp := l_url_wapp||'/';
    end if;
    l_Authorization_val := 'Basic '||utl_raw.cast_to_varchar2(utl_encode.base64_encode(
                           utl_raw.cast_to_raw(GetGlobalOption('CA_LOGIN')||':'||
                           GetGlobalOption('CA_PASS'))));
    l_walett_path       := GetGlobalOption('CA_WALLET_PATH');
    l_walett_pass       := GetGlobalOption('CA_WALLET_PASS');
    l_action            := 'camakewiring';

--  bars_audit.info('p_branch='||p_branch);
    bars_audit.info('service '||l_action||' start');
    begin
      wsm_mgr.prepare_request(p_url          => l_url_wapp         ,
                              p_action       => l_action           ,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json  ,
                              p_wallet_path  => l_walett_path      ,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header     (p_name => 'Authorization', p_value => l_Authorization_val);
      wsm_mgr.add_parameter  (p_name => 'summa'        , p_value => p_summa            );
      wsm_mgr.add_parameter  (p_name => 'nls'          , p_value => p_nls              );
      wsm_mgr.add_parameter  (p_name => 'ob22'         , p_value => p_ob22             );
      wsm_mgr.add_parameter  (p_name => 'kv'           , p_value => p_kv               );
      wsm_mgr.add_parameter  (p_name => 'branch'       , p_value => p_branch           );
      wsm_mgr.add_parameter  (p_name => 'tvbv'         , p_value => p_tvbv             );
      wsm_mgr.add_parameter  (p_name => 'date_import'  , p_value => p_date_import      );
      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- если есть ответ - в clob будет
      bars_audit.info('service '||l_action||' end - '||substr(l_result,1,3000));
      if substr(l_result,1,3) in ('400','401','404','500') and length(l_result)>3 then
        p_err := l_result;
        p_ret := -1;
        bars_audit.error('crkr_compen.make_wiring: error - '||substr(l_result,1,3000));
        return;
      end if;
    exception when others then
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      p_ret := -1;
      bars_audit.error('crkr_compen.make_wiring: error - '||p_err);
      return;
    end;
    bars_audit.info('crkr_compen.make_wiring: end');

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
    l_timeout            number;

  begin

    tokf;
    bars_audit.info('crkr_compen.drop_wiring: begin');

    p_ret := 0;
    p_err := '';

    l_url_wapp := GetGlobalOption('CA_URL');
    if l_url_wapp is null then
--    l_url_wapp := 'http://ca_url_undefined';
      l_url_wapp := 'http://10.10.10.101:9088/barsroot/api/cagrc';
    end if;
    if substr(l_url_wapp,-1,1)<>'/' then
      l_url_wapp := l_url_wapp||'/';
    end if;
    l_Authorization_val := 'Basic '||utl_raw.cast_to_varchar2(utl_encode.base64_encode(
                           utl_raw.cast_to_raw(GetGlobalOption('CA_LOGIN')||':'||
                           GetGlobalOption('CA_PASS'))));
    l_walett_path       := GetGlobalOption('CA_WALLET_PATH');
    l_walett_pass       := GetGlobalOption('CA_WALLET_PASS');
    begin
      l_timeout         := greatest(to_number(GetGlobalOption('CA_TIMEOUT'),60));
    exception when others then
      l_timeout         := 300;
    end;
    l_action            := 'cadropwiring';

    bars_audit.info('service '||l_action||' start');
    utl_http.set_transfer_timeout(l_timeout);
    begin
      wsm_mgr.prepare_request(p_url          => l_url_wapp         ,
                              p_action       => l_action           ,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json  ,
                              p_wallet_path  => l_walett_path      ,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header     (p_name => 'Authorization', p_value => l_Authorization_val);
      wsm_mgr.add_parameter  (p_name => 'tvbv'         , p_value => p_tvbv             );
      wsm_mgr.add_parameter  (p_name => 'kf'           , p_value => p_kf               );
      wsm_mgr.add_parameter  (p_name => 'date_import'  , p_value => p_date_import      );
      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- если есть ответ - в clob будет
      bars_audit.info('service '||l_action||' end - '||substr(l_result,1,3000));
      if substr(l_result,1,3) in ('400','401','404','500') and length(l_result)>3 then
        p_err := l_result;
        p_ret := -1;
        bars_audit.error('crkr_compen.drop_wiring: error - '||substr(l_result,1,3000));
        return;
      end if;
    exception when others then
      p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
      p_ret := -1;
      bars_audit.error('crkr_compen.drop_wiring: error - '||p_err);
      return;
    end;
    bars_audit.info('crkr_compen.drop_wiring: end');

  end drop_wiring;

--

  procedure get_info_vkl (p_mode in varchar2,
                          p_tvbv in varchar2,
                          p_brmf in varchar2,
                          p_ret out clob)
  is
    p_tmp  varchar2(4000);
  begin
    if p_mode='RU' then
      select XmlElement("crkr",
             XmlAgg(
             XmlElement("Rec",
             XMLFOREST(ob22, sumob22 suma)))).getStringVal()
      into   p_ret
      from   (select sum(ost)                    sumob22,
                     decode(ob22,'23','01',ob22) ob22
              from   compen_portfolio
              where  substr(branch,2,6)=p_brmf and
                     tvbv=p_tvbv               and
                     status=0
              group by decode(ob22,'23','01',ob22)
              order by 2);
    elsif p_mode='CA' then -- old variant report without TVBV
      select XmlElement("crkr",
             XmlAgg(
             XmlElement("Rec",
             XMLFOREST(ob22, sumob22 suma)))).getStringVal()
      into   p_ret
      from   (select sum(ostasvo)                sumob22,
                     decode(ob22,'23','01',ob22) ob22
              from   compen_portfolio
--            where  branch=p_brmf             and
              where  substr(branch,2,6)=p_brmf and
                     status>=1
              group by decode(ob22,'23','01',ob22)
              order by 2);
    else      -- 'CN'      -- new variant report with TVBV
      begin
        p_ret := '';
        for k in (select distinct tvbv
                  from   compen_portfolio
                  where  substr(branch,2,6)=p_brmf and
                         status>=1)
        loop
          select XmlElement("crkr",
                 XmlAgg(
                 XmlElement("Rec",
                 XMLFOREST(tvbv, branch, ob22, sumob22 suma)))).getClobVal()
          into   p_tmp
          from   (select sum(ostasvo)                sumob22,
                         decode(ob22,'23','01',ob22) ob22   ,
                         branch                             ,
                         tvbv
                  from   compen_portfolio
                  where  substr(branch,2,6)=p_brmf and
                         status>=1                 and
                         tvbv=k.tvbv
                  group by decode(ob22,'23','01',ob22),
                           branch                     ,
                           tvbv
                  order by 2);
          p_ret := p_ret||p_tmp;
        end loop;
        if p_ret is null then
          p_ret := '<crkr></crkr>';
        else
          p_ret := replace(p_ret,'</crkr><crkr>');
        end if;
--      dbms_output.put_line(p_ret);
      end;
    end if;
  end get_info_vkl;

--

  procedure count_compen (p_mode in varchar2,
                          p_tvbv in varchar2,
                          p_mfo  in varchar2,
                          p_err out varchar2,
                          p_ret out int)
  is
  begin
    p_err := '';
    if      p_mode='C' then
      SELECT count(*)
      into   p_ret
      from   compen_portfolio
      where  tvbv=p_tvbv and
             substr(branch,2,6)=p_mfo;
    elsif   p_mode='B' then
      SELECT count(*)
      into   p_ret
      from   compen_benef
      where  id_compen in (select id
                           from   compen_portfolio
                           where  tvbv=p_tvbv and
                                  substr(branch,2,6)=p_mfo);
    else -- p_mode='M' then
      SELECT count(*)
      into   p_ret
      from   compen_motions
      where  id_compen in (select id
                           from   compen_portfolio
                           where  tvbv=p_tvbv and
                                  substr(branch,2,6)=p_mfo);
    end if;
  exception when others then
    p_ret := -1;
    p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
  end count_compen;

--

  --Імпорт користувачів з РУ
  procedure compen_user_create(p_logname staff.logname%type,
                               p_fio staff.fio%type,
                               p_branch staff.branch%type,
                               p_can_select_branch staff.can_select_branch%type,
                               p_method varchar2,
                               p_dateprivstart date,
                               p_dateprivend date) is
    type t_dic IS TABLE OF CHAR(2) INDEX BY PLS_INTEGER;
    l_kf_ru   t_dic;
    l_logname staff.logname%type;
  begin
    l_kf_ru(300465) := '01';
    l_kf_ru(324805) := '02';
    l_kf_ru(302076) := '03';
    l_kf_ru(303398) := '04';
    l_kf_ru(305482) := '05';
    l_kf_ru(335106) := '06';
    l_kf_ru(311647) := '07';
    l_kf_ru(312356) := '08';
    l_kf_ru(313957) := '09';
    l_kf_ru(336503) := '10';
    l_kf_ru(322669) := '11';
    l_kf_ru(323475) := '12';
    l_kf_ru(304665) := '13';
    l_kf_ru(325796) := '14';
    l_kf_ru(326461) := '15';
    l_kf_ru(328845) := '16';
    l_kf_ru(331467) := '17';
    l_kf_ru(333368) := '18';
    l_kf_ru(337568) := '19';
    l_kf_ru(338545) := '20';
    l_kf_ru(351823) := '21';
    l_kf_ru(352457) := '22';
    l_kf_ru(315784) := '23';
    l_kf_ru(354507) := '24';
    l_kf_ru(356334) := '25';
    l_kf_ru(353553) := '26';

    l_logname := p_logname || l_kf_ru(substr(p_branch, 2, 6));
    case
      when p_method = 'I' then
        begin
          bars_useradm.create_user(p_usrfio          => p_fio,
                                   p_usrtabn         => null,
                                   p_usrtype         => 0,
                                   p_usraccown       => 0,
                                   p_usrbranch       => p_branch,
                                   p_usrusearc       => 0,
                                   p_usrusegtw       => 0,
                                   p_usrwprof        => 'DEFAULT_PROFILE',
                                   p_reclogname      => l_logname,
                                   p_recpasswd       => 'qwerty',
                                   p_recappauth      => l_logname,
                                   p_recprof         => 'DEFAULTPROFILE',
                                   p_recdefrole      => 'BARS_ACCESS_DEFROLE',
                                   p_recrsgrp        => null,
                                   p_usrid           => null,
                                   p_gtwpasswd       => 'qwerty',
                                   p_canselectbranch => p_can_select_branch,
                                   p_chgpwd          => null,
                                   p_tipid           => null);
        exception
          when others then
            if sqlcode = -1920 then
              null;
            else
              raise;
            end if;
        end;

        update staff$base set BAX = 1, TBAX = sysdate where logname = l_logname;

        update web_usermap
           set webpass   = 'b1b3773a05c0ed0176787a4f1574ff0075f7521e',
               adminpass = null,
               blocked   = 0,
               attempts  = 0
         where DBUSER = l_logname;

        insert into applist_staff
          (id, codeapp, approve, grantor)
          select s.id, 'CRCO', 1, 1
            from staff$base s
           where s.logname = l_logname
             and not exists (select 1
                    from applist_staff astf
                   where astf.id = s.id
                     and astf.codeapp = 'CRCO');
        update applist_staff
           set adate1 = p_dateprivstart, adate2 = p_dateprivend
         where id = (select id from staff$base where logname = l_logname);
      when p_method = 'U' then
        update staff$base
           set fio               = p_fio,
               branch            = p_branch,
               can_select_branch = p_can_select_branch
         where logname = l_logname;
        update applist_staff
           set adate1 = p_dateprivstart, adate2 = p_dateprivend
         where id = (select id from staff$base where logname = l_logname);
      when p_method = 'D' then
        delete from applist_staff
         where codeapp = 'CRCO'
           and id = (select id from staff$base where logname = l_logname);
    end case;
  end compen_user_create;

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

  function b64d (p_s clob) return clob
  is
  begin
    if p_s is not null then
      return utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw(p_s)));
    else
      return null;
    end if;
  end b64d;

--

  function f_dbcode (p_doctype  number  ,
                     p_serial   varchar2,
                     p_number   varchar2) return varchar2
  is
    l_doctype  char(1);
    l_res      varchar2(32);
    l_crc      number := 0;
  begin
    l_doctype := case when p_doctype=1  then
                      'П'
                      when p_doctype=-1 then
                      'З'
                      when p_doctype=-2 then
                      'Н'
                      when p_doctype=-3 then
                      'С'
                      when p_doctype=-4 then
                      'Т'
                      when p_doctype=-7 then--змінити після уточнення з банком(ID-картка)
                      'Я'
                 else
                      'П'
                 end;
    if p_serial is not null then
      if l_doctype='П' then
        for k in 1..length(p_serial)
        loop
--        цикл по таблице с буквами
          for i in 0..g_let_table.count-1
          loop
--          если в таблице нашёлся символ - берём его цифровое значение
            if (g_let_table(i).ukr_let=substr(upper(p_serial),k,1) or
                g_let_table(i).eng_let=substr(upper(p_serial),k,1)) then
--            к результату
              l_res := l_res||g_let_table(i).ukr_num;
              exit;
            end if;
          end loop;
        end loop;
--      добавим номер паспорта
        l_res := l_res||p_number;
--      контрольный разряд
        if l_res is not null then
          for i in 1..length(l_res)
          loop
            begin
              l_crc := l_crc+to_number(substr(l_res,i,1));
              exception
                when others then
                  bars_audit.error('crkr_compen.f_dbcode: Помилка формування DBCODE. p_DOCTYPE = '||p_DOCTYPE||', p_serial='||p_serial||', p_number='||p_number||
                                   ' '||sqlerrm);
                  return null;
            end;  
          end loop;
          l_res := l_res||to_char(mod(l_crc,10));
        end if;
      else
        l_res := l_doctype||replace(p_serial,'-','')||trim(replace(p_number,'-',''));
      end if;
    elsif l_doctype='Я' then --до ID-картки
      l_res := l_doctype||replace(p_number,'-','')||replace(p_serial,'-','');
    else
      l_res := '';
    end if;
    return l_res;
  end f_dbcode;

--
procedure i_row_portfolio_upd(p_portfolio in compen_portfolio%rowtype) is
  begin
    insert into compen_portfolio_update
      (idupd,
       id,
       fio,
       country,
       postindex,
       obl,
       rajon,
       city,
       address,
       fulladdress,
       icod,
       doctype,
       docserial,
       docnumber,
       docorg,
       docdate,
       clientbdate,
       clientbplace,
       clientsex,
       clientphone,
       registrydate,
       nsc,
       ida,
       nd,
       sum,
       ost,
       dato,
       datl,
       attr,
       card,
       datn,
       ver,
       stat,
       tvbv,
       branch,
       kv,
       status,
       date_import,
       dbcode,
       percent,
       kkname,
       ob22,
       rnk,
       branchact,
       reason_change_status,
       heritage_ost,
       rnk_bur,
       branchact_bur,
       ostasvo,
       branch_crkr,
       status_prev,
       user_id,
       user_fio)
    values
      (s_compen_portfolio_update.nextval,
       p_portfolio.id,
       p_portfolio.fio,
       p_portfolio.country,
       p_portfolio.postindex,
       p_portfolio.obl,
       p_portfolio.rajon,
       p_portfolio.city,
       p_portfolio.address,
       p_portfolio.fulladdress,
       p_portfolio.icod,
       p_portfolio.doctype,
       p_portfolio.docserial,
       p_portfolio.docnumber,
       p_portfolio.docorg,
       p_portfolio.docdate,
       p_portfolio.clientbdate,
       p_portfolio.clientbplace,
       p_portfolio.clientsex,
       p_portfolio.clientphone,
       p_portfolio.registrydate,
       p_portfolio.nsc,
       p_portfolio.ida,
       p_portfolio.nd,
       p_portfolio.sum,
       p_portfolio.ost,
       p_portfolio.dato,
       p_portfolio.datl,
       p_portfolio.attr,
       p_portfolio.card,
       p_portfolio.datn,
       p_portfolio.ver,
       p_portfolio.stat,
       p_portfolio.tvbv,
       p_portfolio.branch,
       p_portfolio.kv,
       p_portfolio.status,
       p_portfolio.date_import,
       p_portfolio.dbcode,
       p_portfolio.percent,
       p_portfolio.kkname,
       p_portfolio.ob22,
       p_portfolio.rnk,
       p_portfolio.branchact,
       p_portfolio.reason_change_status,
       p_portfolio.heritage_ost,
       p_portfolio.rnk_bur,
       p_portfolio.branchact_bur,
       p_portfolio.ostasvo,
       p_portfolio.branch_crkr,
       p_portfolio.status_prev,
       user_id,
       (select t.fio from staff$base t where t.id = user_id));
  end;
--
  procedure update_info_from_file_j(p_record       in clob    ,
                                    p_err          out varchar2,
                                    p_ret          out int) as
    l_clob           clob;
    l_parser         xmlparser.parser;
    l_doc            xmldom.domdocument;
    l_ROW            xmldom.domnodelist;
    l_ROWelement     xmldom.DOMNode;
    l_i              int;    
    l_n              int; 

    TYPE             RB is record (recbenef clob);
    type             t_RB is table of RB;
    l_recb          t_RB := t_RB();
       
    l_rec            clob;
    l_ben            clob;    
    iBen             number;
    
    l_ID             varchar2(4000);
    l_POSTINDEX      varchar2(4000);
    l_OBL            varchar2(4000);
    l_RAJON          varchar2(4000);
    l_CITY           varchar2(4000);
    l_ADDRESS        varchar2(4000);
    l_FULLADDRESS    varchar2(4000);
    l_DOCTYPE        varchar2(4000);
    l_DOCSERIAL      varchar2(4000);
    l_DOCNUMBER      varchar2(4000);
    l_DOCORG         varchar2(4000);
    l_DOCDATE        varchar2(4000);
    l_CLIENTBDATE    varchar2(4000);
    l_CLIENTPHONE    varchar2(4000);
    l_percent        varchar2(4000);
    L_dDOCDATE       date;
    L_dCLIENTBDATE   date;  
    
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
    l_dDOCDATEB      date;
    l_dCLIENTBDATEB  date;    
    
    l_status         compen_portfolio.status%type;  
    
    l_portfolio      compen_portfolio%rowtype;
    
    l_cnt            pls_integer := 0;
    l_cnt_notfound   pls_integer := 0;
                                            
  begin
    bars_audit.info('crkr_compen.update_info_from_file_j: begin ');

    p_ret := 0;
    p_err := '';

--  bars_audit.info('p_record(1)    1-4000 = '||substr(p_record,   1,4000));
--  bars_audit.info('p_record(2) 4001-8000 = '||substr(p_record,4001,4000));
    l_clob := b64d(p_record);
--  bars_audit.info('crkr_compen.create_recport: clob: '||substr(l_clob,1,3500));
--  bars_audit.info('l_clob(1)    1-4000 = '||substr(l_clob,   1,4000));
--  bars_audit.info('l_clob(2) 4001-8000 = '||substr(l_clob,4001,4000));
    l_n    := 0;
    if instr(l_clob,'<rec><')>0 then
      loop
        l_i := instr(l_clob,'><rec><');
        if l_i>0 then
          l_recb.extend;
          l_n := l_n + 1;
          l_recb(l_n).recbenef := substr(l_clob,1,l_i);
          l_clob := substr(l_clob,l_i+1);
        else
          exit;
        end if;
      end loop;
      if length(l_clob)>0 then
        l_recb.extend;
        l_n := l_n + 1;
        l_recb(l_n).recbenef := l_clob;
        p_ret := l_n;
      end if;
    end if;
    
    for i in 1..l_n
    loop
      iBen  := instr(l_recb(i).recbenef,'><benef><');
      l_rec := replace(substr(l_recb(i).recbenef,1,iBen),chr(38)||'gt;','>');
      l_ben := replace(substr(l_recb(i).recbenef,iBen+1),chr(38)||'gt;','>');
      
      if l_rec is not null then
        l_clob := l_rec;
        l_parser := xmlparser.newparser;
        xmlparser.parseCLOB(l_parser,l_clob);
        l_doc := xmlparser.getDocument(l_parser);
        l_ROW := xmldom.getelementsbytagname(l_doc,'rec');
        for i in 0..xmldom.getlength(l_ROW)-1
        loop
          l_ROWelement := xmldom.item(l_ROW,i);
          xslprocessor.valueof(l_ROWelement,'ID/text()'          ,l_ID          ); --int
          xslprocessor.valueof(l_ROWelement,'POSTINDEX/text()'   ,l_POSTINDEX   );
          xslprocessor.valueof(l_ROWelement,'OBL/text()'         ,l_OBL         );
          xslprocessor.valueof(l_ROWelement,'RAJON/text()'       ,l_RAJON       );
          xslprocessor.valueof(l_ROWelement,'CITY/text()'        ,l_CITY        );
          xslprocessor.valueof(l_ROWelement,'ADDRESS/text()'     ,l_ADDRESS     );
          xslprocessor.valueof(l_ROWelement,'FULLADDRESS/text()' ,l_FULLADDRESS );
          xslprocessor.valueof(l_ROWelement,'DOCTYPE/text()'     ,l_DOCTYPE     ); --int
          xslprocessor.valueof(l_ROWelement,'DOCSERIAL/text()'   ,l_DOCSERIAL   );
          xslprocessor.valueof(l_ROWelement,'DOCNUMBER/text()'   ,l_DOCNUMBER   );
          xslprocessor.valueof(l_ROWelement,'DOCORG/text()'      ,l_DOCORG      );
          xslprocessor.valueof(l_ROWelement,'DOCDATE/text()'     ,l_DOCDATE     ); --date
          xslprocessor.valueof(l_ROWelement,'CLIENTBDATE/text()' ,l_CLIENTBDATE ); --date
          xslprocessor.valueof(l_ROWelement,'CLIENTPHONE/text()' ,l_CLIENTPHONE );
          xslprocessor.valueof(l_ROWelement,'PERCENT/text()'     ,l_percent     ); --number

          begin
            l_dDOCDATE     := to_date(l_DOCDATE,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -2;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            rollback;
            return;
          end;
          begin
            l_dCLIENTBDATE := to_date(l_CLIENTBDATE,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -3;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            rollback;
            return;
          end;
          
          begin
            select p.status into l_status from compen_portfolio p where p.id = l_ID;
            exception 
              when no_data_found then
                bars_audit.warning('crkr_compen.update_info_from_file_j: Вклад незнайдений: '||l_ID); 
                l_cnt_notfound := l_cnt_notfound + 1;               
                continue;
          end;  
          if l_status in (99,91,92) then --зміни не проводити, так як з вкладом щось почали робити
            bars_audit.warning('crkr_compen.update_info_from_file_j: Вклад '||l_ID||' має статус '||l_status||'. Зміна неможлива. Пропущено.');            
            l_cnt_notfound := l_cnt_notfound + 1;
            else 
              begin
                update compen_portfolio p
                   set
                       p.postindex       = l_POSTINDEX,                
                       p.obl             = l_OBL,                      
                       p.rajon           = l_RAJON,                    
                       p.city            = l_CITY,                     
                       p.address         = l_ADDRESS,                  
                       p.fulladdress     = l_FULLADDRESS,              
                       p.doctype         = l_DOCTYPE,                  
                       p.docserial       = l_DOCSERIAL,                
                       p.docnumber       = l_DOCNUMBER,                
                       p.docorg          = l_DOCORG,                   
                       p.docdate         = l_dDOCDATE,                  
                       p.clientbdate     = l_dCLIENTBDATE,              
                       p.clientphone     = l_CLIENTPHONE,              
                       p.percent         = l_percent,
                       p.dbcode          = f_dbcode(to_number(l_DOCTYPE),l_DOCSERIAL,l_DOCNUMBER),
                       p.datl            = sysdate
                where p.id = l_ID
                returning id, fio, country, postindex, obl, rajon, city, address, fulladdress, icod, doctype, docserial, docnumber, docorg, docdate, clientbdate, clientbplace, clientsex, clientphone, registrydate, nsc, ida, nd, sum, ost, dato, datl, attr, card, datn, ver, stat, tvbv, branch, kv, status, date_import, dbcode, percent, kkname, ob22, rnk, branchact, close_date, reason_change_status, heritage_ost, rnk_bur, branchact_bur, ostasvo, branch_crkr, status_prev, type_person, name_person, edrpo_person into l_portfolio;                         
                
                l_cnt := l_cnt + 1;

                i_row_portfolio_upd(l_portfolio);
                
                exception
                   when others then
                     xmldom.freeDocument(l_doc);
                     xmlparser.freeParser(l_parser);
                     p_ret := -1;
                     p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
                     rollback;
                     return;
          end;                
              
          end if;  
          
        end loop;  
        xmldom.freeDocument(l_doc);
        xmlparser.freeParser(l_parser);        
      end if;   
      
      if l_ben is not null then
        l_clob := l_ben;
--      bars_audit.info('l_clob(1)    1-4000 = '||substr(l_clob,   1,4000));
--      bars_audit.info('l_clob(2) 4001-8000 = '||substr(l_clob,4001,4000));
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
            p_ret := -9;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            rollback;
            return;
          end;
          begin
            l_dCLIENTBDATEB := to_date(l_CLIENTBDATEB,'YYYY-MM-DD');
          exception when others then
            xmldom.freeDocument(l_doc);
            xmlparser.freeParser(l_parser);
            p_ret := -10;
            p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
            rollback;
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
          exception when dup_val_on_index then
                         null;
                    when others then
                      if sqlcode = -2291 then
                        null;--нема вкладу
                        else
                          xmldom.freeDocument(l_doc);
                          xmlparser.freeParser(l_parser);
                          p_ret := -11;
                          p_err := sqlerrm||' - '||dbms_utility.format_error_backtrace;
                          rollback;
                          return;
                      end if;  
          end;
        end loop;
        xmldom.freeDocument(l_doc);
        xmlparser.freeParser(l_parser);
      end if;
      
      
      
    end loop;  
    
    if l_cnt_notfound > 0 then
      p_ret := -15;
      p_err := 'CHANGE_COMPEN('||l_cnt||') MISSED('||l_cnt_notfound||')';
      bars_audit.info('crkr_compen.update_info_from_file_j: '||'Змінено вкладів: '||l_cnt||' Незнайдено або пропущено:'||l_cnt_notfound);          
    end if;
    bars_audit.info('crkr_compen.update_info_from_file_j: end ');    
  end;    

begin
--инициализация пакета
  fill_let_table;
end crkr_compen;
/
grant execute on crkr_compen to bars_access_defrole;