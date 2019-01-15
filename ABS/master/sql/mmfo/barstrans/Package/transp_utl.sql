create or replace package transp_utl is

  -- Author  : OLEKSANDR.IVANENKO
  -- Created : 09.02.2018 17:01:51
  -- Purpose : utils_for_bars_transp

  -- Public type declarations
  --type <TypeName> is <Datatype>;

  -- Public constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  --<VariableName> <Datatype>;

  -- Public function and procedure declarations
  --function <FunctionName>(<Parameter> <Datatype>) return <Datatype>;
  --
  g_header_version            constant varchar2(64) := 'version 1.0 14/02/2018';

  g_http_version              constant varchar2(20) := 'HTTP/1.1';
  g_http_post                 constant varchar2(20) := 'POST';
  g_http_get                  constant varchar2(20) := 'GET';
  -- Content type
  g_ct_json                   constant varchar2(20) := 'application/json';
  g_ct_xml                    constant varchar2(20) := 'text/xml';
  g_ct_html                   constant varchar2(20) := 'text/html';
  -- Content charset
  g_cc_utf8                   constant varchar2(20) := 'charset=utf-8';
  g_cc_win1251                constant varchar2(20) := 'charset=windows-1251';

  g_transfer_timeout          constant number:= 1800;

  --out_status
  g_out_new_req               constant number:= -1; --Новий запит
  g_out_req_add_2_queen       constant number:=  0; --Запит поставлено до черги на обробку
  g_out_req_start_proc        constant number:=  1; --Розпочато обробку запиту
  g_out_req_send_res_id       constant number:=  2; --Запит відправлено(отримано ІД)
  g_out_req_send_err          constant number:=  3; --Помилка при відправці запиту
  g_out_chk_state_add_2_queen constant number:=  4; --Поставлено до черги на отримання статусу обробки
  g_out_chk_state_start_send  constant number:=  5; --Розпочато відправку запитудля отримання статусу обробки
  g_out_chk_state_in_proc     constant number:=  6; --Отримано статус запиту: "Запит в обробці".
  g_out_chk_state_proc        constant number:=  7; --Отримано статус запиту: "Запит оброблено".
  g_out_chk_state_err         constant number:=  8; --Отримано статус запиту: "Помилка обробки запиту".
  g_out_chk_send_err          constant number:=  9; --Помилка відправки запиту для отримання статусу.
  g_out_get_data_add_2_queen  constant number:= 10; --Запит на отримання даних поставлено до черги.
  g_out_get_data_in_proc      constant number:= 11; --Розпочато відправку запиту на отримання даних.
  g_out_get_data_resive       constant number:= 12; --Дані отримано.
  g_out_get_data_err          constant number:= 13; --Помилка отримання даних.
  g_out_new_req_err           constant number:= 14; --Виконання запиту закінчено з помилками.
  g_out_new_req_done          constant number:= 15; --Запит виконано успішно.
  g_out_all_req_err           constant number:= 16; --Всі запити закінчено з помилками.

  --in_status
  g_in_new_req                constant number:= -1; --Новий запит
  g_in_convert                constant number:=  0; --Запит конвертовано
  g_in_req_add_2_queen        constant number:=  1; --Запит поставлено до черги на обробку.
  g_in_req_start_proc         constant number:=  2; --Розпочато обробку запиту.
  g_in_req_proc_err           constant number:=  3; --Помилка обробки запиту.
  g_in_req_procesed           constant number:=  4; --Запит успішно обробку.
  g_in_resp_sended            constant number:=  5; --Відповідь відправлена.
  g_in_resp_send_err          constant number:=  6; --Пимилка при передачі відповіді.

 -------------------------------------------------------------
 type t_add_param is record(
    param_type varchar2(10), --get/header
    tag varchar2(30), --тег
    value varchar2(255));
    
 type t_add_params is table of t_add_param index by pls_integer;


 type number_list is table of number index by pls_integer;


 procedure send_loger(p_req_id        varchar2,
                      p_act           varchar2,
                      p_state         varchar2,
                      p_message       varchar2,
                      p_large_message clob default null,
                      p_sub_req       varchar2 default null,
                      p_chk_req       varchar2 default null,
                      p_loging        number default 1);



 procedure resive_loger(p_req_id        varchar2,
                        p_act           varchar2,
                        p_state         varchar2,
                        p_message       varchar2,
                        p_large_message clob default null,
                        p_loging        number default 1);
 --get_guid-----------------------------------------------------------------------------------
 function get_guid return varchar2;

 --process_input_queue------------------------------------------------------------------------
 procedure process_input_queue;

 --process_main_out_queue---------------------------------------------------------------------
 procedure process_main_out_queue;

 --process_chk_out_queue----------------------------------------------------------------------
 procedure process_chk_out_queue;

 --process_get_d_out_queue--------------------------------------------------------------------
 procedure process_get_d_out_queue;

 function get_in_req_user(p_req_id varchar2) return varchar2;
  
 procedure insert_req(p_type       in varchar2,
                      p_http_type  in varchar2,
                      p_act_type   in varchar2,
                      p_user       in varchar2,
                      p_get_params in clob,
                      p_req_id     out varchar2);

 procedure insert_req_body(p_type       in varchar2,
                           p_http_type  in varchar2,
                           p_act_type   in varchar2,
                           p_user       in varchar2,
                           p_get_params in clob,
                           p_body       in clob,
                           p_req_id     out varchar2);

 procedure insert_req_params(p_req_id varchar2,
                             p_type   varchar2,
                             p_params clob);

procedure get_req_status(p_req_id varchar2, p_user varchar2, p_state out varchar2);

procedure get_resp_data(p_req_id varchar2, p_user varchar2, p_resp out clob);

procedure process_req(p_req_id varchar2, p_is_local number default 0);

procedure job_stoper(p_msg IN sys.scheduler$_event_info);

/*procedure resive(p_type        in varchar2,
                 p_http_type   in varchar2,
                 p_act_type    in varchar2,
                 p_body        in clob,
                 p_req_params  in clob,
                 p_resp_params out clob,
                 p_resp_type   out varchar2,
                 p_resp_body   out clob);*/
/*
procedure resive_get(p_type        in varchar2,
                     p_http_type   in varchar2,
                     p_act_type    in varchar2,
                     p_req_params  in clob,
                     p_resp_params out clob,
                     p_resp_type   out varchar2,
                     p_resp_body   out clob);


procedure resive_clob(p_type    in varchar2,
                      p_body    in out clob,
                      p_params  in out clob,
                      p_req_id  out number,
                      p_err_txt out varchar2);

procedure resive_blob(p_type    in varchar2,
                      p_body    in out blob,
                      p_params  in out clob,
                      p_req_id  out number,
                      p_err_txt out varchar2);*/

  procedure send_req_by_id(p_main_req varchar2, p_is_parallel number default 0 );

  procedure send(p_body       clob,
                   p_add_params t_add_params,
                   p_send_type  varchar2,
                   p_send_kf    number_list,
                   p_main_sess  out varchar2);

  procedure send(p_body       clob,
                   p_add_params t_add_params,
                   p_send_type  varchar2,
                   p_send_kf    NUMBER default 0,
                   p_main_sess  out varchar2);
                    
 procedure send_main_req(p_req_id varchar2, p_req_act varchar2 default null);
 
 procedure send_chk_req(p_req_id varchar2, p_try_cnt number default 0);
 
 procedure send_get_resp_req(p_req_id varchar2, p_try_cnt number default 0);

 procedure send_p_req(p_req_id  varchar2,
                       st_id     number,
                       end_id    number);

 procedure add_resp(p_transtp_id varchar2 , p_resp_body clob);

 procedure add_resp(p_transtp_id varchar2 , p_resp_body blob);

 procedure upd_in_stat(p_req_id varchar2, p_status number);


 --procedure get_data_status(p_status number);

 -- procedure send_group(p_body clob, p_add_params t_add_params, p_send_type varchar2, p_send_list varchar2_list, p_main_sess out number);

  --procedure resive_status_ok(p_res_id number);

  procedure resive_status_err(p_res_id varchar2, p_errmesage varchar2);

  --procedure resive_status_start(p_res_id number);

  --procedure resive_status_exec(p_res_id number);

end transp_utl;
/
create or replace package body transp_utl is

  g_body_version  constant varchar2(64) := 'version 1.0 14/02/2018';

  g_xmlhead  constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

  g_user_id constant number:= sys_context('bars_global', 'user_id');
  g_user_mfo constant varchar2(10):= sys_context('bars_context','user_mfo');

  g_proxy_url   varchar2(256);
  g_wallet_path varchar2(256);
  g_wallet_pass varchar2(256);

  g_out_main_req_id varchar2(36);
  g_out_req_id varchar2(36);
  g_in_req_id varchar2(36);

  type t_out_uri is record(
  GR_ID      varchar2(50),
  KF         NUMBER(10),
  URI_DESC   VARCHAR2(255),
  BASE_HOST  VARCHAR2(255),
  USER_NAME  varchar2(60),
  AUTH_TYPE  VARCHAR2(255),
  AUTH_STR   VARCHAR2(255),
  IS_ACTIVE  NUMBER(1),
  IS_LOCAL   NUMBER(1),
  USER_ID    number
  );

  type t_out_reqs is table of out_reqs%rowtype index by pls_integer;
 --send_loger---------------------------------------------------------------------------------
 procedure send_loger(p_req_id        varchar2,
                      p_act           varchar2,
                      p_state         varchar2,
                      p_message       varchar2,
                      p_large_message clob default null,
                      p_sub_req       varchar2 default null,
                      p_chk_req       varchar2 default null,
                      p_loging        number default 1) is
     pragma autonomous_transaction;
     l_id number;
 begin
     if p_loging = 1 then
         l_id := s_OUTPUT_LOG.nextval;
         insert into OUTPUT_LOG
         values
             (l_id,
              p_req_id,
              p_sub_req,
              p_chk_req,
              p_act,
              p_state,
              p_message,
              p_large_message,
              localtimestamp);
         commit;
     end if;
 end;
 --resive_loger-------------------------------------------------------------------------------
 procedure resive_loger(p_req_id        varchar2,
                        p_act           varchar2,
                        p_state         varchar2,
                        p_message       varchar2,
                        p_large_message clob default null,
                        p_loging        number default 1) is
     pragma autonomous_transaction;
     l_id number;
 begin
     if p_loging = 1 then
         l_id := s_input_log.nextval;
         insert into input_log
         values
             (l_id,
              p_req_id,
              p_act,
              p_state,
              p_message,
              p_large_message,
              localtimestamp);
         commit;
     end if;
 end;
--get_out_type--------------------------------------------------------------------------------
function get_out_type(p_type_name varchar2) return out_types%rowtype is
    l_retval out_types%rowtype;
begin
    select t.id,
           t.type_name,
           t.type_desc,
           t.sess_type,
           t.web_method,
           t.http_method,
           t.output_data_type,
           t.input_data_type,
           t.cont_type,
           t.is_parallel,
           t.send_type,
           t.uri_group,
           t.uri_suf,
           t.priority,
           t.done_acction,
           t.main_timeout,
           t.send_trys,
           t.send_pause,
           t.chk_pause,
           t.xml2json,
           t.json2xml,
           t.compress_type,
           t.input_decompress,
           t.output_compress,
           t.input_base_64,
           t.output_base_64,
           t.check_sum,
           t.store_head,
           t.acc_cont_type,
           t.loging
      into l_retval
      FROM BARSTRANS.OUT_TYPES t
     where t.type_name = p_type_name;
    return l_retval;
exception
    when no_data_found then
        send_loger(g_out_main_req_id,
                   'SELECT_TRANSP_TYPE',
                   'ERROR',
                   'Невідомий тип запиту з ІД "' || p_type_name || '"');
        raise_application_error(-20000,
                                'Невідомий тип запиту з ІД "' ||
                                p_type_name || '"');

end;
--get_out_uri--------------------------------------------------------------------------------
function get_out_uri(p_uri_gr varchar2, p_uri_kf varchar2) return t_out_uri is
    l_retval t_out_uri;
begin
    select u.gr_name,
           u.kf,
           a.adr_desc,
           a.base_host,
           us.username,
           us.auth_type,
           us.auth_str,
           a.is_active,
           a.is_local,
           us.user_id
      into l_retval
      from out_uri u
      join out_dest_users us
        on u.username = us.username
      join out_dest_adr a
        on u.adr_name = a.adr_name
     where u.gr_name = p_uri_gr
       and u.kf = p_uri_kf;
    return l_retval;
exception
    when no_data_found then
        send_loger(g_out_main_req_id,
                   'SELECT_TRANSP_TYPE',
                   'ERROR',
                   'Невідомий адресат групи ' || p_uri_gr || ' з KF "' ||
                   p_uri_kf || '"');
        raise_application_error(-20000,
                                'Невідомий URI для KF "' || p_uri_kf || '"');
end;

 function get_out_main_req(p_req_id     varchar2,
                           p_sub_req_id varchar2 default null)
     return out_main_req%rowtype is
     l_retval out_main_req%rowtype;
 begin
     select r.id,
            r.send_type,
            r.c_data,
            r.b_data,
            r.ins_date,
            r.req_date,
            r.status,
            r.done_date,
            r.user_id,
            r.user_kf
       into l_retval
       from out_main_req r
      where r.id = p_req_id;
     return l_retval;
 end;

 function get_out_req(p_req_id varchar2) return out_reqs%rowtype is
     l_retval out_reqs%rowtype;
 begin
     select r.id,
            r.main_id,
            r.req_id,
            r.uri_gr_id,
            r.uri_kf,
            r.type_id,
            r.insert_time,
            r.send_time,
            r.resp_clob,
            r.c_date,
            r.b_date,
            r.status,
            r.processed_time
       into l_retval
       from out_reqs r
      where r.id = p_req_id;
     return l_retval;
 end;

 function get_out_reqs(p_main_req_id varchar2) return t_out_reqs is
     l_retval t_out_reqs;
 begin
     select r.id,
            r.main_id,
            r.req_id,
            r.uri_gr_id,
            r.uri_kf,
            r.type_id,
            r.insert_time,
            r.send_time,
            r.resp_clob,
            r.c_date,
            r.b_date,
            r.status,
            r.processed_time
       bulk collect into l_retval
       from out_reqs r
      where r.main_id = p_main_req_id;
     return l_retval;
 end;
--get_input_type--------------------------------------------------------------------------------
 function get_input_type(p_type_name varchar2,
                         p_req_id    varchar2 default null)
     return input_types%rowtype is
     l_retval input_types%rowtype;
 begin
     select t.id,
            t.type_name,
            t.type_desc,
            t.sess_type,
            t.act_type,
            t.output_data_type,
            t.input_data_type,
            t.priority,
            t.cont_type,
            t.json2xml,
            t.xml2json,
            t.compress_type,
            t.input_decompress,
            t.output_compress,
            t.input_base_64,
            t.output_base_64,
            t.store_head,
            t.add_head,
            t.check_sum,
            t.loging,
            t.exec_timeout
       into l_retval
       from INPUT_TYPES t
      where t.TYPE_NAME = p_type_name;
     return l_retval;
 exception
     when no_data_found then
         raise_application_error(-20000,
                                 'Невідомий тип запиту "' || p_type_name ||
                                 '" для запиту ІД: "' || p_req_id || '"');
 end;
--get_input_type---------------------------------------------------------------------------
 function get_input_req(p_req_id varchar2) return input_reqs%rowtype is
     l_input_reqs input_reqs%rowtype;
 begin
 select t.id,
       t.http_type,
       t.type_name,
       t.req_action,
       t.req_user,
       t.req_date,
       t.insert_time,
       t.d_clob,
       t.d_blob,
       t.convert_time,
       t.status,
       t.processed_time
       into l_input_reqs
  from barstrans.input_reqs t
  where t.id = p_req_id;
  return l_input_reqs;
 end;
----------------------------------------------------------------------------------------------
 procedure upd_out_state(p_req_id varchar2, p_state number) is
     l_main_id varchar2(36);
     l_main_state number;
     begin
         select r.main_id into l_main_id from out_reqs r where r.id = p_req_id;

          update out_reqs r
            set r.status = p_state
          where r.id = p_req_id;

          update out_queue r
            set r.status = p_state
          where r.req_id= p_req_id;

         select case when reqs = done then g_out_new_req_done
                     when reqs = err then g_out_all_req_err
                     when reqs = err+done then g_out_new_req_err
                else g_out_req_start_proc end as state
                    into l_main_state
                from (
         select count(*) as reqs,
         count(case when r.status = 14 then 1 else null end) as err,
         count(case when r.status = 15 then 1 else 0 end) as done
         from out_reqs r where r.main_id = l_main_id);

         update out_main_req r
            set r.status = l_main_state
          where r.id = l_main_id
          and R.STATUS <> l_main_state;
          
          update out_main_req r
            set r.done_date = localtimestamp
          where r.id = l_main_id;
 end;
  --upd_out_m_stat-----------------------------------------------------------------------------
 procedure upd_out_m_stat(p_req_id varchar2, p_state number) is
 begin
     update out_main_req rq
        set rq.status = p_state
      where rq.id = p_req_id;

     update out_reqs rq
        set rq.status = p_state
      where rq.main_id = p_req_id;
     
     for i in (select id from out_reqs rq where rq.main_id = p_req_id) loop
     update out_queue r
            set r.status = p_state
          where r.req_id = i.id;
     end loop;     

 end;
 --upd_in_stat--------------------------------------------------------------------------------
  procedure upd_in_stat(p_req_id varchar2, p_status number) is
     l_count number;
 begin
     select count(rq.id) into l_count from input_reqs rq where rq.id = p_req_id;
     if l_count > 0 then
     update input_reqs rq
        set rq.status = p_status
      where rq.id = p_req_id;
      end if;
     select count(rq.req_id) into l_count 
       from input_queue rq 
      where rq.req_id = p_req_id;
     if l_count > 0 and p_status in (g_in_req_proc_err, g_in_req_procesed) then 
       delete input_queue q where q.req_id = p_req_id;
     end if;
 end;
 
  --upd_input_queue-------------------------------------------------------------------------
 procedure upd_input_queue(p_id     varchar2,
                              p_state  number,
                              p_ch_try number default null) is
     l_try number;
 begin
     if p_ch_try is null then
         update input_queue q set q.status = p_state where q.req_id = p_id;
     else
         select nvl(q.exec_try, 0)
           into l_try
           from input_queue q
          where q.req_id = p_id;

         update input_queue q
            set q.status   = p_state,
                q.last_try = localtimestamp,
                q.exec_try = l_try + 1
          where q.req_id = p_id;
     end if;
 end;
 --upd_out_queue-------------------------------------------------------------------------
 procedure upd_out_queue(p_id     varchar2,
                            p_state  number,
                            p_ch_try number default null) is
     l_try number;
 begin
     if p_ch_try is null then
         update out_queue q set q.status = p_state where q.req_id = p_id;
     else
         select nvl(q.exec_try, 0)
           into l_try
           from out_queue q
          where q.req_id = p_id;

         update out_queue q
            set q.status   = p_state,
                q.last_try = localtimestamp,
                q.exec_try = l_try + 1
          where q.req_id = p_id;
     end if;
 end;

 function get_mime_type(p_id number) return varchar2 is
     l_retval varchar2(255);
     begin
         select m.mime_types into l_retval from dict_mime_types m where m.id = p_id;
         return l_retval;
     end;

 /*procedure upd_out_queue(p_req_id varchar2, p_state number, p_try number, */

 /*function out_timeout(p_out_quequ out_queue%rowtype) return boolean is
     begin
         (cast(p_out_quequ.last_try as date) -
                                           cast(l_req_ids(j).insert_time as date)) * 24 * 60 * 60 >
                     l_main_timeout
 end;*/

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
 --xml_extract--------------------------------------------------------------------------------
 function xml_extract(pl_xml xmltype, pl_xpath varchar2) return varchar2 is
  retval varchar2(32000);
  begin
    if pl_xml.existSNode(pl_xpath) > 0 then
    retval:= utl_i18n.unescape_reference(pl_xml.extract(pl_xpath).GetStringVal());
    else
      retval:=null;
    end if;
    return retval;
  end xml_extract;
 --map_status---------------------------------------------------------------------------------
 function map_status(p_status clob, p_main_req varchar2, l_sub_req_id varchar2) return number is
 l_status number;
 l_req_id varchar2(36);
 l_temp varchar2(32000);
 l_rem_req_id varchar2(36);
 l_xml xmltype;
 begin
   l_xml:= xmltype(p_status);
     l_temp:=xml_extract(l_xml, 'root/status/text()');
     l_status:=to_number(l_temp);
     l_req_id:=xml_extract(l_xml, 'root/req_id/text()');

     select rq.req_id into l_rem_req_id
     from out_reqs rq
     where rq.id = l_sub_req_id;

     if UPPER(l_req_id) = UPPER(l_rem_req_id) then
     l_status := case
                     when l_status in (g_in_new_req,
                                       g_in_convert,
                                       g_in_req_add_2_queen,
                                       g_in_req_start_proc)
                                                                        then g_out_chk_state_in_proc
                     when l_status in (g_in_req_procesed,
                                       g_in_resp_sended)
                                                                        then g_out_chk_state_proc
                     when l_status in (g_in_req_proc_err,
                                       g_in_resp_send_err)
                                                                        then g_out_chk_state_err
                                                                        else g_out_chk_send_err
                 end;
     else
        send_loger(p_main_req, 'MAP_STATUS', 'ERROR', 'REQ_ID <> L_REQ_ID', null, l_sub_req_id);

        l_status:= g_out_chk_send_err;
     end if;

     return l_status;
     exception when others then
         send_loger(p_main_req,
                    'MAP_STATUS',
                    'ERROR',
                     substr(sqlerrm || dbms_utility.format_error_backtrace(), 1, 4000),
                     null,
                     l_sub_req_id);
        return g_out_chk_send_err;
 end;
 --exec_action--------------------------------------------------------------------------------
 procedure  exec_action(p_req_id varchar2) is
     l_act_type varchar2(255);
 begin
    savepoint bef_exec;
     begin
    select t.act_type into l_act_type
    from input_types t
    join input_reqs rq on rq.type_name = t.type_name
    where rq.id = p_req_id;
    exception when no_data_found then
        l_act_type:= null;
    end;

     if l_act_type is not null then
         execute immediate 'begin ' || l_act_type || ' end;'
             using p_req_id;
     end if;
 exception
     when others then
         resive_loger(p_req_id  => p_req_id,
                      p_act     => 'EXEC ' || l_act_type,
                      p_state   => 'ERROR',
                      p_message => substr(sqlerrm ||
                                          dbms_utility.format_error_backtrace(),
                                          1,
                                          4000));
         rollback to bef_exec;
         update input_reqs rq
         set rq.status = g_in_req_proc_err
         where rq.id = p_req_id;
         
         delete input_queue q where q.req_id = p_req_id;
         commit;
         raise_application_error(-20000, dbms_utility.format_error_backtrace());
 end;
 --exec_out_action--------------------------------------------------------------------------------
 procedure exec_out_action(p_main_req_id varchar2) is
     l_act_type varchar2(255);
 begin
     begin
    select t.done_acction into l_act_type
    from out_types t
    join out_main_req rq on rq.send_type = t.type_name
    where rq.id = p_main_req_id;
    exception when no_data_found then
        l_act_type:= null;
    end;

     if l_act_type is not null then
         execute immediate 'begin ' || l_act_type || ' end;'
             using p_main_req_id;
     end if;
 exception
     when others then
         send_loger(p_req_id  => p_main_req_id,
                      p_act     => 'EXEC ' || l_act_type,
                      p_state   => 'ERROR',
                      p_message => substr(sqlerrm ||
                                          dbms_utility.format_error_backtrace(),
                                          1,
                                          4000));

 end;
 --process_input_queue------------------------------------------------------------------------
 procedure process_input_queue is
     l_max_items    number := 10;
     l_trys         number;
     l_send_pause   number;
     l_main_timeout number;
     type l_req_ids_t is table of input_queue%rowtype;
     l_req_ids l_req_ids_t := l_req_ids_t();
 begin
     begin
         select q.req_id,
                q.is_main,
                q.priority,
                q.status,
                q.insert_time,
                q.exec_try,
                q.last_try
           bulk collect
           into l_req_ids
           from barstrans.input_queue q
          where q.status  = g_in_req_add_2_queen
          order by q.priority, q.insert_time
            FOR UPDATE SKIP LOCKED;
     exception
         when no_data_found then
             RETURN;
     end;

         forall j in 1 .. l_req_ids.count
             update barstrans.input_queue q 
                set q.status = g_in_req_start_proc
              where q.req_id = l_req_ids(j).req_id;
         commit;

         for j in 1 .. l_req_ids.count loop
             exec_action(l_req_ids(j).req_id);
             commit;
         end loop;
exception when others then
    for j in 1 .. l_req_ids.count loop
       resive_loger(p_req_id  => l_req_ids(j).req_id,
                    p_act     => 'CHANGE_STATUS',
                    p_state   => 'ERROR',
                    p_message => substr(sqlerrm ||dbms_utility.format_error_backtrace(),1,4000));

             update barstrans.out_queue q
                set q.status = l_req_ids(j).status
              where q.req_id = l_req_ids(j).req_id and q.status = g_out_req_start_proc;
              commit;
         end loop;
 end;
 --process_main_out_queue---------------------------------------------------------------------
 procedure process_main_out_queue is
     l_max_items    number := 10;
     l_trys         number;
     l_send_pause   number;
     l_main_timeout number;
     l_main_id      varchar2(36);
     type l_req_ids_t is table of out_queue%rowtype;
     l_req_ids l_req_ids_t := l_req_ids_t();
 begin
     begin
         select q.req_id,
                q.is_main,
                q.priority,
                q.status,
                q.insert_time,
                q.exec_try,
                q.last_try
           bulk collect
           into l_req_ids
           from barstrans.out_queue q
          where q.status in (g_out_req_add_2_queen,
                             g_out_req_send_res_id,
                             g_out_req_send_err)
          order by q.priority, q.insert_time
            FOR UPDATE SKIP LOCKED;
     exception
         when no_data_found then
             RETURN;
     end;

     for j in 1 .. l_req_ids.count loop
         update barstrans.out_queue q
            set q.status = g_out_req_start_proc
          where q.req_id = l_req_ids(j).req_id;
     end loop;
     commit;

     for j in 1 .. l_req_ids.count loop
        select rq.main_id
               into l_main_id
               from out_reqs rq
              where rq.id = l_req_ids(j).req_id;

         case
             when l_req_ids(j).status = g_out_req_send_res_id then
                 update barstrans.out_queue q
                    set q.status   = g_out_chk_state_add_2_queen,
                        q.exec_try = 0,
                        q.is_main = 0
                  where q.req_id = l_req_ids(j).req_id;

             when l_req_ids(j).status = g_out_req_send_err then
                 select t.send_trys, t.main_timeout, t.send_pause
                   into l_trys, l_main_timeout, l_send_pause
                   from out_reqs q
                   join out_types t
                     on q.type_id = t.type_name
                  where q.id = l_req_ids(j).req_id;

                 if l_req_ids(j)
                  .exec_try > l_trys or (cast(l_req_ids(j).last_try as date) -
                                           cast(l_req_ids(j).insert_time as date)) * 24 * 60 * 60 >
                     l_main_timeout then
                     update out_reqs q
                        set q.status = g_out_req_send_err
                      where q.id = l_req_ids(j).req_id;

                     delete out_queue q where q.req_id = l_req_ids(j).req_id;
                     
                     exec_out_action(l_main_id);
                     
                 elsif (sysdate - cast(l_req_ids(j).last_try as date)) * 24 * 60 * 60 >=
                       l_send_pause then
                     begin
                     send_main_req(l_req_ids(j).req_id);
                     exception when others then 
                         null;
                     end;
                     update barstrans.out_queue q
                        set q.last_try = localtimestamp,
                            q.exec_try = nvl( l_req_ids(j).exec_try,0)+1
                     where q.req_id = l_req_ids(j).req_id;
                 end if;
             when l_req_ids(j).status = g_out_req_add_2_queen then
                 begin
                 send_main_req(l_req_ids(j).req_id);
                 exception when others then 
                 null;
                 end;
                 update barstrans.out_queue q
                        set q.last_try = localtimestamp,
                            q.exec_try = nvl( l_req_ids(j).exec_try,0)+1
                     where q.req_id = l_req_ids(j).req_id;
         end case;
         
             update barstrans.out_queue q
                set q.status = l_req_ids(j).status
              where q.req_id = l_req_ids(j).req_id
                and q.status = g_out_req_start_proc;
         commit;
     end loop;
 exception
     when others then
         for j in 1 .. l_req_ids.count loop

             select rq.main_id
               into l_main_id
               from out_reqs rq
              where rq.id = l_req_ids(j).req_id;

             send_loger(p_req_id        => l_main_id,
                        p_act           => 'PROC_SEND_QUEUE',
                        p_state         => 'ERROR',
                        p_message       => substr(sqlerrm ||
                                                  dbms_utility.format_error_backtrace(),
                                                  1,
                                                  4000),
                        p_large_message => null,
                        p_sub_req       => l_req_ids(j).req_id);

             update barstrans.out_queue q
                set q.status = l_req_ids(j).status
              where q.req_id = l_req_ids(j).req_id
                and q.status = g_out_req_start_proc;
             commit;
         end loop;
 end;
 --process_chk_out_queue----------------------------------------------------------------------
 procedure process_chk_out_queue is
     l_max_items    number := 100;
     l_trys         number;
     l_chk_pause    number;
     l_main_timeout number;
     l_main_id      varchar2(36);
     type l_req_ids_t is table of out_queue%rowtype;
     l_req_ids l_req_ids_t := l_req_ids_t();
 begin
     begin
         select q.req_id,
                q.is_main,
                q.priority,
                q.status,
                q.insert_time,
                q.exec_try,
                q.last_try
           bulk collect
           into l_req_ids
           from barstrans.out_queue q
          where q.status in (g_out_chk_state_add_2_queen,
                             g_out_chk_state_in_proc,
                             g_out_chk_state_proc,
                             g_out_chk_state_err,
                             g_out_chk_send_err)
          order by q.priority, q.insert_time
            FOR UPDATE SKIP LOCKED;
     exception
         when no_data_found then
             RETURN;
     end;

     for j in 1 .. l_req_ids.count loop
         update barstrans.out_queue q
            set q.status = g_out_chk_state_start_send, q.exec_try = 0
          where q.req_id = l_req_ids(j).req_id;
     end loop;
     commit;

     for j in 1 .. l_req_ids.count loop
        select rq.main_id
               into l_main_id
               from out_reqs rq
              where rq.id = l_req_ids(j).req_id;
     
         case
             when l_req_ids(j).status = g_out_chk_state_proc then
                 update barstrans.out_queue q
                    set q.status = g_out_get_data_add_2_queen
                  where q.req_id = l_req_ids(j).req_id;

             when l_req_ids(j).status in (g_out_chk_send_err,
                              g_out_chk_state_err,
                              g_out_chk_state_in_proc) then
                 select t.send_trys, t.main_timeout, t.chk_pause
                   into l_trys, l_main_timeout, l_chk_pause
                   from out_reqs q
                   join out_types t
                     on q.type_id = t.type_name
                  where q.id = l_req_ids(j).req_id;

                 if (cast(l_req_ids(j).last_try as date) -
                    cast(l_req_ids(j).insert_time as date)) * 24 * 60 * 60 >
                    l_main_timeout or l_req_ids(j)
                   .status = g_out_chk_state_err then

                     update out_reqs q
                        set q.status = g_out_chk_send_err
                      where q.id = l_req_ids(j).req_id;

                     delete out_queue q where q.req_id = l_req_ids(j).req_id;
                     
                     exec_out_action(l_main_id);
                     
                 elsif (sysdate - cast(l_req_ids(j).last_try as date)) * 24 * 60 * 60 >=
                       l_chk_pause then
                     send_chk_req(l_req_ids(j).req_id,
                              to_number(nvl(l_req_ids(j).exec_try, 0) + 1));

                     update barstrans.out_queue q
                        set q.last_try = localtimestamp,
                            q.exec_try = nvl( l_req_ids(j).exec_try,0)+1
                     where q.req_id = l_req_ids(j).req_id;
                 end if;
             when l_req_ids(j).status = g_out_chk_state_add_2_queen then
                 send_chk_req(l_req_ids(j).req_id,
                          to_number(nvl(l_req_ids(j).exec_try, 0) + 1));
                 update barstrans.out_queue q
                        set q.last_try = localtimestamp,
                            q.exec_try = nvl( l_req_ids(j).exec_try,0)+1
                     where q.req_id = l_req_ids(j).req_id;
         end case;

             update barstrans.out_queue q
                set q.status = l_req_ids(j).status
              where q.req_id = l_req_ids(j).req_id
                and q.status = g_out_chk_state_start_send;
         commit;
     end loop;
 exception
     when others then
         for j in 1 .. l_req_ids.count loop
             select rq.main_id
               into l_main_id
               from out_reqs rq
              where rq.id = l_req_ids(j).req_id;

             send_loger(p_req_id        => l_main_id,
                        p_act           => 'PROC_CHK_QUEUE',
                        p_state         => 'ERROR',
                        p_message       => substr(sqlerrm ||
                                                  dbms_utility.format_error_backtrace(),
                                                  1,
                                                  4000),
                        p_large_message => null,
                        p_sub_req       => l_req_ids(j).req_id);

             update barstrans.out_queue q
                set q.status = l_req_ids(j).status
              where q.req_id = l_req_ids(j).req_id
                and q.status = g_out_chk_state_start_send;
             commit;
         end loop;
 end;
 --process_get_d_out_queue--------------------------------------------------------------------
 procedure process_get_d_out_queue is
     l_max_items    number := 100;
     l_trys         number;
     l_send_pause   number;
     l_main_timeout number;
     l_main_id      varchar2(36);
     type l_req_ids_t is table of out_queue%rowtype;
     l_req_ids l_req_ids_t := l_req_ids_t();
 begin
     begin
         select q.req_id,
                q.is_main,
                q.priority,
                q.status,
                q.insert_time,
                q.exec_try,
                q.last_try
           bulk collect
           into l_req_ids
           from barstrans.out_queue q
          where q.status in (g_out_get_data_add_2_queen,
                             g_out_get_data_err,
                             g_out_get_data_resive)
          order by q.priority, q.insert_time
            FOR UPDATE SKIP LOCKED;
     exception
         when no_data_found then
             RETURN;
     end;

     for j in 1 .. l_req_ids.count loop
         update barstrans.out_queue q
            set q.status = g_out_get_data_in_proc
          where q.req_id = l_req_ids(j).req_id;
     end loop;
     commit;

     for j in 1 .. l_req_ids.count loop
             select rq.main_id
               into l_main_id
               from out_reqs rq
              where rq.id = l_req_ids(j).req_id;
         
         case
             when l_req_ids(j).status = g_out_get_data_resive then
                 delete barstrans.out_queue q
                  where q.req_id = l_req_ids(j).req_id;

                 update barstrans.out_reqs q
                    set q.status = g_out_get_data_resive
                  where q.id = l_req_ids(j).req_id;

             when l_req_ids(j).status = g_out_get_data_err then
                 select t.send_trys, t.main_timeout, t.send_pause
                   into l_trys, l_main_timeout, l_send_pause
                   from out_reqs q
                   join out_types t
                     on q.type_id = t.type_name
                  where q.id = l_req_ids(j).req_id;

                 if (cast(l_req_ids(j).last_try as date) -
                    cast(l_req_ids(j).insert_time as date)) * 24 * 60 * 60 >
                    l_main_timeout or l_req_ids(j)
                   .status = g_out_chk_state_err then

                     update out_reqs q
                        set q.status = g_out_chk_send_err
                      where q.id = l_req_ids(j).req_id;

                     delete out_reqs q where q.id = l_req_ids(j).req_id;
                     
                     exec_out_action(l_main_id);
                     
                 elsif (sysdate - cast(l_req_ids(j).last_try as date)) * 24 * 60 * 60 >=
                       l_send_pause then
                     send_get_resp_req(l_req_ids(j).req_id,
                              nvl(l_req_ids(j).exec_try, 0) + 1);
                 end if;
             when l_req_ids(j).status = g_out_get_data_add_2_queen then
                 send_get_resp_req(l_req_ids(j).req_id,
                          nvl(l_req_ids(j).exec_try, 0) + 1);

                 update barstrans.out_queue q
                        set q.last_try = localtimestamp,
                            q.exec_try = nvl( l_req_ids(j).exec_try,0)+1
                     where q.req_id = l_req_ids(j).req_id;
         end case;

             update barstrans.out_queue q
                set q.status = l_req_ids(j).status
              where q.req_id = l_req_ids(j).req_id
                and q.status = g_out_get_data_in_proc;
         commit;
     end loop;
 exception
     when others then
         for j in 1 .. l_req_ids.count loop
             select rq.main_id
               into l_main_id
               from out_reqs rq
              where rq.id = l_req_ids(j).req_id;

             send_loger(p_req_id        => l_main_id,
                        p_act           => 'PROC_CHK_QUEUE',
                        p_state         => 'ERROR',
                        p_message       => substr(sqlerrm ||
                                                  dbms_utility.format_error_backtrace(),
                                                  1,
                                                  4000),
                        p_large_message => null,
                        p_sub_req       => l_req_ids(j).req_id);
             update barstrans.out_queue q
                set q.status = l_req_ids(j).status
              where q.req_id = l_req_ids(j).req_id
                and q.status = g_out_get_data_in_proc;
             commit;
         end loop;
 end;
 --chk_main_out_status------------------------------------------------------------------------
 procedure chk_main_out_status(p_main_id varchar2) is
     l_data_resive number;
     data_err      number;
     data_in_proc  number;
 begin
     select sum(case
                    when rq.status = g_out_get_data_resive then
                     1
                    else
                     0
                end) as data_resive,
            sum(case
                    when rq.status = g_out_get_data_err then
                     1
                    else
                     0
                end) as data_err,
            sum(case
                    when rq.status in
                         (g_out_get_data_in_proc, g_out_get_data_add_2_queen) then
                     1
                    else
                     0
                end) as data_in_proc
       into l_data_resive, data_err, data_in_proc
       from out_reqs rq
      where rq.main_id = p_main_id
      group by rq.main_id;

     if data_in_proc = 0 and data_err = 0 then
         update out_main_req r
            set r.status = g_out_new_req_done, r.done_date = localtimestamp
          where r.id = p_main_id;
         exec_out_action(p_main_id);
     elsif data_in_proc = 0 and data_err > 0 then
         update out_main_req r
            set r.status = g_out_new_req_err, r.done_date = localtimestamp
          where r.id = p_main_id;
         exec_out_action(p_main_id);
     end if;
 end;
 --run_parallel-------------------------------------------------------------------------------
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

 --job_stoper---------------------------------------------------------------------------------
PROCEDURE job_stoper(p_msg IN sys.scheduler$_event_info) AS
    l_req_id varchar2(36);
BEGIN

    IF p_msg.event_type = 'JOB_OVER_MAX_DUR' AND
       p_msg.object_owner = 'BARSTRANS'  
     THEN
    
        begin
            select comments
              into l_req_id
              from all_scheduler_jobs t
             where t.job_name = p_msg.object_name;
        exception
            when no_data_found then
                l_req_id := null;
        end;
    
        dbms_scheduler.stop_job(job_name => p_msg.object_owner || '.' ||
                                            p_msg.object_name,
                                force    => FALSE);

        if substr(p_msg.object_name, 1, 3) = 'IN_' then
            
            transp_utl.upd_in_stat(l_req_id, g_in_req_proc_err);
            
            resive_loger(l_req_id,
                         'JOB_SECSSES_STOPED',
                         'INFO',
                         'l_jobname -> ' || p_msg.object_name);
        end if;
    
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        resive_loger(l_req_id,
                     'JOB_STOP_ERR',
                     'INFO',
                     substr('l_jobname -> ' || p_msg.object_name || ' -> ' ||
                            sqlerrm ||
                            dbms_utility.format_error_backtrace(),
                            1,
                            4000));
END;

 --create_resive_job1-------------------------------------------------------------------------
 procedure create_resive_job1(p_req_id varchar2, p_acction varchar2) is
     l_jobname varchar2(30);
     l_timeout number;
 begin
     select rawtohex(m.rowid), exec_timeout
       into l_jobname, l_timeout
       from input_reqs m
       join input_types t
         on m.type_name = t.type_name
      where m.id = p_req_id;
     l_jobname := 'IN_' || l_jobname;
     dbms_scheduler.create_job(job_name   => l_jobname,
                               job_type   => 'PLSQL_BLOCK',
                               comments   => p_req_id,
                               job_action => 'declare
                                 l_start_time timestamp := localtimestamp;
                                  begin 
                                  execute immediate ''begin ' ||
                                             p_acction || ' end;'' using ''' ||
                                             p_req_id || ''';
                                  barstrans.transp_utl.resive_loger(''' ||
                                             p_req_id ||
                                             ''', ''JOB_EXECUTE'', ''INFO'', ''TRANSP_UTL_PROC_SESS_' ||
                                             p_req_id ||
                                             ' DONE IN: ''||TO_CHAR(localtimestamp-l_start_time)||'' SEC. CRT_TO_EXEC_LAG:''||TO_CHAR(l_start_time-
                                  TO_TIMESTAMP(''' ||
                                             TO_CHAR(localtimestamp,
                                                     'YYYY-MM-DD HH24:MI:SS.FF6') ||
                                             ''',''YYYY-MM-DD HH24:MI:SS.FF6''))||'' SEC.'');
                                    exception when others then
                                        rollback;
                                        barstrans.transp_utl.upd_in_stat(''' ||
                                             p_req_id || ''', ' ||
                                             g_in_req_proc_err || ');
                                        commit;
                                        barstrans.transp_utl.resive_loger(''' ||
                                             p_req_id ||
                                             ''', ''JOB_EXECUTE'', ''ERROR'', ''TRANSP_UTL_PROC_SESS_' ||
                                             p_req_id ||
                                             ' ERROR: ''||substr(sqlerrm ||
                                              dbms_utility.format_error_backtrace(),
                                              1,
                                              4000)||''. CRT_TO_EXEC_LAG:''||TO_CHAR(l_start_time-
                                  TO_TIMESTAMP(''' ||
                                             TO_CHAR(localtimestamp,
                                                     'YYYY-MM-DD HH24:MI:SS.FF6') ||
                                             ''',''YYYY-MM-DD HH24:MI:SS.FF6''))||'' SEC.'');
                                        raise;
                                  end;',
                               auto_drop  => true,
                               enabled    => true);
 
     if l_timeout is not null then
         dbms_scheduler.set_attribute(name      => l_jobname,
                                      attribute => 'MAX_RUN_DURATION',
                                      value     => numtodsinterval(l_timeout,
                                                                   'SECOND'));
     end if;
 
     resive_loger(p_req_id,
                  'JOB_SECSSES_CREATED',
                  'INFO',
                  'l_jobname -> ' || l_jobname);
 exception
     when others then
         dbms_scheduler.drop_job(l_jobname, force => true);
         resive_loger(p_req_id,
                      'JOB_CREATION_EXCEPTION',
                      'ERROR',
                      substr(sqlerrm ||
                             dbms_utility.format_error_backtrace(),
                             1,
                             4000));
         raise;
 end create_resive_job1;
 --create_send_job1---------------------------------------------------------------------------
 procedure create_send_job1(p_req_id varchar2, p_paralell number) is
     l_jobname varchar2(30);
     l_timeout number;
 begin

     select rawtohex(m.rowid), t.main_timeout
       into l_jobname, l_timeout
       from out_main_req m
       join out_types t on m.send_type = t.type_name
      where m.id = p_req_id;
     l_jobname := 'OUT_' || l_jobname;
     dbms_scheduler.create_job(job_name   => l_jobname,
                               comments   => p_req_id,
                               job_type   => 'PLSQL_BLOCK',
                               job_action => 'begin
                                                bars.bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                                                           p_userid    => '||g_user_id||',
                                                                           p_hostname  => null,
                                                                           p_appname   => null);
                                                barstrans.transp_utl.send_req_by_id(''' || p_req_id || ''',' || p_paralell || ');
                                                bars.bars_login.logout_user;
                                              end;',
                               auto_drop  => true,
                               enabled    => true);
                               
     if l_timeout is not null then
     dbms_scheduler.set_attribute(name      => l_jobname,  
                               attribute => 'MAX_RUN_DURATION',  
                               value     => numtodsinterval(l_timeout, 'SECOND'));  
     end if;
 exception
     when others then
         dbms_scheduler.drop_job(l_jobname, force => true);
         send_loger(p_req_id  => p_req_id,
                    p_act     => 'Create Priority - 1 job',
                    p_state   => 'ERROR',
                    p_message => substr(sqlerrm ||
                                        dbms_utility.format_error_backtrace(),
                                        1,
                                        4000));

 end create_send_job1;
  --chk_proc-----------------------------------------------------------------------------------
 procedure chk_proc(p_id number, p_resp out number, p_err out varchar2) is
 begin
     null;
 end;
--pars_uri_params-----------------------------------------------------------------------------
 procedure pars_uri_params(p_req_id varchar2, p_type varchar2, p_uri_params clob) is

    l_parser            dbms_xmlparser.parser;
    l_doc               dbms_xmldom.domdocument;
    l_params            dbms_xmldom.DOMNodeList;
    l_param             dbms_xmldom.DOMNode;

    type t_reqsw        is table of input_req_params%rowtype;
    tr_reqsw            t_reqsw := t_reqsw();

    function l_get_node_val(p_node dbms_xmldom.DOMNode, p_node_name varchar2) return varchar2 is
      ll_temp varchar2(4000);
      begin
      dbms_xslprocessor.valueof(p_node, p_node_name||'/text()', ll_temp);
      ll_temp:=utl_i18n.unescape_reference(trim(ll_temp));
      ll_temp:=utl_i18n.unescape_reference(ll_temp);
      return ll_temp;
      end;
 begin
 l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, p_uri_params);
  l_doc := dbms_xmlparser.getdocument(l_parser);
  l_params := dbms_xmldom.getelementsbytagname(l_doc, 'param');

  for i in 0 .. dbms_xmldom.getlength(l_params)-1
  loop
     l_param := dbms_xmldom.item(l_params, i);
     tr_reqsw.extend;
     tr_reqsw(tr_reqsw.last).req_id:= p_req_id;
     tr_reqsw(tr_reqsw.last).param_type:= upper(p_type);
     tr_reqsw(tr_reqsw.last).tag:= upper(l_get_node_val(l_param, 'tag'));
     tr_reqsw(tr_reqsw.last).value:= l_get_node_val(l_param, 'value');
  end loop;

forall j in tr_reqsw.first .. tr_reqsw.last
      insert into input_req_params values tr_reqsw(j);
      tr_reqsw.delete;
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);
 end;
 
 function get_in_req_user(p_req_id varchar2) return varchar2 is
 l_retval varchar2(50);
 begin
 select t.req_user into l_retval from input_reqs t where T.ID = p_req_id;
 return l_retval;
 exception when no_data_found then
 return null;
 end;

 --insert_req---------------------------------------------------------------------------------
 procedure insert_req(p_type       in varchar2,
                      p_http_type  in varchar2,
                      p_act_type   in varchar2,
                      p_user       in varchar2,
                      p_get_params in clob,
                      p_req_id     out varchar2) is
     l_req_id    varchar2(36) := get_guid();
     l_type_name varchar2(50);
 begin
     begin
         select t.type_name
           into l_type_name
           from INPUT_TYPES t
          where t.TYPE_NAME = upper(p_type);
     exception
         when no_data_found then
             raise_application_error(-20000,
                                     'Невідомий тип запиту "' || p_type || '"');
     end;

     insert into input_reqs rq
     values
         (l_req_id,
          upper(p_http_type),
          l_type_name,
          upper(p_act_type),
          upper(p_user),
          null,
          localtimestamp,
          null,
          null,
          null,
          -1,
          null);

          pars_uri_params(l_req_id, 'GET', p_get_params);

     p_req_id := l_req_id;
 end;
 --insert_req_body----------------------------------------------------------------------------
 procedure insert_req_body(p_type       in varchar2,
                           p_http_type  in varchar2,
                           p_act_type   in varchar2,
                           p_user       in varchar2,
                           p_get_params in clob,
                           p_body       in clob,
                           p_req_id     out varchar2) is
     l_req_id    varchar2(36) := get_guid();
     l_input_type input_types%rowtype;
     l_clob clob;
     l_blob blob;
 begin
     l_input_type:= get_input_type(upper(p_type));
     
     transp_lob.req_to_data(p_body,
                 l_input_type.input_data_type,
                 l_input_type.JSON2XML,
                 l_input_type.COMPRESS_TYPE,
                 l_input_type.INPUT_DECOMPRESS,
                 l_input_type.INPUT_BASE_64,
                 l_clob,
                 l_blob);
                 
     insert into input_reqs rq
     values
         (l_req_id,
          upper(p_http_type),
          l_input_type.type_name,
          upper(p_act_type),
          upper(p_user),
          p_body,
          localtimestamp,
          l_clob,
          l_blob,
          null,
          -1,
          null);
          if p_get_params is not null then
          pars_uri_params(l_req_id, 'GET', p_get_params);
          end if;

     p_req_id := l_req_id;
 end;
 --insert_req_params--------------------------------------------------------------------------
 procedure insert_req_params(p_req_id varchar2,
                             p_type   varchar2,
                             p_params clob) is
     l_store_headers number(1);
 begin
     begin
         select t.store_head
           into l_store_headers
           from INPUT_TYPES t
          where t.TYPE_NAME = (select rq.type_name
                                 from input_reqs rq
                                where rq.id = p_req_id);
     exception
         when no_data_found then
             raise_application_error(-20000,
                                     'Невідомий тип запиту "' || p_req_id || '"');
     end;
     if (l_store_headers <> 0 and p_type = 'HEADER') or p_type = 'GET' then
         pars_uri_params(p_req_id, p_type, p_params);
     end if;
 end;
 --get_req_status-----------------------------------------------------------------------------
 procedure get_req_status(p_req_id varchar2,
                          p_user   varchar2,
                          p_state  out varchar2) is
     l_status varchar2(50);
 begin
     begin
         select rq.status
           into l_status
           from input_reqs rq
          where rq.id = p_req_id
            and rq.req_user = upper(p_user);
     exception
         when no_data_found then
             raise_application_error(-20000,
                                     'Невідомий запит: "' || p_req_id || '"');
     end;
     p_state := l_status;
 end;
 --get_resp_data------------------------------------------------------------------------------
 procedure get_resp_data(p_req_id varchar2,
                         p_user   varchar2,
                         p_resp   out clob) is
     l_status   varchar2(50);
     l_req_user varchar2(50);
     l_clob     clob;
 begin
     begin
         select rq.status, rq.req_user
           into l_status, l_req_user
           from input_reqs rq
          where rq.id = p_req_id
            and rq.req_user = upper(p_user);
     exception
         when no_data_found then
             raise_application_error(-20000,
                                     'Невідомий запит: "' || p_req_id || '"');
     end;

     begin
         select rs.resp_clob
           into l_clob
           from input_resp rs
          where rs.req_id = p_req_id;
     exception
         when no_data_found then
             null;
     end;

     update input_resp rs
        set rs.send_time = localtimestamp
      where rs.req_id = p_req_id;

     p_resp := l_clob;
 end;
 --save_headers-------------------------------------------------------------------------------
 procedure save_headers(p_req_id varchar2) is
 begin
     for i in 1 .. transp_web.g_headers.count loop
         if substr(transp_web.g_headers(i).p_header_name, 1, 10) = 'MyRespHead' then
             begin
                 insert into OUT_RESP_PARAMS
                 values
                     (p_req_id,
                      'HEADER',
                      substr(transp_web.g_headers(i).p_header_name, 11),
                      transp_web.g_headers(i).p_header_value);
             exception
                 when dup_val_on_index then
                     update OUT_RESP_PARAMS rp
                        set rp.value = rp.value || chr(10) || transp_web.g_headers(i).p_header_value
                      where rp.tag = substr(transp_web.g_headers(i).p_header_name, 11)
                        and rp.req_id = p_req_id
                        and rp.param_type = 'HEADER';
             end;
         end if;
     end loop;
 end;

 --process_req--------------------------------------------------------------------------------
 procedure process_req(p_req_id varchar2, p_is_local number default 0) is
     L_INPUT_TYPES INPUT_TYPES%rowtype;
     l_http_type   varchar2(50);
     l_type_name   varchar2(50);
     l_req_action  varchar2(50);
 begin
     begin
         select rq.http_type, rq.type_name, rq.req_action
           into l_http_type, l_type_name, l_req_action
           from input_reqs rq
          where rq.id = p_req_id;
     exception
         when no_data_found then
             raise_application_error(-20000,
                                     'Невідомий запит: "' || p_req_id || '"');
     end;

     l_input_types:=get_input_type(l_type_name);

     begin
         if L_INPUT_TYPES.SESS_TYPE = 'SYNCH' or p_is_local = 1 and
            l_input_types.act_type is not null then
             exec_action(p_req_id);
         elsif L_INPUT_TYPES.SESS_TYPE = 'ASYNCH' and
               L_INPUT_TYPES.PRIORITY = 1 and
               l_input_types.act_type is not null then
             create_resive_job1(p_req_id, l_input_types.act_type);
         elsif l_input_types.act_type is not null then
             insert into INPUT_QUEUE
                 (REQ_ID, IS_MAIN, PRIORITY, STATUS, INSERT_TIME)
             values
                 (p_req_id,
                  1,
                  L_INPUT_TYPES.PRIORITY,
                  g_in_req_add_2_queen,
                  localtimestamp);
         end if;
     exception
         when others then
             resive_loger(p_req_id  => p_req_id,
                          p_act     => 'CONVERT_DATA_TO_CLOB',
                          p_state   => 'ERROR',
                          p_message => substr(sqlerrm ||
                                              dbms_utility.format_error_backtrace(),
                                              1,
                                              4000));
             raise_application_error(-20000,
                                     'Помилка при обробці даних');
     end;
 end;
 --send_local---------------------------------------------------------------------------------
  procedure send_local(p_sub_req_id in out_reqs.id%type) is
      l_out_reqs       out_reqs%rowtype;
      l_input_types    input_types%rowtype;
      l_types          out_types%rowtype;
      l_req_data       out_main_req.req_date%type;
      l_resp_data      input_resp.resp_clob%type;
      l_c_data         input_resp.d_clob%type;
      l_b_data         input_resp.d_blob%type;
      l_out_uri        t_out_uri;
      l_out_req_params t_add_params;
      l_req_id         varchar2(36);
      l_inp_type       varchar2(50);
      l_inp_acl        varchar2(50);
  begin
      l_out_reqs := get_out_req(p_sub_req_id);
      l_types    := get_out_type(l_out_reqs.type_id);
      l_out_uri  := get_out_uri(l_types.uri_group, l_out_reqs.uri_kf);
  
      select q.req_date
        into l_req_data
        from out_main_req q
       where q.id = l_out_reqs.main_id;
  
      select rp.param_type, rp.tag, rp.value
        bulk collect
        into l_out_req_params
        from out_req_params rp
       where rp.req_id = l_out_reqs.main_id;
  
      l_inp_type := substr(l_types.uri_suf,
                           instr(l_types.uri_suf, '/', 12) + 1);
      l_inp_type := upper(substr(l_inp_type,
                                 1,
                                 instr(l_inp_type || '/', '/')));
  
      l_inp_acl := substr(l_types.uri_suf,
                          instr(l_types.uri_suf, '/', 12, 2) + 1);
      l_inp_acl := upper(substr(l_inp_acl, 1, instr(l_inp_acl || '/', '/')));
  
      l_input_types := get_input_type(l_inp_type);
  
      /*insert_req(p_type       => l_input_types.type_name,
      p_http_type  => l_types.http_method,
      p_act_type   => nvl(l_inp_acl,"LOCAL"),
      p_user       => l_out_uri.USER_NAME,
      p_get_params => null,
      p_req_id     => l_req_id);*/
  
      insert_req_body(p_type       => l_input_types.type_name,
                      p_http_type  => l_types.http_method,
                      p_act_type   => nvl(l_inp_acl, 'LOCA1L'),
                      p_user       => l_out_uri.USER_NAME,
                      p_get_params => null, --todo add_get params
                      p_body       => l_req_data,
                      p_req_id     => l_req_id);
  
      /* insert_req_params(p_req_id => ,
      p_type   => ,
      p_params => );*/
  
      process_req(l_req_id, 1);
  
      get_resp_data(p_req_id => l_req_id,
                    p_user   => l_out_uri.USER_NAME,
                    p_resp   => l_resp_data);
  
      transp_lob.req_to_data(p_req_body  => l_resp_data,
                             p_data_type => l_types.input_data_type,
                             p_json2xml  => l_types.json2xml,
                             p_pack_type => l_types.compress_type,
                             p_compress  => l_types.input_decompress,
                             p_base64    => l_types.input_base_64,
                             p_c_data    => l_c_data,
                             p_b_data    => l_b_data);
  
      update OUT_REQS s
         set s.resp_clob      = l_resp_data,
             s.status         = g_out_get_data_resive,
             s.processed_time = localtimestamp,
             s.send_time      = localtimestamp,
             s.c_date         = l_c_data,
             s.b_date         = l_b_data
       where s.id = p_sub_req_id;
  
      exec_out_action(p_sub_req_id);

      /*get_req_status(p_req_id => ,
      p_user   => ,
      p_state  => );*/
      exception
         when others then
             send_loger(p_req_id  => l_out_reqs.main_id,
                        p_act     => 'SEND_LOCAL',
                        p_state   => 'ERROR',
                        p_message => substr(sqlerrm ||
                                            dbms_utility.format_error_backtrace(),
                                            1,
                                            4000),
                        p_sub_req => p_sub_req_id);
             raise_application_error(-20000,
                                     'Помилка при обробці даних');
  end;
--send_req------------------------------------------------------------------------------------
procedure add_to_chk_que(p_resp_id  varchar2,
                         p_req_id   varchar2,
                         p_priority number) is
    l_send_req_id varchar2(36);
begin
    l_send_req_id := xml_extract(xmltype(p_resp_id), 'root/req_id/text()');

    update OUT_REQS s
       set s.req_id    = l_send_req_id,
           s.send_time = localtimestamp,
           s.status    = g_out_chk_state_add_2_queen
     where s.id = p_req_id;
    begin
        insert into out_queue
            (req_id, is_main, priority, status, insert_time)
        values
            (p_req_id,
             0,
             p_priority,
             g_out_chk_state_add_2_queen,
             localtimestamp);
    exception
        when dup_val_on_index then
            update out_queue q
               set q.status = g_out_chk_state_add_2_queen, q.is_main = 0
             where q.req_id = p_req_id;
    end;

    send_loger(null,
               'WEB_SERVICE_SAVE_ID_',
               'INFO',
               'GET_ID',
               null,
               p_req_id);

exception
    when others then
        update out_queue q
           set q.status = g_out_req_send_err
         where q.req_id = p_req_id;
        send_loger(null,
                   'WEB_SERVICE_SEND_ID_',
                   'ERROR',
                   'GET_ID',
                   sqlerrm || dbms_utility.format_error_backtrace(),
                   p_req_id);
    
end;
----------------------------------------------------------------------------------------------
procedure send_main_req(p_req_id varchar2, p_req_act varchar2 default null) is
    l_out_uri     t_out_uri;
    l_out_req     out_reqs%rowtype;
    l_out_type    out_types%rowtype;
    l_c_data      input_resp.d_clob%type;
    l_b_data      input_resp.d_blob%type;
    l_req_status  number;
    l_response    transp_web.t_response;
    l_send_req_id varchar2(36);
    l_clob        clob;
begin
    --Отримуємо параметри 
    l_out_req  := get_out_req(p_req_id);
    l_out_type := get_out_type(l_out_req.type_id);
    l_out_uri  := get_out_uri(l_out_req.uri_gr_id, l_out_req.uri_kf);
    --Отримуєми тіло запиту
    dbms_lob.createtemporary(l_clob, true);
    select q.req_date
      into l_clob
      from out_main_req q
     where q.id = l_out_req.main_id;

    --Підготовка запиту
    transp_web.prepare_request(p_url         => g_proxy_url,
                               p_http_method => g_http_post,
                               p_wallet_path => g_wallet_path,
                               p_wallet_pwd  => g_wallet_pass,
                               p_body        => l_clob);
    --Заповнюємо параметри для передачі адресату                         
    for param in (SELECT PARAM_TYPE, TAG, VALUE
                    FROM BARSTRANS.OUT_REQ_PARAMS qp
                   where qp.req_id = l_out_req.main_id) loop
        if param.param_type = 'GET' then
            transp_web.add_parameter(p_name  => param.tag,
                                     p_value => param.value);
        elsif param.param_type = 'HEADER' then
            transp_web.add_header(p_name  => 'MyReqHead' || param.tag,
                                  p_value => param.value);
        end if;
    end loop;
    --Заповнюємо параметри для проксі сервіса
    transp_web.add_header(p_name  => 'Content-Type', p_value => g_ct_xml || '; ' || g_cc_utf8);
    transp_web.add_header(p_name  => 'MyProxyMethod', p_value => l_out_type.http_method);
    transp_web.add_header(p_name  => 'MyProxyAccCT', p_value => get_mime_type(l_out_type.acc_cont_type));
    transp_web.add_header(p_name  => 'MyProxyURI', p_value => l_out_uri.BASE_HOST || l_out_type.uri_suf);
    transp_web.add_header(p_name  => 'MyReqHeadAuthorization', p_value => l_out_uri.AUTH_TYPE || ' ' || l_out_uri.AUTH_STR);
    transp_web.add_header(p_name  => 'MyProxyTimeout', p_value => round((l_out_type.main_timeout + l_out_type.send_pause) * l_out_type.send_trys * 1000));

    send_loger(l_out_req.main_id,
               'req',
               'INFO',
               'Data sended.',
               NULL,
               p_req_id);

    transp_web.execute_api(l_response);

    if l_response.status = 200 and l_out_type.sess_type = 'ASYNCH' then
        send_loger(l_out_req.main_id,
                   'WEB_SERVICE_SEND_',
                   'INFO',
                   'Data sended.',
                   null,
                   p_req_id);
    
        add_to_chk_que(to_char(l_response.cdoc),
                       p_req_id,
                       l_out_type.priority);
    elsif l_response.status = 200 and l_out_type.sess_type = 'SYNCH' then
    
        transp_lob.req_to_data(p_req_body  => l_response.cdoc,
                               p_data_type => l_out_type.input_data_type,
                               p_json2xml  => l_out_type.json2xml,
                               p_pack_type => l_out_type.compress_type,
                               p_compress  => l_out_type.input_decompress,
                               p_base64    => l_out_type.input_base_64,
                               p_c_data    => l_c_data,
                               p_b_data    => l_b_data);
    
        update OUT_REQS s
           set s.resp_clob      = l_response.cdoc,
               s.status         = g_out_get_data_resive,
               s.processed_time = localtimestamp,
               s.send_time      = localtimestamp,
               s.c_date         = l_c_data,
               s.b_date         = l_b_data
         where s.id = p_req_id;
    
        exec_out_action(l_out_req.main_id);
    
        if l_out_type.store_head = 1 then
            save_headers(p_req_id);
        end if;
    else
        send_loger(l_out_req.main_id,
                   'WEB_SERVICE_SEND' || p_req_id,
                   'ERROR',
                   'Send error:' || l_response.status || '. Try: ' ||
                   to_char(p_req_id),
                   replace(replace(l_response.cdoc, '\r', chr(13)),
                           '\n',
                           chr(10)),
                   p_req_id);
                   
         upd_out_state(p_req_id, g_out_req_send_err);
                  
         raise_application_error(-20000, replace(replace(l_response.cdoc, '\r', chr(13)),'\n',chr(10)));
    
    end if;

exception when others then  

             send_loger(l_out_req.main_id,
                        'WEB_SERVICE_SEND_' || p_req_id,
                        'ERROR',
                        sqlerrm(sqlcode),
                        sqlerrm ||dbms_utility.format_error_backtrace(),
                        p_req_id);
                   
    upd_out_state(p_req_id, g_out_req_send_err);
        
    raise_application_error(-20000, sqlerrm ||dbms_utility.format_error_backtrace());
end;
----------------------------------------------------------------------------------------------
procedure send_chk_req(p_req_id varchar2, p_try_cnt number default 0) is
    l_out_uri     t_out_uri;
    l_out_req     out_reqs%rowtype;
    l_out_type    out_types%rowtype;
    l_req_status  number;
    l_response    transp_web.t_response;
    l_send_req_id varchar2(36);
    l_clob        clob;
begin
    --Отримуємо параметри 
    l_out_req  := get_out_req(p_req_id);
    l_out_type := get_out_type(l_out_req.type_id);
    l_out_uri  := get_out_uri(l_out_req.uri_gr_id, l_out_req.uri_kf);
    --Підготовка запиту
    transp_web.prepare_request(p_url         => g_proxy_url,
                               p_http_method => g_http_post,
                               p_wallet_path => g_wallet_path,
                               p_wallet_pwd  => g_wallet_pass,
                               p_body        => l_clob);

     --Заповнюємо параметри для проксі сервіса
     transp_web.add_header(p_name => 'Content-Type',p_value => g_ct_xml || '; ' || g_cc_utf8);
     transp_web.add_header(p_name => 'MyProxyMethod', p_value => g_http_get);
     transp_web.add_header(p_name => 'MyProxyURI', p_value => l_out_uri.BASE_HOST||l_out_type.uri_suf||'\GETREQSTATUS');
     transp_web.add_header(p_name => 'MyReqHeadAuthorization', p_value => l_out_uri.AUTH_TYPE||' '||l_out_uri.AUTH_STR);
     
     transp_web.add_parameter(p_name  => 'REQID', p_value => l_out_req.req_id);

     send_loger(l_out_req.main_id, 'req', 'INFO', 'Data sended.', NULL, p_req_id);

     transp_web.execute_api(l_response);
     
     if l_response.status = 200 then
        send_loger(l_out_req.main_id,'WEB_SERVICE_SEND_', 'INFO', 'Data sended.' ,null, p_req_id);
        
                     begin
                     l_req_status := map_status(l_response.cdoc,
                                                l_out_req.main_id,
                                                p_req_id);
                     update OUT_REQS s
                        set s.processed_time = localtimestamp,
                            s.status         = l_req_status
                      where s.id = p_req_id;

                      update out_queue q
                         set q.status = case when l_req_status = g_out_chk_state_proc then g_out_get_data_add_2_queen else l_req_status end
                         where q.req_id = p_req_id;
                         exception when others then
                             update out_queue q
                              set q.status = g_out_chk_send_err
                              where q.req_id = p_req_id;
                              send_loger(l_out_req.main_id,
                                'WEB_SERVICE_SEND_CHK_ID_' || p_req_id,
                                'ERROR',
                                'GET_ID',
                                sqlerrm ||dbms_utility.format_error_backtrace(),
                                p_req_id);
                      end;


                     send_loger(l_out_req.main_id,
                                'WEB_SERVICE_SAVE_STATUS_' || p_req_id,
                                'INFO',
                                'GET_STATUS',
                                null,
                                p_req_id);
     else
                     update OUT_REQS s
                        set s.processed_time = localtimestamp,
                            s.status         = g_out_chk_send_err
                      where s.id = p_req_id;

                      update out_queue q
                         set q.status = g_out_chk_send_err
                         where q.req_id = p_req_id;

                       send_loger(l_out_req.main_id,
                       'WEB_SERVICE_SEND_CHK_ID_' || p_req_id,
                       'ERROR',
                       'GET_ID',
                        l_response.status||' '||sqlerrm ||dbms_utility.format_error_backtrace()||' '||l_response.cdoc,
                        p_req_id);

     end if;
exception when others then  

             send_loger(l_out_req.main_id,
                        'WEB_SERVICE_SEND_CHK_' || p_req_id,
                        'ERROR',
                        sqlerrm(sqlcode),
                        sqlerrm ||dbms_utility.format_error_backtrace(),
                        p_req_id);
                   
    upd_out_state(p_req_id, g_out_chk_send_err);       
      
end;
----------------------------------------------------------------------------------------------
procedure send_get_resp_req(p_req_id varchar2, p_try_cnt number default 0) is
    l_out_uri     t_out_uri;
    l_out_req     out_reqs%rowtype;
    l_out_type    out_types%rowtype;
    l_req_status  number;
    l_response    transp_web.t_response;
    l_c_data      input_resp.d_clob%type;
    l_b_data      input_resp.d_blob%type;
    l_send_req_id varchar2(36);
    l_clob        clob;
begin
    --Отримуємо параметри 
    l_out_req  := get_out_req(p_req_id);
    l_out_type := get_out_type(l_out_req.type_id);
    l_out_uri  := get_out_uri(l_out_req.uri_gr_id, l_out_req.uri_kf);
    --Підготовка запиту
    transp_web.prepare_request(p_url         => g_proxy_url,
                               p_http_method => g_http_post,
                               p_wallet_path => g_wallet_path,
                               p_wallet_pwd  => g_wallet_pass,
                               p_body        => null);

    --Заповнюємо параметри для проксі сервіса
    transp_web.add_header(p_name  => 'Content-Type', p_value => g_ct_xml || '; ' || g_cc_utf8);
    transp_web.add_header(p_name => 'MyProxyMethod', p_value => g_http_get);
    transp_web.add_header(p_name  => 'MyProxyURI', p_value => l_out_uri.BASE_HOST || l_out_type.uri_suf || '\GETRESP');
    transp_web.add_header(p_name  => 'MyReqHeadAuthorization', p_value => l_out_uri.AUTH_TYPE || ' ' || l_out_uri.AUTH_STR);
    
    transp_web.add_parameter(p_name  => 'REQID', p_value => l_out_req.req_id);

    send_loger(l_out_req.main_id,
               'req',
               'INFO',
               'Data sended.',
               NULL,
               p_req_id);

    transp_web.execute_api(l_response);

    if l_response.status = 200 then
        send_loger(l_out_req.main_id,
                   'WEB_SERVICE_SEND_',
                   'INFO',
                   'Data sended.',
                   null,
                   p_req_id);
    
        transp_lob.req_to_data(p_req_body  => l_response.cdoc,
                               p_data_type => l_out_type.input_data_type,
                               p_json2xml  => l_out_type.json2xml,
                               p_pack_type => l_out_type.compress_type,
                               p_compress  => l_out_type.input_decompress,
                               p_base64    => l_out_type.input_base_64,
                               p_c_data    => l_c_data,
                               p_b_data    => l_b_data);
    
        update OUT_REQS s
           set s.resp_clob = l_response.cdoc,
               s.status    = g_out_get_data_resive,
               s.c_date    = l_c_data,
               s.b_date    = l_b_data
         where s.id = p_req_id;
         
        exec_out_action(l_out_req.main_id);
        delete out_queue q where q.req_id = p_req_id;
    
        send_loger(l_out_req.main_id,
                   'WEB_SERVICE_SAVE_STATUS_' || p_req_id,
                   'INFO',
                   'GET_DATA',
                   null,
                   p_req_id);
    
        if l_out_type.store_head = 1 then
            save_headers(p_req_id);
        end if;
    else
        null;
    end if;
exception when others then  

             send_loger(l_out_req.main_id,
                        'WEB_SERVICE_SEND_GET_RESP_' || p_req_id,
                        'ERROR',
                        sqlerrm(sqlcode),
                        sqlerrm ||dbms_utility.format_error_backtrace(),
                        p_req_id);
                   
    upd_out_state(p_req_id, g_out_get_data_err);      
    
end;
----------------------------------------------------------------------------------------------
  procedure send_p_req(p_req_id  varchar2,
                       st_id     number,
                       end_id    number) is

  begin
  for i in (select id, is_local from ( select rownum as rn , t.id, a.is_local
                               from OUT_REQS t
                               join out_uri u on t.uri_gr_id = u.gr_name and t.uri_kf = u.kf
                               join out_dest_adr a on u.adr_name = a.adr_name
                              where t.main_id = p_req_id
                             order by t.id) where rn between st_id and end_id) loop
  begin
  if i.is_local = 1 then
    send_local(i.id);
  else
    send_main_req(i.id);
  end if;
  exception when others then
        send_loger(p_req_id,
                        '--------------------------------------------->>',
                        'ERROR',
                        sqlerrm(sqlcode),
                        sqlerrm ||dbms_utility.format_error_backtrace());  
  
      upd_out_state(i.id, g_out_get_data_err);
      exec_out_action(p_req_id);
  end;
  end loop;
  end;
----------------------------------------------------------------------------------------------
  procedure send_req_by_id(p_main_req varchar2, p_is_parallel number default 0 ) is
      l_parallel_ch number;
      l_chunk       varchar2(4000);
      l_stmt        varchar2(4000);
  begin

      if p_is_parallel > 0 then
          l_chunk := 'select rownum as start_id, rownum as end_id
        from OUT_REQS t where t.main_id  = '''|| p_main_req||'''
        order by t.id';

          l_stmt := 'begin
                    transp_utl.send_p_req('''||p_main_req||''', :start_id, :end_id);
                     end;';

          if p_is_parallel <> 1 then
              l_parallel_ch := p_is_parallel;
          else
              select count(q.id) + 1
                into l_parallel_ch
                from OUT_REQS q
               where q.main_id = p_main_req;
          end if;

          run_parallel('transp_utl_send_ru' || to_char(p_main_req),
                       l_chunk,
                       l_stmt,
                       l_parallel_ch);
      else
          for i in (select t.id, a.is_local
                      from OUT_REQS t
                      join out_uri u on t.uri_gr_id = u.gr_name and t.uri_kf = u.kf
                      join out_dest_adr a on u.adr_name = a.adr_name
                     where t.main_id = p_main_req) loop
                  if i.is_local = 1 then
                    send_local(i.id);
                  else
                    send_main_req(i.id);
                  end if;
          end loop;
      end if;

  end;
--proc_out_req--------------------------------------------------------------------------------
 procedure proc_out_req(p_types    out_types%rowtype,
                        p_req_id   varchar2) is
 begin
     case
         when p_types.sess_type = 'SYNCH' then

             send_req_by_id(p_req_id, p_types.is_parallel);

         when p_types.sess_type = 'ASYNCH' and p_types.priority = 1 then

             create_send_job1(p_req_id, p_types.is_parallel);

         when p_types.sess_type = 'ASYNCH' and p_types.priority > 1 then

             for i in (select rq.id
                         from out_reqs rq
                        where rq.main_id = p_req_id) loop
                 insert into out_queue
                     (req_id, is_main, priority, status, insert_time)
                 values
                     (i.id,
                      1,
                      p_types.priority,
                      g_out_req_add_2_queen,
                      localtimestamp);
                 upd_out_state(i.id, g_out_req_add_2_queen);
             end loop;

         else

             send_loger(null,
                        '',
                        'ERROR',
                        'Невідомий тип сесії.',
                        null,
                        p_req_id);

     end case;
 exception
     when others then
         send_loger(p_req_id  => p_req_id,
                    p_act     => '',
                    p_state   => 'ERROR',
                    p_message => substr(sqlerrm ||
                                        dbms_utility.format_error_backtrace(),
                                        1,
                                        4000));
         upd_out_m_stat(p_req_id, g_out_all_req_err);                                        
         exec_out_action(p_req_id);
 end;
 --send group KF-----------------------------------------------------------------------------
 procedure send(p_body       clob,
                p_add_params t_add_params,
                p_send_type  varchar2,
                p_send_kf    number_list,
                p_main_sess  out varchar2) is
     --asinc/parallel
     l_types    out_types%rowtype;
     l_out_uri  t_out_uri;
     l_req_body clob;
     l_sub_ses  varchar2(36);

 begin
     g_out_main_req_id := get_guid;
     p_main_sess       := g_out_main_req_id;
     --визначаємо тип запиту
     l_types := get_out_type(p_send_type);
     --конвертуємо вхідні дані для передачі
     transp_lob.data_to_req(p_body,
                 null,
                 l_types.output_data_type,
                 l_types.xml2json,
                 l_types.compress_type,
                 l_types.output_compress,
                 l_types.output_base_64,
                 l_req_body);
     --додаємо данні та та статус
     insert into out_main_req
         (id,
          send_type,
          c_data,
          req_date,
          ins_date,
          status,
          user_id,
          user_kf)
     values
         (g_out_main_req_id,
          p_send_type,
          p_body,
          l_req_body,
          localtimestamp,
          g_out_new_req,
          g_user_id,
          g_user_mfo);
     send_loger(null, 'INSERT_SEND_DATA', 'INFO', 'DATE INSERTED');
     --додаємо дані/переметри GET/HEADER
     for i in 1 .. p_add_params.count loop
         insert into out_req_params
         values
             (g_out_main_req_id,
              p_add_params     (i).param_type,
              p_add_params     (i).tag,
              p_add_params     (i).value);
     end loop;
     --формуємо перелік підзапитів
     for kf in 1 .. p_send_kf.count loop
      --перевіряємо чи існує адреса
     l_out_uri := get_out_uri(l_types.uri_group, p_send_kf(kf));
     g_out_req_id := get_guid;
     insert into out_reqs
         (id, main_id, uri_gr_id, uri_kf, type_id, insert_time, status)
     values
         (g_out_req_id,
          g_out_main_req_id,
          l_out_uri.gr_id,
          p_send_kf(kf),
          l_types.type_name,
          localtimestamp,
          g_out_new_req);
     end loop;
     send_loger(null, 'INSERT_SEND_PARAMS', 'INFO', 'PARAMS INSERTED');

     --старт процедури відправки
     proc_out_req(l_types, g_out_main_req_id);

 end;
 --send single KF-----------------------------------------------------------------------------
 procedure send(p_body       clob,
                p_add_params t_add_params,
                p_send_type  varchar2,
                p_send_kf    number default 0,
                p_main_sess  out varchar2) is
     --asinc/parallel
     l_types    out_types%rowtype;
     l_out_uri  t_out_uri;
     l_req_body clob;
     l_ses_id   varchar2(36);
     l_sub_ses  varchar2(36);

 begin
     l_ses_id:= get_guid;
     p_main_sess:= l_ses_id;
     g_out_main_req_id:= l_ses_id;
     --визначаємо тип запиту
     l_types := get_out_type(p_send_type);
     --перевіряємо чи існує адреса
     l_out_uri := get_out_uri(l_types.uri_group, p_send_kf);
     --конвертуємо вхідні дані для передачі
     transp_lob.data_to_req(p_body,
                 null,
                 l_types.output_data_type,
                 l_types.xml2json,
                 l_types.compress_type,
                 l_types.output_compress,
                 l_types.output_base_64,
                 l_req_body);
     --додаємо данні та та статус
     insert into out_main_req
         (id,
          send_type,
          c_data,
          req_date,
          ins_date,
          status,
          user_id,
          user_kf)
     values
         (l_ses_id,
          p_send_type,
          p_body,
          l_req_body,
          localtimestamp,
          g_out_new_req,
          g_user_id,
          g_user_mfo);
     send_loger(null, 'INSERT_SEND_DATA', 'INFO', 'DATE INSERTED');
     --додаємо дані/переметри GET/HEADER
     for i in 1 .. p_add_params.count loop
         insert into out_req_params
         values
             (l_ses_id,
              p_add_params     (i).param_type,
              p_add_params     (i).tag,
              p_add_params     (i).value);
     end loop;
     --формуємо перелік підзапитів

     l_sub_ses:= get_guid;
     g_out_req_id:=l_sub_ses;
     insert into out_reqs
         (id, main_id, uri_gr_id, uri_kf, type_id, insert_time, status)
     values
         (l_sub_ses,
          l_ses_id,
          l_out_uri.gr_id,
          p_send_kf,
          l_types.type_name,
          localtimestamp,
          g_out_new_req);
     send_loger(null, 'INSERT_SEND_PARAMS', 'INFO', 'PARAMS INSERTED');

     --старт процедури відправки
     proc_out_req(l_types, l_ses_id);


 end;
 ------------------------------------------------------------------------------------------------

procedure resive_status_ok(p_res_id varchar2) is

begin
    update input_reqs r
       set r.processed_time = localtimestamp,
           r.status         = 4
     where R.ID = p_res_id;

end;

procedure resive_status_err(p_res_id varchar2, p_errmesage varchar2) is
pragma autonomous_transaction;
begin
    update input_reqs r
       set r.processed_time = localtimestamp, r.status = 3
     where R.ID = p_res_id;
   commit;
end;

procedure resive_status_start(p_res_id varchar2) is
begin

    update input_reqs r set r.status = 1 where R.ID = p_res_id;

end;

procedure resive_status_exec(p_res_id varchar2) is
begin
    update input_reqs r set r.status = 2 where R.ID = p_res_id;
end;

 procedure add_resp(p_transtp_id varchar2 , p_resp_body clob) is
 l_input_req  input_reqs%rowtype;
 l_input_type  input_types%rowtype;
 l_clob clob;
 begin
 l_input_req:=get_input_req(p_transtp_id);
 l_input_type:=get_input_type(l_input_req.type_name);
           
           transp_lob.data_to_req(p_resp_body,
                       null,
                       l_input_type.output_data_type,
                       l_input_type.xml2json,
                       l_input_type.compress_type,
                       l_input_type.output_compress,
                       l_input_type.output_base_64,
                       l_clob);
 
 
    insert into input_resp(req_id,
                           d_clob,
                           insert_time,
                           resp_clob)
                           values(
                           p_transtp_id,
                           p_resp_body,
                           localtimestamp,
                           l_clob);
    
    update input_reqs rq
    set rq.status = g_in_req_procesed
    where rq.id = p_transtp_id;                       
                           
 exception when others then 
    resive_loger(p_req_id  => p_transtp_id,
                      p_act     => 'INSERT RESPONCE',
                      p_state   => 'ERROR',
                      p_message => substr(sqlerrm ||
                                          dbms_utility.format_error_backtrace(),
                                          1,
                                          4000));
 RAISE;

 end;

 procedure add_resp(p_transtp_id varchar2 , p_resp_body blob) is
 l_input_req  input_reqs%rowtype;
 l_input_type  input_types%rowtype;
 l_clob clob;
 begin
 l_input_req:=get_input_req(p_transtp_id);
 l_input_type:=get_input_type(l_input_req.type_name);
           
           transp_lob.data_to_req(null,
                       p_resp_body,
                       l_input_type.output_data_type,
                       l_input_type.xml2json,
                       l_input_type.compress_type,
                       l_input_type.output_compress,
                       l_input_type.output_base_64,
                       l_clob);
 
 
    insert into input_resp(req_id,
                           d_blob,
                           insert_time,
                           resp_clob)
                           values(
                           p_transtp_id,
                           p_resp_body,
                           localtimestamp,
                           l_clob);
    
    update input_reqs rq
    set rq.status = g_in_req_procesed
    where rq.id = p_transtp_id;                       

 exception when others then 
    resive_loger(p_req_id  => p_transtp_id,
                      p_act     => 'INSERT RESPONCE',
                      p_state   => 'ERROR',
                      p_message => substr(sqlerrm ||
                                          dbms_utility.format_error_backtrace(),
                                          1,
                                          4000));
 RAISE;
 end;

begin
  -- Initialization
 -- <Statement>;
    select p.PARAM_VALUE into g_proxy_url from barstrans.transp_params p where p.param_name = 'PROXY_URI';
    select p.PARAM_VALUE into g_wallet_path from barstrans.transp_params p where p.param_name = 'WALLET_PATH';
    BEGIN
    select UTL_RAW.CAST_TO_VARCHAR2(utl_encode.base64_decode(utl_raw.cast_to_raw(p.PARAM_VALUE)))
           into g_wallet_pass from barstrans.transp_params p where p.param_name = 'WALLET_PASS';
    EXCEPTION WHEN OTHERS THEN
        IF SQLCODE = -29261 THEN g_wallet_pass:='';
        ELSE RAISE;
        END IF;
    END;
end transp_utl;
/
