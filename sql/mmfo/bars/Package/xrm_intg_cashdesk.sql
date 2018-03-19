create or replace package xrm_intg_cashdesk
is
   g_head_version   constant varchar2 (64) := 'version 1.2 12.02.2018';

   --
   -- реализация функционала сервиса функционала сервиса  XRMIntegrationCreateDocuments
   --
   procedure doc_service (p_doctype         in     int,
                          p_requestdata     in     clob,
                          p_result             out clob,
                          p_resultcode         out int,
                          p_resultmessage      out varchar2);
end xrm_intg_cashdesk;
/
create or replace package body xrm_intg_cashdesk
is
   g_body_version   constant varchar2 (64) := 'version 1.2 12.02.2018';

   g_p_name         constant varchar2 (17) := 'xrm_intg_cashdesk';

   g_modcode        constant varchar2 (3) := 'XRM';

   g_type_deposit   constant varchar2 (7) := 'DEPOSIT';

   g_type_card      constant varchar2 (4) := 'CARD';


   type l_req_oper is record
   (
      tt          varchar2 (3),
      cura        number,
      curb        number,
      sum         number,
      sum2        number,
      dk          number,
      contracta   varchar2 (32),
      contractb   varchar2 (32),
      typea       varchar2 (10),
      typeb       varchar2 (10),
      idb         varchar2 (14),
      namb        varchar2 (38),
      nazn        varchar2 (160),
      mfob        varchar2 (6),
      tabn        varchar2 (10),
      vob         number,
      vdat        date
   );

   type l_req_operw is record
   (
      tag     varchar2 (5),
      value   varchar2 (220)
   );

   type l_req_operw_set is table of l_req_operw;

   type l_tt_par is record
   (
      flags   tts.flags%type,
      fli     tts.fli%type,
      flv     tts.flv%type,
      kva     tts.kv%type,
      kvb     tts.kvk%type,
      nlsa    tts.nlsa%type,
      nlsb    tts.nlsb%type,
      mfob    tts.mfob%type,
      sk      tts.sk%type,
      dk      tts.dk%type,
      nazn    tts.nazn%type,
      s       tts.s%type,
      s2      tts.s2%type,
      diga    tabval.dig%type,
      digb    tabval.dig%type,
      lcva    tabval.lcv%type,
      lcvb    tabval.lcv%type
   );



   procedure init
   is
   begin
      null;
   end;

   function get_user_key_id
      return varchar2
   is
      l_key_id   staff$base.tabn%type;
   begin
      select tabn
        into l_key_id
        from staff$base
       where tabn is not null and id = user_id;

      return l_key_id;
   exception
      when no_data_found
      then
         raise_application_error (
            -20000,
            'По користувачу не знайдено ключ для підпису');
   end get_user_key_id;

   procedure crt_doc (p_requestdata in clob, p_result out clob)
   is
      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_analyticlist    dbms_xmldom.domnodelist;
      l_analytic        dbms_xmldom.domnode;

      l_tab             l_req_operw_set := l_req_operw_set ();
      l_rec             l_req_oper;

      l_tt              l_tt_par;

      l_oper            oper%rowtype;
      l_check_operw     number;
      l_clob_data       clob;
      l_buf_ext         varchar2 (444);
      l_buf_int         varchar2 (1024);
      l_domdoc          dbms_xmldom.domdocument;
      l_root_node       dbms_xmldom.domnode;
      l_element_node    dbms_xmldom.domnode;
      l_element_tnode   dbms_xmldom.domnode;
      l_node            dbms_xmldom.domnode;
      l_node2           dbms_xmldom.domnode;
      l_node3           dbms_xmldom.domnode;

      l_rat_o           number;
      l_rat_b           number;
      l_rat_s           number;
      l_kurs            number;

      l_tmp             varchar2(256);
      l_nms_a           accounts.nms%type;
      l_nms_b           accounts.nms%type;
      p_dat             date;
      procedure get_okpo_nam (p_nls    in     varchar2,
                              p_kv     in     number,
                              p_okpo      out customer.okpo%type,
                              p_namb      out customer.nmk%type,
                              p_nms       out accounts.nms%type)
      is
      begin
         select c.okpo, c.nmk, a.nms
           into p_okpo, p_namb, p_nms
           from accounts a, customer c
          where a.rnk = c.rnk and a.kv = p_kv and a.nls = p_nls;
      exception
         when no_data_found
         then
            bars_error.raise_nerror (g_modcode,
                                     'NLS_NOT_FOUND',
                                     '',
                                     p_nls);
      end;

      procedure check_n_get_nls (p_contract   in     varchar2,
                                 p_tt_nls     in     varchar2,
                                 p_type       in     varchar2,
                                 p_side       in     varchar2,
                                 p_nls           out varchar2)
      is
         l_nls    varchar2 (32);
         l_stmt   varchar2 (4000);
      begin
         if p_tt_nls is not null and substr (p_tt_nls, 1, 1) = '#'
         then
            l_stmt := trim (leading '#' from p_tt_nls);

            execute immediate 'select ' || l_stmt || 'from dual' into l_nls;
         elsif p_tt_nls is not null
         then
            l_nls := p_tt_nls;
         end if;

         if p_contract is not null and l_nls is not null
         then
            bars_error.raise_nerror (g_modcode, 'CONTRACT_IS_FILLED_IN_TTS', p_side);
         end if;

         if p_contract is null and l_nls is null
         then
            bars_error.raise_nerror (g_modcode, 'CONTRACT_IS_EMPTY_IN_TTS', p_side);
         end if;

         if p_type is not null and p_type not in (g_type_deposit, g_type_card)
         then
            bars_error.raise_nerror (g_modcode,
                                     'ACC_TYPE_UNDEFINED',
                                     p_side,
                                     p_type);
         end if;

         if p_type = g_type_deposit
         then
            begin
               select nls
                 into l_nls
                 from dpt_deposit d, accounts a
                where deposit_id = xrm_maintenance.add_ru_tail (p_contract) and d.acc = a.acc;
            exception
               when no_data_found
               then
                  bars_error.raise_nerror (g_modcode,
                                           'NLS_NOT_FOUND',
                                           g_type_deposit,
                                           p_contract);
            end;
         elsif p_type = g_type_card
         then
            begin
               select a.nls
                 into l_nls
                 from w4_acc w, accounts a
                where w.nd = xrm_maintenance.add_ru_tail (p_contract) and w.acc_pk = a.acc;
            exception
               when no_data_found
               then
                  bars_error.raise_nerror (g_modcode,
                                           'NLS_NOT_FOUND',
                                           g_type_card,
                                           p_contract);
            end;
         end if;

         if l_nls is not null
         then
            p_nls := l_nls;
         elsif p_contract is not null
         then
            p_nls := p_contract;
         else
            bars_error.raise_nerror (g_modcode,
                                     'NLS_NOT_FOUND',
                                     p_side,
                                     p_contract);
         end if;
      end check_n_get_nls;
   begin
      -- парсим хмл

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, p_requestdata);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      l_analytic := dbms_xmldom.makenode (l_doc);

      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/tt/text()', l_rec.tt);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/currencya/text()', l_rec.cura);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/currencyb/text()', l_rec.curb);
     -- dbms_xslprocessor.valueof (l_analytic, 'root/body/row/dk/text()', l_rec.dk);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/sum/text()', l_rec.sum);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/contracta/text()', l_rec.contracta);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/contractb/text()', l_rec.contractb);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/typea/text()', l_rec.typea);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/typeb/text()', l_rec.typeb);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/idb/text()', l_rec.idb);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/namb/text()', l_rec.namb);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/nazn/text()', l_rec.nazn);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/mfob/text()', l_rec.mfob);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/tabn/text()', l_rec.tabn);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/vob/text()', l_rec.vob);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/vdat/text()', l_tmp);
      l_rec.vdat:=to_date(l_tmp,'dd/mm/yyyy') ;


      l_analyticlist := dbms_xslprocessor.selectnodes (l_analytic, 'root/body/row/op_fields/par');

      for j in 1 .. dbms_xmldom.getlength (l_analyticlist)
      loop
         l_tab.extend;

         l_analytic := dbms_xmldom.item (l_analyticlist, j - 1);

         dbms_xslprocessor.valueof (l_analytic, 'tag/text()', l_tab (l_tab.last).tag);
         dbms_xslprocessor.valueof (l_analytic, 'value/text()', l_tab (l_tab.last).value);
      end loop;

      dbms_xmldom.freedocument (l_doc);


      --можно ли делать ручную операцию по данному тт для данного юзера
      begin
         select t.flags,
                t.fli,
                t.flv,
                t.kv,
                t.kvk,
                t.nlsa,
                t.nlsb,
                t.mfob,
                t.sk,
                t.dk,
                t.nazn,
                t.s,
                t.s2,
                t1.dig,
                t2.dig,
                t1.lcv,
                t2.lcv
           into l_tt
           from tts t,
                staff_tts s,
                tabval t1,
                tabval t2
          where     t.kv = t1.kv(+)
                and t.kvk = t2.kv(+)
                and t.tt = l_rec.tt
                and t.tt = s.tt
                and (flv = 0 or (flv = 1 and substr (t.flags, 12, 1) = '1')) --мультивалютные, по которым курс не принимаеться от пользователя
                and t.fli < 3
                and substr (t.flags, 1, 1) = '1'
                and (   s.id = user_id
                     or s.id in (select id_whom
                                   from staff_substitute
                                  where     id_who = user_id
                                        and date_is_valid (date_start,
                                                           date_finish,
                                                           null,
                                                           null) = 1))
                and decode ( (select nvl (min (to_number (val)), 0)
                                from params
                               where par = 'LOSECURE'),
                            0, nvl (s.approve, 0),
                            1) = 1
                and date_is_valid (s.adate1,
                                   s.adate2,
                                   s.rdate1,
                                   s.rdate2) = 1;
      exception
         when no_data_found
         then
            bars_error.raise_nerror (g_modcode, 'TT_IS_NOT_ALLOWED');
      end;


      -- c xrm всегда приходит дк = 1 соответственно если дк - 0 , то переворачиваеим
      if l_tt.dk=0
      then

      l_tmp:=l_rec.cura;
      l_rec.cura := l_rec.curb;
      l_rec.curb := to_number(l_tmp);

      l_tmp:=l_rec.contracta;
      l_rec.contracta := l_rec.contractb;
      l_rec.contractb := l_tmp;

      l_tmp:=l_rec.typea;
      l_rec.typea := l_rec.typeb;
      l_rec.typeb := l_tmp;
       end if;

      --проверка ключа пользовтеля
      $if $$debug_flag $then
      $else
      if get_user_key_id <> l_rec.tabn
      then
         bars_error.raise_nerror (g_modcode, 'KEY_DOSNT_MATCH');
      end if;
      $end

    /*  --проверка дк
      if l_rec.dk <> l_tt.dk
      then
         bars_error.raise_nerror (g_modcode, 'DK_DOESNT_MATCH_TO_OPER');
      end if;
    */
      --проверяем валюты по настройке операций
      if l_rec.cura <> nvl (l_tt.kva, l_rec.cura) or l_rec.curb <> nvl (l_tt.kvb, l_rec.curb)
      then
         bars_error.raise_nerror (g_modcode, 'CURRENCY_DOESNT_MATCH_TO_OPER');
      end if;

      l_oper.tt := l_rec.tt;
      l_oper.dk := l_tt.dk;
      l_oper.kv := l_rec.cura;
      l_oper.kv2 := l_rec.curb;
      l_oper.sk := l_tt.sk;

      --проверяем vob
      begin
         select vob
           into l_oper.vob
           from tts_vob
          where vob = l_rec.vob and tt = l_rec.tt;
      exception
         when no_data_found
         then
            bars_error.raise_nerror (g_modcode, 'VOB_DOESNT_MATCH_TO_TTS_VOB');
      end;

      --проверяем и подбераем счета
      check_n_get_nls (l_rec.contracta,
                       l_tt.nlsa,
                       l_rec.typea,
                       'A',
                       l_oper.nlsa);
      check_n_get_nls (l_rec.contractb,
                       l_tt.nlsb,
                       l_rec.typeb,
                       'B',
                       l_oper.nlsb);

      --определяем МФОА
      l_oper.mfoa := f_ourmfo;

      --определяем МФОБ
      if l_tt.mfob is not null
      then
         l_oper.mfob := l_tt.mfob;
      elsif l_tt.fli in (0, 2)
      then
         l_oper.mfob := f_ourmfo ();
      elsif l_rec.mfob is not null
      then
         l_oper.mfob := l_rec.mfob;
      else
         bars_error.raise_nerror (g_modcode, 'MFOB_NOT_FOUND');
      end if;

      --подбираем окпоа и нама по счету
      get_okpo_nam (l_oper.nlsa,
                    l_oper.kv,
                    l_oper.id_a,
                    l_oper.nam_a,
                    l_nms_a);

      --определеяем окпоб намб
      if l_oper.mfob = f_ourmfo
      then
         get_okpo_nam (l_oper.nlsb,
                       l_oper.kv2,
                       l_oper.id_b,
                       l_oper.nam_b,
                       l_nms_b);
      elsif l_oper.mfob <> f_ourmfo and l_rec.idb is not null and l_rec.namb is not null
      then
         l_oper.id_b := l_rec.idb;
         l_oper.nam_b := l_rec.namb;
      else
         bars_error.raise_nerror (g_modcode, 'BSIDE_NOT_FOUND');
      end if;

      --проверяем назначение
      if l_rec.nazn is null
      then
         bars_error.raise_nerror (g_modcode, 'PURPOSE_NOT_FOUND');
      else
         l_oper.nazn := l_rec.nazn;
      end if;

      --проверяем наличиее обязатиельных доп реквизитов
      for m in (select *
                  from op_rules
                 where opt = 'M' and used4input = 1 and tt = l_oper.tt)
      loop
         l_check_operw := 0;

         for j in l_tab.first .. l_tab.last
         loop
            if trim(l_tab (j).tag) = trim(m.tag) and l_tab (j).value is not null
            then
               l_check_operw := 1;
               exit;
            end if;
         end loop;

         if l_check_operw = 0
         then
            bars_error.raise_nerror (g_modcode, 'OPERW_NOT_FOUND');
         end if;
      end loop;


      --подсчет сумм по формуле
      if l_tt.s is not null
      then
         l_tt.s := replace (upper (l_tt.s), '#(KVA)', l_oper.kv);
         l_tt.s := replace (upper (l_tt.s), '#(NLSA)', '''' || l_oper.nlsa || '''');
         l_tt.s := replace (upper (l_tt.s), '#(IDA)', '''' || l_oper.id_a || '''');
         l_tt.s := replace (upper (l_tt.s), '#(MFOB)', '''' || l_oper.mfob || '''');
         l_tt.s := replace (upper (l_tt.s), '#(KVB)', l_oper.kv2);
         l_tt.s := replace (upper (l_tt.s), '#(NLSB)', '''' || l_oper.nlsb || '''');
         l_tt.s := replace (upper (l_tt.s), '#(NAMB)', '''' || l_oper.nam_b || '''');
         l_tt.s := replace (upper (l_tt.s), '#(IDB)', '''' || l_oper.id_b || '''');
         l_tt.s := replace (upper (l_tt.s), '#(SK)', '''' || l_oper.sk || '''');
         l_tt.s := replace (upper (l_tt.s), '#(TT)', '''' || l_oper.tt || '''');

         if l_tt.flv = 0
         then
            l_tt.s := replace (upper (l_tt.s), '#(S)', l_rec.sum);
         end if;

         for r in l_tab.first .. l_tab.last
         loop
            l_tt.s :=
               replace (upper (l_tt.s), upper (l_tab (r).tag), '''' || l_tab (r).value || '''');
         end loop;

         if l_tt.s like '%#(%'
         then
            bars_error.raise_nerror (g_modcode, 'PAR_S_NOT_FOUND');
         else
            execute immediate 'select ' || l_tt.s || ' from dual' into l_tt.s;
         end if;
      end if;

      if l_tt.s2 is not null
      then
         l_tt.s2 := replace (upper (l_tt.s2), '#(KVA)', l_oper.kv);
         l_tt.s2 := replace (upper (l_tt.s2), '#(NLSA)', '''' || l_oper.nlsa || '''');
         l_tt.s2 := replace (upper (l_tt.s2), '#(IDA)', '''' || l_oper.id_a || '''');
         l_tt.s2 := replace (upper (l_tt.s2), '#(MFOB)', '''' || l_oper.mfob || '''');
         l_tt.s2 := replace (upper (l_tt.s2), '#(KVB)', l_oper.kv2);
         l_tt.s2 := replace (upper (l_tt.s2), '#(NLSB)', '''' || l_oper.nlsb || '''');
         l_tt.s2 := replace (upper (l_tt.s2), '#(NAMB)', '''' || l_oper.nam_b || '''');
         l_tt.s2 := replace (upper (l_tt.s2), '#(IDB)', '''' || l_oper.id_b || '''');
         l_tt.s2 := replace (upper (l_tt.s2), '#(SK)', '''' || l_oper.sk || '''');
         l_tt.s2 := replace (upper (l_tt.s2), '#(TT)', '''' || l_oper.tt || '''');

         if l_tt.flv = 0
         then
            l_tt.s2 := replace (upper (l_tt.s2), '#(S)', l_rec.sum);
         end if;

         for r in l_tab.first .. l_tab.last
         loop
            l_tt.s2 :=
               replace (upper (l_tt.s2), upper (l_tab (r).tag), '''' || l_tab (r).value || '''');
         end loop;

         if l_tt.s2 like '%#(%'
         then
            bars_error.raise_nerror (g_modcode, 'PAR_S_NOT_FOUND');
         else
            execute immediate 'select ' || l_tt.s2 || ' from dual' into l_tt.s2;
         end if;
      end if;

      --флаг 16 - сумма только расчетная

      if     substr (l_tt.flags, 16, 1) = 1
         and (   (l_tt.flv = 0 and nvl (l_tt.s, 0) <= 0)
              or (l_tt.flv = 1 and (nvl (l_tt.s, 0) <= 0 or nvl (l_tt.s2, 0) <= 0)))
      then
         bars_error.raise_nerror (g_modcode, 'CALCULATED_S_IS_NULL');
      elsif substr (l_tt.flags, 16, 1) = 1 and nvl (l_rec.sum, 0) > 0
      then
         bars_error.raise_nerror (g_modcode, 'S_CAN_NOT_BE_ENTERED');
      elsif substr (l_tt.flags, 16, 1) = 0 and nvl (l_rec.sum, 0) <= 0
      then
         bars_error.raise_nerror (g_modcode, 'SUM_SHOULD_BE_POSITIVE');
      end if;

      --определяем сумму
      l_oper.s := case when nvl (l_rec.sum, 0) > 0 then l_rec.sum else l_tt.s end;

      if l_tt.flv = 0
      then
         l_oper.s2 := case when nvl (l_rec.sum, 0) > 0 then l_rec.sum else l_tt.s2 end;
      elsif l_tt.flv = 1
      then
         --курс
         getxrate (l_rat_o,
                   l_rat_b,
                   l_rat_s,
                   l_oper.kv,
                   l_oper.kv2,
                   gl.bdate);

         if substr (l_tt.flags, 1, 60) = '1' and l_oper.dk in (0, 2)
         then
            l_kurs := l_rat_s;
         elsif substr (l_tt.flags, 1, 60) = '1' and l_oper.dk not in (0, 2)
         then
            l_kurs := l_rat_b;
         else
            l_kurs := l_rat_o;
         end if;

         if nvl (l_kurs, 0) > 0
         then
            l_oper.s2 := case when nvl (l_rec.sum, 0) > 0 then l_rec.sum else l_tt.s2 end;
            l_oper.s2 := l_oper.s2 * l_kurs;
         else
            bars_error.raise_nerror (g_modcode, 'EX_RATES_IS_NULL');
         end if;
      end if;


      --проверяем дату валютирования
      if (l_rec.vdat<>trunc(sysdate) and substr(l_tt.flags,6,1)=1) or (l_rec.vdat> trunc(sysdate+10)) --+10 дней -- решили на встрече оО
        then
           bars_error.raise_nerror (g_modcode, 'VDAT_NOT_CORRECT');
      else
         l_oper.vdat:=l_rec.vdat;
      end if;
      p_dat:= sysdate;
      --создаем док
      gl.ref (l_oper.ref);

      gl.in_doc3 (ref_     => l_oper.ref,
                  tt_      => l_oper.tt,
                  vob_     => l_oper.vob,
                  nd_      => substr (l_oper.ref, 1, 10),
                  pdat_    => p_dat,
                  vdat_    => l_oper.vdat,
                  dk_      => l_oper.dk,
                  kv_      => l_oper.kv,
                  s_       => l_oper.s,
                  kv2_     => l_oper.kv2,
                  s2_      => l_oper.s2,
                  sk_      => l_oper.sk,
                  data_    => gl.bdate,
                  datp_    => gl.bdate,
                  nam_a_   => substr (l_oper.nam_a, 1, 38),
                  nlsa_    => l_oper.nlsa,
                  mfoa_    => l_oper.mfoa,
                  nam_b_   => substr (l_oper.nam_b, 1, 38),
                  nlsb_    => l_oper.nlsb,
                  mfob_    => l_oper.mfob,
                  nazn_    => substr (l_oper.nazn, 1, 160),
                  d_rec_   => null,
                  id_a_    => l_oper.id_a,
                  id_b_    => l_oper.id_b,
                  id_o_    => null,
                  sign_    => null,
                  sos_     => 1,
                  prty_    => null,
                  uid_     => null);


      --вставка доп реквизитов
      forall k in l_tab.first .. l_tab.last
         insert into operw
              values (l_oper.ref,
                      l_tab (k).tag,
                      l_tab (k).value,
                      f_ourmfo);

      -- получаем буферы
      chk.make_int_docbuf (l_oper.ref, l_buf_int);

      if l_tt.fli in (1, 2)
      then
         docsign.retrievesepbuffer (l_oper.ref, l_rec.tabn, l_buf_ext);
      else
         l_buf_ext := null;
      end if;

      --формируем ответ
      l_domdoc := dbms_xmldom.newdomdocument;
      l_root_node := dbms_xmldom.makenode (l_domdoc);
      l_node :=
         dbms_xmldom.appendchild (
            l_root_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'root')));
      l_node2 :=
         dbms_xmldom.appendchild (
            l_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'body')));
      l_node3 :=
         dbms_xmldom.appendchild (
            l_node2,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));

      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'ref')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, xrm_maintenance.cut_off_ru_tail (l_oper.ref))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nd')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, substr (l_oper.ref, 1, 10))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'docbufin')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_buf_int)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'docbufsep')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_buf_ext)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsa')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nlsa)));
----b
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nms_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_nms_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'id_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.id_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nam_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nam_a)));
----e
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nlsb)));
----b
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nms_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_nms_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'id_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.id_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nam_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nam_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'mfob')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.mfob)));
----e
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'suma')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.s)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sumb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.s2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'cura')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.kv)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'curb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.kv2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'vdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, to_char (l_oper.vdat, 'DD/MM/YYYY'))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'pdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, to_char (p_dat, 'DD/MM/YYYY'))));

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_xmldom.writetoclob (l_domdoc, l_clob_data);
      dbms_xmldom.freedocument (l_domdoc);

      --пакуем ответ
      p_result := xrm_maintenance.packing (l_clob_data);
   end;

   procedure pay_doc (p_requestdata in clob, p_result out clob)
   is
      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_analyticlist    dbms_xmldom.domnodelist;
      l_analytic        dbms_xmldom.domnode;

      l_oper            oper%rowtype;
      l_tts             tts%rowtype;
      l_signin          sgn_data.sign_hex%type;
      l_signsep         sgn_data.sign_hex%type;
      l_tabn            staff$base.tabn%type;
      l_rec_id          oper_visa.sqnc%type;
      l_sos             number;
      l_domdoc          dbms_xmldom.domdocument;
      l_root_node       dbms_xmldom.domnode;
      l_element_node    dbms_xmldom.domnode;
      l_element_tnode   dbms_xmldom.domnode;
      l_node            dbms_xmldom.domnode;
      l_node2           dbms_xmldom.domnode;
      l_node3           dbms_xmldom.domnode;
      l_node4           dbms_xmldom.domnode;
      l_node5           dbms_xmldom.domnode;
      l_node6           dbms_xmldom.domnode;
      l_node7           dbms_xmldom.domnode;


      l_clob_data       clob;

      type l_opldok is table of opl%rowtype;

      l_tab_opl         l_opldok := l_opldok ();

      l_branch          varchar2(256);
   begin
      -- парсим хмл
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, p_requestdata);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      l_analytic := dbms_xmldom.makenode (l_doc);

      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/ref/text()', l_oper.ref);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/docsignin/text()', l_signin);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/docsignsep/text()', l_signsep);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/row/tabn/text()', l_tabn);

      dbms_xmldom.freedocument (l_doc);

      l_oper.ref := xrm_maintenance.add_ru_tail (l_oper.ref);

      --проверка ключа пользовтеля
      $if $$debug_flag $then
      $else
      if get_user_key_id <> l_tabn
      then
         bars_error.raise_nerror (g_modcode, 'KEY_DOSNT_MATCH');
      end if;
      $end

      select *
        into l_oper
        from oper
       where ref = l_oper.ref;

      select *
        into l_tts
        from tts
       where tt = l_oper.tt;


      if l_tts.fli = 1 and substr (l_tts.flags, 1, 38) = 1
      then
         bars_error.raise_nerror (g_modcode, 'SEP_FACT_PAYMENT_IS_NOT_ALLOWED');
      end if;

      gl.dyntt2 (l_sos,
                 0,
                 null,
                 l_oper.ref,
                 l_oper.vdat,
                 l_oper.vdat,
                 l_oper.tt,
                 l_oper.dk,
                 l_oper.kv,
                 l_oper.mfoa,
                 l_oper.nlsa,
                 l_oper.s,
                 l_oper.kv,
                 l_oper.mfob,
                 l_oper.nlsb,
                 l_oper.s2,
                 null,
                 null);

      if substr (l_tts.flags, 1, 38) = 1
      then
         gl.pay (2, l_oper.ref, gl.bdate);
      end if;

      chk.put_visa_out (l_oper.ref,
                        l_oper.tt,
                        null,
                        0,
                        null,
                        null,
                        null,
                        l_rec_id);

      sgn_mgr.store_int_sign (p_ref         => l_oper.ref,
                              p_rec_id      => l_rec_id,
                              p_sign_type   => 'VG2',
                              p_key_id      => l_tabn,
                              p_sign_hex    => l_signin);

      if l_tts.fli in (1, 2)
      then
         sgn_mgr.store_sep_sign (p_ref         => l_oper.ref,
                                 p_sign_type   => 'VG2',
                                 p_key_id      => l_tabn,
                                 p_sign_hex    => l_signsep);
      end if;


      select *
        into l_oper
        from oper
       where ref = l_oper.ref;



      select *
        bulk collect into l_tab_opl
        from opl
       where ref = l_oper.ref;


      --формируем ответ
      l_domdoc := dbms_xmldom.newdomdocument;
      l_root_node := dbms_xmldom.makenode (l_domdoc);
      l_node :=
         dbms_xmldom.appendchild (
            l_root_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'root')));
      l_node2 :=
         dbms_xmldom.appendchild (
            l_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'body')));
      l_node3 :=
         dbms_xmldom.appendchild (
            l_node2,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));

      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'ref')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, xrm_maintenance.cut_off_ru_tail (l_oper.ref))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nd')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nd)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsa')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nlsa)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nlsb)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'suma')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.s)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sumb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.s2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'cura')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.kv)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'curb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.kv2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'vdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, to_char (l_oper.vdat, 'DD/MM/YYYY'))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'pdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, to_char (l_oper.pdat, 'DD/MM/YYYY'))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,l_oper.sos)));

      l_node4 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'acc_model')));

    if l_tab_opl.COUNT  >0 then         
 
      for j in l_tab_opl.first .. l_tab_opl.last
      loop
         l_node5 :=
            dbms_xmldom.appendchild (
               l_node4,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'tt')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).tt)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'dk')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).dk)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nls')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).nls)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sum')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).s)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sumeq')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).sq)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).sos)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'fdat')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (l_domdoc, to_char (l_tab_opl (j).fdat, 'DD/MM/YYYY'))));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'kv')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).kv)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsname')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_tab_opl (j).nms)));
      end loop;
     end if;
      l_node6 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'visas')));

      for t in (select counter,
               mark,
               checkgroup_id,
               checkgroup,
               username,
               dat
               from v_visalist_xrm
               where ref = l_oper.ref
               order by counter)
      loop

      l_node7 :=
            dbms_xmldom.appendchild (
               l_node6,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
      l_element_node :=
            dbms_xmldom.appendchild (
               l_node7,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchk')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup_id)));
      l_element_node :=
            dbms_xmldom.appendchild (
               l_node7,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchkname')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup)));
      l_element_node :=
            dbms_xmldom.appendchild (
               l_node7,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'username')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.username)));
      l_element_node :=
            dbms_xmldom.appendchild (
               l_node7,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'status')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.mark)));
      l_element_node :=
            dbms_xmldom.appendchild (
               l_node7,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'date')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, to_char (t.dat, 'DD/MM/YYYY HH24:MI:SS'))));
      l_element_node :=
            dbms_xmldom.appendchild (
               l_node7,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'order')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.counter)));
      end loop;

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_xmldom.writetoclob (l_domdoc, l_clob_data);
      dbms_xmldom.freedocument (l_domdoc);

      --пакуем ответ
      p_result := xrm_maintenance.packing (l_clob_data);
   end pay_doc;

   procedure get_docs_for_visa (p_requestdata in clob, p_result out clob)
   is
      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_analyticlist    dbms_xmldom.domnodelist;
      l_analytic        dbms_xmldom.domnode;
      l_domdoc          dbms_xmldom.domdocument;
      l_root_node       dbms_xmldom.domnode;
      l_element_node    dbms_xmldom.domnode;
      l_element_tnode   dbms_xmldom.domnode;
      l_node            dbms_xmldom.domnode;
      l_node2           dbms_xmldom.domnode;
      l_node3           dbms_xmldom.domnode;
      l_node5           dbms_xmldom.domnode;
      l_clob_data       clob;
      l_buf_ext         varchar2 (444);
      l_buf_int         varchar2 (1024);
      l_tabn            staff$base.tabn%type;

/*      type t_num_array is table of number
         index by binary_integer;

      l_refs            t_num_array;*/

      type t_num_array is record
       (
          ref     oper.ref%type,
          fli     tts.fli%type,
          sos     oper.sos%type
       );
      type t_refs is table of t_num_array;
      l_refs         t_refs := t_refs ();



      l_idchk           chklist.idchk%type;
      l_grp             chklist.idchk_hex%type;
   begin
      -- парсим хмл
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, p_requestdata);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      l_analytic := dbms_xmldom.makenode (l_doc);

      dbms_xslprocessor.valueof (l_analytic, 'root/body/idchk/text()', l_idchk);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/tabn/text()', l_tabn);

      dbms_xmldom.freedocument (l_doc);


      begin
         select c.idchk_hex
           into l_grp
           from staff_chk s, chklist c
          where s.chkid = l_idchk and s.id = user_id and s.chkid = c.idchk;
      exception
         when no_data_found
         then
            bars_error.raise_nerror (g_modcode, 'VISA_IS_NOT_ALLOWED_FOR_USER');
      end;

      select o.ref, t.fli, o.sos
        bulk collect into l_refs
        from oper o, ref_que r, tts t
       where o.ref = r.ref
         and o.tt  = t.tt
         and o.sos >= 0
         and o.sos < 5
         and (   (o.nextvisagrp = chk.get_selfvisa_grp_hex () and o.userid = getcurrentuserid)
              or (    o.nextvisagrp <> chk.get_selfvisa_grp_hex ()
                  and o.branch like sys_context ('bars_context', 'user_branch_mask')))
         and o.nextvisagrp = l_grp;


      --формируем ответ
      l_domdoc := dbms_xmldom.newdomdocument;
      l_root_node := dbms_xmldom.makenode (l_domdoc);
      l_node :=
         dbms_xmldom.appendchild (
            l_root_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'root')));
      l_node2 :=
         dbms_xmldom.appendchild (
            l_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'body')));

      if l_refs.count > 0
      then
         for j in l_refs.first .. l_refs.last
         loop
            l_node3 :=
               dbms_xmldom.appendchild (
                  l_node2,
                  dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
            l_element_node :=
               dbms_xmldom.appendchild (
                  l_node3,
                  dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'ref')));
            l_element_tnode :=
               dbms_xmldom.appendchild (
                  l_element_node,
                  dbms_xmldom.makenode (
                     dbms_xmldom.createtextnode (l_domdoc,
                                                 xrm_maintenance.cut_off_ru_tail (l_refs (j).ref))));
            l_element_node :=
               dbms_xmldom.appendchild (
                  l_node3,
                  dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
            l_element_tnode :=
               dbms_xmldom.appendchild (
                  l_element_node,
                  dbms_xmldom.makenode (
                     dbms_xmldom.createtextnode (l_domdoc,l_refs (j).sos)));

                   -- получаем буферы
          chk.make_int_docbuf (l_refs (j).ref, l_buf_int);

          if l_refs (j).fli in (1, 2)
          then
             docsign.retrievesepbuffer (l_refs (j).ref, l_tabn, l_buf_ext);
          else
             l_buf_ext := null;
          end if;

            l_element_node :=
               dbms_xmldom.appendchild (
                  l_node3,
                  dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'docbufin')));
            l_element_tnode :=
               dbms_xmldom.appendchild (
                  l_element_node,
                  dbms_xmldom.makenode (
                     dbms_xmldom.createtextnode (l_domdoc,l_buf_int)));
            l_element_node :=
               dbms_xmldom.appendchild (
                  l_node3,
                  dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'docbufsep')));
            l_element_tnode :=
               dbms_xmldom.appendchild (
                  l_element_node,
                  dbms_xmldom.makenode (
                     dbms_xmldom.createtextnode (l_domdoc,l_buf_ext)));
         end loop;
      end if;

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_xmldom.writetoclob (l_domdoc, l_clob_data);
      dbms_xmldom.freedocument (l_domdoc);

      --пакуем ответ
      p_result := xrm_maintenance.packing (l_clob_data);
   end get_docs_for_visa;

   procedure set_visas (p_requestdata in clob, p_type in number, p_result out clob)
   is
      /*
      логика пенесена из вєба
      1.парсим реквест
      2.формируем хмл для chk.make_data4visa_ext_xml
      3.парсим ответ процедуры
      4.формируем хмл для chk.put_visas_xml_ext;
      5.парсим ответ
      6.формируем респонс.
      */
      l_parser                dbms_xmlparser.parser;
      l_doc                   dbms_xmldom.domdocument;
      l_analyticlist          dbms_xmldom.domnodelist;
      l_analytic              dbms_xmldom.domnode;
      l_domdoc                dbms_xmldom.domdocument;
      l_root_node             dbms_xmldom.domnode;
      l_element_node          dbms_xmldom.domnode;
      l_element_tnode         dbms_xmldom.domnode;
      l_node                  dbms_xmldom.domnode;
      l_node2                 dbms_xmldom.domnode;
      l_node3                 dbms_xmldom.domnode;
      l_node6                 dbms_xmldom.domnode;
      l_node7                 dbms_xmldom.domnode;

      l_clob_data             clob;
      l_clob_data2            clob;

      type t_num_array is table of number
         index by binary_integer;

      l_refs                  t_num_array;

      l_idchk                 chklist.idchk%type;
      l_tabn                  staff$base.tabn%type;
      l_par                   number;


      type l_rec is record
      (
         ref              number,
         err              number,
         erm              varchar2 (4000),
         int_buffer_hex   varchar2 (4000),
         ext_buffer_hex   varchar2 (4000),
         int_sign_hex     varchar2 (4000),
         ext_sign_hex     varchar2 (4000)
      );

      type l_tab is table of l_rec;

      l_docs                  l_tab := l_tab ();
      l_docs_answers          l_tab := l_tab ();
      l_docs_answers_to_xrm   l_tab := l_tab ();

      l_xmlrootelement        dbms_xmldom.domelement;
      l_xmldocnodes           dbms_xmldom.domnodelist;
      l_xmldocnode            dbms_xmldom.domnode;
      l_xmldocelement         dbms_xmldom.domelement;

      l_xmlbufsnode           dbms_xmldom.domnode;
      l_xmlbufselement        dbms_xmldom.domelement;
      l_xmlecpnode            dbms_xmldom.domnode;
      l_xmlecpelement         dbms_xmldom.domelement;
      l_xmlbufsextnode        dbms_xmldom.domnode;
      l_xmlbufsextelement     dbms_xmldom.domelement;
      l_xmlecpextnode         dbms_xmldom.domnode;
      l_xmlecpextelement      dbms_xmldom.domelement;


      l_err_cnt               number := 0;
      l_sos                   oper.sos%type;
   begin
      -- парсим хмл
      l_parser := dbms_xmlparser.newparser;

      dbms_xmlparser.parseclob (l_parser, p_requestdata);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      l_analytic := dbms_xmldom.makenode (l_doc);

      dbms_xslprocessor.valueof (l_analytic, 'root/body/idchk/text()', l_idchk);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/tabn/text()', l_tabn);
      dbms_xslprocessor.valueof (l_analytic, 'root/body/par/text()', l_par);


      l_analyticlist := dbms_xslprocessor.selectnodes (l_analytic, 'root/body/docs/row');

      for j in 1 .. dbms_xmldom.getlength (l_analyticlist)
      loop
         l_analytic := dbms_xmldom.item (l_analyticlist, j - 1);

         dbms_xslprocessor.valueof (l_analytic, 'ref/text()', l_refs (j));
      end loop;

      dbms_xmldom.freedocument (l_doc);

       --проверка ключа пользовтеля
      $if $$debug_flag $then
      $else
      if get_user_key_id <> l_tabn
      then
         bars_error.raise_nerror (g_modcode, 'KEY_DOSNT_MATCH');
      end if;
      $end


      -- есть ли документы
      if l_refs.count = 0
      then
         bars_error.raise_nerror (g_modcode, 'REF_NOT_FOUND');
      end if;


      dbms_lob.createtemporary (l_clob_data, false);
      dbms_lob.append (l_clob_data, '<?xml version="1.0" encoding="utf-8" ?>');
      dbms_lob.append (l_clob_data,
                       '<docs4visa grpid="' || l_idchk || '" key="" key_hash="" sign_type="VG2">');

      for k in l_refs.first .. l_refs.last
      loop
         dbms_lob.append (l_clob_data,
                          '<doc ref="' || xrm_maintenance.add_ru_tail (l_refs (k)) || '" />');
      end loop;

      dbms_lob.append (l_clob_data, '</docs4visa>');


      chk.make_data4visa_ext_xml (l_clob_data, l_clob_data);


      l_parser := dbms_xmlparser.newparser;

      -- загружаем xml из clob
      dbms_xmlparser.parseclob (l_parser, l_clob_data);
      l_doc := dbms_xmlparser.getdocument (l_parser);

      -- перебираем все документы
      l_xmldocnodes := dbms_xmldom.getelementsbytagname (l_doc, 'doc');


      for i in 1 .. dbms_xmldom.getlength (l_xmldocnodes)
      loop
         l_xmldocnode := dbms_xmldom.item (l_xmldocnodes, i - 1);
         l_xmldocelement := dbms_xmldom.makeelement (l_xmldocnode);

         l_docs.extend;

         l_docs (l_docs.last).ref := to_number (dbms_xmldom.getattribute (l_xmldocelement, 'ref'));
         l_docs (l_docs.last).err := dbms_xmldom.getattribute (l_xmldocelement, 'err');
         l_docs (l_docs.last).erm := dbms_xmldom.getattribute (l_xmldocelement, 'erm');


         l_xmlbufsnode :=
            dbms_xmldom.item (dbms_xmldom.getelementsbytagname (l_xmldocelement, 'int_ecp'), 0);
         l_xmlbufselement := dbms_xmldom.makeelement (l_xmlbufsnode);
         l_docs (l_docs.last).int_buffer_hex :=
            dbms_xmldom.getattribute (l_xmlbufselement, 'int_buffer_hex');

         l_xmlecpnode :=
            dbms_xmldom.item (dbms_xmldom.getelementsbytagname (l_xmlbufselement, 'ecp'), 0);
         l_xmlecpelement := dbms_xmldom.makeelement (l_xmlecpnode);
         l_docs (l_docs.last).int_sign_hex := dbms_xmldom.getattribute (l_xmlecpelement, 'sign_hex');

         l_xmlbufsextnode :=
            dbms_xmldom.item (dbms_xmldom.getelementsbytagname (l_xmldocelement, 'ext_ecp'), 0);
         l_xmlbufsextelement := dbms_xmldom.makeelement (l_xmlbufsextnode);
         l_docs (l_docs.last).ext_buffer_hex :=
            dbms_xmldom.getattribute (l_xmlbufsextelement, 'ext_buffer_hex');

         l_xmlecpextnode :=
            dbms_xmldom.item (dbms_xmldom.getelementsbytagname (l_xmlbufsextelement, 'ecp'), 0);
         l_xmlecpextelement := dbms_xmldom.makeelement (l_xmlecpextnode);
         l_docs (l_docs.last).ext_sign_hex :=
            dbms_xmldom.getattribute (l_xmlecpextelement, 'sign_hex');
      end loop;

      dbms_xmlparser.freeparser (l_parser);
      dbms_xmldom.freedocument (l_doc);


      if p_type = 4
      then
         l_par := 0;
      elsif p_type = 7
      then
         l_par := -1;
      end if;

      dbms_lob.createtemporary (l_clob_data2, false);
      dbms_lob.append (l_clob_data2, '<?xml version="1.0" encoding="utf-8" ?>');
      dbms_lob.append (l_clob_data2, '<docs4visa grpid="' || l_idchk || '" par="' || l_par || '">');

      for k in l_docs.first .. l_docs.last
      loop
         if nvl (l_docs (k).err, 0) = 0
         then
            dbms_lob.append (
               l_clob_data2,
               '<doc ref="' || l_docs (k).ref || '" key_id="' || l_tabn || '" sign_type="VG2">');
            dbms_lob.append (
               l_clob_data2,
                  '<bufs inner_buf="'
               || l_docs (k).int_buffer_hex
               || '" outer_buf="'
               || l_docs (k).ext_buffer_hex
               || '" />');
            dbms_lob.append (
               l_clob_data2,
                  '<ecps inner_ecp="'
               || l_docs (k).int_sign_hex
               || '" outer_ecp="'
               || l_docs (k).ext_sign_hex
               || '" />');
            dbms_lob.append (l_clob_data2, '</doc>');
         else
            l_err_cnt := l_err_cnt + 1;
            l_docs_answers_to_xrm.extend;
            l_docs_answers_to_xrm (l_docs_answers_to_xrm.last).ref := l_docs (k).ref;
            l_docs_answers_to_xrm (l_docs_answers_to_xrm.last).err := nvl (l_docs (k).err, 0);
            l_docs_answers_to_xrm (l_docs_answers_to_xrm.last).erm := l_docs (k).erm;
         end if;
      end loop;

      dbms_lob.append (l_clob_data2, '</docs4visa>');


      if l_docs.count <> l_err_cnt
      then
         chk.put_visas_xml_ext (l_clob_data2, l_clob_data2);
         l_parser := dbms_xmlparser.newparser;

         -- загружаем xml из clob
         dbms_xmlparser.parseclob (l_parser, l_clob_data2);
         l_doc := dbms_xmlparser.getdocument (l_parser);

         -- перебираем все документы
         l_xmldocnodes := dbms_xmldom.getelementsbytagname (l_doc, 'doc');

         for i in 1 .. dbms_xmldom.getlength (l_xmldocnodes)
         loop
            l_xmldocnode := dbms_xmldom.item (l_xmldocnodes, i - 1);
            l_xmldocelement := dbms_xmldom.makeelement (l_xmldocnode);

            l_docs_answers_to_xrm.extend;
            l_docs_answers_to_xrm (l_docs_answers_to_xrm.last).ref :=
               to_number (dbms_xmldom.getattribute (l_xmldocelement, 'ref'));
            l_docs_answers_to_xrm (l_docs_answers_to_xrm.last).err :=
               dbms_xmldom.getattribute (l_xmldocelement, 'err');
            l_docs_answers_to_xrm (l_docs_answers_to_xrm.last).erm :=
               dbms_xmldom.getattribute (l_xmldocelement, 'erm');
         end loop;
      end if;

      dbms_xmlparser.freeparser (l_parser);
      dbms_xmldom.freedocument (l_doc);



      --формируем ответ
      l_domdoc := dbms_xmldom.newdomdocument;
      l_root_node := dbms_xmldom.makenode (l_domdoc);
      l_node :=
         dbms_xmldom.appendchild (
            l_root_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'root')));
      l_node2 :=
         dbms_xmldom.appendchild (
            l_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'body')));


      for j in l_docs_answers_to_xrm.first .. l_docs_answers_to_xrm.last
      loop
         l_node3 :=
            dbms_xmldom.appendchild (
               l_node2,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node3,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'ref')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (
                     l_domdoc,
                     xrm_maintenance.cut_off_ru_tail (l_docs_answers_to_xrm (j).ref))));
                     
      select  o.sos
        into l_sos
        from oper o
       where o.ref = l_docs_answers_to_xrm (j).ref;
       
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node3,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (
                     l_domdoc,l_sos)));                                     
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node3,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'resultcode')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (
                     l_domdoc,
                     case when nvl (l_docs_answers_to_xrm (j).err, 0) = 0 then 0 else -1 end)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node3,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'resultmessage')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (
                     l_domdoc,
                     case
                        when nvl (l_docs_answers_to_xrm (j).err, 0) = 0 then null
                        else substr (l_docs_answers_to_xrm (j).erm, 1, 1000)
                     end)));

       l_node6 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'visas')));

         for t in (select counter,
               mark,
               checkgroup_id, 
               checkgroup,
               username,
               dat
               from v_visalist_xrm
               where ref = l_docs_answers_to_xrm (j).ref
               order by counter)
              loop

              l_node7 :=
                    dbms_xmldom.appendchild (
                       l_node6,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchk')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup_id)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchkname')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'username')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.username)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'status')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.mark)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'date')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, to_char (t.dat, 'DD/MM/YYYY HH24:MI:SS'))));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'order')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.counter)));
              end loop;
      end loop;


      dbms_lob.createtemporary (l_clob_data, false);
      dbms_xmldom.writetoclob (l_domdoc, l_clob_data);
      dbms_xmldom.freedocument (l_domdoc);

      --пакуем ответ
      p_result := xrm_maintenance.packing (l_clob_data);
   end set_visas;

   procedure get_doc_old (p_requestdata in clob, p_result out clob)
   is
      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_analyticlist    dbms_xmldom.domnodelist;
      l_analytic        dbms_xmldom.domnode;

      l_oper            oper%rowtype;

      l_domdoc          dbms_xmldom.domdocument;
      l_root_node       dbms_xmldom.domnode;
      l_element_node    dbms_xmldom.domnode;
      l_element_tnode   dbms_xmldom.domnode;
      l_node            dbms_xmldom.domnode;
      l_node2           dbms_xmldom.domnode;
      l_node3           dbms_xmldom.domnode;
      l_node4           dbms_xmldom.domnode;
      l_node5           dbms_xmldom.domnode;
      l_node6           dbms_xmldom.domnode;
      l_node7           dbms_xmldom.domnode;

      l_clob_data       clob;

   begin

            --формируем ответ
      l_domdoc := dbms_xmldom.newdomdocument;
      l_root_node := dbms_xmldom.makenode (l_domdoc);
      l_node :=
         dbms_xmldom.appendchild (
            l_root_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'root')));
      l_node2 :=
         dbms_xmldom.appendchild (
            l_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'body')));

      -- парсим хмл
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, p_requestdata);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      l_analytic := dbms_xmldom.makenode (l_doc);

      l_analyticlist := dbms_xslprocessor.selectnodes (l_analytic, 'root/body/ref');

      for p in 1 .. dbms_xmldom.getlength (l_analyticlist)
      loop
         l_analytic := dbms_xmldom.item (l_analyticlist, p - 1);

         dbms_xslprocessor.valueof (l_analytic, 'text()', l_oper.ref);


      l_oper.ref := xrm_maintenance.add_ru_tail (l_oper.ref);


      select *
        into l_oper
        from oper
       where ref = l_oper.ref;

      l_node3 :=
         dbms_xmldom.appendchild (
            l_node2,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));

      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'ref')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, xrm_maintenance.cut_off_ru_tail (l_oper.ref))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nd')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nd)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsa')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nlsa)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.nlsb)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'suma')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.s)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sumb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.s2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'cura')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.kv)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'curb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, l_oper.kv2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'vdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, to_char (l_oper.vdat, 'DD/MM/YYYY'))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'pdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, to_char (l_oper.pdat, 'DD/MM/YYYY HH24:MI:SS'))));
       l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'odat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, to_char (l_oper.odat, 'DD/MM/YYYY'))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,l_oper.sos)));

      l_node4 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'acc_model')));



      for j in (select * from opl
                where ref = l_oper.ref )
      loop
         l_node5 :=
            dbms_xmldom.appendchild (
               l_node4,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'tt')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, j.tt)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'dk')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, j.dk)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nls')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, j.nls)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sum')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, j.s)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sumeq')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, j.sq)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (l_domdoc, j.sos)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'fdat')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (
                  dbms_xmldom.createtextnode (l_domdoc, to_char (j.fdat, 'DD/MM/YYYY'))));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'kv')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, j.kv)));
         l_element_node :=
            dbms_xmldom.appendchild (
               l_node5,
               dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsname')));
         l_element_tnode :=
            dbms_xmldom.appendchild (
               l_element_node,
               dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, j.nms)));


      end loop;

         l_node6 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'visas')));

        for t in (select counter,
               mark,
               checkgroup_id,
               checkgroup,
               username,
               dat
               from v_visalist_xrm
               where ref =  l_oper.ref
               order by counter)
              loop

              l_node7 :=
                    dbms_xmldom.appendchild (
                       l_node6,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchk')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup_id)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchkname')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'username')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.username)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'status')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.mark)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'date')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, to_char (t.dat, 'DD/MM/YYYY HH24:MI:SS'))));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'order')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.counter)));
              end loop;

      l_oper:=null;

     end loop;

      dbms_xmldom.freedocument (l_doc);

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_xmldom.writetoclob (l_domdoc, l_clob_data);
      dbms_xmldom.freedocument (l_domdoc);

      --пакуем ответ
      p_result := xrm_maintenance.packing (l_clob_data);
   end;

   procedure get_doc (p_requestdata in clob, p_result out clob)
   is
      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_analyticlist    dbms_xmldom.domnodelist;
      l_analytic        dbms_xmldom.domnode;

      l_domdoc          dbms_xmldom.domdocument;
      l_root_node       dbms_xmldom.domnode;
      l_element_node    dbms_xmldom.domnode;
      l_element_tnode   dbms_xmldom.domnode;
      l_node            dbms_xmldom.domnode;
      l_node2           dbms_xmldom.domnode;
      l_node3           dbms_xmldom.domnode;
      l_node4           dbms_xmldom.domnode;
      l_node5           dbms_xmldom.domnode;
      l_node6           dbms_xmldom.domnode;
      l_node7           dbms_xmldom.domnode;
      l_node8           dbms_xmldom.domnode;
      l_node9           dbms_xmldom.domnode;

      l_ref             oper.ref%type;

      l_clob_data       clob;

   begin

     --формируем ответ
      l_domdoc := dbms_xmldom.newdomdocument;
      l_root_node := dbms_xmldom.makenode (l_domdoc);
      l_node :=
         dbms_xmldom.appendchild (
            l_root_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'root')));

      -- парсим хмл
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, p_requestdata);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      l_analytic := dbms_xmldom.makenode (l_doc);

      l_analyticlist := dbms_xslprocessor.selectnodes (l_analytic, 'root/body/ref');

    for p in 1 .. dbms_xmldom.getlength (l_analyticlist)
    loop
         l_analytic := dbms_xmldom.item (l_analyticlist, p - 1);

         dbms_xslprocessor.valueof (l_analytic, 'text()', l_ref);
      l_ref := xrm_maintenance.add_ru_tail (l_ref);
     for c in (select a.ref as ref,
                   a.tt as tt,
                   a.userid as userid,
                   a.nd as nd,
                   a.mfoa as mfoa,
                   a.nlsa as nlsa,
                   a.id_a as id_a,
                   a.nam_a as nam_a,
                   a.s as s,
                   a.lcv as lcv,
                   to_char (a.vdat, 'dd/mm/yyyy') as vdat,
                   a.s2 as s2,
                   a.lcv2 as lcv2,
                   a.mfob as mfob,
                   a.nlsb as nlsb,
                   a.id_b as id_b,
                   a.nam_b as nam_b,
                   a.dk as dk,
                   a.sk as sk,
                   to_char (a.datd, 'dd/mm/yyyy') as datd,
                   a.nazn as nazn,
                   a.tobo as tobo,
                   a.sos as sos,
                   aa.nms  nms_a,
                   ab.nms  nms_b,
                   a.VOB,
                   to_char (a.pdat, 'dd/mm/yyyy') as pdat,
                   to_char (a.odat, 'dd/mm/yyyy') as odat
              from v_docs_tobo_out a,
                   accounts aa,
                   accounts ab
             where a.REF=l_ref
               and a.NLSA = aa.nls
               and a.NLSB = ab.nls    )
      loop

      l_node3 :=
         dbms_xmldom.appendchild (
            l_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));

      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'ref')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, xrm_maintenance.cut_off_ru_tail (c.ref))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'userid')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.userid)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nd')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.nd)));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'mfoa')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.mfoa)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsa')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.nlsa)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 's')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.s)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'lcv')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.lcv)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'vdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc,  c.vdat)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 's2')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.s2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'lcv2')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.lcv2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'mfob')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, c.mfob)));
       l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, c.nlsb)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'dk')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.dk)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sk')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.sk)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'datd')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.datd)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nazn')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nazn)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'tt')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.tt)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'tobo')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.tobo)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'id_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.id_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nam_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nam_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'id_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.id_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nam_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nam_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.sos)));

       l_node6 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'visas')));

        for t in (select counter,
               mark,
               checkgroup_id,
               checkgroup,
               username,
               dat
               from v_visalist_xrm
               where ref =  c.ref
               order by counter)
              loop

              l_node7 :=
                    dbms_xmldom.appendchild (
                       l_node6,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchk')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup_id)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchkname')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'username')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.username)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'status')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.mark)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'date')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, to_char (t.dat, 'DD/MM/YYYY HH24:MI:SS'))));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'order')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.counter)));
              end loop;

---b
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nms_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nms_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nms_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nms_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'vob')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.vob)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'pdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.pdat)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'odat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.odat)));

       l_node8 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'operw')));
        for t in (select tag ,
                         value
               from operw o
               where o.ref =  c.ref
                 and o.value is not null)
        loop
              l_node9 :=
                    dbms_xmldom.appendchild (
                       l_node8,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node9,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, t.tag)));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.value)));
        end loop;
      end loop;
---e

    end loop;

      dbms_xmldom.freedocument (l_doc);

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_xmldom.writetoclob (l_domdoc, l_clob_data);
      dbms_xmldom.freedocument (l_domdoc);

      --пакуем ответ
      p_result := xrm_maintenance.packing (l_clob_data);
   end;

   procedure get_docs (p_requestdata in clob, p_result out clob)
   is
      l_parser          dbms_xmlparser.parser;
      l_doc             dbms_xmldom.domdocument;
      l_analyticlist    dbms_xmldom.domnodelist;
      l_analytic        dbms_xmldom.domnode;

      l_domdoc          dbms_xmldom.domdocument;
      l_root_node       dbms_xmldom.domnode;
      l_element_node    dbms_xmldom.domnode;
      l_element_tnode   dbms_xmldom.domnode;
      l_node            dbms_xmldom.domnode;
      l_node2           dbms_xmldom.domnode;
      l_node3           dbms_xmldom.domnode;
      l_node4           dbms_xmldom.domnode;
      l_node5           dbms_xmldom.domnode;
      l_node6           dbms_xmldom.domnode;
      l_node7           dbms_xmldom.domnode;
      l_node8           dbms_xmldom.domnode;
      l_node9           dbms_xmldom.domnode;

      l_dat1            varchar2(64);
      l_dat2            varchar2(64);

      l_clob_data       clob;

   begin



      -- парсим хмл
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, p_requestdata);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      l_analytic := dbms_xmldom.makenode (l_doc);

        dbms_xslprocessor.valueof (l_analytic, 'root/dat1/text()', l_dat1);
        dbms_xslprocessor.valueof (l_analytic, 'root/dat2/text()', l_dat2);




      if to_date (l_dat2, 'dd/mm/yyyy')-to_date (l_dat1, 'dd/mm/yyyy')>7
      then
             bars_error.raise_nerror (g_modcode, 'REQUEST_PERIOD_IS_MORE_THEN_MAX');
      end if;


     --формируем ответ
      l_domdoc := dbms_xmldom.newdomdocument;
      l_root_node := dbms_xmldom.makenode (l_domdoc);
      l_node :=
         dbms_xmldom.appendchild (
            l_root_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'root')));

     for c in (select a.ref as ref,
                   a.tt as tt,
                   a.userid as userid,
                   a.nd as nd,
                   a.mfoa as mfoa,
                   a.nlsa as nlsa,
                   a.id_a as id_a,
                   a.nam_a as nam_a,
                   a.s as s,
                   a.lcv as lcv,
                   to_char (a.vdat, 'dd/mm/yyyy') as vdat,
                   a.s2 as s2,
                   a.lcv2 as lcv2,
                   a.mfob as mfob,
                   a.nlsb as nlsb,
                   a.id_b as id_b,
                   a.nam_b as nam_b,
                   a.dk as dk,
                   a.sk as sk,
                   to_char (a.datd, 'dd/mm/yyyy') as datd,
                   a.nazn as nazn,
                   a.tobo as tobo,
                   a.sos as sos,
                   aa.nms  nms_a,
                   ab.nms  nms_b,
                   a.VOB,
                   to_char (a.pdat, 'dd/mm/yyyy') as pdat,
                   to_char (a.odat, 'dd/mm/yyyy') as odat
              from v_docs_tobo_out a,
                   accounts aa,
                   accounts ab
             where a.pdat >= to_date (l_dat1, 'dd/mm/yyyy')
               and a.pdat < (to_date (l_dat2, 'dd/mm/yyyy') + 1)
               and a.NLSA = aa.nls
               and a.NLSB = ab.nls    )
      loop

      l_node3 :=
         dbms_xmldom.appendchild (
            l_node,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));

      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'ref')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, xrm_maintenance.cut_off_ru_tail (c.ref))));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'userid')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.userid)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nd')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.nd)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'mfoa')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.mfoa)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsa')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.nlsa)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 's')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.s)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'lcv')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.lcv)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'vdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc,  c.vdat)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 's2')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, c.s2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'lcv2')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.lcv2)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'mfob')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, c.mfob)));
       l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nlsb')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc, c.nlsb)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'dk')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.dk)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'sk')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.sk)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'datd')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.datd)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nazn')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nazn)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'tt')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.tt)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'tobo')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.tobo)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'id_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.id_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nam_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nam_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'id_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.id_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nam_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nam_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'state')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.sos)));

       l_node6 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'visas')));

        for t in (select counter,
               mark,
               checkgroup_id, 
               checkgroup,
               username,
               dat
               from v_visalist_xrm
               where ref =  c.ref
               order by counter )
              loop

              l_node7 :=
                    dbms_xmldom.appendchild (
                       l_node6,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchk')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup_id)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'idchkname')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.checkgroup)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'username')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.username)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'status')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.mark)));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'date')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, to_char (t.dat, 'DD/MM/YYYY HH24:MI:SS'))));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node7,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'order')));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.counter)));
              end loop;

---b
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nms_a')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nms_a)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'nms_b')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.nms_b)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'vob')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.vob)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'pdat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.pdat)));
      l_element_node :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'odat')));
      l_element_tnode :=
         dbms_xmldom.appendchild (
            l_element_node,
            dbms_xmldom.makenode (
               dbms_xmldom.createtextnode (l_domdoc,c.odat)));

       l_node8 :=
         dbms_xmldom.appendchild (
            l_node3,
            dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'operw')));
        for t in (select tag ,
                         value
               from operw o
               where o.ref =  c.ref
                 and o.value is not null)
        loop
              l_node9 :=
                    dbms_xmldom.appendchild (
                       l_node8,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, 'row')));
              l_element_node :=
                    dbms_xmldom.appendchild (
                       l_node9,
                       dbms_xmldom.makenode (dbms_xmldom.createelement (l_domdoc, t.tag)));
                 l_element_tnode :=
                    dbms_xmldom.appendchild (
                       l_element_node,
                       dbms_xmldom.makenode (dbms_xmldom.createtextnode (l_domdoc, t.value)));
        end loop;
---e

      end loop;

      dbms_xmldom.freedocument (l_doc);

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_xmldom.writetoclob (l_domdoc, l_clob_data);
      dbms_xmldom.freedocument (l_domdoc);

      --пакуем ответ
      p_result := xrm_maintenance.packing (l_clob_data);
   end;
   procedure doc_service (p_doctype         in     int,
                          p_requestdata     in     clob,
                          p_result             out clob,
                          p_resultcode         out int,
                          p_resultmessage      out varchar2)
   is
      l_requestdata   clob;
   begin
      l_requestdata := xrm_maintenance.unpacking (p_requestdata);

      if p_doctype = 1                                                           -- cтворення макету операції
      then
         crt_doc (l_requestdata, p_result);
      elsif p_doctype = 2                                                        -- фиксация документа
      then
         pay_doc (l_requestdata, p_result);
      elsif p_doctype = 3                                                        -- список документов на визирование
      then
         get_docs_for_visa (l_requestdata, p_result);
      elsif p_doctype in (4, 5, 7)                                               -- визирование,сторно,возврат на одну визу назад
      then
         set_visas (l_requestdata, p_doctype, p_result);
      elsif p_doctype = 6                                                        -- инфо по документу
      then
         get_doc (l_requestdata, p_result);
      elsif p_doctype = 8                                                        -- перегляд документів відділення
      then
         get_docs (l_requestdata, p_result);
      end if;

      p_resultcode := 0;
   exception
      when others
      then
         p_resultmessage :=
            substr (
                  'ERORR - '
               || dbms_utility.format_error_stack ()
               || chr (10)
               || dbms_utility.format_error_backtrace (),
               1,
               4000);
         p_resultcode := -1;
         rollback;
   end doc_service;
begin
   null;
end xrm_intg_cashdesk;
/
