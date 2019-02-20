create or replace package eds_intg is

  gc_header_version constant varchar2(64)  := 'version 1.2 23.01.2019';
  
  gc_iban constant boolean :=false;
  
  st_request_new          constant number := -1; -- Новий запит
  st_declaration_register constant number :=  0; -- Запит зареєстровано
  st_declaration_prepared constant number :=  1; -- Декларація підготовлена
  st_declaration_error    constant number :=  2; -- Помилка підготовки декларації
  st_declaration_rejected constant number :=  3; -- Декларацію відхилено
  st_declaration_deleted  constant number :=  4; -- Декларацію видалено
  st_declaration_new_ex   constant number :=  5; -- Дані видалені, існує нова декларація

  --Формування guid в форматі XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
  function get_guid return varchar2;
   
  --Реєстрація запиту в системі
  procedure create_request(
    p_okpo       in eds_decl.okpo%type,
    p_birth_date in eds_decl.birth_date%type,
    p_doc_type   in eds_decl.doc_type%type,
    p_doc_serial in eds_decl.doc_serial%type,
    p_doc_number in eds_decl.doc_number%type,
    p_date_from  in eds_decl.date_from%type,
    p_date_to    in eds_decl.date_to%type,
    p_name       in eds_decl.cust_name%type,
    p_comm       in eds_decl.comm%type,
    p_decl_id    in out number
    );
  --Пошук декларації за номером
  procedure decl_search(p_decl_id number, p_resp out number);
  --Створення PDF файлу декларації для Ощад 24/7
  procedure create_report(P_TRANSTP_ID VARCHAR2);
  --Обробка запиту від Ощад 24/7
  procedure pocess_request(p_transp_id varchar2);
  --Формування вітрини даних
  procedure fill_data(p_req_id varchar2);
  --Очистка старих данних в вітринах
  procedure delete_old_data;
  
end eds_intg;
/

CREATE OR REPLACE package body BARS.EDS_INTG is

  gc_body_version constant varchar2(64) := 'version 1.2 23.01.2019';
  gc_pkg          constant varchar2(8)  := 'eds_intg';
  -----------------------------------------------------------------------------------------

  -----------------------------------------------------------------------------------------
  --  header_version
  --
  --    Версія заголовка пакету
  --
  function header_version return varchar2
  is
  begin
     return 'package header '||gc_pkg||': ' || gc_header_version;
  end header_version;

  -----------------------------------------------------------------------------------------
  --  body_version
  --
  --    Версія тіла пакету
  --
  function body_version return varchar2
  is
  begin
     return 'package body '||gc_pkg||': ' || gc_body_version;
  end body_version;
--xml_extract---------------------------------------------------------------------------------
  function xml_extract(p_xml xmltype, p_xpath varchar2) return varchar2 is
  retval varchar2(32000);
  begin
    if p_xml.existSNode(p_xpath) > 0 then
    retval:= utl_i18n.unescape_reference(p_xml.extract(p_xpath).GetStringVal());
    else
      retval:=null;
    end if;
    return retval;
  end xml_extract;

--get_guid-----------------------------------------------------------------------------------
 function get_guid return varchar2 is
     l_retval varchar2(40);
 begin
     l_retval := RAWTOHEX(sys_guid());
     l_retval := substr(l_retval, 1, 8) || '-' || substr(l_retval, 9, 4) || '-' ||
                 substr(l_retval, 13, 4) || '-' || substr(l_retval, 17, 4) || '-' ||
                 substr(l_retval, 21);
     return l_retval;
 end;
 
 procedure add_new_decl(p_eds_decl eds_decl%rowtype, p_eds_decls_policy eds_decls_policy%rowtype default null) is
    pragma autonomous_transaction;
 begin
    insert into eds_decl values p_eds_decl;
    if p_eds_decls_policy.id is not null then
        insert into eds_decls_policy values p_eds_decls_policy;
    end if;    
    commit;
 exception when dup_val_on_index then
    null;
  end;
 procedure set_decl_status(p_id varchar2, p_status number) is
    pragma autonomous_transaction;
 begin
    update eds_decl e 
       set e.state = p_status
     where e.id = p_id;
    commit;
 end; 

--  set_request_state
procedure log_crt_req(p_transp_id varchar2, p_kf varchar2, p_req_body varchar2, p_id out varchar2) is
      pragma autonomous_transaction;
      l_id varchar2(36);
  begin
      l_id:=xml_extract(xmltype(p_req_body), '/ROOT/ID/text()');
      insert into eds_crt_req_log
          (id, transp_req_id, so_kf, req_user_id, req_time, req_body, req_status)
      values
          (coalesce(l_id, get_guid),
           p_transp_id,
           p_kf,
           user_id,
           sysdate,
           p_req_body,
           st_request_new) returning id into l_id;
      commit;
      p_id:= l_id;
  exception when dup_val_on_index then
     raise_application_error(-20000, 'Запит з ІД "'||l_id||'" надіснано повторно!');
  end;
  
  procedure upd_log_req_status(p_id varchar2, p_status number, p_err varchar2 default null) is 
  pragma autonomous_transaction;
  begin
    update eds_crt_req_log l 
       set l.req_status = p_status,
           l.err = p_err
     where l.id = p_id;
     commit;
  end;
  
  procedure add_log_req_resp(p_id varchar2, p_status number, p_resp_body varchar2, p_decl_id number) is
  pragma autonomous_transaction;
  begin
      update eds_crt_req_log l 
       set l.req_status = p_status,
           l.resp_time = sysdate,
           l.resp_body = p_resp_body,
           l.decl_id = p_decl_id
     where l.id = p_id;
     commit;
  end;
  
--xml_2_obj-----------------------------------------------------------------------------------
  function xml_2_obj(p_xml clob) return eds_decl%rowtype is
  l_retval   eds_decl%rowtype;
  l_xml        xmltype;
  begin
  l_xml:=xmltype(p_xml);
  l_retval.ID         := xml_extract(l_xml, '/ROOT/ID/text()');
  l_retval.DECL_ID    := xml_extract(l_xml, '/ROOT/DECL_ID/text()');
  l_retval.CRT_DATE   := to_date(xml_extract(l_xml, '/ROOT/CRT_DATE/text()'),'dd.mm.yyyy hh24:mi:ss');
  l_retval.STATE      := xml_extract(l_xml, '/ROOT/STATE/text()');
  l_retval.OKPO       := xml_extract(l_xml, '/ROOT/OKPO/text()');
  l_retval.CUST_NAME  := xml_extract(l_xml, '/ROOT/CUST_NAME/text()');
  l_retval.BIRTH_DATE := to_date(xml_extract(l_xml, 'ROOT/BIRTH_DATE/text()'),'dd.mm.yyyy');
  l_retval.DOC_TYPE   := xml_extract(l_xml, '/ROOT/DOC_TYPE/text()');
  l_retval.DOC_SERIAL := xml_extract(l_xml, '/ROOT/DOC_SERIAL/text()');
  l_retval.DOC_NUMBER := xml_extract(l_xml, '/ROOT/DOC_NUMBER/text()');
  l_retval.DATE_FROM  := to_date(xml_extract(l_xml, '/ROOT/DATE_FROM/text()'),'dd.mm.yyyy');
  l_retval.DATE_TO    := to_date(xml_extract(l_xml, '/ROOT/DATE_TO/text()'),'dd.mm.yyyy');
  l_retval.COMM       := xml_extract(l_xml, '/ROOT/COMM/text()');
  l_retval.DONEBY     := xml_extract(l_xml, '/ROOT/DONEBY/text()');
  l_retval.DONEBY_FIO := xml_extract(l_xml, '/ROOT/DONEBY_FIO/text()');
  l_retval.BRANCH     := xml_extract(l_xml, '/ROOT/BRANCH/text()');
  return l_retval;
  end;
  
  --crt_xml-------------------------------------------------------------------------------------
  function crt_xml(p_req_id number, p_type number default 0) return clob is
  l_xml xmltype;
  begin
  select
  xmlroot(xmlelement("ROOT",
                     xmlelement("ID",         e.id),
                     xmlelement("DECL_ID",    e.decl_id),
                     xmlelement("CRT_DATE",   to_char(e.crt_date, 'dd.mm.yyyy hh24:mi:ss')),
                     xmlelement("STATE",      to_char(e.state)),
                     xmlelement("OKPO",       e.okpo),
                     xmlelement("CUST_NAME",  e.cust_name),
                     xmlelement("BIRTH_DATE", to_char(e.birth_date, 'dd.mm.yyyy')),
                     xmlelement("DOC_TYPE",   e.doc_type),
                     xmlelement("DOC_SERIAL", e.doc_serial),
                     xmlelement("DOC_NUMBER", e.doc_number),
                     xmlelement("DATE_FROM",  to_char(e.date_from, 'dd.mm.yyyy')),
                     xmlelement("DATE_TO",    to_char(e.date_to, 'dd.mm.yyyy')),
                     xmlelement("COMM",       e.comm),
                     xmlelement("DONEBY",     case when p_type = 0 then null else to_number(e.doneby) end),
                     xmlelement("DONEBY_FIO", case when p_type = 0 then null else e.doneby_fio end),
                     xmlelement("BRANCH",     e.branch)), version '1.0" encoding="windows-1251')
  INTO l_xml
  from eds_decl e
  where decl_id = p_req_id;
  return l_xml.GetClobVal();
  end; 

--create_report-------------------------------------------------------------------------------
  procedure create_report(p_transtp_id varchar2) is
    l_buff      xmltype;
    l_url           varchar2(1024) := getglobaloption('LINK_FOR_ABSBARS_WEBAPISERVICES')||'fastreport/fastreport/getFileInBase64';
    l_wallet_path   varchar2(256) := getglobaloption('PATH_FOR_ABSBARS_WALLET');
    l_wallet_pwd    varchar2(256) := getglobaloption('PASS_FOR_ABSBARS_WALLET');
    l_response      wsm_mgr.t_response;
    l_param         varchar2(255);
    begin
    begin
    select r.value
      into l_param
      from barstrans.input_req_params r
     where r.req_id = p_transtp_id
       and upper(r.tag) = 'DECL_ID'
       and r.param_type = 'GET';
       exception when no_data_found then
        raise_application_error(-20001,'GET Параметр DECL_ID не передано в запиті');
        end;


    select xmlroot( XmlElement("ROOT",
                    Xmlelement("FileName", 'EDECL_FR_OTHERS.frx'),
                    Xmlelement("ResponseFileType", '7'),
                    Xmlelement("Parameters",
                               XmlElement("FrxParameter",
                                          Xmlelement("Name", 'p_decl_id'),
                                          Xmlelement("Value",l_param),
                                          Xmlelement("Type", '9')
                           ))), version '1.0" encoding="windows-1251')
                           into l_buff from dual;

    wsm_mgr.prepare_request(p_url=> l_url,
                          p_action      => null,
                          p_http_method => wsm_mgr.g_http_post,
                          p_wallet_path => l_wallet_path,
                          p_wallet_pwd  => l_wallet_pwd,
                          p_body        => l_buff.getclobval());
             -- позвать метод веб-сервиса
             wsm_mgr.execute_api(l_response);

      BARSTRANS.transp_utl.add_resp(p_transtp_id, l_response.cdoc);
    end;

--decl_search---------------------------------------------------------------------------------
  procedure decl_search(p_decl_id number, p_resp out number) is
  l_id varchar2(36);
  l_decl_cou number;
  begin
  select count(*) into l_decl_cou from v_eds_crt_log where decl_id = p_decl_id;

     if l_decl_cou = 0 then
         begin
            select id into l_id from eds_decl where decl_id = p_decl_id;
         exception when no_data_found then
             p_resp:=3;
             l_id:='-1';
         end;
         if l_id <> '-1' then
             insert into eds_decls_policy ( id, add_date, add_id)
             values (l_id, sysdate, user_id);
             p_resp:=0;
         end if;
     else
         p_resp:=1;
     end if;
  exception when others then
     p_resp:=2;
  end;

procedure p_cur_rates (p_req_id varchar2)
 is
 begin
   insert into eds_curs_rates (req_id,kv,name,vdate,rate_o,rate_b,rate_s)
   select e.id,c.kv,n.name,e.date_to,c.rate_o,c.rate_b,c.rate_s
     from bars.eds_decl e
     join bars.cur_rates$base c on c.vdate=e.date_to and c.kv in (840,978) and c.branch = '/300465/'
     join bars.TABVAL$GLOBAL n on n.kv = c.kv
    where e.id=p_req_id;
exception when dup_val_on_index then
null;    
end;

procedure fill_data(p_req_id varchar2, p_id out number) is
  
  type t_eds_w4_data is table of eds_w4_data%rowtype;
  type t_eds_dpt_data is table of eds_dpt_data%rowtype;
  type t_eds_credit_data is table of eds_credit_data%rowtype;
  
  l_eds_w4_data t_eds_w4_data := t_eds_w4_data();
  l_eds_dpt_data t_eds_dpt_data := t_eds_dpt_data();
  l_eds_credit_data t_eds_credit_data := t_eds_credit_data();
  l_decl_id number;
  begin
  bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                        p_userid    => 1,
                        p_hostname  => null,
                        p_appname   => null);
  bc.go('/');
  
  savepoint bef_form;
  
  eds_intg.p_cur_rates (p_req_id);
  
  for cust in (select i.id, c.okpo, c.rnk, c.kf, i.date_from, i.date_to,
                      substr(b.attribute_value, 1, 100) as attribute_value
                      from person p 
                      join customer c on p.rnk = c.rnk
                      join eds_decl i on c.okpo = i.okpo 
                                     and p.passp = i.doc_type 
                                     and p.passp = i.doc_type 
                                     and p.numdoc = i.doc_number 
                                     and p.bday = i.birth_date
                                     and case when i.doc_type = 7 then '1' else p.ser end = case when i.doc_type = 7 then '1' else i.doc_serial end
                     left join branch_attribute_value b on b.attribute_code='NAME_BRANCH' and b.branch_code=c.branch
                     where i.id = p_req_id) loop
                     
                     for account in (select fost(a.acc,trunc(cust.date_to)) as end_bal,
                                            gl.p_icurval(a.kv,fost(a.acc,trunc(cust.date_to)), cust.date_to) as end_balq,
                                            a.acc, a.nls, a.nbs, a.kv, a.kf, c.code, t.grp_code,
                                            case t.grp_code 
                                                when 'SALARY' then 'SALARY'
                                                when 'PENSION' then 'PENSION'
                                                when 'MOYA_KRAYINA' then 'PENSION'
                                                else 'OTHERS' end as ACC_TYPE
                                       from accounts a
                                       left join w4_acc w4 on w4.acc_pk = a.acc and w4.kf = a.kf
                                       left join w4_card c on w4.card_code = c.code and w4.kf = c.kf
                                       left join w4_product t on t.code=c.product_code and t.kf = c.kf
                                      where a.rnk=cust.rnk
                                        and a.nbs in ('2620','2625') 
                                        and not exists(select 1 from w4_acc ww where ww.acc_2625d = a.acc)) loop
                                        l_eds_w4_data.extend;
                                        l_eds_w4_data(l_eds_w4_data.last).req_id:=cust.id;
                                        l_eds_w4_data(l_eds_w4_data.last).rnk:=cust.rnk;
                                        l_eds_w4_data(l_eds_w4_data.last).acc:=account.acc;
                                        l_eds_w4_data(l_eds_w4_data.last).nls:=account.nls;
                                        l_eds_w4_data(l_eds_w4_data.last).kv:=account.kv;
                                        l_eds_w4_data(l_eds_w4_data.last).open_in:=cust.attribute_value;
                                        l_eds_w4_data(l_eds_w4_data.last).acc_type:=account.acc_type;
                                        l_eds_w4_data(l_eds_w4_data.last).end_bal:= account.end_bal;
                                        l_eds_w4_data(l_eds_w4_data.last).end_balq:= account.end_balq;
                                        l_eds_w4_data(l_eds_w4_data.last).kf:=account.kf;
                                        
                               begin
                               select sum(case when (account.grp_code= 'SALARY' and o.tt in ('PKS','KL1','IB6','IB5','PKB','CL5')) or
                                                    (account.grp_code in ('PENSION', 'MOYA_KRAYINA') and account.code not like 'SOC_%' and o.tt ='PKX') or
                                                    (account.grp_code not in ('PENSION', 'MOYA_KRAYINA', 'SALARY') or account.grp_code is null)
                                              then o.s else 0 end) as AMOUNT,
                                      sum(case when (account.grp_code= 'SALARY' and o.tt in ('PKS','KL1','IB6','IB5','PKB','CL5')) or
                                                    (account.grp_code in ('PENSION', 'MOYA_KRAYINA') and account.code not like 'SOC_%' and o.tt ='PKX') or
                                                    (account.grp_code not in ('PENSION', 'MOYA_KRAYINA', 'SALARY') or account.grp_code is null)
                                              then gl.p_icurval(account.kv, o.s, o.fdat) else 0 end) as AMOUNT,
                                      sum(case when (account.grp_code= 'SALARY' and o.tt not in ('PKS','KL1','IB6','IB5','PKB','CL5')) or
                                                    (account.grp_code in ('PENSION', 'MOYA_KRAYINA') and account.code not like 'SOC_%' and o.tt <>'PKX')
                                               then o.s else 0 end) AMOUNT_OTH
                                        into l_eds_w4_data(l_eds_w4_data.last).amount_period,
                                             l_eds_w4_data(l_eds_w4_data.last).amount_periodq, 
                                             l_eds_w4_data(l_eds_w4_data.last).other_accruals
                                        from opldok o
                                        left join opldok o2 on o.ref = o2.ref and o2.dk = 1-o.dk and  o2.stmt = o.stmt
                                       where o.acc=account.acc
                                         and o.kf = account.kf
                                         and not exists (select 1 from w4_acc_inst i where i.acc_pk = account.acc and i.acc = o2.acc and i.trans_mask = 'ACC_2203I') --не рахуємо кредити instolment
                                         and not exists (select 1 from w4_acc w where w.acc_pk = account.acc and (w.acc_2628 = o2.acc or w.acc_ovr = o2.acc)) --не рахуємо проценти за депозитом та кредити ovr
                                         and o.dk=1
                                         and o.fdat between cust.date_from and cust.date_to
                                       group by o.acc;
                               exception when no_data_found then
                                   l_eds_w4_data(l_eds_w4_data.last).amount_period:=0;
                                   l_eds_w4_data(l_eds_w4_data.last).amount_periodq:=0;
                                   l_eds_w4_data(l_eds_w4_data.last).other_accruals:=0;
                               end;
                               end loop;
                       --deposit
                       for account in (select bars.fost(a.acc,trunc(cust.date_to)) as end_bal, 
                                              gl.p_icurval(a.kv,fost(a.acc,trunc(cust.date_to)), cust.date_to) as end_balq,
                                              a.acc, a.nls, a.nbs, a.kv, a.kf, a.tip, acc_pp.acc as acc_dpt
                                         from accounts a
                                         left join (select dpa.accid, a1.acc from dpt_accounts dpa
                                                            join dpt_accounts dpa1 on dpa1.dptid=dpa.dptid                                           
                                                            join accounts a1 on a1.acc=dpa1.accid and a1.nbs='2638') acc_pp on acc_pp.accid=a.acc
                                        where a.rnk = cust.rnk
                                          and a.nbs = '2630') loop

                                        l_eds_dpt_data.extend;
                                        l_eds_dpt_data(l_eds_dpt_data.last).req_id:=cust.id;
                                        l_eds_dpt_data(l_eds_dpt_data.last).rnk:=cust.rnk;
                                        l_eds_dpt_data(l_eds_dpt_data.last).acc:=account.acc;
                                        l_eds_dpt_data(l_eds_dpt_data.last).nls:=account.nls;
                                        l_eds_dpt_data(l_eds_dpt_data.last).kv:=account.kv;
                                        l_eds_dpt_data(l_eds_dpt_data.last).open_in:=cust.attribute_value;
                                        l_eds_dpt_data(l_eds_dpt_data.last).end_bal:=account.end_bal;
                                        l_eds_dpt_data(l_eds_dpt_data.last).end_balq:=account.end_balq;
                                        l_eds_dpt_data(l_eds_dpt_data.last).kf:=account.kf;
                                        l_eds_dpt_data(l_eds_dpt_data.last).tip:=account.tip;
                                        
                                       begin
                                       select sum(case when o.tt ='%%1' then o.s else 0 end) as sum_proc,
                                              sum(case when o.tt ='%%1' then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_procq,
                                              sum(case when o.tt ='%15' then o.s else 0 end) as sum_pdfo,
                                              sum(case when o.tt ='%15' then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_pdfoq,
                                              sum(case when o.tt ='MIL' then o.s else 0 end) as sum_mil,
                                              sum(case when o.tt ='MIL' then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_milq,
                                              sum(case when o.tt in ('MIL','%15') then o.s else 0 end) as sum_totaly,
                                              sum(case when o.tt in ('MIL','%15') then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_totalyq
                                              into l_eds_dpt_data(l_eds_dpt_data.last).sum_proc,   l_eds_dpt_data(l_eds_dpt_data.last).sum_procq, 
                                                   l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfo,   l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfoq,
                                                   l_eds_dpt_data(l_eds_dpt_data.last).sum_mil,    l_eds_dpt_data(l_eds_dpt_data.last).sum_milq,
                                                   l_eds_dpt_data(l_eds_dpt_data.last).sum_totaly, l_eds_dpt_data(l_eds_dpt_data.last).sum_totalyq  
                                         from opldok o
                                        where o.acc = account.acc_dpt
                                          and o.kf = account.kf
                                          and o.fdat between cust.date_from and cust.date_to
                                        group by o.acc;
                                         exception when no_data_found then
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_proc:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfo:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_mil:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_totaly:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_procq:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfoq:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_milq:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_totalyq:=0;
                                         end;
                                        end loop;
                                        
                          --mobilni zaoschadzhenia              
                          for account in (select bars.fost(a1.acc,trunc(cust.date_to)) as end_bal, 
                                                 gl.p_icurval(nvl(a1.kv, 980),fost(a1.acc,trunc(cust.date_to)), cust.date_to) as end_balq,
                                                 nvl(w.acc_2625d, a.acc) as acc , nvl(a1.nls, a.nls) as nls, 
                                                 a.kv, a.kf, nvl(a1.tip, a.tip) as tip, w.acc_2628
                                         from accounts a
                                         join w4_acc w on a.acc = w.acc_pk
                                         left join accounts a1 on a1.acc = w.acc_2625d
                                        where a.rnk=cust.rnk
                                          and a.nbs in ('2625','2620') and w.acc_2628 is not null) loop

                                        l_eds_dpt_data.extend;
                                        l_eds_dpt_data(l_eds_dpt_data.last).req_id:=cust.id;
                                        l_eds_dpt_data(l_eds_dpt_data.last).rnk:=cust.rnk;
                                        l_eds_dpt_data(l_eds_dpt_data.last).acc:=account.acc;
                                        l_eds_dpt_data(l_eds_dpt_data.last).nls:=account.nls;
                                        l_eds_dpt_data(l_eds_dpt_data.last).kv:=account.kv;
                                        l_eds_dpt_data(l_eds_dpt_data.last).open_in:=cust.attribute_value;
                                        l_eds_dpt_data(l_eds_dpt_data.last).end_bal:=account.end_bal;
                                        l_eds_dpt_data(l_eds_dpt_data.last).end_balq:=account.end_balq;
                                        l_eds_dpt_data(l_eds_dpt_data.last).kf:=account.kf;
                                        l_eds_dpt_data(l_eds_dpt_data.last).tip:=account.tip;
                                        
                                       begin
                                        if account.kv = 980 then
                                           select sum(case when o.dk=1 and a1.nbs='7040' then o.s else 0 end) as sum_proc,
                                                  sum(case when o.dk=1 and a1.nbs='7040' then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_procq,
                                                  sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22='37' then o.s else 0 end) as sum_pdfo,
                                                  sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22='37' then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_pdfoq,
                                                  sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22='36' then o.s else 0 end) as sum_mil,
                                                  sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22='36' then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_milq,
                                                  sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22 in ('36','37') then o.s else 0 end) as sum_totaly, 
                                                  sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22 in ('36','37') then gl.p_icurval(account.kv ,o.s, o.fdat) else 0 end) as sum_totalyq                                              
                                             into l_eds_dpt_data(l_eds_dpt_data.last).sum_proc,   l_eds_dpt_data(l_eds_dpt_data.last).sum_procq, 
                                                  l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfo,   l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfoq,
                                                  l_eds_dpt_data(l_eds_dpt_data.last).sum_mil,    l_eds_dpt_data(l_eds_dpt_data.last).sum_milq,
                                                  l_eds_dpt_data(l_eds_dpt_data.last).sum_totaly, l_eds_dpt_data(l_eds_dpt_data.last).sum_totalyq                        
                                            from opldok o
                                            join opldok o2 on o.ref = o2.ref and o2.dk = 1-o.dk and  o2.stmt = o.stmt
                                            join accounts a1 on a1.acc = o2.acc and a1.nbs in ('3622', '7040')   
                                           where o.acc = account.acc_2628 
                                             and o.kf = account.kf
                                             and o.fdat between cust.date_from and cust.date_to
                                            group by o.acc;
                                        else
                                           select sum(case when o.dk=1 and op.nlsb like '2628%' and op.nazn like '%Моб.%' then o.s else 0 end) as sum_proc,
                                                  sum(case when o.dk=1 and op.nlsb like '2628%' and op.nazn like '%Моб.%' then gl.p_icurval(op.kv ,o.s, o.fdat) else 0 end) as sum_procq,
                                                  sum(case when o.dk=0 and substr(op.nlsb, 1, 4) in ('3622', '3800') and op.nazn = 'Cl Deposit Saving Profitt Interest Fee' then o.s else 0 end) as sum_pdfo,
                                                  sum(case when o.dk=0 and substr(op.nlsb, 1, 4) in ('3622', '3800') and op.nazn = 'Cl Deposit Saving Profitt Interest Fee' then gl.p_icurval(op.kv ,o.s, o.fdat) else 0 end) as sum_pdfoq,
                                                  sum(case when o.dk=0 and substr(op.nlsb, 1, 4) in ('3622', '3800') and op.nazn = 'PDFO BCU Account Transfer' then o.s else 0 end) as sum_mil,
                                                  sum(case when o.dk=0 and substr(op.nlsb, 1, 4) in ('3622', '3800') and op.nazn = 'PDFO BCU Account Transfer' then gl.p_icurval(op.kv ,o.s, o.fdat) else 0 end) as sum_milq,
                                                  sum(case when o.dk=0 and substr(op.nlsb, 1, 4) in ('3622', '3800') and op.nazn in ('PDFO BCU Account Transfer', 'Cl Deposit Saving Profitt Interest Fee') then o.s else 0 end) as sum_totaly, 
                                                  sum(case when o.dk=0 and substr(op.nlsb, 1, 4) in ('3622', '3800') and op.nazn in ('PDFO BCU Account Transfer', 'Cl Deposit Saving Profitt Interest Fee') then gl.p_icurval(op.kv ,o.s, o.fdat) else 0 end) as sum_totalyq                                                                   
                                             into l_eds_dpt_data(l_eds_dpt_data.last).sum_proc,   l_eds_dpt_data(l_eds_dpt_data.last).sum_procq, 
                                                  l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfo,   l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfoq,
                                                  l_eds_dpt_data(l_eds_dpt_data.last).sum_mil,    l_eds_dpt_data(l_eds_dpt_data.last).sum_milq,
                                                  l_eds_dpt_data(l_eds_dpt_data.last).sum_totaly, l_eds_dpt_data(l_eds_dpt_data.last).sum_totalyq   
                                            from opldok o
                                            join oper op on op.ref = o.ref and op.kf = o.kf
                                           where o.acc = account.acc_2628 
                                             and substr(op.nlsb, 1, 4) in ('2628', '3622', '3800')
                                             and o.kf = account.kf
                                             and o.fdat between cust.date_from and cust.date_to
                                            group by o.acc;
                                        end if;
                                         exception when no_data_found then
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_proc:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfo:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_mil:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_totaly:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_procq:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_pdfoq:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_milq:=0;
                                             l_eds_dpt_data(l_eds_dpt_data.last).sum_totalyq:=0;
                                         end;
                                        end loop;
                            --cc_deals
                          for credit in (select s.nd, s.kf, c.vidd, abs(bars.fost(a.acc,cust.date_to)) as BAL_DEBT,
                                                a.kv, s.proc_sum, s.credit_sum, s.proc_sum + s.credit_sum as sum_totaly, c.sdate, c.sdog*100 as sum_zagal
                                         from
                                        (select n.nd, n.kf,
                                        GREATEST (
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip in ('SN', 'SPN')  then bars.gl.p_Icurval(a.kv, s.kos, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SPN' then bars.gl.p_Icurval(a.kv, s.DOS, s.fdat) else 0 end),0),gl.bd)
                                        ,0) as proc_sum,

                                        GREATEST (
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip in ('SS', 'SP') then bars.gl.p_Icurval (a.kv, s.kos, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SP' then bars.gl.p_Icurval (a.kv, s.DOS, s.fdat) else 0 end),0),gl.bd)
                                        ,0) as credit_sum
                                         FROM bars.accounts a
                                              join bars.nd_acc n on n.acc = a.acc and a.kf = n.kf
                                              join bars.saldoa s on s.acc = a.acc and a.kf = s.kf
                                         WHERE s.fdat BETWEEN cust.date_from AND cust.date_to
                                           and a.rnk=cust.rnk
                                           AND a.tip IN ('SS', 'SP', 'SN', 'SPN')
                                         group by  n.nd, n.kf) s
                                         join bars.nd_acc n on n.nd = s.nd and n.kf = s.kf
                                         join bars.cc_deal c on c.nd = s.nd and c.kf = s.kf
                                         join accounts a on n.acc = a.acc and n.kf = a.kf and a.tip='SS' and (a.dazs >= cust.date_from or a.dazs is null)
                                         where c.wdate>=cust.date_from)
                                         loop
                                         l_eds_credit_data.extend;
                                         l_eds_credit_data(l_eds_credit_data.last).req_id:=cust.id;
                                         l_eds_credit_data(l_eds_credit_data.last).rnk:=cust.rnk;
                                         l_eds_credit_data(l_eds_credit_data.last).nd:=credit.nd;
                                         l_eds_credit_data(l_eds_credit_data.last).vidd:=credit.vidd;
                                         l_eds_credit_data(l_eds_credit_data.last).kv:=credit.kv;
                                         l_eds_credit_data(l_eds_credit_data.last).open_in:=cust.attribute_value;
                                         l_eds_credit_data(l_eds_credit_data.last).sdate:=credit.sdate;
                                         l_eds_credit_data(l_eds_credit_data.last).balance_debt:=credit.bal_debt;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_proc:=credit.proc_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_principal:=credit.credit_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_totaly_credit:=credit.sum_totaly;
                                         l_eds_credit_data(l_eds_credit_data.last).kf:=credit.kf;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_zagal:= credit.sum_zagal;
                                         l_eds_credit_data(l_eds_credit_data.last).credit_type:= 'CC_DEALS';
                                         end loop;
                           --instolment              
                          for credit in (select kv, chain_idt, posting_date, 
                                               sum(BAL_DEBT) over (partition by acc) + BAL_9129 as total_amount,
                                               BAL_DEBT, proc_sum, credit_sum, proc_sum + credit_sum as sum_totaly, kf 
                                          from (
                                                select a.acc, a.kv,
                                                       i.chain_idt,
                                                       t.posting_date,
                                                       max(case when a1.tip = 'ISS' then abs(bars.fost(a1.acc,cust.date_to)) else null end) as BAL_DEBT,
                                                       max(abs(bars.fost(a2.acc,cust.date_to))) as BAL_9129,
                                                       GREATEST(
                                                       bars.gl.p_ncurval(980,NVL(sum(case when a1.tip in ('IKN', 'IPN') then bars.gl.p_Icurval(a1.kv, s.kos, s.fdat) else 0 end), 0),gl.bd)-
                                                       bars.gl.p_ncurval(980,NVL(sum(case when a1.tip = 'IPN' then bars.gl.p_Icurval(a1.kv, s.dos, s.fdat) else 0 end), 0),gl.bd), 0) as proc_sum,
                                                       GREATEST(
                                                       bars.gl.p_ncurval(980,NVL(sum(case when a1.tip in ('ISS', 'ISP') then bars.gl.p_Icurval(a1.kv, s.kos, s.fdat) else 0 end), 0),gl.bd) -
                                                       bars.gl.p_ncurval(980,NVL(sum(case when a1.tip = 'ISP' then bars.gl.p_Icurval(a1.kv, s.dos, s.fdat) else 0 end), 0),gl.bd), 0) as credit_sum,
                                                       a.kf
                                                  from accounts a
                                                  join w4_acc w on a.acc = w.acc_pk
                                                  join accounts a2 on w.acc_9129i = a2.acc
                                                  left join w4_acc_inst i on a.acc = i.acc_pk
                                                  left join accounts a1 on i.acc = a1.acc                                           
                                                  left join ow_inst_totals t on i.chain_idt = t.chain_idt and (t.end_date_f is not null or t.end_date_f >= cust.date_from)
                                                  left join bars.saldoa s on s.acc = a1.acc and s.kf = a1.kf and s.fdat BETWEEN cust.date_from AND cust.date_to
                                                 where a.rnk = cust.rnk 
                                                   and substr(a.nls, 1, 4) in ('2620', '2625') 
                                                   and (a.dazs >= cust.date_from or a.dazs is null)
                                              group by a.acc, a.kv, a.kf, i.chain_idt, t.posting_date))
                                         loop
                                         l_eds_credit_data.extend;
                                         l_eds_credit_data(l_eds_credit_data.last).req_id:=cust.id;
                                         l_eds_credit_data(l_eds_credit_data.last).rnk:=cust.rnk;
                                         l_eds_credit_data(l_eds_credit_data.last).nd:=credit.chain_idt;
                                         l_eds_credit_data(l_eds_credit_data.last).vidd:=null;
                                         l_eds_credit_data(l_eds_credit_data.last).kv:=credit.kv;
                                         l_eds_credit_data(l_eds_credit_data.last).open_in:=cust.attribute_value;
                                         l_eds_credit_data(l_eds_credit_data.last).sdate:=credit.posting_date;
                                         l_eds_credit_data(l_eds_credit_data.last).balance_debt:=credit.bal_debt;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_proc:=credit.proc_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_principal:=credit.credit_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_totaly_credit:=credit.sum_totaly;
                                         l_eds_credit_data(l_eds_credit_data.last).kf:=credit.kf;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_zagal:= credit.total_amount;
                                         l_eds_credit_data(l_eds_credit_data.last).credit_type:= 'INSTALLMENT';
                                         end loop; 
                          --bpk              
                          for credit in (with w4 as (select ND, ACC_PK, ACC_FILD, ACC 
                                                       from ( select nd, ACC_PK, ACC_2207, ACC_2208, ACC_2209, ACC_OVR, ACC_9129
                                                                from W4_ACC) 
                                                             unpivot (ACC FOR ACC_FILD IN (ACC_2207, ACC_2208, ACC_2209, ACC_OVR, ACC_9129)))
                                        select a.kv,
                                               w4.nd,
                                               max(case when w4.ACC_FILD = 'ACC_9129' then a1.daos else null end) as daos,
                                               max(case when w4.ACC_FILD = 'ACC_OVR' then abs(bars.fost(a1.acc,cust.date_to)) else 0 end) as BAL_DEBT,
                                               max(case when w4.ACC_FILD = 'ACC_OVR' then abs(bars.fost(a1.acc,cust.date_to)) else 0 end) + 
                                               max(case when w4.ACC_FILD = 'ACC_9129' then abs(bars.fost(a1.acc,cust.date_to)) else 0 end) as dog_sum,
                                               GREATEST(
                                                        bars.gl.p_ncurval(980,NVL(sum(case when w4.ACC_FILD in ('ACC_2208', 'ACC_2209') then bars.gl.p_Icurval(a1.kv, s.kos, s.fdat) else 0 end), 0),gl.bd)-
                                                        bars.gl.p_ncurval(980,NVL(sum(case when w4.ACC_FILD = 'ACC_2209' then bars.gl.p_Icurval(a1.kv, s.dos, s.fdat) else 0 end), 0),gl.bd), 0) as proc_sum,
                                               GREATEST(
                                                        bars.gl.p_ncurval(980,NVL(sum(case when w4.ACC_FILD in ('ACC_OVR', 'ACC_2207') then bars.gl.p_Icurval(a1.kv, s.kos, s.fdat) else 0 end), 0),gl.bd) -
                                                        bars.gl.p_ncurval(980,NVL(sum(case when w4.ACC_FILD = 'ACC_2207' then bars.gl.p_Icurval(a1.kv, s.dos, s.fdat) else 0 end), 0),gl.bd), 0) as credit_sum,
                                               GREATEST(
                                                        bars.gl.p_ncurval(980,NVL(sum(case when w4.ACC_FILD in ('ACC_2208', 'ACC_OVR', 'ACC_2207') then bars.gl.p_Icurval(a1.kv, s.kos, s.fdat) else 0 end), 0),gl.bd)-
                                                        bars.gl.p_ncurval(980,NVL(sum(case when w4.ACC_FILD in ('ACC_2209', 'ACC_2207') then bars.gl.p_Icurval(a1.kv, s.dos, s.fdat) else 0 end), 0),gl.bd), 0) as sum_totaly,
                                               a.kf
                                          from accounts a
                                          join w4 on a.acc = w4.acc_pk
                                          left join accounts a1 on a1.acc = w4.acc and (a1.dazs is null or a1.dazs >= cust.date_from)
                                          left join saldoa s on s.acc = w4.acc and s.fdat between cust.date_from and cust.date_to
                                         where a.rnk = cust.rnk 
                                           and substr(a.nls, 1, 4) in ('2625', '2620') 
                                           and (a.dazs >= cust.date_from or a.dazs is null)   
                                         group by a.kv, w4.nd, a.kf)
                                         loop
                                         l_eds_credit_data.extend;
                                         l_eds_credit_data(l_eds_credit_data.last).req_id:=cust.id;
                                         l_eds_credit_data(l_eds_credit_data.last).rnk:=cust.rnk;
                                         l_eds_credit_data(l_eds_credit_data.last).nd:=credit.nd;
                                         l_eds_credit_data(l_eds_credit_data.last).vidd:=null;
                                         l_eds_credit_data(l_eds_credit_data.last).kv:=credit.kv;
                                         l_eds_credit_data(l_eds_credit_data.last).open_in:=cust.attribute_value;
                                         l_eds_credit_data(l_eds_credit_data.last).sdate:=credit.daos;
                                         l_eds_credit_data(l_eds_credit_data.last).balance_debt:=credit.bal_debt;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_proc:=credit.proc_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_principal:=credit.credit_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_totaly_credit:=credit.sum_totaly;
                                         l_eds_credit_data(l_eds_credit_data.last).kf:=credit.kf;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_zagal:= credit.dog_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).credit_type:= 'BPK';
                                         end loop;
                          --over              
                          for credit in (select s.nd, s.kf, c.sdate, c.vidd, abs(bars.fost(a.acc,cust.date_to)) as BAL_DEBT,
                                                a.kv, s.proc_sum, s.credit_sum, s.proc_sum + s.credit_sum as sum_totaly, sumzagal.sum_zagal as sum_zagal, a.tip
                                                from
                                        (select n.nd, n.kf,
                                        GREATEST (
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip in ('SN', 'SPN')  then bars.gl.p_Icurval(a.kv, s.kos, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SPN' then bars.gl.p_Icurval(a.kv, s.DOS, s.fdat) else 0 end),0),gl.bd)
                                        ,0) as proc_sum,

                                        GREATEST (
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip in ('OVN', 'SP') then bars.gl.p_Icurval (a.kv, s.kos, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SP' then bars.gl.p_Icurval (a.kv, s.DOS, s.fdat) else 0 end),0),gl.bd)
                                        ,0) as credit_sum
                                         FROM bars.accounts a
                                              join bars.nd_acc n on n.acc = a.acc and a.kf = n.kf
                                              join bars.saldoa s on s.acc = a.acc and a.kf = s.kf
                                         WHERE s.fdat BETWEEN cust.date_from AND cust.date_to
                                           and a.rnk=cust.rnk
                                           AND a.tip IN ('OVN', 'SP', 'SN', 'SPN')
                                         group by  n.nd, n.kf) s
                                         join bars.nd_acc n on n.nd = s.nd and n.kf = s.kf
                                         join bars.cc_deal c on c.nd = s.nd and c.kf = s.kf
                                         join accounts a on n.acc = a.acc and n.kf = a.kf and a.tip='OVN' and (a.dazs >= cust.date_from or a.dazs is null)
                                         left join (select na.nd,a.acc, min(a.dos) keep (dense_rank first order by a.fdat) as sum_zagal
                                                      from bars.saldoa a, bars.accounts a1, bars.nd_acc na
                                                     where a1.acc=na.acc and a.acc=a1.acc and a1.nbs=9129
                                                     group by na.nd,a.acc)   sumzagal on sumzagal.nd=c.nd
                                         where c.wdate>=cust.date_from and c.vidd in (10, 110))
                                         loop
                                         l_eds_credit_data.extend;
                                         l_eds_credit_data(l_eds_credit_data.last).req_id:=cust.id;
                                         l_eds_credit_data(l_eds_credit_data.last).rnk:=cust.rnk;
                                         l_eds_credit_data(l_eds_credit_data.last).nd:=credit.nd;
                                         l_eds_credit_data(l_eds_credit_data.last).vidd:=credit.vidd;
                                         l_eds_credit_data(l_eds_credit_data.last).kv:=credit.kv;
                                         l_eds_credit_data(l_eds_credit_data.last).open_in:=cust.attribute_value;
                                         l_eds_credit_data(l_eds_credit_data.last).sdate:=credit.sdate;
                                         l_eds_credit_data(l_eds_credit_data.last).balance_debt:=credit.bal_debt;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_proc:=credit.proc_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).amount_pay_principal:=credit.credit_sum;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_totaly_credit:=credit.sum_totaly;
                                         l_eds_credit_data(l_eds_credit_data.last).kf:=credit.kf;
                                         l_eds_credit_data(l_eds_credit_data.last).sum_zagal:= credit.sum_zagal;
                                         l_eds_credit_data(l_eds_credit_data.last).credit_type:= 'OVER';
                                         end loop;
       end loop;
         if l_eds_w4_data.count <> 0 then
         forall j in l_eds_w4_data.first..l_eds_w4_data.last
           insert into eds_w4_data values l_eds_w4_data(j);
         end if;

         if l_eds_dpt_data.count <> 0 then
         forall j in l_eds_dpt_data.first..l_eds_dpt_data.last
           insert into eds_dpt_data values l_eds_dpt_data(j);
         end if;

         if l_eds_credit_data.count <> 0 then
         forall j in l_eds_credit_data.first..l_eds_credit_data.last
           insert into eds_credit_data values l_eds_credit_data(j);
         end if; 
         
         l_decl_id:= s_eds_decls.nextval;
         
         update eds_decl e
            set e.state=st_declaration_prepared,
                e.decl_id = l_decl_id,
                e.prepare_date = sysdate
         where e.id=p_req_id;
         
         p_id := l_decl_id; 
     exception when others then
         rollback to bef_form;
         update eds_decl e
            set e.state = st_declaration_rejected,
                e.comm = substr(e.comm||' -edecl-'||p_req_id|| ' error crt_decl '|| dbms_utility.format_error_stack || ' ' || dbms_utility.format_error_backtrace, 1, 255),
                e.prepare_date = sysdate
         where e.id = p_req_id;
         bars.logger.info('edecl-'||p_req_id|| ' error crt_decl '|| dbms_utility.format_error_stack || ' ' || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
end;

procedure fill_data(p_req_id varchar2) is
l_decl_id number;
begin
fill_data(p_req_id, l_decl_id);
end;

--create_fill_job----------------------------------------------------------------------------
  procedure create_fill_job(p_id varchar2) is
     l_jobname varchar2(30);
 begin
     l_jobname := substr('COLLECT_EDECL_' || replace(p_id, '-', ''),1,30);
     dbms_scheduler.create_job(l_jobname ,program_name=>'EDS_INTG_FILL_DATA_ASINC', auto_drop  => true);
     dbms_scheduler.set_job_argument_value(l_jobname, 1, p_id);
     dbms_scheduler.enable(l_jobname);
 exception
     when others then
         dbms_scheduler.drop_job(l_jobname, force => true);
end create_fill_job;

 function get_ex_decl(p_eds_decl eds_decl%rowtype) return number is
 l_id          number;
 begin
     begin
      if p_eds_decl.doc_type = 7 then
       select max(d.decl_id) into l_id
       from eds_decl d
       where d.okpo =       p_eds_decl.okpo
         and d.doc_type =   p_eds_decl.doc_type
         and d.doc_number = p_eds_decl.doc_number
         and d.birth_date = p_eds_decl.birth_date
         and d.date_from =  p_eds_decl.DATE_FROM
         and d.date_to =    p_eds_decl.DATE_TO
         and d.state =      st_declaration_prepared;
     else
        select max(d.decl_id) into l_id
       from eds_decl d
       where d.okpo = p_eds_decl.okpo
         and d.doc_type = p_eds_decl.doc_type
         and d.doc_number = p_eds_decl.doc_number
         and d.doc_serial = p_eds_decl.doc_serial
         and d.birth_date =  p_eds_decl.birth_date
         and d.date_from = p_eds_decl.DATE_FROM
         and d.date_to = p_eds_decl.DATE_TO
         and d.state = st_declaration_prepared;
     end if;
       exception when no_data_found then
       l_id:=null;
    end;
    return l_id;
 end;
 
 procedure clear_old_decl(p_id number) is
    l_id varchar2(40);
 begin
 begin
 select id into l_id from eds_decl d where d.decl_id = p_id;
 exception when no_data_found then
 l_id := null;
 end;
      delete eds_w4_data w where w.req_id  = l_id;
      delete eds_dpt_data d where d.req_id  = l_id;
      delete eds_credit_data c where c.req_id  = l_id;
      delete eds_curs_rates r where r.req_id  = l_id;
      update eds_decl e 
         set e.state = st_declaration_new_ex
      where e.id  = l_id and e.state in (st_declaration_prepared, 
                                         st_declaration_error);
 end;
 
  
  -----------------------------------------------------------------------------------------
  --  create_request
  --
  --    Реєстрація запиту в системі
  --
  procedure create_request(
    p_okpo       in eds_decl.okpo%type,
    p_birth_date in eds_decl.birth_date%type,
    p_doc_type   in eds_decl.doc_type%type,
    p_doc_serial in eds_decl.doc_serial%type,
    p_doc_number in eds_decl.doc_number%type,
    p_date_from  in eds_decl.date_from%type,
    p_date_to    in eds_decl.date_to%type,
    p_name       in eds_decl.cust_name%type,
    p_comm       in eds_decl.comm%type,
    p_decl_id    in out number
    )
  is
    l_decl_id           number;
    l_eds_decl          eds_decl%rowtype;
    l_eds_decls_policy  eds_decls_policy%rowtype;
    l_act               varchar2(255) := gc_pkg||'.create_request ';
  begin
  if p_decl_id is null then
    l_eds_decl.id          := get_guid;
    l_eds_decl.crt_date    := sysdate;
    l_eds_decl.state       := st_declaration_register;   
    l_eds_decl.okpo        := p_okpo;
    l_eds_decl.cust_name   := p_name;
    l_eds_decl.birth_date  := p_birth_date;
    l_eds_decl.doc_type    := p_doc_type;
    l_eds_decl.doc_serial  := p_doc_serial;
    l_eds_decl.doc_number  := p_doc_number;
    l_eds_decl.date_from   := p_date_from;
    l_eds_decl.date_to     := p_date_to;
    l_eds_decl.comm        := p_comm;
    l_eds_decl.doneby      := user_id;
    l_eds_decl.doneby_fio  := user_name;
    l_eds_decl.branch      := sys_context('bars_context','user_branch');
  else
  select * into l_eds_decl from eds_decl e where decl_id = p_decl_id;
    l_eds_decl.id          := get_guid;
    l_eds_decl.decl_id     := null;    
    l_eds_decl.crt_date    := sysdate;
    l_eds_decl.state       := st_declaration_register;
    l_eds_decl.doneby      := user_id;
    l_eds_decl.doneby_fio  := user_name;
    l_eds_decl.branch      := sys_context('bars_context','user_branch');
  end if;    
    l_eds_decls_policy.id       := l_eds_decl.id;
    l_eds_decls_policy.add_date := sysdate;
    l_eds_decls_policy.add_id   := user_id;
    
    if p_decl_id is null then
        l_decl_id:= get_ex_decl(l_eds_decl);
    else
        clear_old_decl(p_decl_id);
        l_decl_id:=null;
    end if;
    if l_decl_id is null then
        add_new_decl(l_eds_decl, l_eds_decls_policy);
        set_decl_status(l_eds_decl.id ,st_declaration_register);
        eds_intg.create_fill_job(l_eds_decl.id);
    end if;
    p_decl_id:=l_decl_id;

  exception
    when others then
    bars.logger.info(l_act||l_eds_decl.id|| ' error crt_decl '|| dbms_utility.format_error_stack || ' ' || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
    raise_application_error(-20000, '<b>Помилка формування декларації</b>'||chr(10)|| dbms_utility.format_error_stack || ' ' || dbms_utility.format_error_backtrace);
  end create_request; 
  
--for oshad 24
 procedure pocess_request(p_transp_id varchar2)
  is
    l_buff              varchar2(4000);
    l_mfo               varchar2(6);
    l_id                varchar2(36);
    l_decl_id           number;
    l_act               varchar2(255) := gc_pkg||'.parse_request ';
    l_eds_decl          eds_decl%rowtype;
    unknown_action_type exception;
  begin
        select rq.d_clob
          into l_buff
          from barstrans.input_reqs rq
         where rq.id = p_transp_id;
        begin
            select p.value
              into l_mfo
              from barstrans.input_req_params p
             where p.req_id = p_transp_id
               and p.tag = 'MFO'
               and p.param_type = 'GET';
        exception
            when no_data_found then
                l_mfo:='300465';
        end;

    log_crt_req(p_transp_id, l_mfo, l_buff, l_id);
    l_eds_decl:=xml_2_obj(l_buff);
    l_eds_decl.id := l_id;
    
    l_decl_id:= get_ex_decl(l_eds_decl);
    
    if l_decl_id is null then
        l_eds_decl.state:= st_request_new;
        add_new_decl(l_eds_decl); 
        upd_log_req_status(l_eds_decl.id, st_declaration_register);
        fill_data(l_eds_decl.id, l_decl_id);
        l_buff:=crt_xml(l_decl_id);
        add_log_req_resp(l_id, st_declaration_prepared, l_buff, l_decl_id);
        barstrans.transp_utl.add_resp(p_transp_id, l_buff);
    else
        l_buff:=crt_xml(l_decl_id);
        add_log_req_resp(l_id, st_declaration_prepared, l_buff, l_decl_id);
        barstrans.transp_utl.add_resp(p_transp_id, l_buff);
    end if;
end pocess_request;

procedure delete_old_data is
l_vc2list varchar2_list;
cursor old_date is 
(select id from eds_decl d where d.prepare_date < add_months(sysdate, -1));
begin
open old_date;
loop
fetch old_date bulk collect into l_vc2list limit 1000;
    if l_vc2list.count = 0 then 
        exit; 
    end if;    
    forall i in l_vc2list.first..l_vc2list.last
      delete eds_w4_data w where w.req_id  = l_vc2list(i);
    forall i in l_vc2list.first..l_vc2list.last
      delete eds_dpt_data d where d.req_id  = l_vc2list(i);
    forall i in l_vc2list.first..l_vc2list.last
      delete eds_credit_data c where c.req_id  = l_vc2list(i);
    forall i in l_vc2list.first..l_vc2list.last
      delete eds_curs_rates r where r.req_id  = l_vc2list(i);
    forall i in l_vc2list.first..l_vc2list.last
      update eds_decl e 
         set e.state = st_declaration_deleted
      where e.id  = l_vc2list(i) and e.state in (st_declaration_prepared, 
                                                 st_declaration_error,
                                                 st_declaration_new_ex);
    l_vc2list.delete;
end loop;
close old_date;
end;

end eds_intg;
/
