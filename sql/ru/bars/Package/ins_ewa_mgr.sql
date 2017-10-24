
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ins_ewa_mgr.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
 CREATE OR REPLACE PACKAGE BARS.ins_ewa_mgr is

  -- Author  : VITALIY.LEBEDINSKIY
  -- Created : 01.02.2016 12:57:33
  -- Purpose : Інтеграція із зовнішньою системою EWA

  -- Public type declarations


  -- Public constant declarations
  g_header_version  constant varchar2(64)  := 'version 3.0 07/07/2017';

  -- Public function and procedure declarations

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- get_purpose - получение назначения платежа
  --
  procedure get_purpose(p_branch         in varchar2,
                    p_user_name      in varchar2,
                    p_mfob           in varchar2,
                    p_nameb          in varchar2,
                    p_accountb       in varchar2,
                    p_okpob          in varchar2,
                    p_ammount        in number,
                    p_commission     in number,
                    p_number         in varchar2,
                    p_date_from      in date,
                    p_date_to        in date,
                    p_date           in date,
                    p_cust_name_last in varchar2,
                    p_cust_name_first in varchar2,
                    p_cust_name_middle in varchar2,
                    p_cust_okpo      in varchar2,
                    p_cust_series    in varchar2,
                    p_cust_number    in varchar2,
                    p_cust_birthdate in date,
                    p_cust_phone     in varchar2,
                    p_cust_address   in varchar2,
                    p_external_id    in varchar2,
                    p_purpose            out varchar2,
                    p_errcode        out decimal,
                    p_errmessage     out varchar2,
                    p_ext_idn        in number default null
                    );

  --------------------------------------------------------------------------------
  -- pay_isu - создание платежного документа
  --
  procedure pay_isu(p_branch in varchar2,
                    p_user_name in varchar2,
                    p_mfob in varchar2,
                    p_nameb in varchar2,
                    p_accountb in varchar2,
                    p_okpob in varchar2,
                    p_ammount in number,
                    p_commission in number,
                    p_commission_type in varchar2,
                    p_number in varchar2,
                    p_date_from in date,
                    p_date_to in date,
                    p_date in date,
                    p_purpose in varchar2,
                    p_cust_name in varchar2,
                    p_cust_okpo in varchar2,
                    p_cust_doc_type in varchar2,
                    p_cust_series in varchar2,
                    p_cust_number in varchar2,
                    p_cust_doc_date in date,
                    p_cust_doc_issued in varchar2,
                    p_cust_birthdate in date,
                    p_cust_phone in varchar2,
                    p_cust_address in varchar2,
                    p_external_id in varchar2,
                    p_external_id_tariff in varchar2,
                 p_email           in varchar2,
                    p_ref out decimal,
                    p_errcode out decimal,
                    p_errmessage out varchar2);

  --------------------------------------------------------------------------------
  -- pay_storno - сторнирование платежного документа
  --
  /*procedure pay_storno(p_ref decimal,
                       p_account varchar2,
                       p_ammount decimal,
                       p_errcode out decimal,
                       p_errmessage out varchar2);*/

  --------------------------------------------------------------------------------
  -- get_pay_status - получение статуса документа
  --
  procedure get_pay_status(p_ref decimal,
                           p_account varchar2,
                           p_ammount decimal,
                           p_status out varchar2,
                           p_errcode out decimal,
                           p_errmessage out varchar2);

  --------------------------------------------------------------------------------
  -- create_deal - создание страхового договора
  --
  procedure create_deal(p_params in xmltype,
                        p_deal_number out ins_deals.id%type,
                        p_errcode out number,
                        p_errmessage out varchar2);
  procedure send_sos;
end ins_ewa_mgr;
/
CREATE OR REPLACE PACKAGE BODY BARS.ins_ewa_mgr is

  -- Private type declarations

  -- Private constant declarations
  g_package_name constant varchar2(160) := 'ins_ewa_mgr';
  g_body_version  constant varchar2(64)  := 'version 3.01 26/07/2017';
  
  --3.0
--исправлены мелкие ошибки при создании договоров страхования (формат полей таблиц модуля страхования, проверкуи на корректность данных и и.п.)
--добавлен функционал " продуктовые пакеты"
--добавлен функционал для передачи статусов платежа в ПО ЕВА
--добавлена операция для ЦА EW3

  
  
  g_tt constant varchar(3 byte) := 'EW1'; -- операція для РУ
  g_tt_ch constant varchar2(3 byte) := 'EW2'; --Операція перерахунку з каси на транзитний рахунок
  g_tt_ca constant varchar2(3 byte) := 'EW3'; -- операція для ЦА
  g_tt_rko constant varchar2(3 byte) := 'RKO'; -- операція для РКО

  -- Function and procedure implementations

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header ins_ewa_mgr '||g_header_version||'.';
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body ins_ewa_mgr '||g_body_version||'.';
  end body_version;

  --------------------------------------------------------------------------------
  -- get_purpose - получение назначения платежа
  --
  procedure get_purpose(p_branch         in varchar2,
                    p_user_name      in varchar2,
                    p_mfob           in varchar2,
                    p_nameb          in varchar2,
                    p_accountb       in varchar2,
                    p_okpob          in varchar2,
                    p_ammount        in number,
                    p_commission     in number,
                    p_number         in varchar2,
                    p_date_from      in date,
                    p_date_to        in date,
                    p_date           in date,
                    p_cust_name_last in varchar2,
                    p_cust_name_first in varchar2,
                    p_cust_name_middle in varchar2,
                    p_cust_okpo      in varchar2,
                    p_cust_series    in varchar2,
                    p_cust_number    in varchar2,
                    p_cust_birthdate in date,
                    p_cust_phone     in varchar2,
                    p_cust_address   in varchar2,
                    p_external_id    in varchar2,
                    p_purpose            out varchar2,
                    p_errcode        out decimal,
                    p_errmessage     out varchar2,
                    p_ext_idn        in number default null
                    ) is
      l_mask          varchar2(4000);
      l_item_txt      varchar2(4000);
      l_item_name_txt varchar2(4000);
      l_item_name     varchar2(4000);
      l_uid     staff$base.id%type;
      l_branch  branch.branch%type;
      l_date_months   varchar2(4000);
      l_date_etalon   varchar2(4000);
      l_months_cnt    int;
      sql_stmt        varchar2(4000);
    begin
      logger.info('INS get_purpose datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
      /*begin
        select id, branch
          into l_uid, l_branch
          from staff$base
         where logname = upper(p_user_name);
      exception
        when no_data_found then
          p_purpose        := null;
          p_errcode    := -20001;
          p_errmessage := 'Не знайдено корстувача';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return ;
      end;*/
      begin
        select regexp_replace(decode(instr(name,' ',1,2),0,name,substr(name,0,instr(name,' ',1,2))),'[^[:digit:]/]','')
          into l_branch
          from branch
         where branch = p_branch;
      exception
        when no_data_found then
          p_purpose        := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено номер відділення';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return ;
      end;
      logger.info('INS get_purpose datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss')||'.START CREATING PURPOSE');
      for c in (  select * from ins_mapping_purpose
                  where (okpo_ic = p_okpob and p_ext_idn is null and rownum = 1 and (ewa_type_id=p_external_id or ewa_type_id is null )) or
                        (okpo_ic = p_okpob and ext_id = p_ext_idn)
        ) loop
        l_mask := c.mask;
        while (regexp_instr(l_mask, '=#\S+#') > 0) loop
          l_item_txt      := regexp_substr(l_mask, '=#[^#]+#');
          l_item_name_txt := regexp_substr(l_item_txt, '=#[^%#]+');
          l_item_name := replace(l_item_name_txt, '=#', '');
          if l_item_name = 'contract.externalId' then
            l_item_name := p_external_id;
          elsif l_item_name = 'contract.code' then
            l_item_name := p_number;
          elsif l_item_name = 'contract.customer.nameLast' then
            l_item_name := p_cust_name_last || ' ';
          elsif l_item_name = 'contract.customer.nameFirst' then
            l_item_name := p_cust_name_first || (case when p_cust_name_middle is null then '' else ' ' end);
          elsif l_item_name = 'contract.customer.nameMiddle' then
            l_item_name := p_cust_name_middle;
          elsif l_item_name = 'contract.customer.code' then
            l_item_name := p_cust_okpo;
          elsif l_item_name = 'payment.payment' then
            l_item_name := trim(to_char(round(p_ammount/100,2),'9999999999990D00'));
          elsif l_item_name = 'payment.commission' then
            l_item_name := trim(to_char(round(p_commission/100,2),'9999999999990D00'));
          elsif l_item_name = 'contract.salePoint.code' then
            l_item_name := l_branch;--trim(replace(substr(p_branch, -8), '/', ' '));
          elsif l_item_name = 'contract.customer.phone' then
            l_item_name := p_cust_phone;
          elsif l_item_name = 'contract.user.externalId' then
            l_item_name := p_user_name;
          elsif l_item_name = 'contract.dateFrom' then
            l_item_name := to_char(to_date(p_date_from), 'dd.mm.yyyy');
          elsif l_item_name = 'contract.customer.series' then
            l_item_name := p_cust_series;
          elsif l_item_name = 'contract.customer.number' then
            l_item_name := p_cust_number;
          elsif l_item_name = 'contract.customer.birthDate' then
            l_item_name := to_char(to_date(p_cust_birthdate),'dd.mm.yyyy');
          elsif l_item_name = 'contract.customer.address' then
            l_item_name := p_cust_address;
          elsif l_item_name = 'contract.dateTo' then
            l_item_name := to_char(to_date(p_date_to), 'dd.mm.yyyy');
          elsif l_item_name = 'contract.date' then
            l_item_name := to_char(to_date(p_date), 'dd.mm.yyyy');
          end if;
          l_mask := replace(l_mask, l_item_txt, l_item_name);
        end loop;
        while (regexp_instr(l_mask, '%#\S+#') > 0) loop
          l_item_txt      := regexp_substr(l_mask, '%#[^#]+#');
          l_item_name_txt := regexp_substr(l_item_txt, '%#[^%#]+');
          l_item_name := replace(l_item_name_txt, '%#', '');
          --l_item_name :=
          sql_stmt := 'select ' || l_item_name || ' from dual';
          execute immediate sql_stmt into l_item_name;
          l_mask := replace(l_mask, l_item_txt, l_item_name);
        end loop;
      end loop;
      logger.info('INS get_purpose datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss')||'.MASK PARSED');
      if l_mask is null then
        p_purpose        := null;
          p_errcode    := -20001;
          p_errmessage := 'Не знайдено шаблон призначення платежу для СК ОКПО '||p_okpob;
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return ;
      else
        logger.info('INS out from array l_mask='||l_mask);
        l_mask := replace(l_mask,';;','; ;');
        l_date_etalon := substr(regexp_substr(l_mask,'months_between(\S+,\S+)'),0,instr(regexp_substr(l_mask,'months_between(\S+,\S+)'),';') - 1);
        if l_date_etalon is not null then
           l_date_months := regexp_replace(l_date_etalon,'(\d{2}.\d{2}.\d{4})','to_date(''\1'',''dd.mm.yyyy'')');
           sql_stmt := 'select ' || l_date_months || ' from dual';
           execute immediate sql_stmt into l_months_cnt;
           l_mask := replace(l_mask, l_date_etalon, l_months_cnt);
        end if;
        if substr(l_mask,0,2) = '/=' then
           l_mask := l_mask||'=/';
        end if;
        logger.info('INS get_purpose  datetime_out='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss')||'.PURPOSE :'||l_mask);
        p_purpose := l_mask;
      end if;
  end;

  --------------------------------------------------------------------------------
  -- pay_isu - создание платежного документа
  --
  procedure pay_isu(p_branch          in varchar2,
                    p_user_name       in varchar2,
                    p_mfob            in varchar2,
                    p_nameb           in varchar2,
                    p_accountb        in varchar2,
                    p_okpob           in varchar2,
                    p_ammount         in number,
                    p_commission      in number,
                    p_commission_type in varchar2,
                    p_number          in varchar2,
                    p_date_from       in date,
                    p_date_to         in date,
                    p_date            in date,
                    p_purpose         in varchar2,
                    p_cust_name       in varchar2,
                    p_cust_okpo       in varchar2,
                    p_cust_doc_type   in varchar2,
                    p_cust_series     in varchar2,
                    p_cust_number     in varchar2,
                    p_cust_doc_date   in date,
                    p_cust_doc_issued in varchar2,
                    p_cust_birthdate  in date,
                    p_cust_phone      in varchar2,
                    p_cust_address    in varchar2,
                    p_external_id     in varchar2,
                    p_external_id_tariff in varchar2,
                    p_email           in varchar2,
                    p_ref             out decimal,
                    p_errcode         out decimal,
                    p_errmessage      out varchar2) is
    l_errcode decimal := null;
    l_errmsg  varchar2(4000) := null;
    l_doc     bars_xmlklb_imp.t_doc;
    l_impdoc  xml_impdocs%rowtype;
    l_tt      varchar2(3 Byte);
    l_vob     decimal;
    l_uid     staff$base.id%type;
    l_acca    accounts%rowtype;
    l_cusa    customer%rowtype;
    l_nls     accounts.nls%type;
    l_dk      int;
    l_branch  branch.branch%type;
    l_recid   number;
    l_nazn    varchar2(160);
    l_random varchar2(10);
    /*****************************/
    --l_item_txt      varchar2(4000);
--    l_item_name_txt varchar2(4000);
--    l_item_name     varchar2(4000);
    --l_date_months   varchar2(4000);
    --l_date_etalon   varchar2(4000);
    --l_months_cnt    int;
    --l_mask          varchar2(4000);
    --sql_stmt        varchar2(4000);
  begin
    logger.info('INS pay_isu datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
    savepoint sp_paystart;
    begin
      -- вибір операції
      begin
        select tt
          into l_tt
          from tts
         where tt = decode(substr(p_branch, 2, 6), '300465', g_tt_ca, g_tt);
        select vob
          into l_vob
          from tts_vob
         where tt = l_tt
           and rownum = 1;
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено код операції';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return;
      end;
      -- вибір користувача від якого створюється документ
      begin
        select id, branch
          into l_uid, l_branch
          from staff$base
         where logname = upper(p_user_name);
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено користувача';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return;
      end;
      bc.subst_branch(l_branch);
      -- вибір транзитного рахунку
      begin
        l_nls := nbs_ob22('2902', '02');
        select *
          into l_acca
          from accounts
         where nls = l_nls
           and dazs is null
           and kv = 980;
        select * into l_cusa from customer where rnk = l_acca.rnk;
      exception
        when no_data_found then
          rollback to savepoint sp_paystart;
          p_ref        := null;
          p_errcode    := -20001;
          p_errmessage := upper(g_package_name)||'. Не знайдено транзитний рахунок';
          logger.error(g_package_name || ' in params p_branch=' ||
                       p_branch || ',p_user_name=' || p_user_name ||
                       ',p_mfob=' || p_mfob || ',p_nameb=' || p_nameb ||
                       ',p_accountb=' || p_accountb || ',p_okpob=' ||
                       p_okpob || ',p_ammount=' || p_ammount ||
                       ', p_errmessage=' || p_errmessage);
          return;
      end;
      -- будуємо призначення платежу
      /*for c in (select * from ins_mapping_purpose where okpo_ic = p_okpob) loop
        l_mask := c.mask;
        while (regexp_instr(l_mask, '=#\S+#') > 0) loop
          l_item_txt      := regexp_substr(l_mask, '=#[^#]+#');
          l_item_name_txt := regexp_substr(l_item_txt, '=#[^%#]+');
          l_item_name := replace(l_item_name_txt, '=#', '');
          if l_item_name = 'contract.externalId' then
            l_item_name := p_external_id;
          elsif l_item_name = 'contract.code' then
            l_item_name := p_number;
          elsif l_item_name = 'contract.customer.name' then
            l_item_name := p_cust_name;
          elsif l_item_name = 'contract.customer.code' then
            l_item_name := p_cust_okpo;
          elsif l_item_name = 'payment.payment' then
            l_item_name := trim(to_char(round(p_ammount/100,2),'9999999999990D00'));
          elsif l_item_name = 'contract.salePoint.code' then
            l_item_name := trim(replace(substr(p_branch, -8), '/', ' '));
          elsif l_item_name = 'contract.customer.phone' then
            l_item_name := p_cust_phone;
          elsif l_item_name = 'contract.user.externalId' then
            l_item_name := l_uid;
          elsif l_item_name = 'contract.dateFrom' then
            l_item_name := to_date(p_date_from, 'dd.mm.yyyy');
          elsif l_item_name = 'contract.customer.series' then
            l_item_name := p_cust_series;
          elsif l_item_name = 'contract.customer.number' then
            l_item_name := p_cust_number;
          elsif l_item_name = 'contract.customer.birthDate' then
            l_item_name := to_date(p_cust_birthdate,'dd.mm.yyyy');
          elsif l_item_name = 'contract.customer.address' then
            l_item_name := p_cust_address;
          elsif l_item_name = 'contract.dateTo' then
            l_item_name := to_date(p_date_to, 'dd.mm.yyyy');
          end if;
          l_mask := replace(l_mask, l_item_txt, l_item_name);
        end loop;
      end loop;
      l_date_etalon := substr(regexp_substr(l_mask,'months_between(\S+,\S+)'),0,instr(regexp_substr(l_mask,'months_between(\S+,\S+)'),';') - 1);
      if l_date_etalon is not null then
        l_date_months := regexp_replace(l_date_etalon,'(\d{2}.\d{2}.\d{4})','to_date(''\1'',''dd.mm.yyyy'')');
        sql_stmt := 'select ' || l_date_months || ' from dual';
        execute immediate sql_stmt into l_months_cnt;
        l_mask := replace(l_mask, l_date_etalon, l_months_cnt);
      end if;
      if substr(l_mask,0,2) = '/=' then
        l_mask := l_mask||'=/';
      end if;*/
      -- параметри платіжного документа
      --select to_char(sysdate, 'HH24MISS') into l_random from dual;
      l_random := p_number;
      l_dk            := 1;
      l_nazn          := substr(p_purpose, 0, 160);
      l_impdoc.ref_a  := null;
      l_impdoc.impref := null;
      l_impdoc.nd     := l_random;
      l_impdoc.datd   := trunc(gl.bd);
      l_impdoc.vdat   := trunc(gl.bd);
      l_impdoc.nam_a  := l_cusa.nmkk;
      l_impdoc.mfoa   := l_acca.kf;
      l_impdoc.nlsa   := l_acca.nls;
      l_impdoc.id_a   := l_cusa.okpo;
      l_impdoc.nam_b  := p_nameb;
      l_impdoc.mfob   := p_mfob;
      l_impdoc.nlsb   := p_accountb;
      l_impdoc.id_b   := p_okpob;
      l_impdoc.s      := (case when p_commission_type = 'IMMEDIATE' then p_ammount - nvl(p_commission, 0) else p_ammount end);
      l_impdoc.kv     := l_acca.kv;
      l_impdoc.s2     := (case when p_commission_type = 'IMMEDIATE' then p_ammount - nvl(p_commission, 0) else p_ammount end);
      l_impdoc.kv2    := l_acca.kv;
      l_impdoc.sk     := 5;
      l_impdoc.dk     := l_dk;
      l_impdoc.tt     := l_tt;
      l_impdoc.vob    := l_vob;
      l_impdoc.nazn   := l_nazn; --p_purpose;
      l_impdoc.datp   := trunc(gl.bd);

      l_impdoc.userid := l_uid;

      l_impdoc.d_rec := null;

      l_doc.doc := l_impdoc;
      bars_login.login_user(p_sessionid => sys_guid(),
                            p_userid    => l_uid,
                            p_hostname  => null,
                            p_appname   => null);
      --Доп параметер "Документ"
        l_doc.drec(0).tag := 'PASP';
        select name into l_doc.drec(0).val from passp where passp = (case when p_cust_doc_type = 'PASSPORT' then 1 else 99 end);
      --Доп параметер "Серія, номер"
        l_doc.drec(1).tag := 'PASPN';
        l_doc.drec(1).val := p_cust_series||' '||p_cust_number;
      --Доп параметер "Адреса"
        l_doc.drec(2).tag := 'ADRES';
        l_doc.drec(2).val := p_cust_address;
      --Доп параметер "Дата видачі і ким"
        l_doc.drec(3).tag := 'ATRT';
        l_doc.drec(3).val := p_cust_doc_issued||' від '|| to_char(p_cust_doc_date,'dd.mm.yyyy')||'р.';
      --Доп параметер "Платник"
        l_doc.drec(4).tag := 'FIO';
        l_doc.drec(4).val := p_cust_name;
      --Доп параметер "Код платника"
        l_doc.drec(5).tag := 'IDA';
        l_doc.drec(5).val := p_cust_okpo;
      --Доп параметер "Отримувач"
        l_doc.drec(6).tag := 'OTRIM';
        l_doc.drec(6).val := p_nameb;
      --Доп параметер "Код отримувача"
        l_doc.drec(7).tag := 'OOKPO';
        l_doc.drec(7).val := p_okpob;
      --Доп параметер "Комісія по договору страхування"
        l_doc.drec(8).tag := 'EWCOM';
        l_doc.drec(8).val := p_commission/100;
      --Доп параметер "Ідентификатор продавця (EWA)"
        l_doc.drec(9).tag := 'EWATN';
        l_doc.drec(9).val := p_external_id;
      --Доп параметер "Зовн. ідент. стр. продукту (EWA)"
        l_doc.drec(10).tag:= 'EWEXT';
        l_doc.drec(10).val:= p_external_id_tariff;
     --Доп параметер "Email кор-ча, що створ. дог(EWA)"
        l_doc.drec(11).tag:= 'EWAML';
        l_doc.drec(11).val:= p_email;
      ------------------------------
      bars_xmlklb_imp.pay_extern_doc(p_doc     => l_doc,
                                     p_errcode => l_errcode,
                                     p_errmsg  => l_errmsg);
      if l_errcode <> 0 then
        p_ref        := -1;
        p_errcode    := l_errcode;
        p_errmessage := l_errmsg;
        logger.error(g_package_name || ' in params p_branch=' || p_branch ||
                     ',p_user_name=' || p_user_name || ',p_mfob=' ||
                     p_mfob || ',p_nameb=' || p_nameb || ',p_accountb=' ||
                     p_accountb || ',p_okpob=' || p_okpob || ',p_ammount=' ||
                     p_ammount || ', p_errmessage=' || p_errmessage);
        bars_login.logout_user;
        rollback to savepoint sp_paystart;
        return;
      else
        p_ref        := l_doc.doc.ref;
        p_errcode    := l_errcode;
        p_errmessage := null;
        declare
          l_nls_param2 accounts.nls%type;
          l_sum oper.s%type;
        begin
          l_sum := p_ammount;
          if p_commission > 0 and p_commission_type = 'IMMEDIATE' then
            paytt (flg_  => 0,          -- флаг оплаты
                   ref_  => l_doc.doc.ref,    -- референция
                   datv_ => trunc(gl.bd),   -- дата валютировния
                   tt_   => g_tt_rko,     -- тип транзакции
                   dk0_  => 1,          -- признак дебет-кредит
                   kva_  => l_acca.kv, -- код валюты А
                   nls1_ => l_acca.nls,   -- номер счета А
                   sa_   => p_commission,      -- сумма в валюте А
                   kvb_  => l_acca.kv, -- код валюты Б
                   nls2_ => p_accountb  ,  -- номер счета Б
                   sb_   => p_commission    -- сумма в валюте Б
                  );
            --l_sum := l_sum + p_commission;
          end if;
          l_nls_param2 := get_proc_nls('T00',l_acca.kv);
          paytt (flg_  => 0,          -- флаг оплаты
                 ref_  => l_doc.doc.ref,    -- референция
                 datv_ => trunc(gl.bd),   -- дата валютировния
                 tt_   => g_tt_ch,     -- тип транзакции
                 dk0_  => 1,          -- признак дебет-кредит
                 kva_  => l_acca.kv, -- код валюты А
                 nls1_ => l_acca.nls,   -- номер счета А
                 sa_   => l_sum,      -- сумма в валюте А
                 kvb_  => l_acca.kv, -- код валюты Б
                 nls2_ => l_nls_param2,  -- номер счета Б
                 sb_   => p_commission    -- сумма в валюте Б
                );
        exception
          when others then
            p_ref        := -1;
            p_errcode    := sqlcode;
            p_errmessage := substr(sqlerrm, 1, 4000);
            logger.error(g_package_name || ' in params p_branch=' || p_branch ||
                         ',p_user_name=' || p_user_name || ',p_mfob=' ||
                         p_mfob || ',p_nameb=' || p_nameb || ',p_accountb=' ||
                         p_accountb || ',p_okpob=' || p_okpob || ',p_ammount=' ||
                         p_ammount || ', p_errmessage=' || p_errmessage);
            bars_login.logout_user;
            rollback to savepoint sp_paystart;
            return;
        end;
      end if;
      logger.info('INS pay_isu datetime_out='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
      bars_login.logout_user;
    exception
      when others then
        p_ref        := -1;
        p_errcode    := sqlcode;
        p_errmessage := substr(sqlerrm, 1, 4000);
        logger.error(g_package_name || ' in params p_branch=' || p_branch ||
                     ',p_user_name=' || p_user_name || ',p_mfob=' ||
                     p_mfob || ',p_nameb=' || p_nameb || ',p_accountb=' ||
                     p_accountb || ',p_okpob=' || p_okpob || ',p_ammount=' ||
                     p_ammount || ', p_errmessage=' || p_errmessage);
        bars_login.logout_user;
        rollback to savepoint sp_paystart;
        return;
    end;
  end;

  --------------------------------------------------------------------------------
  -- pay_storno - сторнирование платежного документа
  --
  /*procedure pay_storno(p_ref decimal,
                       p_account varchar2,
                       p_ammount decimal,
                       p_errcode out decimal,
                       p_errmessage out varchar2) is
    l_ref oper.ref%type;
    l_par2 number;
    l_par3 varchar2(40);
  begin
    savepoint sp_stornostart;
    begin
      select ref into l_ref from oper where ref = p_ref and nlsb = p_account and s = p_ammount;
    exception
      when no_data_found then
        p_errcode := -20001;
        p_errmessage := 'Платіжний документ не знайдено';
        rollback to savepoint sp_stornostart;
        logger.error(g_package_name||' in params p_ref='||p_ref||',p_account='||p_account||',p_ammount='||p_ammount||', p_errmessage='||p_errmessage);
        return;
    end;
    begin
      p_back_dok(l_ref, 5, null, l_par2, l_par3);
      p_errcode    := 0;
      p_errmessage := null;
    exception
      when others then
        p_errcode    := sqlcode;
        p_errmessage := sqlerrm;
        rollback to savepoint sp_stornostart;
        logger.error(g_package_name||' in params p_ref='||p_ref||',p_account='||p_account||',p_ammount='||p_ammount||', p_errmessage='||p_errmessage);
        return;
    end;
  end;*/

  --------------------------------------------------------------------------------
  -- get_pay_status - получение статуса документа
  --
  procedure get_pay_status(p_ref decimal,
                           p_account varchar2,
                           p_ammount decimal,
                           p_status out varchar2,
                           p_errcode out decimal,
                           p_errmessage out varchar2) is
    l_sos varchar2(10);
    l_done varchar2(10) := 'PAID';
    l_in varchar2(10) := 'PENDING';
    l_storno varchar2(10) := 'CANCELED';
  begin
    begin
      select (case
                when sos in (0,1,3) then l_in
                when sos = 5 then l_done
                when sos in (-1,-2,99) then l_storno
              end) as sos
        into l_sos
        from oper
       where ref = p_ref
         and nlsb = p_account
         and s = p_ammount;
      p_status := l_sos;
      p_errcode := 0;
      p_errmessage := null;
    exception
      when no_data_found then
        p_status := null;
        p_errcode := -20001;
        p_errmessage := 'Платіжний документ не знайдено';
        logger.error(g_package_name||' in params p_ref='||p_ref||',p_account='||p_account||',p_ammount='||p_ammount||', p_errmessage='||p_errmessage);
        return;
    end;
  end;

  --------------------------------------------------------------------------------
  -- create_deal - создание страхового договора
  --
  procedure create_deal(p_params in xmltype,
                        p_deal_number out ins_deals.id%type,
                        p_errcode out number,
                        p_errmessage out varchar2) is
    l_deal_id ins_deals.id%type := null;
    l_partner ins_partners%rowtype;
    l_customer customer%rowtype;
    l_user_id staff$base.id%type;
    l_rnk customer.rnk%type;
    l_bday date;
    l_bday_tmp varchar2(400);
    l_ourcountry number(38);
    l_parname params.par%type := 'KOD_G';
    l_currancy tabval.kv%type := 980;
    l_payment_id ins_payments_schedule.id%type;
    l_ise customer.ise%type;
    l_fs customer.fs%type;
    l_ved customer.ved%type;
    l_k050 customer.k050%type;
    l_freq freq.freq%type := 360;
    l_ser person.ser%type;
    l_numdoc person.numdoc%type;
    l_ext_system varchar2(400);
    l_payment_sum ins_payments_schedule.plan_sum%type;
    l_type_id ins_types.id%type;
    l_passp passp.passp%type;
    l_ext_state varchar2(400);
    
    l_ref oper.ref%type;
    l_ewa_id number;
    n number;

    function get_xml_val(p_par xmltype, p_path varchar2) return string is
    begin
      if p_par.existSNode(p_path) > 0 then
        return utl_i18n.unescape_reference(p_par.extract(p_path).GetStringVal());--+декодируем спецсимволы типо apos;
      else
        return null;
      end if;
    end;

    function get_date(p_val varchar2) return date is
        l_indexT int;
        l_res date;
        l_tmp varchar2(400);
      begin
        l_indexT := instr(p_val, 'T');
        if l_indexT > 0 then
          l_tmp := substr(p_val, 0, l_indexT - 1);
          l_res := to_date(l_tmp, 'yyyy-mm-dd');
        else
          l_res := to_date(p_val, 'yyyy-mm-dd');
        end if;
        return l_res;
      end;

  begin
    logger.info('INS create_deal datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
    
    -----------------------------------------------
    ---Добавлена проверка на присутствие рефа в json.
    ---Если есть, то загружаем в табличку для дальнейшей передачи статусов платежей в EWA.
    
    l_ref:=to_number(get_xml_val(p_params,'/CreateDealParams/payments/Payment/number/text()'));
    
    if nvl(l_ref,0)=0
    then 
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'В договорі відсутній документ';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
        return;
    else     
    
       l_ewa_id:=to_number(get_xml_val(p_params,'/CreateDealParams/payments/Payment/id/text()'));
       
       begin             
         insert into ins_ewa_ref_sos(ref,id_ewa,crt_date,kf) values (l_ref,l_ewa_id,sysdate,f_ourmfo());      
       exception 
       when dup_val_on_index then
         null;
       end;
 
    end if;  
     
    ----------------------------------------------
    savepoint create_start;  
    
    begin
      select to_number(val) into l_ourcountry from params where par = l_parname;
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено код країни';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
        return;
    end;
    declare
      l_ins_code varchar2(20);
    begin
      l_ins_code := get_xml_val(p_params,'/CreateDealParams/tariff/insurer/code/text()');
      select p.* into l_partner from ins_partners p, customer c where p.rnk = c.rnk and c.okpo = l_ins_code and p.custtype = 3 and date_off is null;--p_params.extract('/CreateDealParams/tariff/insurer/code/text()').GetStringVal();
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено страхову компанію';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
        return;
    end;
    declare
      l_user varchar2(100);
    begin
      l_user := upper(get_xml_val(p_params,'/CreateDealParams/user/externalId/text()'));
      select id into l_user_id from staff$base where upper(logname) = l_user;/*p_params.extract('/CreateDealParams/user/lastName/text()').GetStringVal()*/
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено користувача';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
        return;
    end;
    declare
      l_ewa_type varchar2(255);
    begin
      l_ewa_type := get_xml_val(p_params,'/CreateDealParams/tariff/externalId/text()');
      select ext_id into l_type_id from ins_ewa_types where id = l_ewa_type;
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено відповідний тип страхового договору';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
        return;
    end;
    declare
      l_ewa_doc_type varchar2(255);
    begin
      l_ewa_doc_type := get_xml_val(p_params,'/CreateDealParams/customer/document/type/text()');
      select ext_id into l_passp from ins_ewa_document_types where id = l_ewa_doc_type;
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено відповідний тип документу, що посвідчує особу';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
        return;
    end;
    ----
   declare
   l_ewa_doc_date date;
   x number;
    begin
        l_ewa_doc_date := get_date(get_xml_val(p_params,'/CreateDealParams/customer/document/date/text()'));
        l_bday := get_date(get_xml_val(p_params,'/CreateDealParams/customer/birthDate/text()'));
        if nvl(l_ewa_doc_date,l_bday)<l_bday
        then 
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Дата документу, що посвідчує особу меньше даты дати народження';
        logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
        return;
        end if;
    end;
    
    
    /*begin
      select kv into l_currancy from tabval where d_close is null and lcv = p_params.extract('/CreateDealParams/currancy/text()').GetStringVal();
    exception
      when no_data_found then
        rollback to savepoint create_start;
        p_deal_number := null;
        p_errcode := -20001;
        p_errmessage := 'Не знайдено код валюти';
        return;
    end;*/
    select p050.k050, p070.k070, p080.k080, p110.k110
      into l_k050,l_ise,l_fs,l_ved
      from (select min(val) as k050 from params where par = 'CUSTK050') p050,
           (select min(val) as k070 from params where par = 'CUSTK070') p070,
           (select min(val) as k080 from params where par = 'CUSTK080') p080,
           (select min(val) as k110 from params where par = 'CUSTK110') p110;
    bc.subst_branch(get_xml_val(p_params,'/CreateDealParams/salePoint/code/text()'));
    --l_bday_tmp := get_xml_val(p_params,'/CreateDealParams/customer/birthDate/text()');
    --l_bday := to_date(substr(l_bday_tmp,0,instr(l_bday_tmp,'T') - 1),'yyyy-mm-dd');
    l_bday := get_date(get_xml_val(p_params,'/CreateDealParams/customer/birthDate/text()'));
    l_ser := get_xml_val(p_params,'/CreateDealParams/customer/document/series/text()');
    l_numdoc := get_xml_val(p_params,'/CreateDealParams/customer/document/number/text()');
    l_payment_sum := to_number(get_xml_val(p_params,'/CreateDealParams/payment/text()'));
    logger.info('INS '||l_payment_sum);
    declare
      l_cust_code varchar2(20);
    begin
      l_cust_code := get_xml_val(p_params,'/CreateDealParams/customer/code/text()');
      select rnk
      into l_rnk
      from
          (select c.*, row_number() over (partition by okpo order by nvl(sed,'00')) rn -- приоритет физики
            --into l_customer
            from customer c,
                 person p
           where c.rnk = p.rnk
             and ((c.okpo = l_cust_code and c.okpo != '0000000000')
              or (p.ser = l_ser and p.numdoc = l_numdoc and p.bday = l_bday and c.okpo = l_cust_code))
             and c.custtype = 3
             and c.date_off is null)
       where rn=1;
     -- l_rnk := l_customer.rnk;
    exception
      when no_data_found then
        begin
          kl.setCustomerAttr(Rnk_          => l_rnk,
                             Custtype_     => 3,
                             Nd_           => null,
                             Nmk_          => substr(get_xml_val(p_params,'/CreateDealParams/customer/name/text()'),1,70),
                             Nmkv_         => SubStr(F_TRANSLATE_KMU(get_xml_val(p_params,'/CreateDealParams/customer/name/text()')),1,70),
                             Nmkk_         => substr(get_xml_val(p_params,'/CreateDealParams/customer/name/text()'),1,38),
                             Adr_          => null,
                             Codcagent_    => 5,
                             Country_      => l_ourcountry,
                             Prinsider_    => 99,
                             Tgr_          => 2,
                             Okpo_         => get_xml_val(p_params,'/CreateDealParams/customer/code/text()'),
                             Stmt_         => null,
                             Sab_          => null,
                             DateOn_       => trunc(sysdate),
                             Taxf_         => null,
                             CReg_         => null,
                             CDst_         => null,
                             Adm_          => null,
                             RgTax_        => null,
                             RgAdm_        => null,
                             DateT_        => null,
                             DateA_        => null,
                             Ise_          => l_ise,
                             Fs_           => l_fs,
                             Oe_           => null,
                             Ved_          => l_ved,
                             Sed_          => '00',
                             Notes_        => null,
                             Notesec_      => null,
                             CRisk_        => null,
                             Pincode_      => null,
                             RnkP_         => null,
                             Lim_          => null,
                             NomPDV_       => null,
                             MB_           => null,
                             BC_           => null,
                             Tobo_         => get_xml_val(p_params,'/CreateDealParams/salePoint/code/text()'),
                             Isp_          => null);
          kl.setPersonAttrEx(Rnk_    => l_rnk,
                             Sex_    => 0,
                             Passp_  => l_passp,
                             Ser_    => l_ser,
                             Numdoc_ => l_numdoc,
                             --Pdate_  => to_date(get_xml_val(p_params,'/CreateDealParams/customer/document/date/text()'),'yyyy-mm-dd'),
                             Pdate_  => get_date(get_xml_val(p_params,'/CreateDealParams/customer/document/date/text()')),
                             Organ_  => substr(get_xml_val(p_params,'/CreateDealParams/customer/document/issuedBy/text()'),0,70),
                             Fdate_  => null,
                             Bday_   => l_bday,
                             Bplace_ => null,
                             TelD_   => null,
                             TelW_   => null,
                             TelM_   => get_xml_val(p_params,'/CreateDealParams/customer/phone/text()'));
          kl.setCustomerElement(l_rnk, 'K013' , '5', 0);
          kl.setCustomerElement(l_rnk, 'PUBLP' , 'Ні', 0);
          kl.setCustomerEN( p_rnk  => l_rnk,
                          p_k070 => l_ise,
                          p_k080 => l_fs,
                          p_k110 => l_ved,
                          p_k090 => null,
                          p_k050 => l_k050,
                          p_k051 => '00');
        end;
    end;
    l_ext_system := get_xml_val(p_params,'/CreateDealParams/id/text()');
    l_ext_state := get_xml_val(p_params,'/CreateDealParams/state/text()');
    logger.info('INS STATE = '||l_ext_state);
    declare
      l_ins_state ins_deals.status_id%type;
    begin
      select a.deal_id, d.status_id
        into l_deal_id, l_ins_state
        from ins_deal_attrs a, ins_deals d
       where a.deal_id = d.id
         and a.attr_id = 'EXT_SYSTEM'
         and a.val = l_ext_system;
      if (l_ext_state = 'DRAFT' or l_ext_state = 'DELETED') and l_ins_state not in ('STORNO') then
        begin
          ins_pack.storno_deal(p_deal_id => l_deal_id, p_status_comm => 'Сторновано із зовнішньої системи');
          p_deal_number := l_deal_id;
          p_errcode := 0;
          p_errmessage := null;
          return;
        exception
          when others then
            rollback to savepoint create_start;
            p_deal_number := null;
            p_errcode := -20001;
            p_errmessage := 'Не вдалось сторнувати договір';
            logger.error(g_package_name||' p_errmessage='||sqlerrm||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
            return;
        end;
      end if;
    exception
      when no_data_found then
        null;
    end;
    if l_ext_state = 'SIGNED' then
      if l_deal_id is null then
        l_deal_id := ins_pack.create_deal(p_partner_id  => l_partner.id,
                                          p_type_id     => l_type_id,
                                          p_ins_rnk     => l_rnk,
                                          p_ser         => null,
                                          p_num         => nvl(get_xml_val(p_params,'/CreateDealParams/code/text()'),get_xml_val(p_params,'/CreateDealParams/number/text()')),
                                          /*p_sdate       => to_date(substr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),0,instr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),'T')-1),'yyyy-mm-dd'),
                                          p_edate       => to_date(get_xml_val(p_params,'/CreateDealParams/dateTo/text()'),'yyyy-mm-dd'),*/
                                          p_sdate       => get_date(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()')),
                                          p_edate       => get_date(get_xml_val(p_params,'/CreateDealParams/dateTo/text()')),
                                          p_sum         => nvl(to_number(get_xml_val(p_params,'/CreateDealParams/insuranceAmount/text()')), 300000),
                                          p_sum_kv      => l_currancy,
                                          p_insu_tariff => null,
                                          p_insu_sum    => to_number(get_xml_val(p_params,'/CreateDealParams/payment/text()')),
                                          p_object_type => 'CL',
                                          p_rnk         => l_rnk,
                                          p_grt_id      => null,            
                                          p_nd          => null,
                                          p_pay_freq    => l_freq,
                                          p_renew_need  => 1);
        begin
          select ps.id
            into l_payment_id
            from ins_payments_schedule ps
           where ps.deal_id = l_deal_id
             and ps.plan_date = (select min(plan_date)
                                   from ins_payments_schedule
                                  where deal_id = ps.deal_id
                                    and fact_date is null);
          update ins_payments_schedule
             set plan_sum = l_payment_sum
           where id = l_payment_id;
        exception
          when no_data_found then
            rollback to savepoint create_start;
            p_deal_number := null;
            p_errcode := -20001;
            p_errmessage := 'Не знайденно документ згідно плану';
            logger.error(g_package_name||' p_errmessage='||p_errmessage||', params:'||chr(13)||chr(10)||substr(p_params.GetStringVal(),0,4000));
            return;
        end;
        ins_pack.pay_deal_pmt(p_id        => l_payment_id,
                              p_fact_date => trunc(sysdate),
                              p_fact_sum  => l_payment_sum,
                              p_pmt_num   => to_number(get_xml_val(p_params,'/CreateDealParams/payments/Payment/number/text()')),
                              p_pmt_comm  => substr(get_xml_val(p_params,'/CreateDealParams/payments/Payment/purpose/text()'),1,500));
      else
        ins_pack.update_deal(p_deal_id     => l_deal_id,
                             p_branch      => get_xml_val(p_params,'/CreateDealParams/salePoint/code/text()'),
                             p_partner_id  => l_partner.id,
                             p_type_id     => l_type_id,
                             p_ins_rnk     => l_rnk,
                             p_ser         => null,
                             p_num         => nvl(get_xml_val(p_params,'/CreateDealParams/code/text()'),get_xml_val(p_params,'/CreateDealParams/number/text()')),
                             /*p_sdate       => to_date(substr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),0,instr(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()'),'T')-1),'yyyy-mm-dd'),
                             p_edate       => to_date(get_xml_val(p_params,'/CreateDealParams/dateTo/text()'),'yyyy-mm-dd'),*/
                             p_sdate       => get_date(get_xml_val(p_params,'/CreateDealParams/dateFrom/text()')),
                             p_edate       => get_date(get_xml_val(p_params,'/CreateDealParams/dateTo/text()')),
                             p_sum         => nvl(to_number(get_xml_val(p_params,'/CreateDealParams/insuranceAmount/text()')), 300000),
                             p_sum_kv      => l_currancy,
                             p_insu_tariff => null,
                             p_insu_sum    => to_number(get_xml_val(p_params,'/CreateDealParams/payment/text()')),
                             p_rnk         => l_rnk,
                             p_grt_id      => null,
                             p_nd          => null,
                             p_renew_need  => 1);
      end if;

      logger.info('INS create_deal datetime_out='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
      ins_pack.set_deal_attr_s(p_deal_id => l_deal_id,
                               p_attr_id => 'EXT_SYSTEM',
                               p_val     => l_ext_system);
      ins_pack.set_status(p_deal_id     => l_deal_id,
                          p_status_id   => 'ON',
                          p_status_comm => 'Договір створено із зовнішньої системи');
    else
      l_deal_id := -99;
    end if;
    p_deal_number := l_deal_id;
    p_errcode := 0;
    p_errmessage := null;
  end;

procedure send_sos
is 

    l_ins_ewa_ref_sos ins_ewa_ref_sos%rowtype;
    l_url             web_barsconfig.val%type;
    l_dir             web_barsconfig.val%type;
    l_pass            web_barsconfig.val%type;
    l_request         soap_rpc.t_request;
    l_response        soap_rpc.t_response;
    l_clob            clob;
    l_error           varchar2(2000);
    l_parser          dbms_xmlparser.parser;
    l_doc             dbms_xmldom.domdocument;
    l_reslist         dbms_xmldom.DOMNodeList;
    l_res             dbms_xmldom.DOMNode;
    l_str             varchar2(4000);
    l_status          varchar2(4000);
    l_tmp             xmltype;
    

begin

    logger.info(g_package_name||'.send_sos datetime_in='||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));

    select val into l_url from web_barsconfig where  key='EWA.URL_SEND_REF_STATUS';
    select val into l_dir from web_barsconfig where  key='EWA.Wallet_dir';
    select val into l_pass from web_barsconfig where key='EWA.Wallet_pass';


   --удаляем все позавчерашние операции,кроме тех по кому небыло успешных передач 
    delete ins_ewa_ref_sos c
    where  trunc(c.crt_date)<trunc(sysdate)-1 and nvl(c.sos,999)<>999;
    
    logger.info(g_package_name||'.send_sos.several refs were deleted from queue - '||sql%rowcount); 

    for c in  (select s.ref,s.id_ewa,s.crt_date,o.sos,s.sos ewa_sos,
                case when o.sos<0 then 'CANCELED' when o.sos between 0 and 4 then 'PENDING' when o.sos=5 then 'PAID' else null end ewa_status
                 from ins_ewa_ref_sos s, oper o
                where s.ref=o.ref
                and (s.sos is null or s.sos<>o.sos))
    loop
        l_request := soap_rpc.new_request  (p_url       => l_url,
                                        p_namespace => 'http://ws.unity-bars-utl.com.ua/',
                                        p_method    => 'SendAccStatus',
                                        p_wallet_dir =>  l_dir,
                                        p_wallet_pass => l_pass);
     
        soap_rpc.add_parameter(l_request, 'id',    to_char(c.id_ewa));

        soap_rpc.add_parameter(l_request, 'state', to_char(c.ewa_status));

        begin
            l_response := soap_rpc.invoke(l_request);

            --разбираем ответ
            --l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
            l_clob := l_response.doc.getClobVal();
            l_parser := dbms_xmlparser.newparser;
            dbms_xmlparser.parseclob(l_parser, l_clob);
            l_doc := dbms_xmlparser.getdocument(l_parser);
            l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                          'SendAccStatusResult');
            l_res     := dbms_xmldom.item(l_reslist, 0);
            dbms_xslprocessor.valueof(l_res, 'status/text()', l_str);
            l_status := substr(l_str, 1, 200);
            
            if lower(l_status)='ok' then
              
                update ins_ewa_ref_sos
                set sos=c.sos
                where ref=c.ref;         
      
                logger.info(g_package_name||'.send_sos. ref status was sent - '||c.ref);
              
            else 
            
                dbms_xslprocessor.valueof(l_res, 'message/text()', l_str);
                l_status := substr(l_str, 1, 4000);
            
                update ins_ewa_ref_sos
                set sos=999
                where ref=c.ref;
                
                bars_audit.error(g_package_name||'.send_sos. ref- '||c.ref|| '. ERROR:' || l_status);    

                --если какой-то ерор то ставим статус 999, для повтрной передачи.

            end if; 
  
        exception
            when others then
              dbms_xmlparser.freeparser(l_parser);
              DBMS_XMLDOM.freeDocument(l_doc);
              l_error := substr(sqlerrm, 1, 900);
              bars_audit.error(g_package_name||'.send_sos. ref- '||c.ref|| '.OTHER ERROR:' || l_error);
              update ins_ewa_ref_sos
              set sos=999
              where ref=c.ref;
        end;            
        dbms_xmlparser.freeparser(l_parser);
        DBMS_XMLDOM.freeDocument(l_doc);       

    end loop;

end send_sos;

end ins_ewa_mgr;
/
 show err;
 
PROMPT *** Create  grants  INS_EWA_MGR ***
grant EXECUTE                                                                on INS_EWA_MGR     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ins_ewa_mgr.sql =========*** End ***
 PROMPT ===================================================================================== 
 