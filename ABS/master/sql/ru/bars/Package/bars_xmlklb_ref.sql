
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_xmlklb_ref.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_XMLKLB_REF is

   ------------------------------------------------------------
   --
   --  Пакет синхронизации справочников
   --  Пока что для сбербанка (мультимфо)
   --
   --  SBR  - Сбербанк
   --  MKF  - мультиф. схема (Сбербанк)
   --
   ------------------------------------------------------------


   G_HEADER_VERSION  constant varchar2(64) := 'version 1.8 14.07.2009';

   -----------------------------------------------------------------
   --   типы
   -----------------------------------------------------------------



   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2;




   -----------------------------------------------------------------
   --   GET_REPLY
   --
   --   Вычитывает из очереди пакеты по обновлению справочников
   --   вычитывает jboss
   --
   --   p_gateid     - номер сообщения       (если =0 - очередь пуста)
   --   p_reply      - исходящий текст ответа
   --   p_packname   - имя исходящего файла для ответа
   --   p_partcnt    - кол-во партиций
   --
   procedure get_reply(
                  p_gateid           out number,
                  p_reply            out nocopy clob,
                  p_partcnt          out number,
                  p_packname         out varchar2);



   -------------------------------------------------------------
   --    POST_FULLREF_FOR_SAB
   --
   --    Поставить в очередь  все данные по справочнику для определенного саб.
   --
   --
   procedure post_fullref_for_sab(
                  p_sab      varchar2,
                  p_refname  varchar2 );


   -------------------------------------------------------------
   --    POST_INCREF_FOR_ALL
   --
   --    Поставить в очередь все инкрементные данные по всем саб.
   --
   --
   procedure post_incref_for_all(p_flag smallint);



   -------------------------------------------------------------
   --    POST_POSTREF_FOR_SAB
   --
   --    Поставить в очередь все заключительные данные по справочнику за дату
   --
   --
   procedure post_postref_for_sab(
                  p_sab       varchar2,
                  p_refname   varchar2,
                  p_date      date );


   -------------------------------------------------------------
   --    POST_REQVREF_FOR_SAB
   --
   --    Поставить в очередь ответы на запрос справочника по параметрам
   --
   --    p_sab         -- саб кому
   --    p_refname     -- имя справочника
   --    p_inpackname  -- имя файла запроса
   --    p_params      -- параметры запроса
   --
   procedure post_reqvref_for_sab(
                  p_sab        varchar2,
                  p_refname    varchar2,
                  p_inpackhdr  bars_xmlklb.t_header,
                  p_params     varchar2_list);


   -------------------------------------------------------------
   --    POST_PARAMREF_FOR_SAB
   --
   --    Поставить в очередь выгрузку справочников с указанными параметрами
   --
   --    p_sab         -- саб кому
   --    p_refname     -- имя справочника
   --    p_parN        -- значение параметров
   --
   procedure post_paramref_for_sab(
                  p_sab        varchar2,
                  p_refname    varchar2,
                  p_par1       varchar2,
                  p_par2       varchar2,
                  p_par3       varchar2,
                  p_par4       varchar2);


   -----------------------------------------------------------------
   --    MAKE_POSTVP
   --
   --    Сформировать выписку за указанную дату для текущего baranch
   --
   --
   procedure  make_postvp( p_date    date,
                           p_sab     varchar2 default null,
                           p_okpo    varchar2 default null,
                           p_nlsmask varchar2 default '%');






   -------------------------------------------------------------
   --    TT_FUNC2PARAM
   --
   --    Получить соответствующее значение параметра для функции в описании опреации
   --    для синхронизайии справочника операций
   --
   function  tt_func2param(p_barsfunc varchar2) return varchar2;


   -------------------------------------------------------------
   --    SYNCGRP_LOCAL
   --
   --    Получить локальную группу счтов синхронизации
   --
   function  syncgrp_local return number;


   -------------------------------------------------------------
   --    SYNCGRP_PARENT
   --
   --    Получить parent группу счтов синхронизации
   --
   function  syncgrp_parent return number;



   -------------------------------------------------------------
   --    SYNCGRP_GLOBAL
   --
   --    Получить global группу счтов синхронизации
   --
   function  syncgrp_global return number;


   -----------------------------------------------------------------
   --
   --    DYNFUNC()
   --
   --    Выполнение функции
   --
   function dynfunc(p_sql varchar2) return varchar2;


   -------------------------------------------------------------
   --    POSTVP_FOR_ALL
   --
   --    Поставить в очередь выписки по всем работающим бранчам
   --
   --
   procedure postvp_for_all(p_date date);


   -------------------------------------------------------------
   --    POSTVP_PERIOD_FOR_SAB
   --
   --    Поставить в очередь выписки зв период по указанному САБ-у
   --    p_sab  -  САБ отделения
   --
   procedure postvp_period_for_sab(
                  p_sab      varchar2,
                  p_datefrom date,
                  p_dateto   date);

   -------------------------------------------------------------
   --    POSTVP_FOR_SAB
   --
   --    Поставить в очередь выписку за дату по маске счета
   --    p_sab  -  САБ отделения
   --
   procedure postvp_for_sab(
                  p_sab      varchar2,
                  p_date     date,
                  p_nlsmask  varchar2);






end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_XMLKLB_REF is


   ------------------------------------------------------------
   --
   --  Пакет синхронизации справочников
   --  Пока что для сбербанка (мультимфо)
   --
   --  SBR  - Сбербанк
   --  MKF  - мультиф. схема (Сбербанк)
   --
   ------------------------------------------------------------


   G_BODY_DEFS constant varchar2(512) := ''
  	||'Для сбербанка'    || chr(10)
  	||'MKF - мульти мфо'||chr(10)
  	||'DOC - Синхонизация оплаченных документов'
  ;


   ----------------------------------------------
   --  константы
   ----------------------------------------------

   G_BODY_VERSION    constant varchar2(64) := 'version 1.16 17.09.2009';
   G_TRACE           constant varchar2(20) := 'xmlklb_ref.';
   G_MODULE          constant varchar2(20) := 'KLB';
   G_SERVICE         constant varchar2(20) := 'REFS';
   G_REPLY_PRFX      constant char(1)      := 'T';
   G_REQV_PRFX       constant char(1)      := 'S';

   G_SYNC_FULL       constant smallint     := 2;   --  полное обновление справочников
   G_SYNC_INCR       constant smallint     := 0;   --  инкрементное обновление справочников
   G_SYNC_POST       constant smallint     := 1;   --  заключительное изменение(в течении банк. дня)
   G_SYNC_REQV       constant smallint     := 3;   --  синхронизация по файлу-запросу
   G_SYNC_PARAM      constant smallint     := 4;   --  синхронизация по параметрам (должна в файле выгрузки
                                                   --  иметь тот же код как и для заключительное изменение(в течении банк. дня)

   ----------------------------------------------
   --  Переменные
   ----------------------------------------------
   G_GRP_LOCAL       number; -- номер локальной группы счетов для синхронизации
   G_GRP_PARENT      number; -- номер родительской группы счетов для синхронизации
   G_GRP_GLOBAL      number; -- номер глобальной группы счетов для синхронизации


   type t_dpttts_rec is record (vidd dpt_tts_vidd.vidd%type,
                                  tt dpt_tts_vidd.tt%type);
   type t_dpttts_tab is table of t_dpttts_rec index by binary_integer;  -- тип для синхронизации справочника dpt_tts_vidd
   g_dpttts_latch    boolean;


   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header BARS_XMLKLB_REF: ' || G_BODY_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body BARS_XMLKLB_REF ' || G_BODY_VERSION || chr(10) ||
              'package body definition(s):' || chr(10) || G_BODY_DEFS;
   end body_version;



   /*
   -------------------------------------------------------------
   --    SYNC_NEW_DPTTTS
   --
   --    Для добавлнеия новой операции по депозиту и дальнейшей синхронизации справочника dpt_tts_vidd
   --
   procedure insert_new_dpttts
   is
      l_offflg smallint := 0;
      l_cnt    smallint := 0;
      l_offtt  tts.tt%type;
   begin
      select count(*)
        into l_offflg
        from op_rules
        where tag = 'DPTOFF' and val= '1' and tt = :new.tt;


      -- операция добавдена не оффлайновская - добавить соответствующую для офлайна
      if  l_offflg = 0 then
          for c in (select tt, tag, val from  op_rules where tt = :new.tt and tag like 'TTOF%' ) loop
	      insert into dpt_tts_vidd(vidd, tt)
	      values(:new.vidd, c.val);
	      l_cnt := l_cnt + 1;
          end loop;
	  if l_cnt = 0 then
	     bars_error.raise_error('KLB', 'NOTEXISTS_OFFLINE_TT', :new.tt);
	  end if;
      end if;

   end;
   */

   -------------------------------------------------------------
   --    INIT
   --
   --    Инициализация пакета
   --
   procedure init
   is
   begin
      select max(decode(par, 'SNCLOCAL', val, '')),
             max(decode(par, 'SNCPARNT', val, '')),
             max(decode(par, 'SNCGLBL',  val, ''))
      into   G_GRP_LOCAL,
             G_GRP_PARENT,
             G_GRP_GLOBAL
      from params$global
      where par in ('SNCLOCAL','SNCPARNT','SNCGLBL');

      if G_GRP_LOCAL is null then
         bars_error.raise_error(G_MODULE,170);
      end if;

      if G_GRP_PARENT is null then
         bars_error.raise_error(G_MODULE,171);
      end if;

      if G_GRP_GLOBAL is null then
         bars_error.raise_error(G_MODULE,172);
      end if;

      g_dpttts_latch := false;

   end;



   -------------------------------------------------------------
   --    SYNCGRP_LOCAL
   --
   --    Получить локальную группу счтов синхронизации
   --
   function  syncgrp_local return number
   is
   begin
      return G_GRP_LOCAL;
   end;


   -------------------------------------------------------------
   --    SYNCGRP_PARENT
   --
   --    Получить parent группу счтов синхронизации
   --
   function  syncgrp_parent return number
   is
   begin
      return G_GRP_PARENT;
   end;



   -------------------------------------------------------------
   --    SYNCGRP_GLOBAL
   --
   --    Получить global группу счтов синхронизации
   --
   function  syncgrp_global return number
   is
   begin
      return G_GRP_GLOBAL;
   end;


   -------------------------------------------------------------
   --    TT_FUNC2PARAM
   --
   --    Получить соответствующее значение параметра для функции в описании опреации
   --    для синхронизайии справочника операций
   --
   function  tt_func2param(p_barsfunc varchar2) return varchar2
   is
      l_param xml_fncequal.klb_param%type;
   begin
      if p_barsfunc is null then
         return '';
      end if;

      begin
         select klb_param into l_param
         from xml_fncequal
         where upper(bars_func) = upper(replace(p_barsfunc,' '));
      exception when no_data_found then
         return '';
      end;
      return  l_param;
   end;


   -------------------------------------------------------------
   --    GET_VPTYPE
   --
   --    Получить значение параемтра тип выпискисправочник (если p_synctype = 3)
   --
   function  get_vptype(p_reftype smallint,
                        p_date    date) return varchar2
   is
      l_vptype char(1);
      l_rrpday char(1);
      l_trace    varchar2(1000):=G_TRACE||'get_vptype: ';
   begin
      bars_audit.trace(l_trace||p_reftype||'-'||p_date);
      case  -- тип синхронизации справочника
         when  p_reftype = G_SYNC_REQV   then   --  по-запросу
              if p_date = bankdate then
                 select substr(val,1,1) into l_rrpday from params where par = 'RRPDAY';
                 if l_rrpday = '1' then -- день открыт
                    l_vptype := '0'; -- не заключительная
                 else
                    l_vptype := '1'; -- заключительная
                 end if;
              else
                 l_vptype := '1'; -- заключительная
              end if;
         when p_reftype = G_SYNC_POST  then
              l_vptype := '1';
         else l_vptype := null;
      end case;
      return to_char(l_vptype);
   end;






   -----------------------------------------------------------------
   --
   --    GET_REFS_FROM_QUE()
   --
   --    Выбирает из очереди запрос на синхронизацияю справочников
   --
   --
   --
   procedure get_refs_from_que(
                   p_qreply  in out t_klbx_qreply )
   is
      l_deqopt	        dbms_aq.dequeue_options_t;
      l_mprop           dbms_aq.message_properties_t;
      l_deq_eventid     raw(16);
      l_trace           varchar2(1000):=G_TRACE||'get_refs_from_que: ';
      mq_empty_or_timeout_exception exception;
      pragma exception_init(mq_empty_or_timeout_exception, -25228);

   begin

     l_deqopt.wait := 1;
     bars_audit.trace(l_trace||'начало получения ответа из очереди');
     begin
         dbms_aq.dequeue (
         queue_name		=> 'bars.aq_klbx_replies',
         dequeue_options	=> l_deqopt,
         message_properties	=> l_mprop,
         payload		=> p_qreply,
         msgid			=> l_deq_eventid);

     exception when mq_empty_or_timeout_exception then
         bars_audit.trace(l_trace||'выходим по истечению таймаута');
         return;

     end;
   end;


   -----------------------------------------------------------------
   --
   --    DYNFUNC()
   --
   --    Выполнение функции
   --
   function dynfunc(p_sql varchar2) return varchar2
   is
      l_res varchar2(1000);
   begin
      execute immediate 'select '||p_sql||' from dual' into l_res;
      return l_res;
   end;


   -----------------------------------------------------------------
   --   GET_REPLY
   --
   --   Вычитывает из очереди пакеты по обновлению справочников
   --   в?чит?вает вертушкой jboss
   --
   --   p_gateid     - номер сообщения       (если =0 - очередь пуста)
   --   p_reply      - исходящий текст ответа
   --   p_packname   - имя исходящего файла для ответа
   --   p_partcnt    - кол-во партиций
   --
   procedure get_reply(
                  p_gateid           out number,
                  p_reply            out nocopy clob,
                  p_partcnt          out number,
                  p_packname         out varchar2)
   is
      l_trace      varchar2(1000):=G_TRACE||'get_reply: ';
      l_qreply     t_klbx_qreply;
   begin

      bars_audit.trace(l_trace||'Начало формирования пакета из очереди');

      -- достать из очереди
      get_refs_from_que(l_qreply);

      if (l_qreply.pack_name is null) then
         bars_audit.trace(l_trace||'текст в очереди - пустой');
         p_gateid   := 0;
   	 p_reply    := null;
   	 p_packname := null;
         p_partcnt  := 0;
         return;
      end if;

      bars_audit.trace(l_trace||'получили пакет из очереди '||l_qreply.pack_name);
      p_gateid   := 1;
      p_partcnt  := 1;
      p_reply    := l_qreply.reply;
      p_packname := l_qreply.pack_name;

   exception when others then
      bars_audit.error(l_trace||'ошибка получения ответа из очереди: '||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    REPLACE_ACTION_ATTR
   --
   --    Переместить тег action в аттрибут тега rowtag
   --
   --    p_refclob  - клоб справочника
   --
   procedure replace_action_attr(
                  p_refclob in out clob)
   is
      l_doc      dbms_xmldom.DOMDocument;
      l_trace    varchar2(1000):=G_TRACE||'replace_action_attr: ';
      l_action   varchar2(10);
      l_attname  varchar2(10) := 'action';
      l_nd       dbms_xmldom.DOMNode;
      l_ndact    dbms_xmldom.DOMNode;
      l_attr     dbms_xmldom.DOMattr;
      l_ndlist   dbms_xmldom.DOMNodeList;
      l_clob     clob;
      l_refname  varchar2(100);
   begin

      bars_audit.trace(l_trace||'в функции ');
      l_doc := bars_xmlklb.parse_clob(p_refclob);

      l_ndlist     := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(l_doc), 'reference/rowtag');
      bars_audit.trace(l_trace||'кол-во найденых нод:'||dbms_xmldom.getLength(l_ndlist));

      for i in 0..dbms_xmldom.getLength(l_ndlist) - 1  loop
          l_nd     := dbms_xmldom.item(l_ndlist, i);
          l_action := dbms_xslprocessor.valueOf(l_nd, 'ACTION/text()');
          if l_action = '' or l_action is null then
             l_refname := dbms_xslprocessor.valueOf(l_nd, '@name');
             -- в?кид?ваем сист. ош о том, что неправильно описан справочник
             bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,72,l_refname));
          end if;
          bars_audit.trace(l_trace||'дейсвие '||l_action);
          l_attr   := dbms_xmldom.createAttribute(l_doc,l_attname);
                      dbms_xmldom.setValue(l_attr, l_action);
          l_attr   := dbms_xmldom.setAttributeNode( dbms_xmldom.makeElement(l_nd), l_attr);
          -- удалить эту ноду
          l_nd     := dbms_xmldom.item(l_ndlist, i);
          l_ndact  := dbms_xslprocessor.selectSingleNode(l_nd, 'ACTION');
          l_nd     := dbms_xmldom.removechild( l_nd, l_ndact);

      end loop;

      dbms_lob.createtemporary(l_clob,false);
      dbms_xmldom.writetoclob(l_doc, l_clob);

      -- удалить
      if dbms_lob.istemporary(p_refclob)  = 1 then
         dbms_lob.freetemporary(p_refclob);
      end if;

      p_refclob := l_clob;

      dbms_xmldom.freedocument(l_doc);

   exception when others then
      if not dbms_xmldom.isnull(l_doc) then
         dbms_xmldom.freedocument(l_doc);
      end if;
      bars_audit.error(l_trace||'Ошибка перемещения тега дейсвия в аттрибут:'||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    ADD_REF_TO_REPLY
   --
   --    Добавить текущий справочник в общий пакет
   --    (тег /reference - является корневым)
   --    ! сдесь выделяется createtemporary
   --    p_ref - справочник
   --
   procedure add_ref_to_reply(
                  p_ref              clob,
                  p_reply    in out  clob )
   is
      l_trgdoc     dbms_xmldom.DOMDocument;
      l_trgbodynd  dbms_xmldom.DOMNode;
      l_srcdoc     dbms_xmldom.DOMDocument;
      l_srcnd      dbms_xmldom.DOMNode;
      l_nd         dbms_xmldom.DOMNode;
      l_trace      varchar2(1000):=G_TRACE||'add_ref_to_reply: ';
      l_clob       clob;
   begin

      dbms_lob.createtemporary(l_clob, false);


      --bars_audit.trace(l_trace||' входящий док-т: '||p_reply);


      l_trgdoc    :=  bars_xmlklb.parse_clob(p_reply);
      l_trgbodynd :=  dbms_xmldom.item(dbms_xmldom.getelementsbytagname(l_trgdoc, 'Body'), 0);

      l_srcdoc    :=  bars_xmlklb.parse_clob(p_ref);
      l_srcnd     :=  dbms_xmldom.makeNode(dbms_xmldom.getDocumentElement(l_srcdoc));

      --dbms_xmldom.item(dbms_xmldom.getelementsbytagname(l_srcdoc, 'reference'), 0);
      l_nd        :=  dbms_xmldom.importNode(l_trgdoc, l_srcnd, true);
      l_nd        :=  dbms_xmldom.appendChild(l_trgbodynd, l_nd);


      dbms_xmldom.writetoclob(l_trgdoc, l_clob);
      -- удалить
      if dbms_lob.istemporary(p_reply)  = 1 then
         dbms_lob.freetemporary(p_reply);
      end if;

      p_reply := l_clob;


      dbms_xmldom.freedocument(l_trgdoc);
      dbms_xmldom.freedocument(l_srcdoc);


   exception when others then
      if not dbms_xmldom.isnull(l_trgdoc) then
         dbms_xmldom.freedocument(l_trgdoc);
      end if;

      if not dbms_xmldom.isnull(l_srcdoc) then
         dbms_xmldom.freedocument(l_srcdoc);
      end if;

      bars_audit.error(l_trace||'Ошибка добавления справочника в ответ:'||sqlerrm);
      raise;
   end;





   -----------------------------------------------------------------
   --    ENQUE_REPLY
   --
   --    Поставить в очердь сформированный ответ
   --
   procedure enque_reply(p_qreply t_klbx_qreply)
   is
      l_enqopt 	    dbms_aq.enqueue_options_t;
      l_mprop 	    dbms_aq.message_properties_t;
      l_enqeventid  raw(16);
      l_trace       varchar2(1000) := G_TRACE||'enque_reply: ';
   begin

      bars_audit.trace(l_trace||'постановка пакета '||p_qreply.pack_name);

      dbms_aq.enqueue(
              queue_name         => 'bars.aq_klbx_replies',
              enqueue_options    => l_enqopt,
              message_properties => l_mprop,
              payload            => p_qreply ,
              msgid              => l_enqeventid);

      bars_audit.trace(l_trace||'пакет в очередь установлен');

   exception when others then
      bars_audit.error(l_trace||'ошибка постановки пакета в очередь: '||sqlerrm);
      raise;
   end;





   -----------------------------------------------------------------
   --    MAKE_POSTVP
   --
   --    Сформировать выписку за указанную дату для текущего baranch
   --    (при выполнении выписки - мы уже долны были прикинуться текущим бранчем )
   --
   --
   procedure  make_postvp( p_date    date,
                           p_sab     varchar2 default null,
                           p_okpo    varchar2 default null,
                           p_nlsmask varchar2 default '%')
   is
     l_nlsk           oper.nlsb%type;
     l_namk           oper.nam_b%type;
     l_mfob           oper.mfob%type;
     l_bankb          banks.nb%type;
     l_idk            oper.id_b%type;
     l_nazn           oper.nazn%type;
     l_kv2            oper.nazn%type;
     l_sab            customer.sab%type;
     l_trace          varchar2(1000) := 'make_postvp:';
     l_search         smallint;
     l_flg            smallint;
     l_acc            number;
     l_branch         branch.branch%type;
     l_nlsmask        varchar2(15);
     G_SEARCH_OPLDOK  constant smallint := 1;
     G_SEARCH_OPER    constant smallint := 2;
   begin
      delete from tmp_vpklb;

      if p_sab is null then
         -- найти значение SAB
         select sab into l_sab
         from branch_parameters p, customer c
         where p.branch = sys_context('bars_context','user_branch')
         and tag = 'RNK'
         and val = c.rnk;
     else
         l_sab := p_sab;
     end if;


     bars_audit.trace(l_trace||'формирование выписки за дату: '||to_char(p_date,'dd-mm-yyyy')||' для саб: '||p_sab||' для ОКПО: '||p_okpo||' для маски: '||p_nlsmask);
     bars_audit.trace(l_trace||'для текущего бранча '||sys_context('bars_context','user_branch')||' нашли sab='||l_sab);

     l_nlsmask := replace(replace(p_nlsmask, '?', '_'), '*', '%');


     -- предполагается, что перед выполнением функи был установлен бранч через bars_xmlklb.pretend_branch
     for c in (select a.acc, l_sab sab ,a.nls,substr(a.nms,1,38) nms,
                      a.isp, s.ostf-s.dos+s.kos ost, s.dos, s.kos,   s.pdat,
                      a.rnk, kv, dapp, a.ostc, a.dos ados, a.kos akos
               from   saldoa s, accounts a
               where  a.acc=s.acc and s.fdat = p_date
                      and nls like l_nlsmask
		      and tip not in ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00','T0B')
                      and branch  = sys_context('bars_context','user_branch')
              )
     loop


             /*insert into tmp_vpklb(acc, accinfo)
             values ( c.acc,
                      XMLTYPE('<SAL><FDAT>'||to_char(gl.bd,'yyyy-mm-dd')||'</FDAT><NLS>'||c.nls||'</NLS><KV>'||c.kv||'</KV><OST>'||c.ostc||'</OST><DOS>'||c.ados||'</DOS><KOS>'||c.akos||'</KOS></SAL>')
                    );
              */

              bars_audit.trace(l_trace||'счет:'||c.nls);


              for opl in (  select p.dk, o.s2, o.sq, p.s,  p.ref, p.tt as tt_opl, o.tt as tt_opr,
	     		           o.nd, o.vob, o.nazn, o.nlsa, o.mfoa, o.nam_a,
	                           o.nlsb, o.mfob, o.nam_b, o.id_b, o.id_a, p.stmt, p.txt, w.value ref_a,
	                           o.datd, o.datp, sk, userid, vdat, o.kv2, o.kv,
                                   --decode(p.tt, 'BAK', 5, o.sos) sos
                                   p.sos
                            from   opldok p, oper o, operw w
                           where  p.ref=o.ref and p.acc=c.acc and p.fdat=p_date
	     		     and p.sos=5 and o.ref = w.ref(+)  and w.tag(+) = 'CLBRF')
              loop

                  bars_audit.trace(l_trace||'документ реф = '||opl.ref||' tt='||opl.tt_opl);
                  -- проводка дочерняя или счет не участвует в документе или равзновалютная
	          if ( (opl.tt_opr<>opl.tt_opl)                  or
                       (c.nls <> opl.nlsb and c.nls <> opl.nlsa) or
                       (opl.nlsb is null)                        or  -- сводный мем ордер (например зачисления)
                       (opl.kv2 <> opl.kv )
                     ) then
                      l_search := G_SEARCH_OPLDOK;
                  else
                      l_search := G_SEARCH_OPER;
                  end if;

                  bars_audit.trace(l_trace||'поиск по '|| (case l_search when G_SEARCH_OPLDOK then 'OPLDOK' else 'OPER' end)  );

                  case l_search
                  when G_SEARCH_OPLDOK then
                       begin

                          if (opl.kv2 = opl.kv ) then
                              l_nazn:=opl.txt;
                          else
                              l_nazn:=opl.nazn;
                          end if;

                          select a.nls,substr(a.nms,1,38), bars_context.extract_mfo(a.branch), c.okpo, a.kv
                             into l_nlsk, l_namk, l_mfob, l_idk, l_kv2
                             from opldok o, accounts a, customer c
                             where  a.acc = o.acc  and o.ref  = opl.ref
                                    and o.tt = opl.tt_opl and o.s   =  opl.s
                                    and o.stmt = opl.stmt
  	     	  	            and c.rnk = a.rnk and o.dk = (1-opl.dk);
                          exception when no_data_found then
                             bars_audit.error(l_trace||' G_SEARCH_OPLDOK: не найдены данные для стороны B по реквизитам: ref='||opl.ref||' dk='||(1-opl.dk)||' stmt='||opl.stmt||' tt='||opl.tt_opl||' s='||opl.s  );
                             bars_error.raise_error(G_MODULE, 179, 'ref='||opl.ref||' dk='||(1-opl.dk)||' stmt='||opl.stmt||' tt='||opl.tt_opl||' s='||opl.s);
                          end;
                          l_mfob := gl.amfo;

                  when G_SEARCH_OPER then

                        bars_audit.trace(l_trace||'поиск по OPER параметры: c.nls='||c.nls||' nlsa='||opl.nlsa||' c.kv='||c.kv||' opl.kv='||opl.kv||' opl.nlsb='||opl.nlsb||' opl.kv2'||opl.kv2);

                        l_nazn:=opl.nazn;


                        if (c.nls = opl.nlsa and c.kv = opl.kv)  then
                           l_nlsk := opl.nlsb;
	     	           l_namk := opl.nam_b;
	     	           l_mfob := opl.mfob;
	     	           l_idk  := opl.id_b;
	     	           l_kv2  := opl.kv2;
                        end if;
	                if (c.nls =  opl.nlsb and c.kv = nvl(opl.kv2,opl.kv) )  then
                           l_nlsk := opl.nlsa;
	     	           l_namk := opl.nam_a;
	     	           l_mfob := opl.mfoa;
 	     	           l_idk  := opl.id_a;
   	     	           l_kv2  := opl.kv;
	     	       end if;


                       bars_audit.trace(l_trace||'после установок l_mfob='||l_mfob);
                  else
                     bars_error.raise_error('KLB', 112, to_char(l_search) );
                  end case;



                  begin
                     select nb into l_bankb from banks where mfo=l_mfob;
                  exception when no_data_found then
                     bars_error.raise_error(G_MODULE, 180, l_mfob);
                  end;


                  insert into tmp_vpklb(
                         acc,   nls,  kv,   nms,   nlsk,   namk,   mfo,    nb,      okpo,
                         s,     nd,     nazn,  vdat,       userid,
                         ref,      sk,   dapp,   datp,    ost,     vob,         fdat,
                         kv2, dk, sab,  tt, s2, sq, pond, sos, stmt  )
                  values ( c.acc, c.nls, c.kv, c.nms, l_nlsk, l_namk, l_mfob, l_bankb,  l_idk,
                           opl.s, opl.nd, l_nazn, opl.vdat,  opl.userid,
	                   opl.ref,  opl.sk, c.dapp, opl.datp, c.ost, opl.vob,  p_date,
	     	           l_kv2, opl.dk, c.sab, opl.tt_opl, opl.s2, opl.sq, opl.ref_a, opl.sos, opl.stmt
                         );
              end loop;  --opl


      end loop; -- sal


      -- сторнированые за дату отчета
      for  c in ( select w.value as ref_a,o.sos, o.vdat, wb.value as blk_val,
                         o.ref, nlsa, mfoa, nlsb, mfob, kv, kv2
                    from oper o, operw wb, operw w
                   where o.vdat = p_date   and o.sos < 0
                     and o.ref  = w.ref(+) and w.tag(+) = 'CLBRF'
                     and o.ref  = wb.ref   and wb.tag   = 'BACKR'
                )
       loop

          l_flg := 0;
          -- для уменшения времени выполнения, вынесем поиск нашего счета
          if c.mfoa  = gl.amfo then
             begin
                -- може счет А  - наш
                select 1 into l_flg
                from   accounts
                where  nls = c.nlsa and kv = c.kv and branch = sys_context('bars_context','user_branch');
             exception when no_data_found then
                l_flg := 0;
             end;
          end if;


          if l_flg = 0 and c.mfob  = gl.amfo then
              begin
                 -- може счет Б - наш
                 select 1 into l_flg
                 from   accounts
                 where  nls = c.nlsb and kv = c.kv2 and branch = sys_context('bars_context','user_branch');
              exception when no_data_found then
                l_flg := 0;
              end;
          end if;


          if l_flg = 1 then
             bars_audit.trace(l_trace||'сторно док-та:  ref_a='||c.ref_a||' ref='||c.ref);
             insert into tmp_vpklb( sab,    sos,   blk_msg, pond, fdat, ref)
             values (l_sab, c.sos, c.blk_val, c.ref_a, c.vdat, c.ref);
          else
             bars_audit.trace(l_trace||'сторно по не нашему счету');
          end if;

      end loop;

      bars_audit.trace(l_trace||'виписки сформировали');

   end;




   -----------------------------------------------------------------
   --    MAKE_SYNCVP
   --
   --    Сформировать выписку по полученным данным синхронизации
   --
   procedure  make_syncvp
   is
      l_vpklb  tmp_vpklb%rowtype;
      l_tmp    number;
      l_cnt    number;
      l_grp    number;
      l_trace       varchar2(1000) := G_TRACE||'make_sync: ';
   begin

      bars_audit.trace(l_trace||'начало формирования выписки');

      execute immediate 'delete from tmp_vpklb';


      for c in ( select unique o.acc, s.nls, s.kv, s.dapp, s.ost, s.fdat, s.nms, c.sab, s.branch
                 from barsaq.tmp_refsync_opldok o,
                      sal s, cust_acc ca, customer c
                 where s.fdat=o.fdat and o.acc = s.acc  and s.acc = ca.acc and ca.rnk = c.rnk
               )
      loop


          --select max(column_value) into l_grp
          --from table(sec.getAgrp(c.acc));

          l_vpklb.acc    := c.acc;
          l_vpklb.nms    := c.nms;
          l_vpklb.nls    := c.nls;
          l_vpklb.kv     := c.kv;
          l_vpklb.dapp   := c.dapp;
          l_vpklb.ost    := c.ost;
          l_vpklb.fdat   := c.fdat;
          l_vpklb.sab    := c.sab;
          l_vpklb.branch := c.branch;


          bars_audit.trace(l_trace||'счет :'||c.nls||'-'||c.kv||' branch = '||c.branch);


          for l in ( select action, p.ref, stmt, fdat, tt, s,
                               kv, sq, pdat, vdat, datd, datp, nd, dk, mfo_a,
                               nls_a, id_a, name_a, mfo_b, nls_b, id_b, name_b,
                               narrative, p.vob, system_cn,
                               --decode(p.branch, sys_context('bars_context','user_branch'),  w.value, null) ref_a
                               w.value ref_a
                        from   barsaq.tmp_dual_opldok p,
                               bars.operw w
                        where ((nls_a = c.nls or nls_b = c.nls) and c.kv = kv)
                                  and p.ref = w.ref(+)  and w.tag(+) = 'CLBRF') loop

                       l_vpklb.scn    := l.system_cn;
                       l_vpklb.pond   := l.ref_a; -- реф. кл-банка


                       -- сторно док-та
                       if  l.stmt is null then
                          l_vpklb.sos    := -1;
                          insert into tmp_vpklb values l_vpklb;
                          return;
                       end if;

                       l_vpklb.stmt   := l.stmt;
                       l_vpklb.s      := l.s;
                       l_vpklb.s2     := l.s;
                       l_vpklb.sq     := l.sq;
                       l_vpklb.nd     := l.nd;
                       l_vpklb.nazn   := l.narrative;
                       l_vpklb.vdat   := l.vdat;
                       l_vpklb.ref    := l.ref;
                       l_vpklb.sk     := null;
                       l_vpklb.userid := null;
                       l_vpklb.vob    := l.vob;
                       l_vpklb.kv2    := null;
                       l_vpklb.datp   := l.datp;
                       l_vpklb.tt     := l.tt;
                       l_vpklb.sos    := 5;

                     bars_audit.trace(l_trace||'nls_a = '||l.nls_a||'  nls_b ='||l.nls_b||' c.nls = '||c.nls);

                     bars_audit.trace(l_trace||'MFOA = '||l.mfo_A||'  mfob='||l.mfo_b);

                    if l.nls_a = c.nls then

                       l_vpklb.nlsk   := l.nls_b;
                       l_vpklb.namk   := l.name_b;
                       l_vpklb.mfo    := l.mfo_b;
                       l_vpklb.okpo   := l.id_b;

                       bars_audit.trace(l_trace||'l.nls_a = c.nls  => l_vpklb.mfo = '||l_vpklb.mfo);

                       if l.dk = 1 then
                          l_vpklb.dk := 0;
                       else
                          l_vpklb.dk := 1;
                       end if;

                      -- select nb into l_vpklb.nb from banks where mfo = l.mfo_b;


                    else
                       l_vpklb.nlsk  := l.nls_a;
                       l_vpklb.namk  := l.name_a;
                       l_vpklb.mfo   := l.mfo_a;
                       l_vpklb.okpo  := l.id_a;

                       bars_audit.trace(l_trace||'l.nls_a <> c.nls  => l_vpklb.mfo = '||l_vpklb.mfo);

                       if l.dk = 1 then
                          l_vpklb.dk := 1;
                       else
                          l_vpklb.dk := 0;
                       end if;

                       --select nb into l_vpklb.nb from banks where mfo = l.mfo_a;

                   end if;


                   bars_audit.trace(l_trace||'док-т реф= '||l.ref||' stmt = '||l_vpklb.stmt);
                   insert into tmp_vpklb values l_vpklb;
	  end loop;  -- opldok

      end loop; -- accounts


      l_vpklb := null;
      -- сторно док-ты


      bars_audit.trace(l_trace||'смотрим сторнированные докумненты');

      /*

       select count(*) into  l_cnt
       from barsaq.tmp_dual_opldok o
       where o.action = 'D';

      */


      bars_audit.trace(l_trace||'всего сторно документов  = '||l_cnt);

      for l  in ( select unique  p.ref, b.value blk_msg, p.fdat, w.value ref_a, a.branch
                   from  barsaq.tmp_refsync_opldok p,
                         bars.operw w,
                         bars.operw b,
                         bars.accounts a,
                         barsaq.tmp_dual_opldok d
                   where d.action  = 'D'
                         and p.ref = d.ref
                         and p.ref = w.ref(+)  and w.tag(+) = 'CLBRF'
                         and p.ref = b.ref(+)  and b.tag(+) = 'BACKR'
                         and p.acc = a.acc
                ) loop

          bars_audit.trace(l_trace||'сторно ref='||l.ref);


          l_vpklb.ref     := l.ref;
          l_vpklb.pond    := l.ref_a; -- реф. кл-банка
          l_vpklb.sos     := -1;
          l_vpklb.blk_msg := l.blk_msg;
          l_vpklb.branch  := l.branch;
          l_vpklb.fdat    := l.fdat;

          insert into tmp_vpklb values l_vpklb;

      end loop;



   end;



   -----------------------------------------------------------------
   --    H2_RRP()
   --
   --   -- Decimal --> 32-imal
   --
   --
   function h2_rrp(i smallint) return char is
     x char(1);
   begin
      if i>=0 and i<=9 then  x := chr(i+48);
      elsif i>=10 and i<=35 then  x := chr(i+55);
      else x := '0';
      end if;
      return x;
   end h2_rrp;




   -------------------------------------------------------------
   --   REPLY_PACKNAME
   --
   --   Получит наименование пакета квитанции для текущего бранча
   --
   --   p_rnk
   --   p_sab
   --   p_inpackname  - имя входящего файла запроса
   --
   function reply_packname(p_rnk        number,
                           p_sab        varchar2,
                           p_inpackname varchar2 default null) return varchar2
   is
      l_trace       varchar2(1000) := G_TRACE||'reply_packname: ';
      l_filesab     varchar2(10);
      l_bnkday      date;
      l_filenum     number;
      l_chrnbr      varchar2(3);
      l_div         number;
      l_mod         number;
      l_packname    varchar2(35);
   begin

      if p_inpackname is not null then
         bars_audit.trace(l_trace||'был входящий пакет запроса с именем '||p_inpackname);
         l_packname := G_REQV_PRFX||substr(p_inpackname,2);
         bars_audit.trace(l_trace||'имя ответа: '||l_packname );
         return l_packname;
      end if;

      begin
         select last_bnkday, last_filenum, filesab
         into   l_bnkday,    l_filenum,    l_filesab
         from   kl_customer_params
         where  rnk = p_rnk  for update;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,78,to_char(p_rnk)));
      end;

      l_filenum := nvl(l_filenum, 0);

      if l_bnkday = gl.bd then
         l_filenum := l_filenum + 1;
      else
         --if l_filenum <> 0 then
         l_filenum := 1;
         --end if;
      end if;

      update kl_customer_params set  last_bnkday = gl.bd, last_filenum = l_filenum
      where rnk = p_rnk;

      l_chrnbr := '';
      l_div    := l_filenum;
      while (l_div > 0) loop
          l_mod     := mod(l_div, 36);
          l_div     := trunc(l_div/36);
          l_chrnbr  := h2_rrp( l_mod )||l_chrnbr;
      end loop;

      l_chrnbr   := lpadchr(l_chrnbr, '0', 3);

      l_packname := G_REPLY_PRFX||l_filesab||h2_rrp( to_char(gl.bd,'MM'))||h2_rrp( to_char(gl.bd,'DD'))||'.'||l_chrnbr;
      return l_packname;
   end;




   -------------------------------------------------------------
   --    CONSTRUCT_REFS_PACK
   --
   --    Собрать полный пакет из тела для установки в очередь
   --
   --   p_sab        - идентификатор
   --   p_synctype   - тип синхронизации справочника
   --   p_reply      - ответ
   --   p_packname   - имя пакта, если нету - генерируется
   --   p_currscn    - текущий SCN пакета
   --   p_packdate   - дата пакета, если нету - генерируется
   --   p_qreply     - структура ответа
   --
   procedure construct_refs_pack(
                  p_sab          varchar2,
                  p_rnk          number,
                  p_synctype     smallint,
                  p_reply        clob,
                  p_packname     varchar2 default null,
                  p_packdate     in out date,
                  p_currscn      number,
                  p_prevscn      number,
                  p_refname      varchar2,
                  p_inpackhdr    bars_xmlklb.t_header,
                  p_params       varchar2_list,
                  p_qreply   out t_klbx_qreply)
   is
      l_qreply      t_klbx_qreply;
      l_trace       varchar2(1000) := G_TRACE||'construct_refs_pack: ';
      l_rplhdr      bars_xmlklb.t_rplheader;
      l_reply       clob;
      l_packname    varchar2(100);
      l_hdrtags     bars_xmlklb.t_taglist;
      l_hdrattr     bars_xmlklb.t_attrs;
      l_vpdate      date;
   begin

      bars_audit.trace(l_trace||'начало инициализации заголовка');

      -- инициализировать заголовок ответа
      if p_packname is null  then
         l_packname  := reply_packname(
                           p_rnk        => p_rnk,
                           p_sab        => p_sab,
                           p_inpackname => p_inpackhdr.pack_name);
      else
         l_packname  :=  p_packname;
      end if;

      -- в заголовке пакета имя пакета должно быть без приставки партиции '_*'
      l_rplhdr.pack_name := substr(l_packname,1,12);

      if p_packdate is null  then
         l_rplhdr.pack_date := gl.bd + (sysdate - trunc(sysdate));
         p_packdate := l_rplhdr.pack_date;
      else
         l_rplhdr.pack_date := p_packdate;
      end if;

      if p_inpackhdr.pack_name is not null then
         l_rplhdr.rqv_mess  := p_inpackhdr.mess;
         l_rplhdr.rqv_pack  := p_inpackhdr.pack_name;
         l_rplhdr.rqv_date  := p_inpackhdr.pack_date;
      else
         l_rplhdr.rqv_mess  := G_SERVICE;
         l_rplhdr.rqv_pack  := null;
         l_rplhdr.rqv_date  := null;
      end if;

      l_rplhdr.sender    := null;
      l_rplhdr.mess      := 'RCPT';
      l_rplhdr.receiver  := p_sab;

      bars_audit.trace(l_trace||'перед устанвлением значений заголовка');
      --bars_audit.trace(l_trace||p_params(1)||' - ');

      l_reply := p_reply;

      l_hdrattr('type'):= to_char(case p_synctype when G_SYNC_PARAM then G_SYNC_POST else p_synctype end);
      l_hdrattr('cscn'):= to_char(p_currscn);
      l_hdrattr('lscn'):= to_char(p_prevscn);

      l_hdrtags('reference').tagval := p_refname;
      l_hdrtags('reference').attrs  := l_hdrattr;


      -- для некоторых справончников (например  - документы)
      -- нужен тег VpType - означающий, заключительная или нет это выписка
      case
           when  p_synctype = G_SYNC_POST then
                 l_hdrtags('VpType').tagval := get_vptype(p_synctype, gl.bd);
           when  p_synctype = G_SYNC_PARAM then
                 l_hdrtags('VpType').tagval := 1;
           when  p_synctype = G_SYNC_REQV  then
                 begin
                    -- первый параметр это дата за которую запросили
                    l_vpdate := to_date(p_params(1), 'yyyy-mm-dd');
                 -- если не дата(например справочник без дат) - тогда и не нужен этот тег
                 exception when others then l_vpdate := null;
                 end;
                 l_hdrtags('VpType').tagval := get_vptype(p_synctype,l_vpdate);
           else  l_hdrtags('VpType').tagval := get_vptype(p_synctype,null);
      end case;




      bars_xmlklb.set_header_values(
           p_reply      => l_reply,
           p_hdr        => l_rplhdr,
           p_service    => null,
           p_hdraddtags => l_hdrtags);

      p_qreply:= t_klbx_qreply(null, null);
      p_qreply.pack_name := l_packname;
      bars_audit.trace(l_trace||'имя пакета '|| l_packname);
      p_qreply.reply     := l_reply;


   end;




   -------------------------------------------------------------
   --    PROCESS_REF_FOR_SAB
   --
   --    Получить данные по справочнику для конкретного sab
   --    Передполагается, что во временных таблицах tmp_refsync_* уже присутствуют
   --    данные для выгрузки
   --
   --    p_synctype  - полная или инкреентаня
   --    p_sab       - для какого саб справочник
   --    p_refname   - имя справочника
   --    p_inpakname - имя файла запроса на справочник (если p_synctype = 3)
   --    p_params    - параметры для запроса на справочник (если p_synctype = 3)
   --
   procedure process_ref_for_sab(
                  p_sab         varchar2,
                  p_refname     varchar2,
                  p_synctype    smallint,
                  p_inpackhdr   bars_xmlklb.t_header default null,
                  p_params      varchar2_list        default null)
   is
      l_replyschem   clob;
      l_reply        clob;
      l_partcnt      number;
      l_packdate     date;
      l_packname     varchar2(100);
      l_packnameprt  varchar2(100);
      l_selectstmt   varchar2(32000);
      l_partsize     number;
      l_rowsnbr      number;
      l_tabname      varchar2(100);
      l_cur          sys_refcursor;
      l_ctx          dbms_xmlquery.ctxhandle;
      l_curdata      clob;
      l_qreply       t_klbx_qreply;
      l_qreplylst    t_klbx_qreply_list;
      l_trace        varchar2(1000) := G_TRACE||'process_ref_for_sab: ';
      l_msg          varchar2(1000);
      l_currscn      number;
      l_prevscn      number;
      l_rnk          number;
      l_gateid       number;
   begin

      case p_synctype

         when G_SYNC_INCR  then l_msg := 'Текущее';
                                l_tabname := 'xml_reflist_inc';
         when G_SYNC_FULL  then l_msg := 'Полное';
                                l_tabname := 'xml_reflist_full';
         when G_SYNC_POST  then l_msg := 'Заключительне';
                                l_tabname := 'xml_reflist_post';
         when G_SYNC_REQV  then l_msg := 'По файлу-запросу';
                                l_tabname := 'xml_reflist_reqv';
         when G_SYNC_PARAM then l_msg := 'По запросу c параметрами';
                                l_tabname := 'xml_reflist_reqv';

      else
         l_msg := '';
      end case;

      l_msg := l_msg||' обновление справочника ';

      bars_audit.trace(l_trace||l_msg||p_refname||' для '||p_sab);
      -- загрузить структуру ответа
      begin
         select reply_schem
         into   l_replyschem
         from   xml_messtypes
         where  message = G_SERVICE;
      exception when no_data_found then
          bars_error.raise_error('KLB', 1, G_SERVICE);
      end;

      bars_xmlklb.pretend_branch(p_sab);
      bars_audit.trace(l_trace||'загрузили схему ответа');
      if (l_replyschem is null ) then
          bars_error.raise_error('KLB', 48, G_SERVICE);
      end if;


      begin
          execute immediate ' select select_stmt, partsize '||
                            ' from xml_reflist r,'||l_tabname||' t'||
                            ' where r.kltable_name = t.kltable_name and isactive = 1 and t.kltable_name='''||p_refname||''''
          into l_selectstmt, l_partsize;

      exception when no_data_found then
             bars_error.raise_error(G_MODULE, 73, p_refname);
      end;




      bars_audit.trace(l_trace||'запрос: '||l_selectstmt);

      -- запомнить текущий SCN
      l_currscn := dbms_flashback.get_system_change_number;

      begin
         select val into l_rnk
         from   branch_parameters
         where  tag='RNK' and branch = sys_context('bars_context','user_branch');
      exception when no_data_found then
         bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,77,sys_context('bars_context','user_branch')));
      end;


      begin
         select last_scn into l_prevscn
         from xml_synccheck
         where rnk = l_rnk and kltable_name = p_refname for update;
      exception when no_data_found then
         l_prevscn := 0;
         insert into xml_synccheck(rnk, kltable_name, last_scn) values(l_rnk, p_refname, 0);
      end;

      bars_audit.trace(l_trace||'текущий SCN: '||l_currscn);

      open  l_cur for l_selectstmt;
      l_ctx := dbms_xmlgen.newcontext(l_cur);
      dbms_xmlgen.setrowsettag(l_ctx, 'reference');
      dbms_xmlgen.setrowtag   (l_ctx, 'rowtag'   );

      bars_audit.trace(l_trace||'размер партиции: '||l_partsize);
      if l_partsize is not null then
         dbms_xmlgen.setmaxrows(l_ctx, l_partsize);
      end if;
      bars_audit.trace(l_trace||'размер партиции установили');

      l_partcnt   := 0;
      l_qreplylst := t_klbx_qreply_list();


      --цикл по партициям
      loop
          l_reply  :=  l_replyschem;


          dbms_lob.createtemporary(l_curdata, false);
          bars_audit.trace(l_trace||'перед формированием xml из курсора, партиция '||l_partcnt);
          dbms_xmlgen.getxml(l_ctx, l_curdata);
          bars_audit.trace(l_trace||'после формирования xml из курсора');


          --кол-во выбранных строк
          l_rowsnbr := dbms_xmlgen.getNumRowsProcessed(l_ctx);
          bars_audit.trace(l_trace||'выбрано '||l_rowsnbr||' строк');

          -- если данные выбрались
          -- или для типа 'синхронизация по запросу' даже если данных никаких не выбрано - всеравно формируем пакет
          if l_rowsnbr  > 0 or  (l_qreplylst.count = 0 and p_synctype = G_SYNC_REQV ) then

             -- для каждой партиции определить имя файла и дату
             if l_partcnt  = 0 then

                l_packdate := gl.bd + (sysdate - trunc(sysdate));
                bars_audit.trace(l_trace||'gl.bd= '|| nvl(to_char(gl.bd, 'dd/mm/yyyy'),'пусто'));

                l_packname := reply_packname(
                                p_rnk        => l_rnk,
                                p_sab        => p_sab,
                                p_inpackname => p_inpackhdr.pack_name);

                l_packnameprt := l_packname;
             else
                l_packnameprt := l_packname ||'_'||to_char(l_partcnt + 1);
             end if;



             l_partcnt := l_partcnt + 1;

             bars_audit.trace(l_trace||'выгружено '||l_rowsnbr||' строк');

             bars_audit.trace(l_trace||'перед внесением справочника в пакет ответа');

             -- добавить справочник в ответ
             add_ref_to_reply(
                   p_ref    => l_curdata,
                   p_reply  => l_reply);
             -- каждый справочник в свой файл
             bars_audit.trace(l_trace||'перед формированем пакета');

             -- сформировать структуру ответа
             construct_refs_pack(
                   p_sab        => p_sab,
                   p_rnk        => l_rnk,
                   p_synctype   => p_synctype,
                   p_reply      => l_reply,
                   p_packname   => l_packnameprt,
                   p_packdate   => l_packdate,
                   p_currscn    => l_currscn,
                   p_prevscn    => l_prevscn,
                   p_refname    => p_refname,
                   p_inpackhdr  => p_inpackhdr,
                   p_params     => p_params,
                   p_qreply     => l_qreply);




             bars_audit.trace(l_trace||'перед вставкой в спискок пакетов');

             l_qreplylst.extend(1);
             l_qreplylst(l_partcnt) := l_qreply;

             bars_audit.trace(l_trace||'вставили в список под номером '||(l_partcnt));

          -- в курсоре данных больше нету
          else
             bars_audit.trace(l_trace||'в курсоре данных больше нету');
             exit;
          end if;

          -- если не по запросу в файле, тогда внести в историю выгрузки
          if p_synctype <> G_SYNC_REQV then
              insert into xml_syncfiles(pnam, datf, rowscnt, refname, synctype)
              values (l_qreply.pack_name, l_packdate, l_rowsnbr, p_refname, p_synctype);
          end if;

      end loop; -- по партициям


      -- если несколько партиций  - проставить тег
      bars_audit.trace(l_trace||'перед установкой аттрибутов партиции');

      if l_partcnt > 1 then
         bars_audit.trace(l_trace||'кол-во партиций = '||l_partcnt);
         for i in 1..l_qreplylst.count  loop
            bars_audit.trace(l_trace||'установка тега партиции № '||i);
            bars_xmlklb.set_partition_attrs(
                p_reply    => l_qreplylst(i).reply,
                p_partcnt  => l_partcnt,
                p_partcur  => i);
         end loop;

      end if;


      bars_audit.trace(l_trace||'перед поставновкой списка ответов в очередь');


      if p_synctype = G_SYNC_REQV then
         begin
            select id into l_gateid
            from xml_gate
            where pnam = p_inpackhdr.pack_name and  datf = p_inpackhdr.pack_date;
            bars_audit.trace(l_trace||' номер сообщения в xml_gate: '||l_gateid||' имя пакета: '||p_inpackhdr.pack_name||' дата пакета: '||to_char(p_inpackhdr.pack_date) );
         exception when no_data_found then
            bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,80,p_inpackhdr.pack_name, to_char(p_inpackhdr.pack_date,'dd-mm-yyyy')));
         end;

      end if;




      for i in 1..l_qreplylst.count loop
          bars_audit.trace(l_trace||'установка в очередь партиции №'||to_char(i));

          if p_synctype = G_SYNC_REQV then
             bars_xmlklb.save_reply(
                   p_gateid   => l_gateid,
                   p_partid   => i,
                   p_reply    => l_qreplylst(i).reply);
             bars_audit.info(l_trace||'сформирован файл-ответ: '||l_qreplylst(i).pack_name);
          else
             enque_reply(l_qreplylst(i));
             bars_audit.info(l_trace||'сформирован и установлен в очередь файл: '||l_qreplylst(i).pack_name);
          end if;



          bars_audit.trace(l_trace||'перед удалением temporary reply');
          if dbms_lob.istemporary(l_qreplylst(i).reply)  = 1 then
             dbms_lob.freetemporary(l_qreplylst(i).reply);
          end if;
          bars_audit.trace(l_trace||'после удаления temporary reply');

      end loop;



      -- если данные выбрали
      if l_qreplylst.count > 0 then
         --установить последний SCN
         bars_audit.trace(l_trace||'установление последнего SCN в значение '||l_currscn);
         update xml_synccheck set last_scn = l_currscn
         where rnk = l_rnk and kltable_name = p_refname;
      end if;


      l_qreplylst.delete;
      dbms_lob.freetemporary(l_curdata);


      close l_cur;


      bars_context.set_context();
      bars_audit.trace(l_trace||'окончание обработки');
   exception when others then
      bars_audit.error(l_trace||'ошибка формирования пакета по обновлению справочников: '||sqlerrm);

      if dbms_lob.istemporary(l_curdata)  = 1 then
         dbms_lob.freetemporary(l_curdata);
      end if;
      if dbms_lob.istemporary(l_reply)  = 1 then
         dbms_lob.freetemporary(l_reply);
      end if;

      bars_context.set_context();
      raise;
   end;


   -------------------------------------------------------------
   --    EXEC_STMT
   --
   --    Выполнить plsql конструкцию
   --
   --
   procedure exec_stmt(
                  p_sqlstmt   varchar2,
                  p_params    varchar2_list default null)
   is
      l_trace      varchar2(1000) := G_TRACE||'exec_stmt: ';
      l_indx       smallint;
   begin
      if(p_sqlstmt) is null then
         return;
      end if;
      bars_audit.trace(l_trace||'выполнение '||p_sqlstmt);

      if p_params is null then
         bars_audit.trace(l_trace||'параметов нету');
         execute immediate p_sqlstmt;
         return;
      end if;

      bars_audit.trace(l_trace||'параметры есть');
      if instr(p_sqlstmt,':4')>0 then
         --bars_audit.trace(l_trace||'4 параметра '||);
         bars_audit.trace(l_trace||'4 параметра '||p_params(1)||', '||p_params(2)||', '|| p_params(3)||', '||p_params(4));
         execute immediate p_sqlstmt using p_params(1), p_params(2), p_params(3), p_params(4);

      elsif instr(p_sqlstmt,':3')>0 then
         bars_audit.trace(l_trace||'3 параметра '||p_params(1)||', '||p_params(2)||', '|| p_params(3));
         execute immediate p_sqlstmt using p_params(1), p_params(2), p_params(3);
      elsif instr(p_sqlstmt,':2')>0 then
         bars_audit.trace(l_trace||'2 параметра '||p_params(1)||', '||p_params(2));
         execute immediate p_sqlstmt using p_params(1), p_params(2);
      elsif instr(p_sqlstmt,':1')>0 then
         bars_audit.trace(l_trace||'1 параметр '||p_params(1));
         execute immediate p_sqlstmt using p_params(1);
      else
         bars_audit.trace(l_trace||'нет параметров ');
         execute immediate p_sqlstmt;
      end if;
   end;




   -------------------------------------------------------------
   --    POST_FULLREF_FOR_SAB
   --
   --    Поставить в очередь все данные по справочнику для определенного саб.
   --
   --
   procedure post_fullref_for_sab(
                  p_sab      varchar2,
                  p_refname  varchar2 )
   is
      l_insertstmt varchar2(32000);
      l_trace      varchar2(1000) := G_TRACE||'post_fullref_for_sab: ';
   begin

      bars_audit.info(l_trace||'Полная выгрузка справочника '||p_refname||' для '||p_sab);


      begin
          select insert_stmt  into l_insertstmt
          from   xml_reflist_full
          where  isactive = 1 and kltable_name = p_refname;
      exception when no_data_found then
             bars_error.raise_error(G_MODULE, 73, p_refname);
      end;

          bars_xmlklb.pretend_branch(p_sab);
      -- выгрузить во временную таблицу tmp_refsync_* данные
      exec_stmt(l_insertstmt);

      process_ref_for_sab(
              p_sab      => p_sab,
              p_refname  => p_refname,
              p_synctype => G_SYNC_FULL);

      bars_context.set_context();


   exception when others then
      bars_context.set_context();
      raise;
   end;





   -------------------------------------------------------------
   --    POST_REQVREF_FOR_SAB
   --
   --    Поставить в очередь ответы на запрос справочника по параметрам
   --
   --    p_sab         -- саб кому
   --    p_refname     -- имя справочника
   --    p_inpackhdr   -- заголовок входящего
   --    p_ackname     -- имя файла запроса
   --    p_params      -- параметры запроса
   --    p_synctype    -- тип синхронизации (синхронизация по запросу может быть из
   --                      файла G_SYNC_REQV .. и по параметрам,например из интерфейса)
   --
   procedure post_reqvref_for_sab(
                  p_sab        varchar2,
                  p_refname    varchar2,
                  p_inpackhdr  bars_xmlklb.t_header,
                  p_params     varchar2_list,
                  p_synctype   number)
   is
      l_insertstmt varchar2(32000);
      l_proc       varchar2(32000);
      l_depparams  varchar2_list;
      l_trace      varchar2(1000) := G_TRACE||'post_reqvref_for_sab: ';
   begin

      bars_audit.info(l_trace||'Выгрузка по запросу справочника '||p_refname||' для '||p_sab);

      if p_inpackhdr.pack_name is not null then
         bars_audit.info(l_trace||'запрос из файла: '||p_inpackhdr.pack_name||' за '||to_char(p_inpackhdr.pack_date));
      end if;

      begin
          select insert_stmt, before_proc into l_insertstmt, l_proc
          from   xml_reflist_reqv rf,  xml_reflist r
          where  isactive = 1
                 and rf.kltable_name = p_refname
                 and rf.kltable_name = r.kltable_name
          order by select_order;

      exception when no_data_found then
             bars_error.raise_error(G_MODULE, 73, p_refname);
      end;

      bars_xmlklb.pretend_branch(p_sab);

      exec_stmt(l_proc, p_params);

      exec_stmt(l_insertstmt, p_params);

      process_ref_for_sab(
              p_sab       => p_sab,
              p_refname   => p_refname,
              p_synctype  => p_synctype,
              p_inpackhdr => p_inpackhdr,
              p_params    => p_params);


      -- если имеются связанные - выгрузить
      for c in (select kltable_depname from xml_refdep
                where kltable_name = p_refname ) loop
            bars_audit.trace(l_trace||'имеется связанная таблица '||c.kltable_depname);
            l_depparams := varchar2_list();
            l_depparams.extend(4);

            for k in (select srcpar, destpar from xml_refdeppar
                      where kltable_name = p_refname
                            and kltable_depname = c.kltable_depname
                      order by destpar  )  loop
                l_depparams(to_number(substr(k.destpar,2) )) := p_params(to_number(substr(k.srcpar,2) ));
            end loop;
            bars_audit.trace(l_trace||'параметры для связанной таблицы: '||l_depparams(1)||';'||l_depparams(2)||';'||l_depparams(3)||';'||l_depparams(4));

            post_paramref_for_sab(
                  p_sab       => p_sab,
                  p_refname   => c.kltable_depname,
                  p_par1      => l_depparams(1),
                  p_par2      => l_depparams(2),
                  p_par3      => l_depparams(3),
                  p_par4      => l_depparams(4) );
      end loop;

      bars_context.set_context();

   exception when others then
      bars_context.set_context();
      raise;
   end;


   -------------------------------------------------------------
   --    POST_REQVREF_FOR_SAB
   --
   --    Поставить в очередь ответы на запрос справочника по параметрам
   --
   --    p_sab         -- саб кому
   --    p_refname     -- имя справочника
   --    p_inpackhdr   -- заголовок входящего
   --    p_ackname     -- имя файла запроса
   --    p_params      -- параметры запроса
   --
   procedure post_reqvref_for_sab(
                  p_sab        varchar2,
                  p_refname    varchar2,
                  p_inpackhdr  bars_xmlklb.t_header,
                  p_params     varchar2_list)
   is
   begin
           post_reqvref_for_sab(
                  p_sab        => p_sab       ,
                  p_refname    => p_refname   ,
                  p_inpackhdr  => p_inpackhdr ,
                  p_params     => p_params    ,
                  p_synctype   => G_SYNC_REQV);
   end;



   -------------------------------------------------------------
   --    POST_PARAMREF_FOR_SAB
   --
   --    Поставить в очередь выгрузку справочников с указанными параметрами
   --
   --    p_sab         -- саб кому
   --    p_refname     -- имя справочника
   --    p_parN        -- значение параметров
   --
   procedure post_paramref_for_sab(
                  p_sab        varchar2,
                  p_refname    varchar2,
                  p_par1       varchar2,
                  p_par2       varchar2,
                  p_par3       varchar2,
                  p_par4       varchar2)
   is
      l_inpackhdr  bars_xmlklb.t_header;
      l_params     varchar2_list;
      l_trace      varchar2(1000) := G_TRACE||'post_paramref_for_sab: ';
   begin

      l_params := varchar2_list();
      l_params.extend(4);
      l_params(1) := p_par1;
      l_params(2) := p_par2;
      l_params(3) := p_par3;
      l_params(4) := p_par4;

      bars_audit.info(l_trace||'Выгрузка справочника: '||p_refname||' для '||p_sab||' по параметрам: ('||p_par1||';'||p_par2||';'||p_par3||';'||p_par4||')');
      post_reqvref_for_sab(
                  p_sab       => p_sab,
                  p_refname   => p_refname,
                  p_inpackhdr => l_inpackhdr,
                  p_params    => l_params,
                  p_synctype  => G_SYNC_PARAM);

   end;




   -------------------------------------------------------------
   --    POST_POSTREF_FOR_SAB
   --
   --    Поставить в очередь все заключительные данные по справочнику за дату
   --
   --
   procedure post_postref_for_sab(
                  p_sab       varchar2,
                  p_refname   varchar2,
                  p_date      date )
   is
      l_insertstmt varchar2(32000);
      l_proc       varchar2(32000);
      l_params     varchar2_list;
      l_trace      varchar2(1000) := G_TRACE||'post_postref_for_sab: ';
   begin

      bars_audit.info('Закоючительна выгрузка справочника '||p_refname||' для '||p_sab);


      begin
          select insert_stmt, before_proc into l_insertstmt, l_proc
          from   xml_reflist_post rf,  xml_reflist r
          where  isactive = 1
                 and rf.kltable_name = p_refname
                 and rf.kltable_name = r.kltable_name
          order by select_order;

      exception when no_data_found then
             bars_error.raise_error(G_MODULE, 73, p_refname);
      end;

      bars_xmlklb.pretend_branch(p_sab);
      l_params := varchar2_list();
      l_params.extend(1);
      l_params(1) := p_date;

      exec_stmt(l_proc, l_params);

      exec_stmt(l_insertstmt, l_params);

      bars_context.set_context();


      process_ref_for_sab(
              p_sab      => p_sab,
              p_refname  => p_refname,
              p_synctype => G_SYNC_POST,
              p_params   => l_params );

      bars_audit.trace(l_trace||'окончание формирования заключ. данных по '||p_refname);
   exception when others then
      bars_context.set_context();
      raise;
   end;



   -------------------------------------------------------------
   --    POST_INCREF_FOR_ALL
   --
   --    Поставить в очередь все инкрементные данные по всем саб.
   --    p_flag - параметр для совместимости с сентурой
   --
   procedure post_incref_for_all(p_flag smallint)
   is
      l_trace varchar2(1000) := G_TRACE||'post_incref_for_all: ';
      l_tmp   number;
   begin

      --установить контекст для JOB-а
      bars_context.set_context();

      bars_audit.trace(l_trace||'Установки контекста: пользователь '||user);

      -- собрать все измения
      barsaq.bars_refsync_usr.get_all_changed_data;

      --
      --манипуляции с оплаченными док-тами (обход проблемы того,
      -- что счет и платеж по нему формируются в одной транзакции)

      -- те что оплоатились только что
      delete from xml_docpayed;

      select count(*) into l_tmp from barsaq.tmp_refsync_opldok;
      bars_audit.trace(l_trace||'всего записей в tmp_refsync_opldok = '||l_tmp);


      if l_tmp > 0 then
         bars_audit.trace(l_trace||'переносим их на след. заход в таблицу xml_docpayed');
      end if;
      insert into xml_docpayed(ref, tt, dk, acc, fdat, s, sq, txt, stmt, sos,
                               id, kf, action, change_date, change_number, system_change_number)
      select ref, tt, dk, acc, fdat, s, sq, txt, stmt, decode(action, 'D', -1, sos) sos,
             id, kf, action, change_date, change_number, system_change_number
      from barsaq.tmp_refsync_opldok;


      -- те что оплоатились в прошлую иттерацию
      delete from barsaq.tmp_refsync_opldok;
      select count(*) into l_tmp from barsaq.tmp_refsync_xml_docpayed;
      bars_audit.trace(l_trace||'всего записей (из пердидущего захода) в tmp_refsync_xml_docpayed = '||l_tmp);


      if l_tmp > 0 then
         bars_audit.trace(l_trace||'переносим их в таблицу tmp_refsync_opldok  для формирования выписки по ним');
      end if;

      insert into barsaq.tmp_refsync_opldok
      select * from barsaq.tmp_refsync_xml_docpayed;

      --преобразовать tmp_refsync_opldok в tmp_dual_opldok
      barsaq.bars_refsync_usr.proc_opldok_changes;

      --сформировать данные для выписки
      make_syncvp;





      bars_audit.trace(l_trace||'пойдем по всем справочникам ');
      -- по всем справочникам
      for c in ( select unique ri.kltable_name, select_order
                 from   xml_reflist_inc ri,
                        xml_reflist     r,
                        barsaq.refsync_list l
                 where  ri.kltable_name = r.kltable_name
                        and instr(ri.aq_tables, l.tabname) > 0
                        and isactive = 1
                 order by select_order )
      loop
	  -- по всем клиентам
          for k in ( select c.sab
                     from   kl_customer_params kl, customer c
                     where  kl.rnk = c.rnk and c.sab is not null and isactive = 1)
          loop

	      process_ref_for_sab(
                  p_sab      => k.sab,
                  p_refname  => c.kltable_name,
                  p_synctype => G_SYNC_INCR);

          end loop;

      end loop;


   exception when others then
      bars_context.set_context();
      raise;
   end;


   -------------------------------------------------------------
   --    POSTVP_FOR_ALL
   --
   --    Поставить в очередь заключительные выписки по всем работающим бранчам
   --
   --
   procedure postvp_for_all(p_date date)
   is
   begin
      for c in (select sab from v_klbx_branch where isactive = 1) loop
          post_postref_for_sab(c.sab, 'OPLDOK', p_date);
      end loop;
   end;

   -------------------------------------------------------------
   --    POSTVP_PERIOD_FOR_SAB
   --
   --    Поставить в очередь выписки зв период по указанному САБ-у
   --    p_sab  -  САБ отделения
   --
   procedure postvp_period_for_sab(
                  p_sab      varchar2,
                  p_datefrom date,
                  p_dateto   date)
   is
      l_trace varchar2(1000) := G_TRACE||'postvp_period_for_sab: ';
   begin
      bars_audit.error(l_trace||'формирование на '||p_sab||' выписки c '||to_char(p_datefrom,'dd-mm-yyyy')||' по '||to_char(p_dateto,'dd-mm-yyyy'));

      for c in ( select fdat from fdat
                 where fdat between p_datefrom and p_dateto) loop

          bars_audit.trace(l_trace||'формирование на '||p_sab||' выписки за = '||to_char(c.fdat,'dd-mm-yyyy'));
          post_postref_for_sab(p_sab, 'OPLDOK', c.fdat);

      end loop;
   end;


   -------------------------------------------------------------
   --    POSTVP_FOR_SAB
   --
   --    Поставить в очередь выписку за дату по маске счета
   --    p_sab  -  САБ отделения
   --
   procedure postvp_for_sab(
                  p_sab      varchar2,
                  p_date     date,
                  p_nlsmask  varchar2)
   is
   begin
      post_paramref_for_sab(
                  p_sab        => p_sab,
                  p_refname    => 'OPLDOK',
                  p_par1       => to_char(p_date,'yyyy-mm-dd'), -- дата выписки
                  p_par2       => p_sab,                       -- саб клиента (аттавизм)
                  p_par3       => '%',                         -- ОКПО клиента
                  p_par4       => nvl(p_nlsmask, '%') );       -- маска счета

   end;








  ------------------------------------
  --
  --   ИНИЦИАЛИЗАЦИЯ ПАКЕТА
  --
  --

  begin
     init;
end;
/
 show err;
 
PROMPT *** Create  grants  BARS_XMLKLB_REF ***
grant EXECUTE                                                                on BARS_XMLKLB_REF to ABS_ADMIN;
grant EXECUTE                                                                on BARS_XMLKLB_REF to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_XMLKLB_REF to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_XMLKLB_REF to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_XMLKLB_REF to JBOSS_USR;
grant EXECUTE                                                                on BARS_XMLKLB_REF to KLBX;
grant EXECUTE                                                                on BARS_XMLKLB_REF to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_xmlklb_ref.sql =========*** End
 PROMPT ===================================================================================== 
 