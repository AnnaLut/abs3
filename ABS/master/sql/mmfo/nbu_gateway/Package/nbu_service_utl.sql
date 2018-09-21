create or replace package nbu_service_utl is

    SESSION_TYPE_APPLY             constant integer := 1;
    SESSION_TYPE_DELETE            constant integer := 2;
    SESSION_TYPE_GET               constant integer := 3;

    LT_SESSION_STATE               constant varchar2(30 char) := 'NBU_601_SESSION_STATE';
    SESSION_STATE_NEW              constant integer := 1;
    SESSION_STATE_TO_SIGN          constant integer := 2;
    SESSION_STATE_SIGNED           constant integer := 3;
    SESSION_STATE_RESPONDED        constant integer := 4;  -- отримана відповідь від НБУ (очікує на перевірку підпису)
    SESSION_STATE_SEND_FAILED      constant integer := 5;  -- помилка передачі даних
    SESSION_STATE_NBU_SIGN_VERIF   constant integer := 6;  -- підпис НБУ пройшов перевірку
    SESSION_STATE_NBU_SIGN_FAILED  constant integer := 7;  -- підпис НБУ не пройшов перевірку
    SESSION_STATE_DECLINED_BY_NBU  constant integer := 8;  -- НБУ не прийняв звернення через невірну структуру або некоректні дані
    SESSION_STATE_PROCESSED        constant integer := 9;  -- відповідь НБУ успішно оброблена
    SESSION_STATE_PROCESSING_FAIL  constant integer := 10;  -- при обробці відповіді виникла помилка
    SESSION_STATE_EXPIRED          constant integer := 11; -- сесія ще не встигла передати свої дані, і з'явилися оновлені дані
    SESSION_STATE_PENDING          constant integer := 12; -- нова сесія очікує на результат обробки попередньої для того щоб прийняти
                                                           -- рішення про свій тип (POST/PUT/DELETE) в залежності від результатів попередньої сесії

    function read_session(
        p_session_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return nbu_session%rowtype;

    function create_session(
        p_report_id in integer,
        p_object_id in integer,
        p_session_type_id in integer,
        p_session_state_id in integer default nbu_service_utl.SESSION_STATE_TO_SIGN,
        p_session_comment in varchar2 default null,
        p_auxiliary_info in clob default null)
    return integer;

    function arrange_post_session(
        p_report_id in integer,
        p_core_object in t_core_object)
    return integer;

    function arrange_pledge_session(
        p_report_id in integer,
        p_core_object in t_core_object)
    return integer;

    function arrange_loan_session(
        p_report_id in integer,
        p_core_object in t_core_object)
    return integer;

    function show_data_for_session(
        p_session_id in integer)
    return clob;

    function get_xml_string_value(
        p_xml_type in xmltype,
        p_xpath in varchar2,
        p_namespace in varchar2 default null)
    return varchar2;

    procedure put_sign(
        p_session_id in integer,
        p_data in clob);

    procedure call_service(
        p_session_row in nbu_session%rowtype);

    procedure call_service_601;

    procedure process_response(
        p_session_row nbu_session%rowtype);

    procedure process_responses;

    procedure repeat_session(
        p_session_id in integer);
end;
/
create or replace package body nbu_service_utl as

     type t_nbu_url is table of varchar2(4000 byte) index by binary_integer;

     g_nbu_url t_nbu_url;

     function read_session(
         p_session_id in integer,
         p_raise_ndf in boolean default true,
         p_lock in boolean default false)
     return nbu_session%rowtype
     is
         l_session_row nbu_session%rowtype;
     begin
         if (p_lock) then
             select *
             into   l_session_row
             from   nbu_session t
             where  t.id = p_session_id
             for update;
         else
             select *
             into   l_session_row
             from   nbu_session t
             where  t.id = p_session_id;
         end if;

         return l_session_row;
     exception
         when no_data_found then
              if (p_raise_ndf) then
                  raise_application_error(-20000, 'Сесія взаємодії з НБУ з ідентифікатором {' || p_session_id || '} не знайдена');
              else return null;
              end if;
     end;

     procedure track_session(
         p_session_id in integer,
         p_state_id in integer,
         p_tracking_comment in varchar2,
         p_auxiliary_info in clob)
     is
     begin
         insert into nbu_session_tracking
         values (s_nbu_session_tracking.nextval, p_session_id, p_state_id, sysdate, substrb(p_tracking_comment, 1, 4000), p_auxiliary_info);
     end;

     function create_session(
         p_report_id in integer,
         p_object_id in integer,
         p_session_type_id in integer,
         p_session_state_id in integer default nbu_service_utl.SESSION_STATE_TO_SIGN,
         p_session_comment in varchar2 default null,
         p_auxiliary_info in clob default null)
     return integer
     is
         l_reported_object_id integer;
     begin
         insert into nbu_session
         values (s_nbu_session.nextval, p_report_id, p_object_id, p_session_type_id, null, null, null, null, p_session_state_id, 0, sysdate, sysdate)
         returning id
         into l_reported_object_id;

         track_session(l_reported_object_id, p_session_state_id, p_session_comment, p_auxiliary_info);

         return l_reported_object_id;
     end;

     procedure set_session_state(
         p_session_id in integer,
         p_session_state_id in integer,
         p_tracking_comment in varchar2,
         p_auxiliary_info in clob default null)
     is
     begin
         update nbu_session s
         set    s.state_id = p_session_state_id,
                s.last_activity_at = sysdate
         where  s.id = p_session_id;

         track_session(p_session_id, p_session_state_id, p_tracking_comment, p_auxiliary_info);
     end;

     function arrange_post_session(
         p_report_id in integer,
         p_object_id in integer)
     return integer
     is
         l_pending_sessions_found boolean default false;
     begin
         for i in (select * from nbu_session t
                   where t.object_id = p_object_id and
                         t.session_type_id = nbu_service_utl.SESSION_TYPE_APPLY and
                         t.state_id in (nbu_service_utl.SESSION_STATE_NEW, nbu_service_utl.SESSION_STATE_TO_SIGN, nbu_service_utl.SESSION_STATE_SIGNED, nbu_service_utl.SESSION_STATE_PENDING,
                                        nbu_service_utl.SESSION_STATE_RESPONDED, nbu_service_utl.SESSION_STATE_NBU_SIGN_VERIF)) loop
             if (i.state_id in (nbu_service_utl.SESSION_STATE_NEW, nbu_service_utl.SESSION_STATE_TO_SIGN, nbu_service_utl.SESSION_STATE_SIGNED, nbu_service_utl.SESSION_STATE_PENDING)) then
                 set_session_state(i.id, nbu_service_utl.SESSION_STATE_EXPIRED, 'Запит до НБУ не надісланий, оскільки оновилися дані, що підлягають передачі');
             elsif (i.state_id in (nbu_service_utl.SESSION_STATE_RESPONDED, nbu_service_utl.SESSION_STATE_NBU_SIGN_VERIF)) then
                 l_pending_sessions_found := true;
             end if;
         end loop;

         if (l_pending_sessions_found) then
             -- якщо ми відправили запит на реєстрацію об'єкта в НБУ, але ще не обробили відповідь, ми не можемо знати чи відправляти наступний запит
             -- на повторну реєстрацію об'єкта (POST) або на редагування параметрів уже створеного (PUT).
             -- Тому поміщаємо сесію в чергу на очікування обробки попереднього запиту.
             -- Після обробки кожної сесії необхідно перевіряти наявність сесій, що перебувають в стані очікування і запускати їх обробку
             return create_session(p_report_id, p_object_id, nbu_service_utl.SESSION_TYPE_APPLY, nbu_service_utl.SESSION_STATE_PENDING,
                                   'Запит на оновлення даних в НБУ очікує на результати обробки попереднього запиту з метою визначення типу сесії (POST або PUT)');
         else
             return create_session(p_report_id, p_object_id, nbu_service_utl.SESSION_TYPE_APPLY);
         end if;
     end;

     function arrange_post_session(
         p_report_id in integer,
         p_core_object in t_core_object)
     return integer
     is
     begin
         return arrange_post_session(p_report_id, p_core_object.reported_object_id);
     end;

     function arrange_pledge_session(
         p_report_id in integer,
         p_core_object in t_core_object)
     return integer
     is
         l_pledge_row nbu_reported_pledge%rowtype;
         l_customer_object_row nbu_reported_object%rowtype;
     begin
         l_pledge_row := nbu_object_utl.read_pledge(p_core_object.reported_object_id);
         l_customer_object_row := nbu_object_utl.read_object(l_pledge_row.customer_object_id);
         
         if (l_customer_object_row.external_id is null) then
         --if (l_customer_object_row.state_id in (nbu_object_utl.OBJ_STATE_NEW, nbu_object_utl.OBJ_STATE_REPORTING_FAILURE)) then
             return create_session(p_report_id,
                                   p_core_object.reported_object_id,
                                   nbu_service_utl.SESSION_TYPE_APPLY,
                                   p_session_state_id => nbu_service_utl.SESSION_STATE_PENDING);
         else
             return arrange_post_session(p_report_id, p_core_object);
         end if;
     end;

     function arrange_loan_session(
         p_report_id in integer,
         p_core_object in t_core_object)
     return integer
     is
         l_loan_row nbu_reported_loan%rowtype;
         l_customer_object_row nbu_reported_object%rowtype;
     begin
         l_loan_row := nbu_object_utl.read_loan(p_core_object.reported_object_id);
         l_customer_object_row := nbu_object_utl.read_object(l_loan_row.customer_object_id);
         
         if (l_customer_object_row.external_id is null) then
         --if (l_customer_object_row.state_id in (nbu_object_utl.OBJ_STATE_NEW, nbu_object_utl.OBJ_STATE_REPORTING_FAILURE)) then
             return create_session(p_report_id,
                                   p_core_object.reported_object_id,
                                   nbu_service_utl.SESSION_TYPE_APPLY,
                                   p_session_state_id => nbu_service_utl.SESSION_STATE_PENDING);
         else
             return arrange_post_session(p_report_id, p_core_object);
         end if;
     end;

     function show_data_for_session(
         p_session_id in integer)
     return clob
     is
         l_session_row nbu_session%rowtype;
         l_clob clob;
     begin
         l_session_row := read_session(p_session_id);

         return nbu_object_utl.get_object_json(l_session_row.object_id, l_session_row.report_id);
         l_clob := nbu_object_utl.get_object_json(l_session_row.object_id, l_session_row.report_id);
         return convert(l_clob, 'AL32UTF8', 'CL8MSWIN1251');
     end;

     procedure prepare_session_to_be_sent(
         p_session_row in nbu_session%rowtype,
         p_request_type out varchar2,
         p_request_url out varchar2)
     is
         l_object_row nbu_reported_object%rowtype;
     begin
         l_object_row := nbu_object_utl.read_object(p_session_row.object_id);

         if (p_session_row.session_type_id = nbu_service_utl.SESSION_TYPE_APPLY) then
            if (l_object_row.external_id is null) then
            -- if (l_object_row.state_id = nbu_object_utl.OBJ_STATE_NEW) then
                 p_request_type := 'POST';
                 p_request_url := g_nbu_url(l_object_row.object_type_id);
             else
                 p_request_type := 'PUT';
                 p_request_url := g_nbu_url(l_object_row.object_type_id) || '/' || l_object_row.external_id;
             end if;

         elsif (p_session_row.session_type_id = nbu_service_utl.SESSION_TYPE_DELETE) then
             p_request_type := 'DELETE';
             p_request_url := g_nbu_url(l_object_row.object_type_id) || '/' || l_object_row.external_id;

         elsif (p_session_row.session_type_id = nbu_service_utl.SESSION_TYPE_GET) then
             p_request_type := 'GET';
             p_request_url := g_nbu_url(l_object_row.object_type_id) || '/' || l_object_row.external_id;
         end if;
     end;

     procedure put_sign(
         p_session_id in integer,
         p_data in clob)
     is
         l_session_row nbu_session%rowtype;
         l_request_type varchar2(6 char);
         l_request_url varchar2(4000 byte);
     begin
         l_session_row := read_session(p_session_id, p_lock => true);

         if (l_session_row.state_id = nbu_service_utl.SESSION_STATE_TO_SIGN) then
             prepare_session_to_be_sent(l_session_row, l_request_type, l_request_url);

             update nbu_session t
             set    t.request_body = p_data,
                    t.request_type = l_request_type,
                    t.request_url = l_request_url
             where  t.id = p_session_id;
         end if;

         set_session_state(l_session_row.id, nbu_service_utl.SESSION_STATE_SIGNED, null, null);
     end;

     procedure call_service(
         p_session_row in nbu_session%rowtype)
     is
         l_url varchar2(32767 byte);
         l_wallet_path varchar2(32767 byte);
         l_wallet_pass varchar2(32767 byte);
         l_response bars.wsm_mgr.t_response;
     begin
         l_url := bars.branch_attribute_utl.get_attribute_value('/', 'NBU_601_PROXY_WEB_SERVER') || 'SendCreditInfoService.asmx';
         -- l_url := 'https://tbarsweb-00-11.oschadbank.ua:44302/barsroot/webservices/SendCreditInfoService.asmx';
         -- l_url := 'https://10.10.10.79:90/barsroot/webservices/SendCreditInfoService.asmx';

         if (lower(l_url) like 'https%') then
             l_wallet_path := bars.branch_attribute_utl.get_attribute_value('/', 'PATH_FOR_ABSBARS_WALLET');
             l_wallet_pass := bars.branch_attribute_utl.get_attribute_value('/', 'PASS_FOR_ABSBARS_WALLET');
         end if;

         bars.wsm_mgr.prepare_request(p_url             => l_url,
                                      p_action          => null,
                                      p_http_method     => bars.wsm_mgr.g_http_post,
                                      p_wallet_path     => l_wallet_path,
                                      p_wallet_pwd      => l_wallet_pass,
                                      p_content_type    => bars.wsm_mgr.g_ct_xml,
                                      p_content_charset => bars.wsm_mgr.g_cc_win1251,
                                      p_namespace       => 'http://tempuri.org/',
                                      p_soap_method     => 'SendData',
                                      p_soap_login      => bars.branch_attribute_utl.get_attribute_value('/', 'TMS_LOGIN'),
                                      p_soap_password   => bars.branch_attribute_utl.get_attribute_value('/', 'TMS_PASS'));

         bars.wsm_mgr.add_parameter(p_name => 'requestType', p_value => p_session_row.request_type);
         bars.wsm_mgr.add_parameter(p_name => 'nbuURL', p_value => p_session_row.request_url);
         bars.wsm_mgr.add_parameter(p_name => 'body', p_value => p_session_row.request_body);

         -- позвать метод веб-сервиса
         bars.wsm_mgr.execute_soap(l_response);

         update nbu_session t
         set    t.response_body = l_response.cdoc
         where  t.id = p_session_row.id;

         set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_RESPONDED, 'Отримана відповідь від НБУ', l_response.cdoc);

         commit;
     exception
         when others then
              rollback;
              set_session_state(p_session_row.id,
                                nbu_service_utl.SESSION_STATE_SEND_FAILED,
                                sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                                l_response.cdoc);
              commit;
     end;

     procedure call_service_601
     is
     begin
         for i in (select t.*
                   from   nbu_session t
                   where  t.state_id in (nbu_service_utl.SESSION_STATE_SIGNED, nbu_service_utl.SESSION_STATE_SEND_FAILED)) loop
             -- call_service(i.id, 'https://172.22.2.168/cr_reestr/api/customer_lp_app_test', null, i.request_body);
             call_service(i);
         end loop;

         commit;

         process_responses();
     end;

     function get_xml_string_value(
         p_xml_type in xmltype,
         p_xpath in varchar2,
         p_namespace in varchar2 default null)
     return varchar2
     is
         l_xml_node xmltype;
     begin
         if (p_namespace is null) then
             l_xml_node := p_xml_type.extract(p_xpath);
         else
             l_xml_node := p_xml_type.extract(p_xpath, p_namespace);
         end if;

         if (l_xml_node is null) then
             return null;
         end if;

         return replace(l_xml_node.getstringval(), chr(38) || 'quot;', '"');
     end;

     function get_xml_clob_value(
         p_xml_type in xmltype,
         p_xpath in varchar2,
         p_namespace in varchar2 default null)
     return clob
     is
         l_xml_node xmltype;
     begin
         if (p_namespace is null) then
             l_xml_node := p_xml_type.extract(p_xpath);
         else
             l_xml_node := p_xml_type.extract(p_xpath, p_namespace);
         end if;

         if (l_xml_node is null) then
             return null;
         end if;

         return replace(l_xml_node.getclobval(), chr(38) || 'quot;', '"');
     end;

     procedure proceed_further_pledge_session(
         p_customer_object_row in nbu_reported_object%rowtype)
     is
     begin
         if (p_customer_object_row.external_id is not null) then
             for i in (select s.*
                       from   nbu_session s
                       where  s.state_id in (nbu_service_utl.SESSION_STATE_PENDING, nbu_service_utl.SESSION_STATE_NEW) and
                              s.object_id in (select t.id
                                              from   nbu_reported_pledge t
                                              where  t.customer_object_id = p_customer_object_row.id) and
                              not exists (select 1
                                          from   nbu_session ss
                                          where  ss.object_id = s.object_id and
                                                 s.state_id in (nbu_service_utl.SESSION_STATE_RESPONDED, nbu_service_utl.SESSION_STATE_NBU_SIGN_VERIF))
                       for update) loop

                 set_session_state(i.id,
                                   nbu_service_utl.SESSION_STATE_TO_SIGN,
                                   '',
                                   null);
             end loop;
         end if;
     end;

     procedure proceed_further_loan_session(
         p_customer_object_row in nbu_reported_object%rowtype)
     is
     begin
         if (p_customer_object_row.external_id is not null) then
             for i in (select s.*
                       from   nbu_session s
                       where  s.state_id in (nbu_service_utl.SESSION_STATE_PENDING, nbu_service_utl.SESSION_STATE_NEW) and
                              s.object_id in (select t.id
                                              from   nbu_reported_loan t
                                              where  t.customer_object_id = p_customer_object_row.id) and
                              not exists (select 1
                                          from   nbu_reported_pledge p
                                          join   nbu_reported_object o on o.id = p.id and
                                                                          o.state_id = nbu_object_utl.OBJ_STATE_NEW
                                          where  p.customer_object_id = p_customer_object_row.id) and
                              not exists (select 1
                                          from   nbu_session ss
                                          where  ss.object_id = s.object_id and
                                                 s.state_id in (nbu_service_utl.SESSION_STATE_RESPONDED, nbu_service_utl.SESSION_STATE_NBU_SIGN_VERIF))
                       for update) loop

                 set_session_state(i.id,
                                   nbu_service_utl.SESSION_STATE_TO_SIGN,
                                   '',
                                   null);
             end loop;
         end if;
     end;

     procedure proceed_further_sessions(
         p_session_row in nbu_session%rowtype)
     is
         l_object_row nbu_reported_object%rowtype;
         l_pledge_row nbu_reported_pledge%rowtype;
     begin
         l_object_row := nbu_object_utl.read_object(p_session_row.object_id);

         if (l_object_row.object_type_id in (nbu_object_utl.OBJ_TYPE_COMPANY, nbu_object_utl.OBJ_TYPE_PERSON)) then
             proceed_further_pledge_session(l_object_row);
             proceed_further_loan_session(l_object_row);
         elsif (l_object_row.object_type_id = nbu_object_utl.OBJ_TYPE_PLEDGE) then
             l_pledge_row := nbu_object_utl.read_pledge(p_session_row.object_id);
             proceed_further_loan_session(nbu_object_utl.read_object(l_pledge_row.customer_object_id));
         end if;
     end;

procedure process_post_response(
         p_session_row in nbu_session%rowtype,
         p_xml in xmltype)
     is
         l_response_code varchar2(32767 byte);
         l_response_json clob;
         l_nbu_response t_nbu_response;
     begin
         l_response_code := get_xml_string_value(p_xml, 'SendDataResponse/SendDataResult/ResponseCode/text()');
         l_response_json := get_xml_clob_value(p_xml, 'SendDataResponse/SendDataResult/ResponseJSONString/text()');

         bars_audit.log_trace('nbu_gateway.nbu_service_utl.process_post_response',
                              '',
                              p_object_id => p_session_row.id,
                              p_auxiliary_info => l_response_json);

         if (l_response_json is null) then
             set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                               'Відсутні дані відповіді НБУ');
         else
             l_nbu_response := t_nbu_response(l_response_json);

             if (l_nbu_response.payload.general_err_code = '0' or l_nbu_response.payload.general_err_comment like '"Запис вже існує в БД%') then
                 if (l_nbu_response.payload.response_units is not null or l_nbu_response.payload.response_units is not empty) then
                     if (l_nbu_response.payload.response_units.count = 1 and l_nbu_response.payload.response_units(1) is not null) then
                         nbu_object_utl.set_object_external_id(p_session_row.object_id, l_nbu_response.payload.response_units(1).reestr_id);

                         set_session_state(p_session_row.id,
                                           nbu_service_utl.SESSION_STATE_PROCESSED,
                                           l_nbu_response.payload.general_err_comment,
                                           null);
                     else
                         set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                                           'Неочікувана структура відповіді - перевишена кількість елементів у масиві "result_kvi"',
                                           l_response_json);
                     end if;
                 else
                     set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSED, l_nbu_response.payload.general_err_comment, null);
                 end if;
             else
                 set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_DECLINED_BY_NBU,
                                   'Код помилки : ' || l_nbu_response.payload.general_err_code || bars.tools.crlf ||
                                   'HTTP-код помилки : ' || l_nbu_response.payload.general_http_status_code || bars.tools.crlf ||
                                   l_nbu_response.payload.general_err_comment);
             end if;



             proceed_further_sessions(p_session_row);
         end if;
     exception
         when others then
              set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                                'Помилка обробки відповіді НБУ: ' || sqlerrm || chr(10) ||
                                dbms_utility.format_error_backtrace());
     end;

  procedure process_put_response(
         p_session_row in nbu_session%rowtype,
         p_xml in xmltype)
     is
         l_response_code varchar2(32767 byte);
         l_response_json clob;
         l_nbu_response t_nbu_response;
     begin
         l_response_code := get_xml_string_value(p_xml, 'SendDataResponse/SendDataResult/ResponseCode/text()');
         l_response_json := get_xml_clob_value(p_xml, 'SendDataResponse/SendDataResult/ResponseJSONString/text()');

         bars_audit.log_trace('nbu_gateway.nbu_service_utl.process_post_response',
                              '',
                              p_object_id => p_session_row.id,
                              p_auxiliary_info => l_response_json);

         if (l_response_json is null) then
             set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                               'Відсутні дані відповіді НБУ');
         else
             l_nbu_response := t_nbu_response(l_response_json);

             if (l_nbu_response.payload.general_err_code = '0' or l_nbu_response.payload.general_err_comment like '"Запис вже існує в БД%') then
                 if (l_nbu_response.payload.response_units is not null or l_nbu_response.payload.response_units is not empty) then
                     if (l_nbu_response.payload.response_units.count = 1 and l_nbu_response.payload.response_units(1) is not null) then
                         set_session_state(p_session_row.id,
                                           nbu_service_utl.SESSION_STATE_PROCESSED,
                                           l_nbu_response.payload.general_err_comment,
                                           null);
                     else
                         set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                                           'Неочікувана структура відповіді - перевишена кількість елементів у масиві "result_kvi"',
                                           l_response_json);
                     end if;
                 else
                     set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSED, l_nbu_response.payload.general_err_comment, null);
                 end if;
             else
                 set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_DECLINED_BY_NBU,
                                   'Код помилки : ' || l_nbu_response.payload.general_err_code || bars.tools.crlf ||
                                   'HTTP-код помилки : ' || l_nbu_response.payload.general_http_status_code || bars.tools.crlf ||
                                   l_nbu_response.payload.general_err_comment);
             end if;

             proceed_further_sessions(p_session_row);
         end if;
     exception
         when others then
              set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                                'Помилка обробки відповіді НБУ: ' || sqlerrm || chr(10) ||
                                dbms_utility.format_error_backtrace());
     end;

     procedure run_next_session(
         p_session_row nbu_session%rowtype)
     is
     begin
         for i in (select s.*
                   from   nbu_session s
                   where  s.object_id = p_session_row.object_id and
                          s.state_id = nbu_service_utl.SESSION_STATE_PENDING
                   order by s.id) loop
             set_session_state(i.id,
                               nbu_service_utl.SESSION_STATE_TO_SIGN,
                               'Обробка сесії з ідентифікатором {' || p_session_row.id || '} завершена - ' ||
                               'розпочинаємо передачу даних наступної сесії {' || i.id || '}', null);
             exit;
         end loop;
     end;

     procedure process_response(
         p_session_row nbu_session%rowtype)
     is
         l_xml xmltype;
         l_fault_node xmltype;
         l_fault_code varchar2(32767 byte);
         l_fault_string varchar2(32767 byte);

         non_xml_data exception;
         pragma exception_init(non_xml_data, -31011);
     begin
         begin
             l_xml := xmltype(p_session_row.response_body);

             l_fault_node := l_xml.extract('/soap:Fault', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');

             if (l_fault_node is not null) then
                 l_fault_code   := get_xml_string_value(l_xml, '/soap:Fault/faultcode/child::text()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');
                 l_fault_string := get_xml_string_value(l_xml, '/soap:Fault/faultstring/child::text()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');

                 set_session_state(p_session_row.id,
                                   nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                                   'Помилка обробки відповіді НБУ' || chr(10) ||
                                       'Код помилки : ' || l_fault_code || chr(10) ||
                                       'Текст помилки : ' || l_fault_string);
             else
                 l_xml := l_xml.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');

                 if (l_xml is not null) then

                     if (p_session_row.request_type = 'POST') then
                         process_post_response(p_session_row, l_xml);
                     elsif (p_session_row.request_type = 'PUT') then
                           process_put_response(p_session_row, l_xml);
                     elsif (p_session_row.request_type = 'DELETE') then
                         null;
                     elsif (p_session_row.request_type = 'GET') then
                         null;
                     end if;
                 else
                     set_session_state(p_session_row.id, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                                       'Порушена структура відповіді',
                                       p_session_row.response_body);
                 end if;
             end if;

             run_next_session(p_session_row);
         exception
             when non_xml_data then
                  set_session_state(p_session_row.id,
                                    nbu_service_utl.SESSION_STATE_PROCESSING_FAIL,
                                    'Помилка обробки даних : ' || chr(10) || sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                                    p_session_row.response_body);
         end;
     end;

     procedure process_responses
     is
     begin
         for i in (select s.*
                   from   nbu_session s
                   where  s.state_id in (nbu_service_utl.SESSION_STATE_RESPONDED)
           and rownum<=5000
                   /*for update*/) loop
             process_response(i);
         end loop;
     end;

     procedure repeat_session(
         p_session_id in integer)
     is
         l_session_row nbu_session%rowtype;
     begin
         l_session_row := read_session(p_session_id);
         if (l_session_row.state_id in (nbu_service_utl.SESSION_STATE_SIGNED, nbu_service_utl.SESSION_STATE_SEND_FAILED)) then
             call_service(l_session_row);

             l_session_row := read_session(p_session_id, p_lock => true);
             if (l_session_row.state_id = nbu_service_utl.SESSION_STATE_RESPONDED) then
                 process_response(l_session_row);
             end if;
         else
             raise_application_error(-20000, 'Сесія взаємодії з НБУ перебуває в стані {' ||
                                             bars.list_utl.get_item_name(nbu_service_utl.LT_SESSION_STATE, l_session_row.state_id) ||
                                             '} - повторна відправка даних заборонена');
         end if;
     end;
 begin
    g_nbu_url(nbu_object_utl.OBJ_TYPE_COMPANY) := 'https://172.22.2.168/cr_reestr/api/v2/customer_lp';
    g_nbu_url(nbu_object_utl.OBJ_TYPE_PERSON)  := 'https://172.22.2.168/cr_reestr/api/v2/customer_pp';
    g_nbu_url(nbu_object_utl.OBJ_TYPE_PLEDGE)  := 'https://172.22.2.168/cr_reestr/api/v2/pledge';
    g_nbu_url(nbu_object_utl.OBJ_TYPE_LOAN)    := 'https://172.22.2.168/cr_reestr/api/v2/credit';
     -- *app_test
 end;
/


