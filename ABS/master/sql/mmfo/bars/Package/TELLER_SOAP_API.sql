
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/teller_soap_api.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.TELLER_SOAP_API is

  -- Author  : VOLODYMYR.POHODA
  -- Created : 31.08.2017 14:44:32
  -- Updated : 16-03-2018
  -- Purpose : Робота з обладнанням для теллерів
  g_glory_session varchar2(100);
  g_package_name  constant varchar2(100) := 'TELLER_SOAP_API';


  function esc_replace (p_str in varchar2)
    return varchar2;

  function get_user_sessionID return varchar2;


  function get_last_cash_request_id (p_req_id in integer default null)
    return number;

  function get_active_request_id
    return number;



  function get_req_message (p_req_id in number default null)
    return varchar2;

  function send_request (p_req_id in number
                        ,p_respcode out number)
    return soap_rpc.t_response;

  function write_request (p_url in varchar2
                         ,p_body in xmltype
                         ,p_meth in varchar2
                         ,p_type in varchar2
                         )
    return number;


  procedure post_request (p_id in number);


  function get_current_dev_status
    return number;

  function get_current_dev_status_desc
    return varchar2;

  function StatusOperation
   return number;

  function get_device_status
   return number;

  function OpenOperation
   return number;

  function ResetOperationNormal (p_errtxt out varchar2)
    return number;

  function ResetOperationAdmin (p_errtxt out varchar2)
    return number;

  function CountOperation (p_errtxt out varchar2)
    return number;

  function EndCountOperation (p_errtxt out varchar2)
    return number;

  function CloseOperation
   return number;

  function OccupyOperation
   return number;

  function ReleaseOperation
   return number;

  function StartCashinOperation
   return number;

  function StoreCashinOperation
   return number;

  function EndCashinOperation
   return number;

  function CancelCashinOperation
   return number;

  function CashOutOperation (p_curcode in varchar2 default null
                            ,p_amount  in number   default null
                            )
   return number;

  function InventoryOperation (p_option in number default 0)
   return number;

  function InventoryClearOperation (p_option in number default 2)
   return number;

  function InventoryAdjustmentOperation
   return number;


/*  procedure make_request (p_oper_code in varchar2
                         ,p_oper_cur  in number   default 980
                         ,p_oper_sum  in number);
*/
  function  make_request (p_oper_code in varchar2
                         ,p_oper_cur  in number default 980
                         ,p_oper_sum  in number)
  return varchar2;

  function make_request (p_oper_code  in varchar2
                       ,p_oper_cur  in varchar2   default 'UAH'
                       ,p_oper_sum  in number)
  return varchar2;

  function make_request (p_oper_ref in number)
    return varchar2;

  procedure save_atm_oper (p_cur in varchar2
                          ,p_amn in number);

  procedure update_atm (p_url in varchar2
                       ,p_amount in xmltype
                       ,p_status in varchar2
                       ,p_status_desc in varchar2
                       ,p_user        in varchar2
                       );


  function get_atm_balance (p_cur in varchar2)
    return number;


  function create_denomination (p_currency in varchar2, p_amount in number)
    return t_arr_nom;



  function user_reconnect (p_errtxt out varchar2)
    return number;


  function RebootATM (p_errtxt out varchar2)
    return number;

  function PowerOFFATM (p_errtxt out varchar2)
    return number;

  function CollectOperation (p_errtxt out varchar2)
    return number;

  function ReleaseATM (p_errtxt out varchar2)
  return number;

  function CollectATM (p_errtxt out varchar2)
  return number;

  function CollectATM (p_currency in varchar2
                      ,p_nominal in  clob
                      ,p_errtxt  out varchar2)
    return number;

  function CollectATM (p_curcode in varchar2
                      ,p_amount  in number
                      ,p_errtxt out varchar2)
  return number;


  function GetStatusChange
    return number;

  function InventoryCount (p_errtxt out varchar2)
    return number;

end teller_soap_api;
/
CREATE OR REPLACE PACKAGE BODY BARS.TELLER_SOAP_API is

  g_glory_ns      constant varchar2(100) := 'http://www.glory.co.jp/gsr.xsd';
  g_body_version constant varchar2(64)  := 'version 3.2 16/05/2019';
  g_local_ns      varchar2(100) := 'http://tempuri.org/';
-- я
  g_local_url     varchar2(100);
-- Андрей
--  g_local_url     constant varchar2(100) := 'http://10.10.10.4:10007/barsroot/webservices/Glory.asmx';
-- Сергей
--  g_local_url     constant varchar2(100) := 'http://10.10.10.104:10101/barsroot/webservices/Glory.asmx';
    --'http://www.glory.co.jp/GCDC.xsd';
  G_XMLHEAD       constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

  g_hostname      constant varchar2(100) := sys_context('bars_global', 'host_name');--sys_context('userenv','host');
  g_gloryname     constant varchar2(20)  := substr(g_hostname,0-least(length(g_hostname),20));
  g_bars_dt       constant date := gl.bd;
  g_eq_url        constant varchar2(20) := teller_utils.get_device_url();


  procedure write_session_id (p_sessID in varchar2)
    is
--    pragma autonomous_transaction;
  begin
    update teller_state ts
      set ts.session_id = p_sessID
      where ts.user_ref = user_id
        and ts.work_date = g_bars_dt;
--    commit;
  end;

  function invoke(p_req_id in number
                 ,p_respcode out number)
    return soap_rpc.t_response;
  function SimpleOperation (p_meth in varchar2, p_reqname in varchar2, p_params in xmltype :=null) return number;

  function create_req_body(p_option in number)
    return xmltype
    is
    v_ret xmltype;
  begin
    select xmlelement("Option",xmlattributes(p_option as "gsr:type"))
    into v_ret
    from dual;
    return v_ret;
  end;

  function get_cash_result (p_req_id in number)
    return varchar2
    is
    v_ret varchar2(1000);

--    pragma autonomous_transaction;
  begin
    select listagg(xt.cur||': '||xt.amount||' = '||cnt,'<br/>') within group (order by null)
      into v_ret
      from teller_requests t,
         xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",'http://www.glory.co.jp/gsr.xsd' as "n"),
         'soapenv:Envelope/soapenv:Body/n:CollectResponse/Cash/Denomination' passing t.xml_response
         columns
         cur varchar2(3) path '@n:cc',
         amount number   path '@n:fv',
         cnt    number   path 'n:Piece') xt
      where req_id = p_req_id;

    update teller_requests tr
      set tr.oper_amount_txt = v_ret
      where tr.req_id = p_req_id;
--    commit;
    return v_ret;
  exception
    when others then
      v_ret := 'Помилка отримання результату роботи з АТМ: '||sqlerrm;
      bars_audit.error(v_ret);
      return v_ret;
  end get_cash_result;

  function get_cash_result (p_req_id in  number
                           ,p_amn    out number)
    return varchar2
    is
    v_ret varchar2(1000);

--    pragma autonomous_transaction;
  begin
    select listagg(xt.cur||': '||xt.amount||' = '||cnt,'<br/>') within group (order by null),
           sum(xt.amount * xt.cnt)
      into v_ret, p_amn
      from teller_requests t,
         xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",'http://www.glory.co.jp/gsr.xsd' as "n"),
         'soapenv:Envelope/soapenv:Body/n:CollectResponse/Cash/Denomination' passing t.xml_response
         columns
         cur varchar2(3) path '@n:cc',
         amount number   path '@n:fv',
         cnt    number   path 'n:Piece') xt
      where req_id = p_req_id;

    update teller_requests tr
      set tr.oper_amount_txt = v_ret,
          tr.oper_amount = p_amn
      where tr.req_id = p_req_id;
--    commit;
    return v_ret;
  exception
    when others then
      v_ret := 'Помилка отримання результату роботи з АТМ: '||sqlerrm;
      bars_audit.error(v_ret);
      return v_ret;
  end get_cash_result;


  function get_user_sessionID
    return varchar2
    is
    v_ret teller_state.session_id%type;
  begin
    select session_id
      into v_ret
      from teller_state
      where user_ref = user_id
        and work_date = g_bars_dt;
    return v_ret;
  exception
    when others then return null;
  end get_user_sessionID;

  function get_current_dev_status
    return number
    is
    v_ret number;
    v_dt  date;
  begin

    v_ret := StatusOperation;

    select tas.status
      into v_ret
      from teller_atm_status tas
      where tas.equip_ip = g_eq_url
        and tas.work_date = g_bars_dt;
    return v_ret;
  exception
    when others then
      bars_audit.error('teller_soap_api.get_current_dev_status: '||sqlerrm);
      return -1;
  end;

  function get_current_dev_status_desc
    return varchar2
    is
    v_ret varchar2(100);
--    pragma autonomous_transaction;
  begin
    v_ret := StatusOperation;

    select tas.status_desc
      into v_ret
      from teller_atm_status tas
      where tas.equip_ip = g_eq_url
        and tas.work_date = g_bars_dt;
--    commit;
    return v_ret;
  exception
    when others then
      bars_audit.info('get_current_dev_status_desc: '||sqlerrm);
      return -1;
  end;

  function get_last_cash_request_id (p_req_id in integer default null)
    return number
    is
    v_ret number;
    v_dt date := g_bars_dt;
  begin
      select max(req_id)
        into v_ret
        from teller_requests tr
        where creator = user_name
          and tr.req_id>=nvl(p_req_id,0)
          and tr.creation_date>=v_dt
          and tr.req_type in ('CollectRequest','EndCashinRequest','EndCashoutRequest','StoreCashinRequest');
    return v_ret;
  exception
    when no_data_found then return 0;
  end;


  function get_active_request_id
    return number
    is
    v_ret number;
    v_dt date := g_bars_dt;
  begin
    select max(req_ref)
      into v_ret
      from teller_state ts, teller_opers op
      where ts.user_ref = user_id
        and ts.work_date = v_dt
        and ts.active_oper = op.id;
    if v_ret is null then
      select max(req_id)
        into v_ret
        from teller_requests tr
        where creator = user_name
          and tr.creation_date>=v_dt;
    end if;
    return v_ret;
  exception
    when no_data_found then return 0;
  end;


  function get_req_status (p_req_id in number default null)
    return number
    is
    v_ret number;
  begin
    select to_number(tr.status)
      into v_ret
      from teller_requests tr
      where tr.req_id = coalesce(p_req_id,get_active_request_id);
    return v_ret;
  exception
    when others then
      return -1;
  end;

  function get_req_message (p_req_id in number default null)
    return varchar2
    is
    v_ret teller_requests.response%type;
  begin
    select tr.response
      into v_ret
      from teller_requests tr
      where tr.req_id = coalesce(p_req_id,get_active_request_id);
    return v_ret;
  exception
    when others then
      return null;
  end;


  procedure write_debug (p_xml in xmltype)
    is
    pragma autonomous_transaction;
  begin
    insert into teller_requests (req_type, ws_response)
      values ('debug data', p_xml.getclobval());
    commit;
  end;

  procedure generate_envelope(p_req in out nocopy soap_rpc.t_request,
                              p_reqn in varchar2,
                              p_env in out nocopy clob) as
  begin
    p_env := G_XMLHEAD || '<soapenv:Envelope ' ||
             'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" ' ||
             'xmlns:gsr="'||g_glory_ns||'">'||
             '<soapenv:Body>' ||
--             '<url>'||p_req.url||'</url>'||chr(10)||
             '<gsr:' || p_reqn || '>' ||
             p_req.body || '</gsr:' || p_reqn || '>' ||
             '</soapenv:Body>' || '</soapenv:Envelope>';
--dbms_output.put_line(p_env);
  end;


  function get_session_id
    return varchar2
    is
    v_ret    varchar2(100);
    v_userid number;
    v_num number;
  begin
    $if $$debug_flag $then
      v_userid := 2009401
    $else
      v_userid :=user_id
    $end;
    select session_id
      into v_ret
      from teller_state
      where user_ref = v_userid
        and work_date = g_bars_dt;
/*    if v_ret is null then
      v_num := OpenOperation;
      select session_id
        into v_ret
        from teller_state
        where user_ref = v_userid
          and work_date = g_bars_dt;
    end if;*/
    return v_ret;
  exception
    when no_data_found then
      raise_application_error(-20100,'Користувач '||user_name||' не починав роботу з роллю "Теллер" в банківскькій даті '||to_char(g_bars_dt,'dd.mm.yyyy'));
    when others then
      raise_application_error(-20100,'Помилка при визначенні активної сесії користувача на обладнанні');
  end get_session_id;


  function esc_replace (p_str in varchar2)
    return varchar2
    is
  begin
    return replace(replace(p_str,chr(38)||'lt;','<'),chr(38)||'gt;','>');
  end;

  function send_request (p_req_id in number
                        ,p_respcode out number)
    return soap_rpc.t_response
    is
    v_req soap_rpc.t_request;
    v_ret soap_rpc.t_response;
  begin
    select g_local_ns, tr.req_meth, tr.req_body.getclobval(), url
      into v_req.namespace, v_req.method, v_req.body, v_req.url
      from teller_requests tr
      where tr.req_id = p_req_id;
--    v_ret := invoke(v_req, p_respcode);

    return v_ret;
  end;

  procedure post_request (p_id in number)
    is
    v_resp soap_rpc.t_response;
    v_respcode number;
    v_errflag  number;
    v_cut_resp xmltype;
  begin
    for q in (select * from teller_requests where req_id = p_id)
    loop
      v_resp := Invoke(q.req_id, v_respcode);
      select existsnode(xmltype(replace(v_resp.doc.getclobval,'xmlns=""')),'soap:Envelope/soap:Body/CallProxyResponse/CallProxyResult/Error','xmlns="http://tempuri.org/" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"')
        into v_errflag
        from dual;
      if v_errflag = 1
      then
        select extract(xmltype(replace(v_resp.doc.getclobval,'xmlns=""')),'soap:Envelope/soap:Body/CallProxyResponse/CallProxyResult','xmlns="http://tempuri.org/" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"')
          into v_cut_resp
          from dual;
        update teller_requests
          set status = 'ER',
              ws_response  = v_resp.doc.getclobval(),
              xml_response = v_cut_resp,
              response     = v_cut_resp.extract('//Error/Message/text()','xmlns="http://tempuri.org/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"').getstringval()
          where req_id = p_id;
      else

        update teller_requests
          set status = 'SN',
              ws_response = v_resp.doc.getclobval(),
              xml_response = extract(v_resp.doc,'/soap:Envelope/soap:Body/CallProxyResponse/CallProxyResult/soapenv:Envelope','xmlns="http://tempuri.org/" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"'),
  --            XML_RESPONSE = v_resp.doc,
              response = v_respcode
          where req_id = p_id;
      end if;
    end loop;
  end;

  function write_request (p_url in varchar2
                         ,p_body in xmltype
                         ,p_meth in varchar2
                         ,p_type in varchar2
                         )
    return number
    is
    v_ret number;
    v_req_body xmltype;
    v_req_clob clob;
    v_record soap_rpc.t_request;
    v_result   number(2);
--    pragma autonomous_transaction;
  begin

    v_ret := s_teller_soap_id.nextval;
    select xmlelement("gsr:METHOD",
--                      xmlattributes(g_glory_ns as "xmlns:gsr"),
                      xmlconcat(xmlelement("gsr:Id",g_gloryname),
                                             xmlelement("gsr:SeqNo", user_name||to_char(sysdate, 'sssss')),
                                             xmlelement("gsr:SessionID",ts.session_id),
                               p_body
                               )
                     )
      into v_req_body
      from teller_state ts
      where ts.user_ref = user_id
        and ts.work_date = g_bars_dt;
    v_record.url       := g_eq_url;
    v_record.namespace := g_glory_ns;
    v_record.method    := p_meth;
    v_record.body      := replace(replace(esc_replace(v_req_body.getstringval),'<gsr:METHOD>',''),'</gsr:METHOD>','');
    generate_envelope(p_req => v_record, p_reqn => p_type, p_env => v_req_clob);

    v_req_body := xmltype(v_req_clob);

    insert into teller_requests (req_id, url,req_type,req_meth,req_body,envelope,oper_ref)
      values (v_ret, p_url, p_type, p_meth, xmltype(v_req_clob,'UTF8'),v_req_body,teller_utils.get_active_oper())
      --xmltype(replace(esc_replace(v_req_body.getstringval),'METHOD',p_type))
      returning req_id into v_ret;
--commit;
    post_request(v_ret);
commit;


    select tr.xml_response.extract('//'||replace(p_meth,'Operation','')||'Response/@result').getnumberval()
      into v_result
      from teller_requests tr
      where tr.req_id = v_ret;
    if v_result = '0' then -- success
      null;
    else
      dbms_output.put_line('Нет ответа');
--      raise_application_error(-20100,'Неможливо виконати операцію '||p_meth);
    end if;
    return v_ret;
  exception
    when others then
      bars_audit.info('p_url = '||p_url||chr(10)||
                      'p_body = '||p_body.getStringVal()||chr(10)||
                      'p_meth = '||p_meth||chr(10)||
                      'p_type = '||p_type);
      bars_audit.error('write_request error: '||sqlerrm);
      return 0;
  end write_request;
  --

  function StatusOperation
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_url      varchar2(20) := g_eq_url;
    v_num      number;
  begin

    select xmlelement("Option",xmlattributes(1 as "gsr:type"))
      into v_req_body
      from dual;
    v_req_id := SimpleOperation('GetStatus','Status',v_req_body);

--bars_audit.info('v_req_id = '||v_req_id);
    if get_req_status(v_req_id) = -1 then
        update_atm(p_url => v_url , p_amount => null, p_status => -1, p_status_desc => get_req_message(v_req_id), p_user => null);
        return 1;
    else
      for r in (select t.*,
                       case t.status_code
                          when '1'  then 'АТМ вільний'
                          when '16' then 'АТМ вільний, заблокований (користувач: '||t.curr_user||')'
                          when '3'  then 'АТМ очікує банкноти (користувач: '||t.curr_user||')'
                          when '4'  then 'АТМ приймає банкноти (користувач: '||t.curr_user||')'
                          when '5'  then 'АТМ відраховує банкноти (користувач: '||t.curr_user||')'
                          when '6'  then 'АТМ очікує на звільнення вихідного блоку від відбракованих банкнот (користувач: '||t.curr_user||')'
                          when '7'  then 'АТМ очікує на звільнення вихідного блоку від виданих банкнот (користувач: '||t.curr_user||')'
                          when '8'  then 'АТМ перезавантажується (користувач: '||t.curr_user||')'
                          when '11' then 'АТМ виконує операцію відміни приймання грошей (користувач: '||t.curr_user||')'
                          when '12' then 'АТМ виконує операцію відвантаження банкнот до інкасаційної касети (користувач: '||t.curr_user||')'
                          when '13' then 'Помилка на АТМ: '||dev_st_desc
                          when '17' then 'АТМ виконує операцію підрахунку банкнот (користувач: '||t.curr_user||')'
                          when '18' then 'Виконується операція верифікації'
                          when '0'  then 'Виконується початкова ініціалізація АТМ'
                          else           'Неочікуваний статус! '||t.dev_status||' '||t.dev_st_desc
                        end
                        stat_desc
                  from teller_requests,
                       xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                              'http://www.glory.co.jp/gsr.xsd' as "n"),
                                'soapenv:Envelope/soapenv:Body/n:StatusResponse' passing xml_response
                                columns
                                  status_code varchar2(3)   path 'Status/n:Code',
                                  dev_status  number        path 'Status/DevStatus/@n:st',
                                  dev_st_desc varchar2(100) path 'Status/DevStatus/@n:desc',
                                  curr_user   varchar2(100) path 'n:Id'
                               ) t
                  where req_id = v_req_id
               )
      loop
        update_atm(p_url => v_url ,
                   p_amount => null,
                   p_status => case r.dev_status
                                 when 2000 then r.dev_status+r.status_code
                                 else r.dev_status
                               end,
                  p_status_desc => r.stat_desc, p_user => r.curr_user);
      end loop;
    end if;

/*    select count(1)
      into v_num
      from teller_requests tr
          ,teller_atm_status tas
      where tas.equip_ip = v_url
        and tr.req_meth != 'GetStatus'
        and tr.creation_date>nvl(tas.amount_time,sysdate);
    if v_num = 0 then
      v_num := InventoryOperation(0);
    end if;*/

    return 1;
  end;
  --

  function get_device_status
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
  begin
    select xmlelement("Option",xmlattributes(0 as "gsr:type"))
      into v_req_body
      from dual;
    v_req_id := SimpleOperation('GetDeviceStatus','DeviceStatus',v_req_body);
    return 1;
  end;

  function OpenOperation
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_result   varchar2(100);
    v_session_id varchar2(100);
  begin

    select xmlconcat(xmlelement("gsr:User",teu.userlogin),
                     xmlelement("gsr:UserPwd", teu.userpassw),
                     xmlelement("gsr:DeviceName",decode(nvl(ts.equip_position,'R'),'R','RIGHT','L','LEFT','???'))
                    )
      into v_req_body
      from teller_stations ts, teller_equip_users teu
      where ts.station_name = g_hostname
        and ts.equip_ref = teu.equip_ref
        and teu.userrole = 'teller'
        and ts.equip_position = teu.position;

    v_req_id := SimpleOperation('OpenOperation','Open',v_req_body);
    select extractvalue(tr.xml_response,'soapenv:Envelope/soapenv:Body/n:OpenResponse/n:SessionID','xmlns="http://www.glory.co.jp/gsr.xsd" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:n="http://www.glory.co.jp/gsr.xsd"')
--           extractvalue(tr.xml_response,'soapenv:Envelope/soapenv:Body/n:OpenResponse/n:SessionID','xmlns="http://www.glory.co.jp/gsr.xsd" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:n="http://www.glory.co.jp/gsr.xsd"')
      into v_session_id
      from teller_requests tr
      where tr.req_id = v_req_id;

    Write_session_id(v_session_id);
    if get_req_status(v_req_id) = 0 then
      return 1;
    else
      return 0;
    end if;
  exception
    when no_data_found then
      logger.info('Teller error: '||sqlerrm);
      return 0;
  end OpenOperation;

  function CloseOperation
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
  begin
    if get_user_sessionID is not null then
      v_req_id := SimpleOperation('CloseOperation','Close',null);
    end if;
    Write_session_id(null);
    update teller_atm_status t
      set t.occupy_user = null
      where t.equip_ip = g_eq_url
        and t.work_date = g_bars_dt;
    return 1;
  end CloseOperation;

  function OccupyOperation
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_result   varchar2(100);
    v_sess_id  varchar2(100);
    v_res_num  number;
  begin

    v_req_id := StatusOperation;
    for r in (select * from teller_atm_status tas where tas.equip_ip = g_eq_url and tas.work_date = g_bars_dt)
    loop
      if r.occupy_user is not null and r.occupy_user != g_gloryname then
--        return 0;
        raise_application_error(-20111, 'Термінал заблокований користувачем '||r.occupy_user);
      elsif r.status in (2003) then
        return 1;
      elsif not r.status in (1000,1500) then
        raise_application_error(-20112, 'Термінал знаходиться в статусі "'||r.status_desc||'". Виконання операції неможливе!');
      end if;
    end loop;


    v_sess_id := get_session_id;
    v_req_id := SimpleOperation('OccupyOperation','Occupy',null);

    select extractvalue(tr.xml_response,'soapenv:Envelope/soapenv:Body/n:OccupyResponse/@n:desc','xmlns="http://www.glory.co.jp/gsr.xsd" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:n="http://www.glory.co.jp/gsr.xsd"'),
           extractvalue(tr.xml_response,'soapenv:Envelope/soapenv:Body/n:OccupyResponse/@n:result','xmlns="http://www.glory.co.jp/gsr.xsd" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:n="http://www.glory.co.jp/gsr.xsd"')
      into v_result, v_res_num
      from teller_requests tr
      where tr.req_id = v_req_id;

    update teller_requests
      set response  = case v_res_num
                        when 3 then 'АТМ заблокований іншим користувачем'
                        else v_result
                      end
      where req_id = v_req_id;
    commit;
    if v_res_num in (0,17) then --  успешно
      return 1;
    elsif v_res_num = 3 then -- occupied by other
      return v_res_num;
    elsif v_res_num = 21 then -- Invalid Session
--      v_res_num := ReleaseOperation;
      v_res_num := CloseOperation;
      v_res_num := OpenOperation;
      v_req_id := SimpleOperation('OccupyOperation','Occupy',null);
      select extractvalue(tr.xml_response,'soapenv:Envelope/soapenv:Body/n:OccupyResponse/@n:desc','xmlns="http://www.glory.co.jp/gsr.xsd" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:n="http://www.glory.co.jp/gsr.xsd"'),
             extractvalue(tr.xml_response,'soapenv:Envelope/soapenv:Body/n:OccupyResponse/@n:result','xmlns="http://www.glory.co.jp/gsr.xsd" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:n="http://www.glory.co.jp/gsr.xsd"')
        into v_result, v_res_num
        from teller_requests tr
        where tr.req_id = v_req_id;

      update teller_requests
        set response  = case v_res_num
                          when 3 then 'АТМ заблокований іншим користувачем'
                          else v_result
                        end
        where req_id = v_req_id;
      commit;
      if v_res_num in (0,17) then
        return 1;
      else
        return v_res_num;
      end if;
    else
      return 0;
    end if;
    return 0;
  end OccupyOperation;

  function ReleaseOperation
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_result   varchar2(2);
    v_req_status number;
  begin
    if get_user_sessionID is not null then
      v_req_id := SimpleOperation('ReleaseOperation','Release',null);
    end if;
    update teller_atm_status t
      set t.occupy_user = null
      where t.equip_ip = g_eq_url
        and t.work_date = g_bars_dt;
    return 1;
  end ReleaseOperation;

  function StartCashinOperation
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_result   varchar2(2);
    v_req_status number;
  begin

    if get_user_sessionID is null then
      if not (OpenOperation = 1 and OccupyOperation = 1) then
        bars_audit.error('Неможливо підключитись до терміналу.');
        return 0;
      end if;
    end if;

    v_req_id := OccupyOperation;
/*
    select xmlelement("Option",xmlattributes(0 as "gsr:type"))
      into v_req_body
      from dual;*/
    v_req_id := SimpleOperation('StartCashinOperation','StartCashin',create_req_body(0));
    v_req_status := get_req_status(v_req_id);
    if v_req_status in (5) and OccupyOperation != 1 then
      return 0;
    elsif v_req_status = 11  then
      if not (OpenOperation = 1 and OccupyOperation = 1) then
        return 0;
      else
        v_req_id := SimpleOperation('StartCashinOperation','StartCashin',create_req_body(0));
        v_req_status := get_req_status(v_req_id);

        if v_req_status = 0 then
          return 0;
        end if;
      end if;
    end if;
    return 1;
  end StartCashinOperation;

  function StoreCashinOperation
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_result   varchar2(2);
    v_amount   number;
    v_curcode  varchar2(3) := teller_utils.get_active_curcode();
    v_response varchar2(1000);
  begin
    v_req_id := SimpleOperation('StoreCashinOperation','StoreCashin', null);
    select listagg(cur_code||': '||amn,', ') within group (order by null),
           sum(round(amn * rato(teller_utils.get_r030(cur_code),gl.bDATE),2))
      into v_response,
           v_amount
    from (
    select cur_code, sum(nominal * pieces) amn
      from teller_requests r,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                       'http://www.glory.co.jp/gsr.xsd' as "n"),
                         'soapenv:Envelope/soapenv:Body/n:StoreCashinResponse/Cash/Denomination' passing r.xml_response
                          columns
                          cur_code varchar2(3) path '@n:cc',
                          nominal  number      path '@n:fv',
                          pieces   number      path 'n:Piece') t
      where req_id = v_req_id
      group by cur_code);

    update teller_requests
      set OPER_AMOUNT_TXT = substr(v_response,1,100)
         ,oper_amount = v_amount
      where req_id = v_req_id;
    return 1;
  exception
    when others then
      bars_audit.error('teller_soap_api.storecashinoperation :'||sqlerrm);
      return 0;
  end StoreCashinOperation;

  function EndCashinOperation
    return number
    is
    v_req_id number;
    v_req_body xmltype;
    v_amount   number;
    v_curcode  varchar2(3) := teller_utils.get_active_curcode();
    v_response varchar2(1000);
    v_response_add varchar2(1000);
    v_tmp_req  number;
    v_sendback varchar2(1000);
  begin
    v_req_id := SimpleOperation('EndCashinOperation','EndCashin', null);

    for r in (select cur_code, sum(nominal * pieces) amn
                from teller_requests r,
                     xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                 'http://www.glory.co.jp/gsr.xsd' as "n"),
                                   'soapenv:Envelope/soapenv:Body/n:EndCashinResponse/Cash/Denomination' passing r.xml_response
                                    columns
                                    cur_code varchar2(3) path '@n:cc',
                                    nominal  number      path '@n:fv',
                                    pieces   number      path 'n:Piece') t
                where req_id = v_req_id
                group by cur_code
             )
    loop
      if teller_utils.get_cur_code(v_curcode) != r.cur_code then  -- надо вытолкнуть другую валюту
        v_tmp_req := CashOutOperation(p_curcode => r.cur_code, p_amount => r.amn);
        if v_sendback is not null then
          v_sendback := v_sendback || '<br/>';
        end if;
        v_sendback := r.cur_code||': '||r.amn;
      else
        v_amount := r.amn;
        v_response := r.cur_code||': '||r.amn;
      end if;
    end loop;
/*
    select sum(nominal * pieces)
      into v_amount
      from teller_requests r,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                       'http://www.glory.co.jp/gsr.xsd' as "n"),
                         'soapenv:Envelope/soapenv:Body/n:EndCashinResponse/Cash/Denomination' passing r.xml_response
                          columns
                          cur_code varchar2(3) path '@n:cc',
                          nominal  number      path '@n:fv',
                          pieces   number      path 'n:Piece') t
      where req_id = v_req_id
        and t.cur_code = teller_utils.get_cur_code(nvl(v_curcode,t.cur_code));

*/
/*    select listagg(amn||' '||cur_code,', ') within group (order by null)
      into v_response
    from (
    select cur_code, sum(nominal * pieces) amn
      from teller_requests r,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                       'http://www.glory.co.jp/gsr.xsd' as "n"),
                         'soapenv:Envelope/soapenv:Body/n:EndCashinResponse/Cash/Denomination' passing r.xml_response
                          columns
                          cur_code varchar2(3) path '@n:cc',
                          nominal  number      path '@n:fv',
                          pieces   number      path 'n:Piece') t
      where req_id = v_req_id
      group by cur_code);
*/
/*    select listagg(cur_code||': '||amn,', ') within group (order by null)
      into v_response_add
    from (
    select cur_code, sum(t1.nominal * t1.pieces) amn
      from teller_requests r,
           teller_atm_units u,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                        'http://www.glory.co.jp/gsr.xsd' as "n"),
                         'soapenv:Envelope/soapenv:Body/n:InventoryResponse/CashUnits/CashUnit[@n:unitno=$i]/Denomination' passing r.xml_response, u.unitno as "i"
                         columns
                           cur_code varchar2(3) path '@n:cc',
                           nominal  number      path '@n:fv',
                           pieces   number      path 'n:Piece',
                           rev      number      path '@n:rev') t1
      where req_id = v_req_id
        and u.equip_id = teller_tools.get_eq_id
      group by cur_code);
*/


    if v_response is null then
      v_response := 'Приймання готівки в АТМ не виконувалось '||case when v_sendback is null then '' else '<br/>Повернено: <br/>'||v_sendback end;
    else
      v_response := 'В АТМ прийнято готівку: '||v_response||case when v_sendback is null then '' else '<br/>Повернено: <br/>'||v_sendback end;
    end if;
    update teller_requests
      set oper_amount = nvl(v_amount,0),
          oper_currency = v_curcode,
          OPER_AMOUNT_TXT = v_response/*||', в т.ч. зношені: '||v_response_add*/
      where req_id = v_req_id;
    v_req_id := ReleaseOperation;
    return 1;
  exception
    when others then
      bars_audit.error('Teller: Помилка : '||sqlerrm);
      return 0;
  end EndCashinOperation;

  function CancelCashinOperation
    return number
    is
    v_req_id number;
    v_amount number;
    v_req_body xmltype;
   begin
     v_req_id := SimpleOperation('CancelCashinOperation','CancelCashin');
     v_req_id := 0;
     for r in (select req_id
                 from teller_requests t
                 where t.oper_ref = teller_utils.get_active_oper()
                   and t.req_meth = 'StoreCashinOperation'
                 order by req_id desc
              )
     loop
       select xmlconcat(
              xmlelement("gsr:Cash",xmlattributes(2 as "gsr:type"),
                        xmlagg(xmlelement("Denomination",xmlattributes(cur_code as "gsr:cc", nominal as "gsr:fv",1 as "gsr:devid",rev as "gsr:rev"),
                                          xmlelement("gsr:Piece",pieces),
                                          xmlelement("gsr:Status",0)
                                         )
                              )

                        )
                    )
         into v_req_body
      from teller_requests tr,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                       'http://www.glory.co.jp/gsr.xsd' as "n"),
                         'soapenv:Envelope/soapenv:Body/n:StoreCashinResponse/Cash/Denomination' passing tr.xml_response
                          columns
                          cur_code varchar2(3) path '@n:cc',
                          nominal  number      path '@n:fv',
                          pieces   number      path 'n:Piece',
                          rev      number      path '@n:rev') t
      where tr.req_id = r.req_id;

       v_req_id := 1;
       exit;
     end loop;
     if v_req_id = 1 then
       v_req_id := SimpleOperation('CashoutOperation','Cashout',v_req_body);
        if get_req_status(v_req_id) = 5 then
          if OpenOperation = 1 and OccupyOperation = 1 then
            v_req_id := SimpleOperation('CashoutOperation','Cashout',v_req_body);
            if get_req_status(v_req_id) != 0 then
              return 0;
            end if;
          else
            return 0;
          end if;
        end if;

    -- обрабатываем успешный ответ
        select sum(xt.amount * cnt)
          into v_amount
          from teller_requests t,
             xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",'http://www.glory.co.jp/gsr.xsd' as "n"),
             'soapenv:Envelope/soapenv:Body/n:CashoutResponse/Cash/Denomination' passing t.xml_response
             columns
             cur varchar2(3) path '@n:cc',
             amount number   path '@n:fv',
             cnt    number   path 'n:Piece') xt
          where req_id = v_req_id;

        update teller_requests ts
          set ts.oper_amount = v_amount
          where req_id = v_req_id;
    --
        loop
          v_req_id := StatusOperation;
          exit when get_current_dev_status() in (1000,1500,9200);
          dbms_lock.sleep(1);
        end loop;
        v_req_id := InventoryOperation;
     end if;
     v_req_id := ReleaseOperation;
     return 1;
   exception
     when others then
       bars_audit.error('Помилка : '||sqlerrm);
       return 0;
   end CancelCashinOperation;

  /*Выдача наличных
    на вход принимаем код валюты и сумму выдачи
  */
  function CashOutOperation (p_curcode in varchar2 default null
                            ,p_amount  in number   default null
                            )
    return number
    is
    v_req_id number;
    v_req_body xmltype;
    v_cur varchar2(3) := p_curcode;
    v_amount number   := p_amount;
    v_sessid varchar2(100);
    v_num number;
    v_denomination t_arr_nom;
    v_result integer;
  begin
--    if get_user_sessionID is not null then
--      v_num := ReleaseOperation;
--    end if;
    if get_user_sessionID is null then
      v_num := OpenOperation;
    end if;
    v_result := get_req_status(get_active_request_id());
    if v_result not in (0,5,21) then
      return 0;
    end if;
    v_num := InventoryOperation(2);
    if v_cur is null and v_amount is null then

      for r in (select ts.*, op.state, op.amount, op.doc_ref, op.id
                  from teller_state ts,
                       teller_opers op
                  where ts.user_ref = user_id
                    and ts.work_date = g_bars_dt
                    and ts.active_oper = op.id)
      loop
        if r.state = 'RO' and r.active_oper<0 then  -- отмена операции СБОН+
          v_amount := r.amount;
          v_cur    := 'UAH';
        elsif r.state = 'RI' or substr(r.state,1,1) = 'I' then
          v_amount  := teller_utils.get_in_amount(r.id,v_cur);
        else
          v_amount  := teller_utils.get_out_amount(r.id,v_cur);
        end if;
        v_sessid  := r.session_id;
      end loop;
    end if;
    v_cur := teller_utils.get_cur_code(v_cur);
    v_denomination := create_denomination(v_cur,v_amount);
    if v_denomination is not null then
      select xmlconcat(
              xmlelement("gsr:Cash",xmlattributes(2 as "gsr:type"),
                        xmlagg(xmlelement("Denomination",xmlattributes(v_cur as "gsr:cc", t_amn.r_value as "gsr:fv",1 as "gsr:devid",t_amn.r_isChange as "gsr:rev"),
                                          xmlelement("gsr:Piece",t_amn.r_count),
                                          xmlelement("gsr:Status",0)
                                         )
                              )

                        )
                    )
        into v_req_body
        from table(cast(v_denomination as t_arr_nom)) t_amn;

      v_req_id := OccupyOperation;
      v_req_id := SimpleOperation('CashoutOperation','Cashout',v_req_body);

      if get_req_status(v_req_id) in (5,21) then
        if OpenOperation = 1 and OccupyOperation = 1 then
          v_req_id := SimpleOperation('CashoutOperation','Cashout',v_req_body);
          if get_req_status(v_req_id) != 0 then
            return 0;
          end if;
        else
          return 0;
        end if;
      end if;

  -- обрабатываем успешный ответ
      select sum(xt.amount * cnt)
        into v_amount
        from teller_requests t,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",'http://www.glory.co.jp/gsr.xsd' as "n"),
           'soapenv:Envelope/soapenv:Body/n:CashoutResponse/Cash/Denomination' passing t.xml_response
           columns
           cur varchar2(3) path '@n:cc',
           amount number   path '@n:fv',
           cnt    number   path 'n:Piece') xt
        where req_id = v_req_id;

      update teller_requests ts
        set ts.oper_amount = v_amount,
            ts.oper_currency = v_cur,
            ts.oper_amount_txt = 'Видано готівку: '||v_amount||' '||v_cur
        where req_id = v_req_id;

      update teller_opers
        set req_ref = v_req_id
        where doc_ref = (select ts.active_oper from teller_state ts where ts.user_ref = user_id and work_date = g_bars_dt);
  --
      loop
        v_req_id := StatusOperation;
        exit when get_current_dev_status() in (1000,1500,9200);
        dbms_lock.sleep(1);
      end loop;
      v_num := InventoryOperation;
--
    else
      insert into teller_requests (req_id,
                                   url,
                                   req_type,
                                   req_meth,
                                   req_body,
                                   status,
                                   oper_ref,
                                   oper_amount,
                                   response,
                                   oper_currency)
      values (s_teller_soap_id.nextval, g_eq_url, 'CashoutRequest', 'CashoutOperation',null,-1,teller_utils.get_active_oper(),0,
              'В АТМ немає купюр потрібного номіналу. Видача тільки з темпокаси',
              v_cur)
      returning req_id, oper_ref into v_req_id, v_num;
      update teller_opers op
        set op.req_ref = v_req_id
        where doc_ref = v_num
          and user_ref = user_id
          and work_date = g_bars_dt
        returning id into v_num;
      teller_utils.set_active_oper(v_num);
      bars_audit.info('В АТМ немає купюр потрібного номіналу. Видача тільки з темпокаси');
    end if;
    v_req_id := ReleaseOperation;
    commit;
    return 1;
  exception
    when others then
      bars_audit.error('Помилка при роботі CashOutOperation :'||sqlerrm);
      return 0;
  end CashOutOperation;

  function InventoryOperation (p_option in number default 0)
    return number
    is
    v_req_id number;
    v_req_body xmltype;
    v_resp_code varchar2(100);
    v_num       number;
    v_cnt       integer := 0;
    v_session_id varchar2(100);
  begin
    loop
      v_session_id := get_session_id;
      exit when v_session_id is not null or v_cnt>2;

      if v_session_id is null then
        v_req_id := OpenOperation;
      end if;
      v_cnt := v_cnt + 1;
    end loop;
    if v_session_id is null then
      return 0;
    end if;
    v_req_body := create_req_body(p_option);
    v_req_id   := SimpleOperation('InventoryOperation','Inventory',v_req_body);

    select r.xml_response,
           r.response
      into v_req_body,
           v_resp_code
      from teller_requests r
      where r.req_id = v_req_id;
    if substr(v_resp_code,1,2) in (21,11) then -- invalidSession
      if v_resp_code = 11 then
        v_req_id := ReleaseOperation;
        v_req_id := CloseOperation;
      end if;
      if OpenOperation = 1 then
--        if OccupyOperation = 1 then
          v_req_id := SimpleOperation('InventoryOperation','Inventory',create_req_body(p_option));
          select r.xml_response,
                 r.response
            into v_req_body,
                 v_resp_code
            from teller_requests r
            where r.req_id = v_req_id;
          if substr(v_resp_code,1,1) != '0' then
            return 0;
          end if;
--        end if;
      else
        return 0;
      end if;
    end if;

    for r in (select t.curr_user
                from teller_requests tr,
                     xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                            'http://www.glory.co.jp/gsr.xsd' as "n"),
                              'soapenv:Envelope/soapenv:Body/n:InventoryResponse' passing xml_response
                              columns
                                curr_user   varchar2(100) path 'n:Id'
                             ) t
                where tr.req_id = v_req_id
             )
    loop
      update_atm(p_url => g_eq_url , p_amount => case p_option
                                                   when 2 then null
                                                   else v_req_body
                                                 end, p_status => null, p_status_desc => null, p_user => r.curr_user);
    end loop;
/*    merge into teller_atm_status tas
    using (select  tst.equip_ref eq_ref, tst.url eq_ip, g_bars_dt w_dt, v_req_body eq_amn
             from teller_stations tst
             where tst.station_name = sys_context('userenv','host')
          ) u
    on (tas.equip_code = u.eq_ref and tas.equip_ip = u.eq_ip and tas.work_date = u.w_dt)
    when matched then
      update set amount = u.eq_amn, last_user = user_id, last_dt = sysdate
    when not matched then
      insert (equip_code, equip_ip, work_date, amount, last_user, last_dt)
      values (u.eq_ref, u.eq_ip, u.w_dt, u.eq_amn, user_id, sysdate);*/

    commit;
    return 1;
  exception
    when others then
      return 0;
  end InventoryOperation;

  function InventoryClearOperation (p_option in number default 2)
    return number
    is
    v_req_id number;
    v_req_body xmltype;
  begin
    select xmlelement("Option",xmlattributes(p_option as "gsr:type"))
      into v_req_body
      from dual;
    v_req_id := SimpleOperation('InventoryClearOperation','InventoryClear',v_req_body);
    return 1;
  end InventoryClearOperation;

  function InventoryAdjustmentOperation
    return number
    is
    v_req_id number;
    v_req_body xmltype;
  begin
    select xmlconcat(xmlelement("Option",xmlattributes(1 as "gsr:type")),
           xmlelement("Cash",xmlattributes(0 as "gsr:type"))
                     )

      into v_req_body
      from dual;
    v_req_id := SimpleOperation('InventoryAdjustmentOperation','InventoryAdjustment',v_req_body);
    if get_req_status(v_req_id) = 21 and OpenOperation = 0
      then return 0;
    else
      v_req_id := SimpleOperation('InventoryAdjustmentOperation','InventoryAdjustment',v_req_body);
    end if;
    return 1;
  end InventoryAdjustmentOperation;



  function SimpleOperation (p_meth in varchar2, p_reqname in varchar2, p_params in xmltype := null)
    return number
    is
    v_req_id number;
    v_result varchar2(100);
    v_meth   varchar2(100) := p_meth;--||'Request';
    v_reqname varchar2(100) := p_reqname||'Request';
    v_sqltext varchar2(2000);
    v_sessid  varchar2(2000);
--    pragma autonomous_transaction;
  begin

    v_req_id := write_request(g_eq_url, p_params, v_meth, v_reqname);
    v_meth   := p_reqname||'Response';
    v_sqltext := 'begin select tr.xml_response.extract(''//n:'||v_meth||'/@n:result'',''xmlns:n="http://www.glory.co.jp/gsr.xsd"'').getstringval()||
                        '' - ''||
                        tr.xml_response.extract(''//n:'||v_meth||'/@n:desc'',''xmlns:n="http://www.glory.co.jp/gsr.xsd"'').getstringval() into :1 from teller_requests tr where tr.req_id = '||v_req_id||';
                  exception when others then dbms_output.put_line(sqlerrm); null;
                  end;';

    execute immediate v_sqltext
      using out v_result;
--bars_audit.info('v_sqltext ='||v_sqltext);
--bars_audit.info('v_result ='||v_result);

    update teller_requests tr
      set tr.response = v_result,
          status      = substr(v_result,1,2)
      where req_id = v_req_id
        and tr.status != 'ER';

    update teller_opers op
      set op.req_ref = v_req_id
      where op.user_ref = user_id
        and (op.doc_ref = teller_utils.get_active_oper() or op.id = teller_utils.get_active_oper());



--    commit;
    return v_req_id;
  end SimpleOperation;


/*
клон soap_rpc.invoke для наших специфических задач
*/

  function invoke(p_req_id in number,
                  p_respcode out number)
    return soap_rpc.t_response
    is
    l_env          clob;
    l_env_length   number;
    l_line         clob;
    l_res          clob;
    l_http_req     utl_http.req;
    l_http_resp    utl_http.resp;
    l_resp         soap_rpc.t_response;
    l_fault_node   xmltype;
    l_fault_code   varchar2(256);
    l_fault_string varchar2(32767);
    header_name varchar2(2000);
    header_value varchar2(2000);

    v_req soap_rpc.t_request;
    v_req_body varchar2(2000);
    v_protocol teller_stations.c_type%type;
  begin
    select g_local_ns, tr.req_meth, tr.req_body.getclobval(), url
      into v_req.namespace, v_req.method, v_req.body, v_req.url
      from teller_requests tr
      where tr.req_id = p_req_id;

    select c_type
      into v_protocol
      from teller_stations ts
      where ts.station_name = g_hostname;

    l_env := v_req.body;

--    utl_http.set_transfer_timeout(soap_rpc.g_transfer_timeout);

    -- формируем заголовки сообщения

--    utl_http.set_proxy(proxy => '10.10.10.1');
    utl_http.set_transfer_timeout(1000);

    utl_http.set_wallet(path     => getglobaloption('PATH_FOR_ABSBARS_WALLET'),
                        password => getglobaloption('PASS_FOR_ABSBARS_WALLET'));

    l_http_req := utl_http.begin_request(url          => g_local_url,
                                         method       => 'POST',
                                         http_version => utl_http.HTTP_VERSION_1_0);

    utl_http.set_header(l_http_req,
                        'Content-Type',
                        'text/xml; charset=windows-1251');




    utl_http.set_header(l_http_req,
                        'GloryUrl',
                        nvl(v_protocol,'http')||'://'||v_req.url||'/axis2/services/GSRService');

    utl_http.set_header(l_http_req,
                        'User',
                        user_name);


/*    utl_http.set_header(l_http_req,
                        'GloryUrl',
                        getglobaloption('WS_GLORY'));
*/
    utl_http.set_header(l_http_req,
                        'GloryIP',
                        v_req.url);

    utl_http.set_header(l_http_req,
                        'GloryProtocol',
                        v_protocol);


    utl_http.set_header(l_http_req,
                        'SessionID',
                        get_user_sessionID());

    utl_http.set_header(l_http_req,
                        'IsLongRequest',
                        case v_req.method
                          when 'CollectOperation' then 1
                          when 'CashoutOperation' then 1
                          else 0
                        end
                          );

    utl_http.set_header(l_http_req,
                        'GloryAction',
                        v_req.method);

    utl_http.set_header(l_http_req,
                        'SOAPAction',
                        v_req.namespace || '' || 'CallProxy');

    -- определяем длину сообщения
    l_env_length := dbms_lob.getlength(l_env);

    -- формируем тело запроса
    if (l_env_length <= 32767) then
      -- если длина xml-данных меньше 32Кб
      utl_http.set_header(r     => l_http_req,
                          name  => 'Content-Length',
                          value => l_env_length);

      -- тело запроса
      declare
        l_tmp varchar2(32767) := dbms_lob.substr(l_env, 32767, 1);
      begin
/*        dbms_output.put_line('------------Request body---------------------------');
        dbms_output.put_line(l_tmp);
*/        utl_http.write_text(l_http_req, l_tmp);

--          insert into teller_requests(envelope) values (l_tmp);
      end;
    elsif (l_env_length > 32767) then
      -- если длина xml-данных больше 32Кб
      utl_http.set_header(r     => l_http_req,
                          name  => 'Transfer-Encoding',
                          value => 'chunked');

      -- тело запроса по кусочкам
      declare
        l_offset  number := 1;
        l_ammount number := 2000;
        l_buffer  varchar2(2000);
      begin
        while (l_offset < l_env_length) loop
          dbms_lob.read(l_env, l_ammount, l_offset, l_buffer);
          utl_http.write_text(l_http_req, l_buffer);
          l_offset := l_offset + l_ammount;
        end loop;
      end;
    end if;

    -- получаем ответ
    l_http_resp := utl_http.get_response(l_http_req);
    l_res       := null;
    begin
      loop
        utl_http.read_text(l_http_resp, l_line);
        l_res := l_res || l_line;
      end loop;
    exception
      when utl_http.end_of_body then
        null;
    end;
    utl_http.end_response(l_http_resp);
    l_resp.doc := xmltype.createxml(l_res);
    p_respcode := l_http_resp.status_code;
    return l_resp;
  exception
    when others then
      dbms_output.put_line(sqlcode);
      if sqlcode = -29273 then
        raise_application_error(-20100,'Неможливо підключитись до обладнання за адресою '||g_eq_url||'.'||chr(10)||' Помилка: '||sqlerrm);
      else
        raise_application_error(-20100,'Помилка під час виклику Web-Service '||sqlerrm);
      end if;
  end invoke;

  function make_request (p_oper_code in varchar2
                         ,p_oper_cur  in number   default 980
                         ,p_oper_sum  in number)
    return varchar2
    is
    v_progname varchar2(100) := g_package_name || '.MAKE_REQUEST';
    v_ret      varchar2(2000);
    v_op_type  varchar2(4);
    v_ws_name  varchar2(100);
    v_sql      varchar2(2000);
  begin
    select tod.need_req
      into v_op_type
      from teller_oper_define tod
      where tod.oper_code = p_oper_code
        and tod.cur_code = p_oper_cur;

    for r in (select * from teller_ws_define wd where wd.op_type = v_op_type order by wd.ws_id)
    loop
      if r.ws_type = 'I' then
        v_sql := 'begin teller_soap_api.'||r.funcname||'; end;';
        bars_audit.info('TELLER. Вызов WS ['||r.ws_name||']');
        execute immediate v_sql;
      elsif r.ws_type = 'D' then
        insert into teller_queue (user_id,
                                  user_name,
                                  host,
                                  req_name,
                                  start_dt,
                                  last_dt,
                                  req_resp,
                                  dev_status,
                                  oper_type,
                                  oper_ref,
                                  oper_code)
        values (user_id, user_name, g_hostname, r.ws_name, sysdate, sysdate, null, null, v_op_type, null, p_oper_code);
        v_ws_name := r.ws_name;
        exit;
      end if;
    end loop;
    v_ret := 'Инициализировано обращение к устройству %device_name веб-сервиса '||v_ws_name||'.'
             ||chr(10)||'детальная информация по работе устройства в профиле пользователя';
    bars_audit.info(v_progname||'. Вызов веб-сервиса для работы с терминалом из интерфейса');
    return v_ret;
  end make_request;
  --
  function make_request (p_oper_code  in varchar2
                         ,p_oper_cur  in varchar2   default 'UAH'
                         ,p_oper_sum  in number)
    return varchar2
    is
    v_ret varchar2(2000);
    v_curcode number;
  begin
    select v.kv into v_curcode
      from tabval v
      where v.lcv = p_oper_cur;
    v_ret := make_request(p_oper_code, v_curcode, p_oper_sum);
  exception
    when no_data_found then
      raise_application_error(-20100,'Не знайдено валюту ['||p_oper_cur||'] в довіднику валют');
    when others then
      raise_application_error(-20100,sqlerrm);
  end;


  function make_request (p_oper_ref in number)
    return varchar2
    is
    v_ret varchar2(2000);
    v_curcode number;
    v_oper_code tts.tt%type;
    v_oper_sum number;
    v_state varchar2(10) := '--';
  begin
    for r in (select * from teller_opers where oper_ref = p_oper_ref) loop
      v_state := r.state;
    end loop;

  /*  if v_state = '--' then
      insert into teller_opers (user_ref, oper_ref, exec_time, cur_code, dbt, crd, amount, amount_uah, doc_ref, is_sw_oper, state, req_ref, work_date)
        values (
  */

    select o.tt, o.kv, o.s
      into v_oper_code, v_curcode, v_oper_sum
      from oper o
      where ref = p_oper_ref;
    v_ret := make_request(v_oper_code, v_curcode, v_oper_sum);
  exception
    when no_data_found then
      raise_application_error(-20100,'Операцію з ref = '||p_oper_ref||' не знайдено в АБС. Некоректний виклик функції');
    when others then
      raise_application_error(-20100,sqlerrm);
  end;



  procedure process_queue
    is
  begin
    null;
  end process_queue;

  procedure save_atm_oper (p_cur in varchar2
                          ,p_amn in number)
    is
  pragma autonomous_transaction;
  begin
    insert into teller_atm_opers (eq_ip,
                                  oper_time,
                                  oper_type,
                                  oper_ref,
                                  status,
                                  cur_code,
                                  amount,
                                  user_ref,
                                  user_ip)
      values (g_eq_url,
              sysdate,
              decode(sign(p_amn),-1,'OUT','IN'),
              teller_utils.get_active_oper,
              'NEW',
              p_cur,
              abs(p_amn),
              user_id,
              g_hostname);
    commit;
  end save_atm_oper;

  procedure update_atm (p_url         in varchar2
                       ,p_amount      in xmltype
                       ,p_status      in varchar2
                       ,p_status_desc in varchar2
                       ,p_user        in varchar2)
    is
--  pragma autonomous_transaction;
    v_amount number;
  begin
/*        if get_req_status = 0 then
--      if p_amount is not null then  -- зашло что-то...
        begin
logger.info('Start select');
        declare 
          v_tmp number := 1;
          v_str varchar2(1000);
        begin
        loop
          v_str := substr(p_amount.getClobVal,v_tmp,1000);
          logger.info(v_str);
          v_tmp := v_tmp + 1000;
          exit when length(v_str)<1000;
        end loop;
        end;
        for q in (select * from xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                      'http://www.glory.co.jp/gsr.xsd' as "n"),
                       'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing p_amount
                       columns
                         cur_code varchar2(3) path '@n:cc',
                         nominal  number      path '@n:fv',
                         pieces   number      path 'n:Piece') curr
                     where pieces != 0)
        loop
          logger.info('Teller ATM new : '||q.cur_code||'.'||q.nominal||'.'||q.pieces);
        end loop;

        for q in (select * 
                    from teller_atm_status s,
                        xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                      'http://www.glory.co.jp/gsr.xsd' as "n"),
                       'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing s.amount
                       columns
                         cur_code varchar2(3) path '@n:cc',
                         nominal  number      path '@n:fv',
                         pieces   number      path 'n:Piece') curr
                     where s.equip_ip = g_eq_url 
                       and pieces != 0)
        loop
          logger.info('Teller ATM old : '||q.cur_code||'.'||q.nominal||'.'||q.pieces);
        end loop;


        for r in (
                  select curr.cur_code, sum(prev.nominal * prev.pieces) prev_amn, 
                                        sum(curr.nominal * curr.pieces) curr_amn
                    from teller_atm_status s, 
                       xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                      'http://www.glory.co.jp/gsr.xsd' as "n"),
                       'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing s.amount
                       columns
                         cur_code varchar2(3) path '@n:cc',
                         nominal  number      path '@n:fv',
                         pieces   number      path 'n:Piece') prev,
                      xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                      'http://www.glory.co.jp/gsr.xsd' as "n"),
                       'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing p_amount
                       columns
                         cur_code varchar2(3) path '@n:cc',
                         nominal  number      path '@n:fv',
                         pieces   number      path 'n:Piece') curr
                   where s.equip_ip = g_eq_url
                     and s.work_date = g_bars_dt
                     and prev.cur_code = curr.cur_code
                     and prev.nominal = curr.nominal
                     and (prev.pieces !=  curr.pieces) 
                   group by curr.cur_code
                     )
        loop
          logger.info('Teller ATM old = '||r.prev_amn||', new = '||r.curr_amn);
          teller_soap_api.save_atm_oper(r.cur_code, r.prev_amn - r.curr_amn);
        end loop;

      exception
        when others then 
          logger.info('Teller.Upd_atm_status error : '||sqlerrm);
      end;
      end if;*/
      update teller_atm_status
        set amount = nvl(p_amount,amount)
           ,last_user = g_hostname
           ,last_dt = sysdate
           ,status = nvl(p_status,status)
           ,status_desc = nvl(p_status_desc,status_desc)
           ,occupy_user = nvl(p_user,occupy_user)
           ,amount_time = sysdate
        where equip_ip = p_url
          and work_date = g_bars_dt;
      if sql%rowcount = 0 then

        insert into teller_atm_status (equip_code, equip_ip, work_date, amount, last_user, last_dt, status, status_desc, occupy_user, amount_time)
          select ts.equip_ref, p_url, g_bars_dt, p_amount, g_hostname, sysdate, p_status, p_status_desc, p_user, sysdate
            from teller_stations ts
            where ts.station_name = g_hostname
              and ts.url = p_url;
      end if;
/*bars_audit.info(p_url||' - '||p_status||','||p_status_desc);
    merge into TELLER_ATM_STATUS tas
    using (select ts.equip_ref equip_code, ts.station_name s_name, ts.url url, g_bars_dt wdt, p_amount amn,
                  p_status status,
                  p_status_desc status_desc,
                  p_user        user_occ
             from teller_stations ts
               where ts.station_name = g_hostname and ts.url = p_url) d
    on (tas.equip_ip = d.url and tas.work_date = d.wdt)
    when matched then update
      set amount = nvl(d.amn,amount),
          last_user = d.s_name,
          last_dt = sysdate,
          status = nvl(d.status,tas.status),
          status_desc = nvl(d.status_desc,tas.status_desc),
          occupy_user = nvl(d.user_occ, occupy_user),
          amount_time = sysdate
    when not matched then
      insert (equip_code, equip_ip, work_date, amount, last_user, last_dt, status, status_desc, occupy_user, amount_time)
      values(d.equip_code, d.url, d.wdt, d.amn, d.s_name, sysdate, d.status, d.status_desc, d.user_occ, sysdate);*/
--    commit;
  exception
    when others then
      bars_audit.info('Step4: '||sqlerrm);
  end;

  function get_atm_balance (p_cur in varchar2)
    return number
    is
    v_ret number;
  begin

    select sum(t.nominal * nvl(t.pieces,0))
      into v_ret
      from teller_atm_status tas,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                  'http://www.glory.co.jp/gsr.xsd' as "n"),
                   'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash/Denomination' passing tas.amount
                   columns
                     cur_code varchar2(3) path '@n:cc',
                     nominal  number      path '@n:fv',
                     pieces   number      path 'n:Piece') t
    where tas.equip_ip = g_eq_url
      and tas.work_date = g_bars_dt
      and t.cur_code = p_cur;

    return v_ret;
  exception
    when others then
      return 0;
  end;

  function create_denomination (p_currency in varchar2, p_amount in number)
    return t_arr_nom
    is
    v_ret t_arr_nom := t_arr_nom();
    v_num number;
    v_amn number := p_amount;
  begin
    for r in (select t.*
                from teller_atm_status tas,
                     tabval v,
                     xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                            'http://www.glory.co.jp/gsr.xsd' as "n"),
                             'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash/Denomination' passing tas.amount
                             columns
                               cur_code varchar2(3) path '@n:cc',
                               nominal  number      path '@n:fv',
                               rev      number      path '@n:rev',
                               pieces   number      path 'n:Piece') t
              where tas.equip_ip = g_eq_url
                and tas.work_date = g_bars_dt
                and /*(v.kv = p_currency or */v.lcv = p_currency
                and v.lcv = t.cur_code
                and t.pieces > 0
              order by t.nominal desc)
    loop
      if v_amn>=r.nominal then
        v_ret.extend;
        v_ret(v_ret.last) := t_nominal(null,null,null,null);
        v_ret(v_ret.last).r_value := r.nominal;
        v_ret(v_ret.last).r_IsChange := r.rev;
        v_ret(v_ret.last).r_count := least(trunc(v_amn/r.nominal),r.pieces);
        v_amn := v_amn - v_ret(v_ret.last).r_value*v_ret(v_ret.last).r_count;
      end if;
    end loop;
    if v_ret.count != 0 then
      return v_ret;
    else
      return null;
    end if;
    return null;
  exception
    when others then
      bars_audit.error('create_denomination.error ('||p_amount||'.'||p_currency||') = '||sqlerrm);
  end;

  function user_reconnect (p_errtxt out varchar2)
    return number
    is
    v_num number;
  begin
    if OpenOperation = 1 then
      p_errtxt := 'Операцію виконано успішно';
      return 1;
    else
      p_errtxt := 'Помилка при з"єднанні з АТМ :'||get_req_status();
      return 0;
    end if;
  end;


  function ResetOperationNormal (p_errtxt out varchar2)
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_ret      number := 1;
    v_req_st   number;
  begin
    v_req_id := SimpleOperation('ResetOperation','Reset',create_req_body(0));
    v_req_st := get_req_status(v_req_id);
    case v_req_st
      when 5 then
        if OccupyOperation != 1 then
          p_errtxt := 'Не вдалося заблокувати АТМ';
          v_ret := 0;
        else
          v_req_id := SimpleOperation('ResetOperation','Reset',create_req_body(0));
          v_req_id := ReleaseOperation;
          v_req_id := CloseOperation;
        end if;
      when 21 then
        if not (OpenOperation = 1 and OccupyOperation = 1) then
          p_errtxt := 'Не вдалося заблокувати АТМ';
          v_ret := 0;
        else
          v_req_id := SimpleOperation('ResetOperation','Reset',create_req_body(0));
        end if;
      when 0 then
        p_errtxt := 'Операцію успішно виконано';
        v_ret := 1;
      else
        p_errtxt := get_req_message(v_req_id);
        v_ret := 0;
    end case;
    v_req_id := ReleaseOperation;
    v_req_id := CloseOperation;
    return v_ret;
  end ResetOperationNormal;

  function ResetOperationAdmin (p_errtxt out varchar2)
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_ret      number;
    v_req_st   number;
  begin
    v_req_id := SimpleOperation('ResetOperation','Reset',create_req_body(1));
    v_req_st := get_req_status(v_req_id);
    case v_req_st
      when 5 then
        if OccupyOperation != 1 then
          p_errtxt := 'Не вдалося заблокувати АТМ';
          v_ret := 0;
        else
          v_req_id := SimpleOperation('ResetOperation','Reset',create_req_body(0));
          p_errtxt := 'Операцію успішно виконано';
        end if;
      when 21 then
        if not (OpenOperation = 1 and OccupyOperation = 1) then
          p_errtxt := 'Не вдалося заблокувати АТМ';
          v_ret := 0;
        else
          v_req_id := SimpleOperation('ResetOperation','Reset',create_req_body(0));
          p_errtxt := 'Операцію успішно виконано';
        end if;
      when 0 then
        p_errtxt := 'Операцію успішно виконано';
        v_ret := 1;
      else
        p_errtxt := get_req_message(v_req_id);
        v_ret := 0;
    end case;
    v_req_id := ReleaseOperation;
    v_req_id := CloseOperation;
    return v_ret;
  end ResetOperationAdmin;

  function CountOperation (p_errtxt out varchar2)
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_req_st   number;
    v_ret      number := 1;
  begin
    v_req_id := SimpleOperation('StartCountOperation','StartCount',create_req_body(1));
    v_req_st := get_req_status(v_req_id);
    case v_req_st
      when 5 then
        if OccupyOperation != 1 then
          p_errtxt := 'Не вдалося заблокувати АТМ';
          v_ret := 0;
        else
          v_req_id := SimpleOperation('StartCountOperation','StartCount',create_req_body(1));
          p_errtxt := 'Покладіть гроші в АТМ. Після закінчення його роботи виконайте функцію "Результат підрахунку"';
        end if;
      when 21 then
        if not (OpenOperation = 1 and OccupyOperation = 1) then
          p_errtxt := 'Не вдалося заблокувати АТМ';
          v_ret := 0;
        else
          v_req_id := SimpleOperation('StartCountOperation','StartCount',create_req_body(1));
          p_errtxt := 'Покладіть гроші в АТМ. Після закінчення його роботи виконайте функцію "Результат підрахунку"';
        end if;
      when 99 then
        p_errtxt := 'Не вдалося отримати відповідь від АТМ. Повторіть спробу через деякий час.';
        v_ret := 0;
      when 0 then
        p_errtxt := 'Покладіть гроші в АТМ. Після закінчення його роботи виконайте функцію "Результат підрахунку"';
        v_ret := 1;
      else
        p_errtxt := get_req_message(v_req_id);
        v_ret := 0;
    end case;

    return v_ret;
  end CountOperation;

  function EndCountOperation (p_errtxt out varchar2)
    return number
    is
    v_req_body xmltype;
    v_req_id   number;
    v_ret      number;
    v_req_st   number;
    v_txt      varchar2(100);
--    v_amount   number;
  begin
    v_req_id := SimpleOperation('EndCountOperation','EndCount',null);

      select listagg(xt.cur||': '||xt.amount||' x '||cnt,'<br/>') within group (order by cur, amount)
        into p_errtxt
        from teller_requests t,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",'http://www.glory.co.jp/gsr.xsd' as "n"),
           'soapenv:Envelope/soapenv:Body/n:EndCountResponse/Cash/Denomination' passing t.xml_response
           columns
           cur varchar2(3) path '@n:cc',
           amount number   path '@n:fv',
           cnt    number   path 'n:Piece') xt
        where req_id = v_req_id;

      select listagg(cur||': '||amount,'<br/>') within group (order by cur)
      into v_txt
      from (
      select cur, sum(amount * cnt) amount
        from teller_requests t,
           xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",'http://www.glory.co.jp/gsr.xsd' as "n"),
           'soapenv:Envelope/soapenv:Body/n:EndCountResponse/Cash/Denomination' passing t.xml_response
           columns
           cur varchar2(3) path '@n:cc',
           amount number   path '@n:fv',
           cnt    number   path 'n:Piece') xt
        where req_id = v_req_id
        group by cur);

    p_errtxt := p_errtxt||'</br>----------------------</br>Разом: '||v_txt;
      update teller_requests ts
        set ts.oper_amount_txt = p_errtxt
        where req_id = v_req_id;

    p_errtxt := 'Результат операції підрахунка купюр :</br>'||p_errtxt;
    v_ret := ReleaseOperation;
    v_ret := CloseOperation;
    return 1;
  end EndCountOperation;

  function RebootATM (p_errtxt out varchar2)
    return number
    is
    v_req_id number;
    v_cnt      number;
  begin
    for r in (select *
                from teller_requests tr
                where tr.url = g_eq_url
                  and trim(tr.status) = '0'
                order by req_id desc
              )
    loop
      if r.req_type = 'PowerControlRequest' then
        p_errtxt := 'Остання отримана терміналом команда - перезавантаження';
        return 0;
      end if;
      exit;
    end loop;
    if get_user_sessionID is null then
      if OpenOperation = 0 then
        p_errtxt := 'Помилка при роботі з ATM';
      end if;
    end if;
    v_cnt := 0;
    loop
      v_cnt := v_cnt + 1;
      v_req_id := SimpleOperation('PowerControlOperation','PowerControl',create_req_body(2));
      if get_req_status(v_req_id) in (21,99,11) then
        if not (OpenOperation = 1 and OccupyOperation =1) then
          p_errtxt := 'Не вдається встановити з"єднання з АТМ. Виконайте, будь ласка, примусове перезавантаження';
          return 0;
        else
          v_req_id := SimpleOperation('PowerControlOperation','PowerControl',create_req_body(2));
        end if;
      end if;
      exit when get_req_status(v_req_id) = 0  or v_cnt>2;
    end loop;
    if get_req_status(v_req_id) = 0 then
      p_errtxt := 'АТМ отримав команду на перезавантаження. Операція перезавантаження буде виконуватись декілька хвилин. Зачекайте, будь-ласка!';
      update teller_atm_status tas
        set tas.status = 00,
            tas.status_desc = 'АТМ перезавантажується'
        where tas.equip_ip = g_eq_url
          and tas.work_date = g_bars_dt;
      return 1;
    else
      p_errtxt := 'Не вдалося надіслати команду на перезавантаження АТМ';
      return 0;
    end if;
  end RebootATM;

  function PowerOFFATM (p_errtxt out varchar2)
    return number
    is
    v_req_id number;
  begin
    if OpenOperation = 1  then
      v_req_id := SimpleOperation('PowerControlOperation','PowerControl',create_req_body(1));
      if get_req_status(v_req_id) = 21 then
        v_req_id := CloseOperation;
        v_req_id := OpenOperation;
        v_req_id := SimpleOperation('PowerControlOperation','PowerControl',create_req_body(1));
        if get_req_status(v_req_id) != 0 then
          p_errtxt := 'Не вдалось виконати запит. Помилка: '||get_req_message(v_req_id);
          return 0;
        end if;
      end if;
      p_errtxt := 'ATM виключено';
      return 1;
    end if;
    p_errtxt := 'ATM не виключено';
    return 0;
  end PowerOFFATM;

  function CollectOperation (p_errtxt out varchar2)
    return number
    is
    v_req_id number;
    v_ret number := 0;
    v_oper_id integer;
    v_curcode number;
  begin
    if get_user_sessionID() is null then
      if not (OpenOperation = 1 and OccupyOperation = 1) then
        p_errtxt := 'Не вдається встановити з"єднання з АТМ. Виконайте, будь ласка, примусове перезавантаження';
        v_ret := 0;
      end if;
    end if;
    loop
      v_req_id := SimpleOperation('CollectOperation','Collect',create_req_body(1));
      case get_req_status(v_req_id)
      when 0 then
/*        select listagg(cur_code||': '||amn,', ') within group (order by null)
          into p_errtxt
        from (*/
        for q in (select cur_code, sum(nominal * pieces) amn
                    from teller_requests r,
                         xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                'http://www.glory.co.jp/gsr.xsd' as "n"),
                                  'soapenv:Envelope/soapenv:Body/n:CollectResponse/Cash/Denomination' passing r.xml_response
                              columns
                              cur_code varchar2(3) path '@n:cc',
                              nominal  number      path '@n:fv',
                              pieces   number      path 'n:Piece') t
          where req_id = v_req_id
          group by cur_code)
        loop
          v_curcode := teller_utils.get_r030(q.cur_code);
          insert into teller_opers (oper_ref,
                                    cur_code,
                                    amount,
                                    is_sw_oper,
                                    state,
                                    req_ref
                                    )
            values ('TOX',
                    v_curcode,
                    q.amn,
                    0,
                    'OA',
                    v_req_id)
            returning id into v_oper_id;
          insert into teller_cash_opers (doc_ref,
                                         op_type,
                                         cur_code,
                                         atm_amount,
                                         non_atm_amount,
                                         last_dt,
                                         last_user)
            values (v_oper_id,
                    'OUT',
                    v_curcode,
                    q.amn,
                    0,
                    sysdate,
                    g_hostname);
          teller_utils.set_active_oper(v_oper_id);
          if p_errtxt is not null then
            p_errtxt := p_errtxt || '<br/>';
          else
            p_errtxt := 'З АТМ вилучено: ';
          end if;
          p_errtxt := p_errtxt||q.amn||' '||v_curcode;
        end loop;

bars_audit.info('Teller: p_errtxt = '||p_errtxt);
        p_errtxt := nvl(p_errtxt,'Не вилучено жодної банкноти');
        update teller_requests
          set OPER_AMOUNT_TXT = substr(p_errtxt,1,100)
          where req_id = v_req_id;
        v_req_id := InventoryClearOperation(2);
--        p_errtxt := 'АТМ вивантажено успішно';
        v_ret := 1;
        exit;
      when 5 then
        if not (OpenOperation = 1 and OccupyOperation = 1) then
          p_errtxt := 'Неможливо підключитись до АТМ';
          v_ret := 0;
          exit;
        end if;
      else
        p_errtxt := 'Помилка вивантаження АТМ: '||get_req_message(v_req_id);
        v_ret := 0;
        exit;
      end case;
    end loop;
    if ReleaseOperation = 1 then
      v_ret := 1;
    else
      v_ret := 0;
    end if;

    return v_ret;
  end CollectOperation;

  function ReleaseATM (p_errtxt out varchar2)
  return number
  is
  begin
    if ReleaseOperation = 1 then
       p_errtxt := 'Сесію користувача на АТМ успішно закрито';
       return 1;
    end if;
    return 0;
  end;

  function CollectATM (p_errtxt out varchar2)
  return number
  is
    v_ret number;
    v_collect_box varchar2(2000);
    v_xml_response xmltype;
    v_oper_id integer;
    v_tempo  varchar2(2000);
  begin
    if not (OpenOperation = 1 and OccupyOperation = 1) then
      p_errtxt := 'Неможливо заблокувати АТМ для виконання операції';
      return 0;
    end if;
    select amount into v_xml_response
      from teller_atm_status ts
      where ts.equip_ip = teller_utils.get_device_url
        and ts.work_date = g_bars_dt;

    for q in (select cur_code, sum(t1.nominal * nvl(t1.pieces,0)) amn
                from teller_atm_units u,
                     xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                  'http://www.glory.co.jp/gsr.xsd' as "n"),
                                   'soapenv:Envelope/soapenv:Body/n:InventoryResponse/CashUnits/CashUnit[@n:unitno=$i]/Denomination' passing v_xml_response, u.unitno as "i"
                                   columns
                                     cur_code varchar2(3) path '@n:cc',
                                     nominal  number      path '@n:fv',
                                     pieces   number      path 'n:Piece',
                                     rev      number      path '@n:rev') t1
                where u.equip_id = 10
                  and pieces != 0
                group by cur_code)
    loop
      if v_collect_box is not null then
        v_collect_box := v_collect_box||', ';
      end if;
      v_collect_box := v_collect_box||q.amn||' '||q.cur_code;
      insert into teller_opers (oper_ref,state, amount,cur_code)
        values ('TOX','OC',q.amn,teller_utils.get_r030(q.cur_code))
        returning id into v_oper_id;

      insert into teller_cash_opers (doc_ref,
                                     op_type,
                                     cur_code,
                                     atm_amount,
                                     non_atm_amount,
                                     last_dt,
                                     last_user,
                                     atm_status)
        values (v_oper_id,
                'OUT',
                teller_utils.get_r030(q.cur_code),
                q.amn,
                0,
                sysdate,
                g_hostname,
                2);


        teller_utils.set_active_oper(v_oper_id);

    end loop;

    v_ret := CollectOperation(p_errtxt => p_errtxt);
    v_ret := get_last_cash_request_id(v_ret);
    select oper_amount_txt
      into p_errtxt
      from teller_requests
      where req_id = v_ret;
--    p_errtxt  := get_cash_result(v_ret);
/*    if v_collect_box is not null then
      if substr(p_errtxt,1,3) = 'Не ' then
        p_errtxt := v_collect_box;
      else
        p_errtxt := p_errtxt||'.<br/>Зношені: '||v_collect_box;
      end if;
    end if;
    if v_tempo is not null then
      if substr(p_errtxt,1,3) = 'Не ' then
        p_errtxt := v_tempo;
      else
        p_errtxt := p_errtxt||'.<br/>З Темпокаси видано: '||v_tempo;
      end if;
    end if;

    if p_errtxt is null then
      p_errtxt := 'Не вилучено жодної банкноти';
    end if;
*/
    p_errtxt := teller_utils.create_cashout_message;
    update teller_requests tr
      set tr.oper_amount_txt = p_errtxt
      where tr.req_id = v_ret;
/*    if v_ret = 1 then
      v_ret := InventoryClearOperation(2);
    end if;
*/    return v_ret;
  end;

  function CollectATM (p_currency in varchar2
                      ,p_nominal in  clob
                      ,p_errtxt  out varchar2)
    return number
    is
    v_ret      number;
    v_req_body xmltype;
    v_req_id   number;
    v_amn      number;
    v_oper_id  number;
    v_collect_amn number;
    v_collect_box varchar2(1000);
    v_xml_response xmltype;
  begin

--bars_audit.info(p_nominal);
    v_ret := InventoryOperation(0);
    update teller_state
      set start_oper = null, active_oper = null
      where user_ref = user_id
        and work_date = g_bars_dt;

    select amount
      into v_xml_response
      from teller_atm_status
      where equip_ip = g_eq_url
        and work_date = g_bars_dt;

    for q in (select cur_code, sum(t1.nominal * nvl(t1.pieces,0)) amn
                from teller_atm_units u,
                     xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                  'http://www.glory.co.jp/gsr.xsd' as "n"),
                                   'soapenv:Envelope/soapenv:Body/n:InventoryResponse/CashUnits/CashUnit[@n:unitno=$i]/Denomination' passing v_xml_response, u.unitno as "i"
                                   columns
                                     cur_code varchar2(3) path '@n:cc',
                                     nominal  number      path '@n:fv',
                                     pieces   number      path 'n:Piece',
                                     rev      number      path '@n:rev') t1
                where u.equip_id = 10
                  and pieces != 0
                group by cur_code)
    loop
      if v_collect_box is not null then
        v_collect_box := v_collect_box||', ';
      end if;
      v_collect_box := v_collect_box||q.amn||' '||q.cur_code;
        insert into teller_opers (oper_ref,state, amount,cur_code)
          values ('TOX','OC',q.amn,teller_utils.get_r030(q.cur_code))
          returning id into v_oper_id;
        insert into teller_cash_opers (doc_ref,
                                       op_type,
                                       cur_code,
                                       atm_amount,
                                       non_atm_amount,
                                       last_dt,
                                       last_user,
                                       atm_status)
          values (v_oper_id,
                  'OUT',
                  teller_utils.get_r030(q.cur_code),
                  q.amn,
                  0,
                  sysdate,
                  g_hostname,
                  2);
        teller_utils.set_active_oper(v_oper_id);
      if p_currency = q.cur_code then
        v_collect_amn := q.amn;
      end if;
    end loop;

    with   atm as (
                   select t.cur_code, t.nominal,sum(t.pieces), t.rev
                     from /*teller_atm_status tas,*/
                          xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                 'http://www.glory.co.jp/gsr.xsd' as "n"),
                                  'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=4]/Denomination' passing v_xml_response
                                  columns
                                    cur_code varchar2(3) path '@n:cc',
                                    nominal  varchar2(5)      path '@n:fv',
                                    pieces   varchar2(4)      path 'n:Piece',
                                    rev      varchar2(1)      path '@n:rev') t
/*                   where tas.equip_ip = g_eq_url
                     and tas.work_date = gl.bd*/
                     group by cur_code, nominal,rev
                  )
    select-- xmlconcat(xmlelement("Body",xmlatrributes(g_glory_ns as "xmlns:gsr"),
            xmlconcat(
            xmlelement("Option",xmlattributes(3 as "gsr:type",g_glory_ns as "xmlns:gsr")),
            xmlelement("gsr:Cash",xmlattributes(2 as "gsr:type",g_glory_ns as "xmlns:gsr"),
                      xmlagg(xmlelement("Denomination",xmlattributes(t.cur as "gsr:cc", t.nom as "gsr:fv",1 as "gsr:devid",atm.rev as "gsr:rev"),
                                        xmlelement("gsr:Piece",t.cnt),
                                        xmlelement("gsr:Status",0)
                                       )
                            )

                      )
                  )
--                  )
    into v_req_body
    from atm,
         xmltable(xmlnamespaces('http://www.w3.org/2001/XMLSchema-instance' as "xsi",'http://www.w3.org/2001/XMLSchema' as "xsd"),
                  'ArrayOfATMCurrencyListModel/ATMCurrencyListModel' passing xmltype(p_nominal)
                  columns
                    cur varchar2(3) path 'Cur_code',
                    nom number      path 'Nominal',
                    cnt number      path 'Count') t
    where atm.cur_code = t.cur
      and atm.nominal = t.nom
      and t.cnt!=0;



    if not (OpenOperation = 1 and OccupyOperation = 1) then
      p_errtxt := 'Неможливо заблокувати АТМ для виконання операції';
      return 0;
    end if;

     v_req_id := SimpleOperation('CollectOperation','Collect',v_req_body);
     p_errtxt := get_cash_result(v_req_id, v_amn);
     if get_req_status(v_req_id) = 0 then
      insert into teller_opers (oper_ref,state, amount,cur_code)
        values ('TOX','OA',v_amn,teller_utils.get_r030(p_currency))
        returning id into v_oper_id;
      insert into teller_cash_opers (doc_ref,
                                     op_type,
                                     cur_code,
                                     atm_amount,
                                     non_atm_amount,
                                     last_dt,
                                     last_user)
        values (v_oper_id,
                'OUT',
                teller_utils.get_r030(p_currency),
                v_amn,
                0,
                sysdate,
                g_hostname);
      teller_utils.set_active_oper(v_oper_id);

       v_ret := InventoryClearOperation(2);
     end if;

bars_audit.info('Teller. p_errtxt = '||p_errtxt);
bars_audit.info('Teller. CurrOper = '||v_oper_id);

     p_errtxt := teller_utils.create_cashout_message;

bars_audit.info('Teller. p_errtxt = '||p_errtxt);
bars_audit.info('Teller. CurrOper = '||v_oper_id);

/*     if p_errtxt is null then
       if v_collect_box is not null then
         p_errtxt := 'Вилучено ЗНОШЕНІ: '||v_collect_box;
       else
         p_errtxt := 'Не вилучено жодної банкноти';
       end if;
     else
       p_errtxt := 'Вилучено: '||p_errtxt;
     end if;
     if v_collect_box is not null then
       p_errtxt := p_errtxt||'.<br/> Зношені: '||v_collect_box;
     end if;*/
/*     v_oper_id := teller_utils.get_active_oper();
     update teller_opers
       set amount = v_amn--+nvl(v_collect_amn,0)
       where id = v_oper_id;
     update teller_cash_opers tco
       set tco.atm_amount = v_amn--+nvl(v_collect_amn,0)
       where tco.doc_ref = v_oper_id;*/
     update teller_requests tr
       set tr.oper_amount_txt = p_errtxt
       where req_id = v_req_id;
    v_ret := InventoryOperation(0);
    v_ret := CloseOperation;
--        v_req_id := SimpleOperation(


    return v_ret;
  end;


  function CollectATM (p_curcode in varchar2
                      ,p_amount  in number
                      ,p_errtxt out varchar2)
  return number
  is
    v_rec t_arr_nom;
    v_req_body xmltype;
    v_req_id   number;
    v_ret number;
  begin

    insert into teller_opers (oper_ref,state, amount)
      values ('TOX','OUT',p_amount)
      returning id into v_ret;
    teller_utils.set_active_oper(v_ret);

    for r in (select sum(nominal * count) amn from v_teller_atm_status where cur_code = p_curcode)
    loop
      if p_amount > r.amn then
        p_errtxt := 'Вказана сума вивантаження ['||p_amount||'] більше наявної в ATM ['||r.amn||']!';
        return 0;
      end if;
      v_rec := create_denomination(p_curcode,p_amount);
    end loop;

    if v_rec is not null then
      select xmlconcat(
              xmlelement("Option",xmlattributes(3 as "gsr:type")),
              xmlelement("gsr:Cash",xmlattributes(2 as "gsr:type"),
                        xmlagg(xmlelement("Denomination",xmlattributes(p_curcode as "gsr:cc", t_amn.r_value as "gsr:fv",1 as "gsr:devid",t_amn.r_isChange as "gsr:rev"),
                                          xmlelement("gsr:Piece",t_amn.r_count),
                                          xmlelement("gsr:Status",0)
                                         )
                              )

                        )
                    )
        into v_req_body
        from table(cast(v_rec as t_arr_nom)) t_amn;

        if not (OpenOperation = 1 and OccupyOperation = 1) then
          p_errtxt := 'Неможливо заблокувати АТМ для виконання операції';
          return 0;
        end if;

         v_req_id := SimpleOperation('CollectOperation','Collect',v_req_body);
         if get_req_status(v_req_id) = 0 then
           v_ret := InventoryClearOperation(2);
         end if;
         p_errtxt := get_cash_result(v_req_id);
         update teller_requests tr
           set tr.oper_amount_txt = p_errtxt,
               tr.oper_ref = teller_utils.get_active_oper()
           where req_id = v_req_id;
         v_ret := 1;
--        v_req_id := SimpleOperation(
    else
      p_errtxt := 'Не вдалося сформувати запит на видачу банкнот';
      v_ret := 0;
    end if;

    return v_ret;
  end;


  function GetStatusChange
    return number
    is
    v_ret  number;
  begin
    v_ret := SimpleOperation('GetStatusChange','StatusChange',null);
    return v_ret;
  end;

  function InventoryCount (p_errtxt out varchar2)
    return number
    is
  begin
    return InventoryOperation(0);
  end;

begin

  g_local_url      := getglobaloption('LINK_FOR_ABSBARS_SOAPWEBSERVICES')||'Glory.asmx';

/*  if g_local_url like '--%' then
    g_local_url := 'http://10.10.17.42:8080/barsroot/webservices/Glory.asmx';
  end if;
*/
if g_hostname like '%10.10.10.75%' then
  g_local_url := 'http://10.10.10.75:5/barsroot/webservices/Glory.asmx';
elsif g_hostname like '%10.10.10.108%' then
  g_local_url := 'http://10.10.10.108:1240/barsroot/webservices/Glory.asmx';
elsif g_hostname like '%10.10.10.29%' then
  g_local_url := 'http://10.10.10.29:8090/barsroot/webservices/Glory.asmx';
end if;
bars_audit.info(g_hostname||' - '||g_local_url);

end teller_soap_api;
/
 show err;
 
PROMPT *** Create  grants  TELLER_SOAP_API ***
grant EXECUTE                                                                on TELLER_SOAP_API to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/teller_soap_api.sql =========*** End
 PROMPT ===================================================================================== 
 