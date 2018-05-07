
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
create or replace package bars_sms is
----
--  Package BARS_SMS - пакет процедур для отправки SMS
--
--  SERG, 31/08/2010

--  Архитектура подсистемы рассылки SMS:
/*

    BARS_SMS                -->  пакет - внешний интерфейс для прикладных модулей
      |
      |
    SMS_PROVIDER            -->  объектный тип обобщенного провайдера услуг по рассылке SMS
      |
      |
    SMS_PROVIDER_<NAME>     -->  объектный тип провайдера услуг по рассылке SMS с именем <NAME>,
      |                          наследуется от SMS_PROVIDER и является оболочкой для BARS_SMS_<NAME>
      |
    BARS_SMS_<NAME>         -->  пакет - реализация транспортного уровня для провайдера <NAME>

*/

g_header_version  constant varchar2(64)  := 'version 2.11  25/04/2018';

g_awk_header_defs constant varchar2(512) := '';

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

----
-- init - инициализация пакета
--
procedure init;

----
-- create_msg - Создает сообщение для посылки SMS
--
procedure create_msg(
    p_msgid             in out  msg_submit_data.msg_id%type,
    p_creation_time     in      msg_submit_data.creation_time%type,
    p_expiration_time   in      msg_submit_data.expiration_time%type,
    p_phone             in      msg_submit_data.phone%type,
    p_encode            in      msg_submit_data.encode%type,
    p_msg_text          in      msg_submit_data.msg_text%type,
    p_kf                in      msg_submit_data.kf%type);

----
-- submit_msg - выполняет посылку сообщения
--
procedure submit_msg(p_msgid in msg_submit_data.msg_id%type);

----
-- submit_messages - выполняет посылку сообщений
--
procedure submit_messages;

procedure submit_messages(p_start_id in number, p_end_id in number);
----
-- query_status - выполняет проверку статуса
--
procedure query_status(p_smsid in sms_query_data.sms_id%type);

----
-- query_statuses - выполняет проверку статуса по всем SMS, ожидающим такой проверки
--
procedure query_statuses;

end bars_sms;
/

create or replace package body bars_sms
is
----
--  Package BARS_SMS - пакет процедур для отправки SMS
--
--  SERG, 31/08/2010

--  Архитектура подсистемы рассылки SMS:
/*

    BARS_SMS                -->  пакет - внешний интерфейс для прикладных модулей
      |
      |
    SMS_PROVIDER            -->  объектный тип обобщенного провайдера услуг по рассылке SMS
      |
      |
    SMS_PROVIDER_<NAME>     -->  объектный тип провайдера услуг по рассылке SMS с именем <NAME>,
      |                          наследуется от SMS_PROVIDER и является оболочкой для BARS_SMS_<NAME>
      |
    BARS_SMS_<NAME>         -->  пакет - реализация транспортного уровня для провайдера <NAME>

*/

g_body_version  constant varchar2(64)  := 'version 2.21 25/04/2018';

g_awk_body_defs constant varchar2(512) := '';

G_SMS_PROV varchar2(30);                                   -- Имя объектного типа SMS-Провайдера

g_sms_provider    sms_provider;    -- экземпляр объектного типа SMS-Провайдера

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2
is
begin
  return 'Package header BARS_SMS '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
end header_version;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2
is
begin
  return 'Package body BARS_SMS '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
end body_version;

----
-- init - инициализация пакета
--
procedure init
is
begin
    --
    -- получим имя объектного типа SMS-Провайдера
    --
    select val
      into G_SMS_PROV
      from params$base
     where par='SMS_PROV';
    --
    -- инстанцируем объект
    --
    execute immediate 'begin :g_sms_provider := new '||G_SMS_PROV||'(); end;'
            using out g_sms_provider;
    --
end init;

----
-- create_msg - Создает сообщение для посылки SMS
--
procedure create_msg(
    p_msgid             in out  msg_submit_data.msg_id%type,
    p_creation_time     in      msg_submit_data.creation_time%type,
    p_expiration_time   in      msg_submit_data.expiration_time%type,
    p_phone             in      msg_submit_data.phone%type,
    p_encode            in      msg_submit_data.encode%type,
    p_msg_text          in      msg_submit_data.msg_text%type,
    p_kf                in      msg_submit_data.kf%type)
is
begin
    if p_msgid is null
    then
        select s_msgid.nextval
          into p_msgid
          from dual;
    end if;
    --
    insert
      into msg_submit_data(msg_id, creation_time, expiration_time, phone, encode, msg_text, kf)
    values (p_msgid, p_creation_time, p_expiration_time, p_phone, p_encode, p_msg_text,p_kf);
    --
end create_msg;

----
-- submit_msg - выполняет посылку сообщения
--
procedure submit_msg(p_msgid in msg_submit_data.msg_id%type)
is
begin
    logger.trace('bars_sms.submit_msg(p_msgid=>'||p_msgid||')');
    --
    g_sms_provider.submit_msg(p_msgid);
    --
    logger.trace('bars_sms.submit_msg(p_msgid=>'||p_msgid||')');
end submit_msg;

----
-- submit_messages - выполняет посылку сообщений
--
procedure submit_messages is
  l_sql_chunk      varchar2(32000);
  l_sql_stmt       varchar2(32000);
  l_parallel_level number;
  l_parallel_group number;
  l_cnt            number;
  l_task           varchar2(35) := 'PCD_SMS'||to_char(current_timestamp,'ddmmyyyyhh24missff');
  l_useparallelexec params$global.val%type;  
begin
  logger.trace('bars_sms.submit_messages: start');
  --
  begin
    l_useparallelexec := trim(get_global_param('USEPAREXECSMS'));
  exception
    when others then
      l_useparallelexec := '0';
  end;
  if l_useparallelexec = '1' then
     begin
       l_parallel_level := to_number(trim(get_global_param('NUMPARLEVELSMS')));
     exception
       when others then
         l_parallel_level := 5;
     end;
     begin
       l_parallel_group := to_number(trim(get_global_param('NUMPARGROUPSMS')));
     exception
       when others then
         l_parallel_group := 50;
     end;
  end if;

  select count(*)
    into l_cnt
    from msg_submit_data
   where status in ('NEW', 'ERROR')
     and exists
   (select 1
            from dual
           where to_number(to_char(sysdate, 'HH24MI')) between 600 and 2100);

  if (l_cnt < 100 and l_useparallelexec = 1) or (l_useparallelexec = 0) then
    for c in (select msg_id
                from msg_submit_data
               where status in ('NEW', 'ERROR')
                 and exists
               (select 1
                        from dual
                       where to_number(to_char(sysdate, 'HH24MI')) between 600 and 2100)
               order by msg_id
                 for update skip locked) loop
      submit_msg(c.msg_id);
    end loop;
  else
    l_sql_chunk := 'select * from (select unique decode(level, 1, min_id, (min_id + step * (level - 1))) start_id,
                                           decode(level,' ||
                   to_char(l_parallel_group) || ',
                                                  max_id,
                                                  decode(level, 1, min_id, (min_id + step * (level - 1))) + step - 1) end_id
                                      from (select min(msg_id) min_id, max(msg_id) max_id,
                                                   trunc((max(msg_id) - min(msg_id)) / ' ||
                   to_char(l_parallel_group) ||
                   ') step
                                              from msg_submit_data t
                                             where  status in (''NEW'', ''ERROR''))
                                    connect by level <=' ||
                   to_char(l_parallel_group) || ') where start_id <=end_id';
      l_sql_stmt := 'begin bars_sms.submit_messages(:start_id, :end_id); end;';                   

      dbms_parallel_execute.create_task(l_task);
      dbms_parallel_execute.create_chunks_by_sql(l_task, l_sql_chunk, false);
      dbms_parallel_execute.run_task(l_task,
                                     l_sql_stmt,
                                     dbms_sql.native,
                                     parallel_level => l_parallel_level);
      dbms_parallel_execute.drop_task(l_task);  
  end if;
  --
  logger.trace('bars_sms.submit_messages: finish');
  --
end submit_messages;

procedure submit_messages(p_start_id in number, p_end_id in number)

is
begin
    logger.trace('bars_sms.submit_messages: start. #p_start_id ='||p_start_id||' p_end_id ='||p_end_id);
    for c in (select msg_id
                from msg_submit_data
               where status in ('NEW','ERROR')
               and exists
               (select 1
                    from dual
                    where
                    to_number(to_char(sysdate,'HH24MI')) between 600 and 2100
               )
               and msg_id between p_start_id and p_end_id
               order by msg_id for update skip locked)
    loop
        submit_msg(c.msg_id);
    end loop;
    logger.trace('bars_sms.submit_messages: finish. #p_start_id ='||p_start_id||' p_end_id ='||p_end_id);   
end;
----
-- query_status - выполняет проверку статуса
--
procedure query_status(p_smsid in sms_query_data.sms_id%type)
is
begin
    logger.trace('bars_sms.query_status(p_smsid=>'''||p_smsid||''')');
    --
    g_sms_provider.query_status(p_smsid);
    --
    logger.trace('bars_sms.query_status(p_smsid=>'''||p_smsid||''')');
    --
end query_status;

----
-- query_statuses - выполняет проверку статуса по всем SMS, ожидающим такой проверки
--
procedure query_statuses
is
begin
    logger.trace('bars_sms.query_statuses: start');
    --
    for c in (select sms_id
                from sms_query_data
               where next_query_time is not null
                 and next_query_time<=sysdate
               order by next_query_time for update skip locked)
    loop
        query_status(c.sms_id);
    end loop;
    --
    logger.trace('bars_sms.query_statuses: finish');
    --
end query_statuses;

begin
  init;
end bars_sms;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sms.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 