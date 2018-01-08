
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SMS is
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

g_header_version  constant varchar2(64)  := 'version 2.1  10/08/2016';

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
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SMS 
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

g_body_version  constant varchar2(64)  := 'version 2.2 10/08/2016';

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
      from params
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
procedure submit_messages
is
begin
    logger.trace('bars_sms.submit_messages: start');
    --
    for c in (select msg_id
                from msg_submit_data
               where status in ('NEW','ERROR')
               and exists
               (select 1
                    from dual
                    where
                    to_number(to_char(sysdate,'HH24MI'))
                    between nvl( GET_GLOBAL_PARAM('SMS_SEND_START'),600)
                    and nvl(GET_GLOBAL_PARAM('SMS_SEND_STOP'),2100)      --не відправляти смс з 21 вечора до 6 ранку

               )
               order by msg_id for update skip locked)
    loop
        submit_msg(c.msg_id);
    end loop;
    --
    logger.trace('bars_sms.submit_messages: finish');
    --
end submit_messages;

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
 