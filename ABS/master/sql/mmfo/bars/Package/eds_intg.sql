create or replace package eds_intg is

  gc_header_version constant varchar2(64)  := 'version 1.1 26.12.2018';

  -- eds_request.act_type
  req_DECLARATION_DATA  constant number := 1; -- Запит на підготовку декларації
  req_DECLARATION_STATE constant number := 2; -- Запит на стан підготовки декларації

  -- eds_request.state
  st_REQUEST_NEW        constant number := -1; -- Новий запит
  st_REQUEST_CREATED    constant number := 0; -- Запит зареєстровано

  -- eds_request_audit.state
  st_DECLARATION_REGISTER constant number := 0; -- Запит зареєстровано
  st_DECLARATION_PREPARED constant number := 1; -- Декларація підготовлена
  st_DECLARATION_ERROR    constant number := 2; -- Помилка підготовки декларації
  st_DECLARATION_REJECTED constant number := 3; -- Декларацію відхилено

  TYPE T_EDS_W4_DATA IS TABLE of EDS_W4_DATA%rowtype;
  TYPE T_EDS_DPT_DATA IS TABLE of eds_dpt_data%rowtype;
  TYPE T_EDS_CREDIT_DATA IS TABLE of eds_credit_data%rowtype;

  function get_guid return varchar2;

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
    p_name       in eds_decl.cust_name%type default null,
    p_comm       in eds_decl.comm%type default null
    );

  procedure decl_search(p_decl_id number, p_resp out number);
  -----------------------------------------------------------------------------------------

  procedure create_report(P_TRANSTP_ID VARCHAR2);
  -------------------------------------------------------------
  procedure pocess_request(p_transp_id varchar2);
  procedure set_data_request_state( p_decl in int ,p_state_req int);
  procedure send_decl_id (p_decl_id varchar2);
  procedure fill_data(p_req_id varchar2 ,p_kf varchar2);
  
end eds_intg;
/

CREATE OR REPLACE package body BARS.eds_intg is

  gc_body_version constant varchar2(64) := 'version 1.1 26.12.2018';
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
        insert into EDS_DECLS_POLICY values p_eds_decls_policy;
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
 -------------------------
  --  set_request_state
procedure log_crt_req(p_transp_id varchar2, p_kf varchar2, p_req_body varchar2, p_id out varchar2) is
      pragma autonomous_transaction;
      l_id varchar2(36);
  begin
      l_id:=xml_extract(xmltype(p_req_body), '/ROOT/ID/text()');
      insert into EDS_CRT_REQ_LOG
          (ID, TRANSP_REQ_ID, SO_KF, REQ_USER_ID, REQ_TIME, REQ_BODY, REQ_STATUS)
      values
          (coalesce(l_id, get_guid),
           p_transp_id,
           p_kf,
           user_id,
           sysdate,
           p_req_body,
           st_REQUEST_NEW) returning ID into l_id;
      commit;
      p_id:= l_id;
  exception when dup_val_on_index then
     raise_application_error(-20000, 'Запит з ІД "'||l_id||'" надіснано повторно!');
  end;
  
  procedure upd_log_req_status(p_id varchar2, p_status number, p_err varchar2 default null) is 
  pragma autonomous_transaction;
  begin
    update EDS_CRT_REQ_LOG l 
       set l.REQ_STATUS = p_status,
           l.err = p_err
     where l.id = p_id;
     commit;
  end;
  
  procedure add_log_req_resp(p_id varchar2, p_status number, p_resp_body varchar2, p_decl_id number) is
  pragma autonomous_transaction;
  begin
      update EDS_CRT_REQ_LOG l 
       set l.REQ_STATUS = p_status,
           l.resp_time = sysdate,
           l.resp_body = p_resp_body,
           l.decl_id = p_decl_id
     where l.id = p_id;
     commit;
  end;
  
--------------------
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
  procedure create_report(P_TRANSTP_ID VARCHAR2) is
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
      from BARSTRANS.INPUT_REQ_PARAMS r
     where r.req_id = P_TRANSTP_ID
       and upper(r.tag) = 'DECL_ID'
       and r.param_type = 'GET';
       exception when no_data_found then
        raise_application_error(-20001,'GET Параметр DECL_ID не передано в запиті');
        end;


    select xmlroot( XmlElement("ROOT",
                    Xmlelement("FileName", 'EDECL_FR.frx'),
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

      BARSTRANS.transp_utl.add_resp(P_TRANSTP_ID, l_response.cdoc);
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
             insert into eds_decls_policy ( id, add_date, add_id, kf)
             values (l_id, sysdate, user_id, sys_context('bars_context','user_mfo'));
             p_resp:=0;
         end if;
     else
         p_resp:=1;
     end if;
  exception when others then
     p_resp:=2;
  end;
---------------------обработка данных Литвин В.Ю
procedure set_data_request_state( p_decl in int ,p_state_req int)
   is
   pragma autonomous_transaction;
   begin
       update  eds_decl t
       set    t.state=p_state_req
       where  t.decl_id=p_decl;
       commit;
end;

--set_main_status-----------------------------------------------------------------------------
 procedure set_main_status(p_id varchar2) is
  l_prepare number;
  l_err number;
  l_count_mass number;
  l_transp_id varchar2(36);
  l_decl_id number;
  l_resp varchar2(4000);
  begin

    select sum(case when l.status = st_DECLARATION_PREPARED then 1 else 0 end) as prepare,
           sum(case when l.status = st_DECLARATION_ERROR    then 1 else 0 end) as err,
           count(*) as cont_mass
           into l_prepare, l_err, l_count_mass
    from eds_send_ru_log l
    where l.req_id=p_id;
    if (l_prepare+l_err)=l_count_mass and l_err<>l_count_mass then
       l_decl_id:= S_EDS_DECLS.Nextval;
    end if;
      if (l_prepare=l_count_mass) then
         update eds_decl e
            set e.state=st_DECLARATION_PREPARED,
                e.decl_id = l_decl_id
         where e.id=p_id;
      elsif ((l_prepare+l_err)=l_count_mass) then
        update eds_decl e
           set e.state=st_DECLARATION_ERROR,
               e.decl_id = l_decl_id
        where e.id=p_id;
      elsif ((l_err)=l_count_mass) then
        update eds_decl e
           set e.state=st_DECLARATION_REJECTED
        where e.id=p_id;
      end if;
        commit;
      if (l_prepare+l_err)=l_count_mass then
          begin
          select TRANSP_REQ_ID into l_transp_id from EDS_CRT_REQ_LOG
          where ID = p_id;
          exception when no_data_found then
          l_transp_id:=null;
          end;
          
          if l_transp_id is not null then
          l_resp:=to_char(crt_xml(l_decl_id));
              if l_resp is not null then
              add_log_req_resp(p_id, st_DECLARATION_PREPARED, l_resp, l_decl_id);
              barstrans.transp_utl.add_resp(l_transp_id, l_resp);
              else
              upd_log_req_status(p_id, st_DECLARATION_ERROR, 'RESPONCE IS EMPTY');
              barstrans.transp_utl.resive_status_err(l_transp_id, l_resp);
              end if;
          end if;
      end if;

      
  end;

procedure p_cur_rates (p_req_id varchar2)
 is
 begin
   insert into eds_curs_rates (req_id,kv,name,vdate,rate_o,rate_b,rate_s)
   select e.id,c.kv,n.name,e.date_to,c.rate_o,c.rate_b,c.rate_s
       from bars.eds_decl e, bars.cur_rates c,bars.TABVAL$GLOBAL n
            where c.vdate=e.date_to and c.kv in (840,978,643) and c.kv=n.kv and e.id=p_req_id;
end;

procedure crt_data_set(p_req_id varchar2,
                         p_w4_ out T_EDS_W4_DATA,
                         p_dpt out T_EDS_DPT_DATA,
                         p_credit out T_EDS_CREDIT_DATA) is
       EDS_w4_DATA T_EDS_W4_DATA := T_EDS_W4_DATA();
       EDS_DPT_DATA T_EDS_DPT_DATA := T_EDS_DPT_DATA();
       EDS_CREDIT_DATA T_EDS_CREDIT_DATA := T_EDS_CREDIT_DATA();

  begin
  for cust in (select i.id, c.okpo, c.rnk, c.kf, i.date_from, i.date_to
                      from person p, customer c, eds_decl i
                     where p.rnk=c.rnk
                       and c.okpo=i.okpo
                       and p.passp= i.doc_type
                       and p.numdoc=i.doc_number
                       and p.bday= i.birth_date
                       and i.id = p_req_id
                       and case when i.doc_type = 7
                                then '1' else p.ser end =
                           case when i.doc_type = 7
                           then '1' else i.doc_serial end) loop

                       for account in (select bars.fost(a.acc,trunc(cust.date_to)) as END_BAL, a.acc, a.nls, a.nbs, a.kv, b.attribute_value, a.kf, w4.code, w4.grp_code,
                            case when w4.grp_code= 'SALARY' then 'SALARY'
                                           when w4.grp_code in ('PENSION', 'MOYA_KRAYINA') then 'PENSION'
                                           else 'OTHERS' end as ACC_TYPE
                                         from accounts a
                                         left join(select * from branch_attribute_value where attribute_code='NAME_BRANCH') b on b.branch_code=a.branch
                                         left join (select w4.acc_pk, w4.kf, c.code, t.grp_code
                                                     from w4_acc w4
                                                     join w4_card c on w4.card_code = c.code
                                                     join w4_product t on t.code=c.product_code
                                                    where t.grp_code in ('PENSION', 'MOYA_KRAYINA', 'SALARY')) w4 on w4.acc_pk = a.acc and w4.kf = a.kf
                                        where a.rnk=cust.rnk
                                          and a.nbs in ('2620','2625') and not exists(select 1 from w4_acc ww where ww.acc_2625d = a.acc)) loop
                                        EDS_W4_DATA.EXTEND;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).REQ_ID:=cust.id;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).RNK:=cust.rnk;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).ACC:=account.acc;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).NLS:=account.nls;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).KV:=account.kv;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).OPEN_IN:=account.attribute_value;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).ACC_TYPE:=account.ACC_TYPE;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).END_BAL:= account.END_BAL;
                                        EDS_W4_DATA(EDS_W4_DATA.LAST).KF:=account.KF;
                                        
                               begin
                               select sum(case when (account.grp_code= 'SALARY' and o.tt in ('PKS','KL1','IB6','IB5','PKB','CL5')) or
                                                    (account.grp_code in ('PENSION', 'MOYA_KRAYINA') and account.code not like 'SOC_%' and tt ='PKX') or
                                                    (account.grp_code not in ('PENSION', 'MOYA_KRAYINA', 'SALARY') or account.grp_code is null)
                                              then o.s else 0 end) as AMOUNT,
                                      sum(case when (account.grp_code= 'SALARY' and tt not in ('PKS','KL1','IB6','IB5','PKB','CL5')) or
                                                    (account.grp_code in ('PENSION', 'MOYA_KRAYINA') and account.code not like 'SOC_%' and tt <>'PKX')
                                               then o.s else 0 end) AMOUNT_OTH
                                        into EDS_W4_DATA(EDS_W4_DATA.LAST).AMOUNT_PERIOD, EDS_W4_DATA(EDS_W4_DATA.LAST).OTHER_ACCRUALS
                                        from opldok o
                                        where o.acc=account.acc
                                          and o.kf = account.kf
                                          and o.dk=1
                                          and o.fdat between cust.date_from and cust.date_to
                                        group by o.acc;
                               exception when no_data_found then
                                   EDS_W4_DATA(EDS_W4_DATA.LAST).AMOUNT_PERIOD:=0;
                                   EDS_W4_DATA(EDS_W4_DATA.LAST).OTHER_ACCRUALS:=0;
                               end;
                                        end loop;
                       --deposit
                       for account in (select bars.fost(a.acc,trunc(cust.date_to)) as END_BAL, a.acc, a.nls, a.nbs, a.kv, b.attribute_value, a.kf,a.tip, acc_pp.acc as acc_dpt
                                         from accounts a
                                         left join (select dpa.accid, a1.acc from dpt_accounts dpa
                                                            join dpt_accounts dpa1 on dpa1.dptid=dpa.dptid                                           
                                                            join accounts a1 on a1.acc=dpa1.accid and a1.nbs='2638') acc_pp on acc_pp.accid=a.acc
                                         left join (select * from branch_attribute_value where attribute_code='NAME_BRANCH') b on b.branch_code=a.branch
                                        where a.rnk = cust.rnk
                                          and a.nbs = '2630') loop

                                        EDS_DPT_DATA.EXTEND;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).REQ_ID:=cust.id;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).RNK:=cust.rnk;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).ACC:=account.acc;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).NLS:=account.nls;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).KV:=account.kv;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).OPEN_IN:=account.attribute_value;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).END_BAL:=account.END_BAL;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).KF:=account.kf;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).TIP:=account.tip;
                                        
                                       begin
                                       select sum(case when o.tt ='%%1' then o.s else 0 end) as sum_proc,
                                              sum(case when o.tt ='%15' then o.s else 0 end) as sum_pdfo,
                                              sum(case when o.tt ='MIL' then o.s else 0 end) as sum_mil,
                                              sum(case when o.tt in ('MIL','%15') then o.s else 0 end) as sum_totaly
                                              into EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PROC, EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PDFO,
                                                   EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_MIL, EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_TOTALY
                                         from opldok o
                                        where o.acc = account.acc_dpt
                                          and o.kf = account.kf
                                          and o.fdat between cust.date_from and cust.date_to
                                        group by o.acc;
                                         exception when no_data_found then
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PROC:=0;
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PDFO:=0;
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_MIL:=0;
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_TOTALY:=0;
                                         end;
                                        end loop;
                                        
                          --mobilni zaoschadzhenia              
                          for account in (select bars.fost(a.acc,trunc(cust.date_to)) as END_BAL, a.acc, a.nls, a.nbs, a.kv, b.attribute_value, a.kf, a.tip, w.acc_2628
                                         from accounts a
                                         join w4_acc w on a.acc = w.acc_2625d
                                         left join(select * from branch_attribute_value where attribute_code='NAME_BRANCH') b on b.branch_code=a.branch
                                        where a.rnk=cust.rnk
                                          and a.nbs in ('2625','2620')) loop

                                        EDS_DPT_DATA.EXTEND;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).REQ_ID:=cust.id;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).RNK:=cust.rnk;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).ACC:=account.acc;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).NLS:=account.nls;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).KV:=account.kv;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).OPEN_IN:=account.attribute_value;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).END_BAL:=account.END_BAL;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).KF:=account.kf;
                                        EDS_DPT_DATA(EDS_DPT_DATA.LAST).TIP:=account.tip;
                                        
                                       begin
                                       select sum(case when o.dk=1 and a1.nbs='7040' then o.s else 0 end) as sum_proc,
                                              sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22='37' then o.s else 0 end) as sum_pdfo,
                                              sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22='36' then o.s else 0 end) as sum_mil,
                                              sum(case when o.dk=0 and a1.nbs='3622' and a1.ob22 in ('36','37') then o.s else 0 end) as sum_totaly 
                                              into EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PROC, EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PDFO,
                                                   EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_MIL, EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_TOTALY                         
                                        from opldok o
                                        join opldok o2 on o.ref=o2.ref and o2.dk=1-o.dk and  o2.stmt=o.stmt
                                        join accounts a1 on a1.acc=o2.acc and a1.nbs in ('3622', '7040')   
                                       where o.acc = account.acc_2628 
                                         and o.kf = account.kf
                                         and o.fdat between cust.date_from and cust.date_to
                                        group by o.acc;
                                         exception when no_data_found then
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PROC:=0;
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_PDFO:=0;
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_MIL:=0;
                                             EDS_DPT_DATA(EDS_DPT_DATA.LAST).SUM_TOTALY:=0;
                                         end;
                                        end loop;

                          for credit in (select s.nd, s.kf, b.attribute_value, c.sdate, c.vidd, bars.fost(a.acc,cust.date_to) as BAL_DEBT,
                                                a.kv, s.proc_sum, s.credit_sum, s.proc_sum + s.credit_sum as sum_totaly
                                         from
                                        (select n.nd, n.kf,
                                        GREATEST (
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip IN ('SN', 'SPN') then bars.gl.p_Icurval(a.kv, s.kos, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SPN' then bars.gl.p_Icurval (a.kv, s.DOS, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SPN' then bars.gl.p_Icurval (a.kv, s.KOS, s.fdat) else 0 end),0),gl.bd)
                                        ,0) as proc_sum,

                                        GREATEST (
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip IN ('SS', 'SP') then  bars.gl.p_Icurval (a.kv, s.kos, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SP' then bars.gl.p_Icurval (a.kv, s.DOS, s.fdat) else 0 end),0),gl.bd)-
                                        bars.gl.p_ncurval(980,NVL(sum(case when a.tip = 'SP' then bars.gl.p_Icurval (a.kv, s.kos, s.fdat) else 0 end),0),gl.bd)
                                        ,0) as credit_sum
                                         FROM bars.accounts a
                                              join bars.nd_acc n on n.acc = a.acc and a.kf = n.kf
                                              join bars.saldoa s on s.acc = a.acc and a.kf = s.kf
                                         WHERE fdat BETWEEN cust.date_from AND cust.date_to
                                           and a.rnk=cust.rnk
                                           AND a.tip IN ('SS', 'SP', 'SN', 'SPN')
                                         group by  n.nd, n.kf) s
                                         join bars.nd_acc n on n.nd = s.nd and n.kf = s.kf
                                         join bars.cc_deal c on c.nd = s.nd and c.kf = s.kf
                                         join accounts a on n.acc = a.acc and n.kf = a.kf and a.tip='SS' and (a.dazs >= cust.date_from or a.dazs is null)
                                         left join(select * from branch_attribute_value where attribute_code='NAME_BRANCH') b on b.branch_code=a.branch
                                         where c.wdate>=cust.date_from
                                           and a.tip='SS'
                                           and (a.dazs >= cust.date_from or a.dazs is null))
                                         loop
                                         EDS_CREDIT_DATA.EXTEND;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).REQ_ID:=cust.id;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).RNK:=cust.rnk;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).ND:=credit.nd;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).VIDd:=credit.vidd;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).KV:=credit.kv;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).OPEN_IN:=credit.attribute_value;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).SDATE:=credit.sdate;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).BALANCE_DEBT:=credit.BAL_DEBT;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).AMOUNT_PAY_PROC:=credit.proc_sum;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).AMOUNT_PAY_PRINCIPAL:=credit.credit_sum;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).SUM_TOTALY_CREDIT:=credit.sum_totaly;
                                         EDS_CREDIT_DATA(EDS_CREDIT_DATA.LAST).KF:=credit.kf;
                                         end loop;
       end loop;
       p_w4_:=EDS_W4_DATA;
       p_dpt:=EDS_DPT_DATA;
       p_credit:=EDS_CREDIT_DATA;
end;

procedure fill_data(p_req_id varchar2 ,p_kf varchar2) is
       l_EDS_w4_DATA T_EDS_W4_DATA := T_EDS_W4_DATA();
       l_EDS_DPT_DATA T_EDS_DPT_DATA := T_EDS_DPT_DATA();
       l_EDS_CREDIT_DATA T_EDS_CREDIT_DATA := T_EDS_CREDIT_DATA();
     begin
         bc.go(p_kf);
           if p_kf = '300465' then
              eds_intg.p_cur_rates (p_req_id);
           end if; 
         crt_data_set(p_req_id,
                      l_EDS_w4_DATA,
                      l_EDS_DPT_DATA,
                      l_EDS_CREDIT_DATA);

         if l_EDS_w4_DATA.count <> 0 then
         forall j in l_EDS_w4_DATA.first..l_EDS_w4_DATA.last
           insert into EDS_w4_DATA values l_EDS_w4_DATA(j);
         end if;

         if l_EDS_DPT_DATA.count <> 0 then
         forall j in l_EDS_DPT_DATA.first..l_EDS_DPT_DATA.last
           insert into EDS_DPT_DATA values l_EDS_DPT_DATA(j);
         end if;

         if l_EDS_CREDIT_DATA.count <> 0 then
         forall j in l_EDS_CREDIT_DATA.first..l_EDS_CREDIT_DATA.last
           insert into EDS_CREDIT_DATA values l_EDS_CREDIT_DATA(j);
         end if;

         update eds_send_ru_log l
            set l.status = st_DECLARATION_PREPARED
         where l.req_id =  p_req_id
           and l.kf = p_kf;

         commit;
         set_main_status(p_req_id);

     exception when others then
         update eds_send_ru_log l
            set l.status = st_DECLARATION_ERROR
         where l.req_id = p_req_id
           and l.kf = p_kf;
         commit;
end;

--create_send_job1----------------------------------------------------------------------------
  procedure create_send_job1(p_id varchar2) is
     l_jobname varchar2(30);
     l_user_id number:=nvl(bars.USER_ID,1);
 begin
     l_jobname := substr('Collect_edecl_' || replace(p_id, '-', ''),1,30);
     dbms_scheduler.create_job(job_name   => l_jobname,
                               job_type   => 'PLSQL_BLOCK',
                               job_action => 'begin
                                                bars.bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                                                           p_userid    => '||l_user_id||',
                                                                           p_hostname  => null,
                                                                           p_appname   => null);
                                                bars.EDS_INTG.SEND_DECL_ID('''||p_id||''');
                                                bars.bars_login.logout_user;
                                              end;',
                               auto_drop  => true,
                               enabled    => true);
 exception
     when others then
         dbms_scheduler.drop_job(l_jobname, force => true);
end create_send_job1;

--run_parallel--------------------------------------------------------------------------------
procedure run_parallel(p_task           in varchar2,
                        p_chunk          in varchar2,
                        p_stmt           in varchar2,
                        p_parallel_level number) is
 begin
     dbms_parallel_execute.create_task(p_task);
     dbms_parallel_execute.create_chunks_by_sql(p_task, p_chunk, false);
     dbms_parallel_execute.run_task(p_task,
                                    p_stmt,
                                    dbms_sql.native,
                                    parallel_level => p_parallel_level);
     dbms_parallel_execute.drop_task(p_task);
end;
--send_decl_id--------------------------------------------------------------------------------
 procedure send_decl_id (p_decl_id varchar2 ) is
      l_parallel_ch number;
      l_chunk       varchar2(4000);
      l_stmt        varchar2(4000);
  begin

          insert into eds_send_ru_log (req_id,status,kf)
           select p_decl_id,st_DECLARATION_REGISTER,kf  from  mv_kf;
           commit;

          l_chunk := 'select kf as START_ID, null as END_ID from bars.mv_kf';

          l_stmt := 'begin
                   bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => 1,
                                            p_hostname  =>null ,
                                            p_appname   =>null);
                   bars.bc.go(:START_ID);

                  bars.logger.info(''run_edecl-''||'''||p_decl_id||'''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo);
                  bars.eds_intg.fill_data('''||p_decl_id||''',:START_ID);
                  --bars.bars_login.logout_user();
                 end;';

            select count(*)+1 into l_parallel_ch from mv_kf;
          run_parallel('run_edecl_' || substr(p_decl_id,1,20),
                       l_chunk,
                       l_stmt,
                       l_parallel_ch);
end;

 function get_ex_decl(p_eds_decl eds_decl%rowtype) return number is
 l_id          number;
 begin
     begin
      if p_eds_decl.doc_type = 7 then
       select d.decl_id into l_id
       from eds_decl d
       where d.okpo =       p_eds_decl.okpo
         and d.doc_type =   p_eds_decl.doc_type
         and d.doc_number = p_eds_decl.doc_number
         and d.birth_date = p_eds_decl.birth_date
         and d.date_from =  p_eds_decl.DATE_FROM
         and d.date_to =    p_eds_decl.DATE_TO
         and d.state =      st_DECLARATION_PREPARED;
     else
        select d.decl_id into l_id
       from eds_decl d
       where d.okpo = p_eds_decl.okpo
         and d.doc_type = p_eds_decl.doc_type
         and d.doc_number = p_eds_decl.doc_number
         and d.doc_serial = p_eds_decl.doc_serial
         and d.birth_date =  p_eds_decl.birth_date
         and d.date_from = p_eds_decl.DATE_FROM
         and d.date_to = p_eds_decl.DATE_TO
         and d.state = st_DECLARATION_PREPARED;
     end if;
       exception when no_data_found then
       l_id:=null;
    end;
    return l_id;
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
    p_name       in eds_decl.cust_name%type default null,
    p_comm       in eds_decl.comm%type default null
    )
  is
    l_decl_id           number;
    l_state             number;
    l_eds_decl          eds_decl%rowtype;
    l_eds_decls_policy  eds_decls_policy%rowtype;
    l_act               varchar2(255) := gc_pkg||'.create_request ';
  begin
    l_eds_decl.id          := get_guid;
    l_eds_decl.crt_date    := sysdate;
    l_eds_decl.state       := st_DECLARATION_REGISTER;   
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
    
    l_eds_decls_policy.id       := l_eds_decl.id;
    l_eds_decls_policy.add_date := sysdate;
    l_eds_decls_policy.add_id   := user_id;
    l_eds_decls_policy.kf       := f_ourmfo;
    
    l_decl_id:= get_ex_decl(l_eds_decl);
    if l_decl_id is null then
        add_new_decl(l_eds_decl, l_eds_decls_policy);
        set_decl_status(l_eds_decl.id ,st_DECLARATION_REGISTER);
        eds_intg.create_send_job1(l_eds_decl.id);
    else
        decl_search(l_decl_id, l_state);
    end if;
    
    if l_state in (2, 3) then
        add_new_decl(l_eds_decl, l_eds_decls_policy);
        set_decl_status(l_eds_decl.id ,st_DECLARATION_REJECTED);
    end if;

  exception
    when others then
    bars.logger.info('edecl-'||l_eds_decl.id|| ' error crt_decl ' || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
    raise;
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
        l_eds_decl.state:= st_DECLARATION_REGISTER;
        add_new_decl(l_eds_decl); 
        upd_log_req_status(l_eds_decl.id, st_REQUEST_CREATED);
        send_decl_id(l_eds_decl.id);
    else
        l_buff:=crt_xml(l_decl_id);
        add_log_req_resp(l_id, st_DECLARATION_PREPARED, l_buff, l_decl_id);
        barstrans.transp_utl.add_resp(p_transp_id, l_buff);
    end if;
end pocess_request;

end eds_intg;
/
