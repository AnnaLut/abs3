
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms_gmsu.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SMS_GMSU is
----
--  Package BARS_SMS_GMSU - пакет процедур для отправки SMS по SMTP через провайдера GMSU
--                              (транспортный уровень)
--  «Global Message Services Ukraine», www.gmsu.ua
--
--  SERG, 31/08/2010
--

g_header_version  constant varchar2(64)  := 'version 1.0 31/08/2010';

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
-- submit_msg - выполняет посылку сообщения
--
procedure submit_msg(p_msgid in msg_submit_data.msg_id%type);

----
-- query_status - выполняет проверку статуса
--
procedure query_status(p_smsid in sms_query_data.sms_id%type);


end bars_sms_gmsu;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SMS_GMSU 
is
----
--  Package BARS_SMS_GMSU - пакет процедур для отправки SMS по SMTP через провайдера GMSU
--                              (транспортный уровень)
--  «Global Message Services Ukraine», www.gmsu.ua
--
--  SERG, 31/08/2010
--

g_body_version  constant varchar2(64)  := 'version 1.02 09/09/2010';

g_awk_body_defs constant varchar2(512) := '';

G_GMSU_DMN  varchar2(128);  -- Доменне ім''я SMTP-сервера GMSU

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2 is
begin
  return 'Package header BARS_SMS_GMSU '||g_header_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_header_defs;
end header_version;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
begin
  return 'Package body BARS_SMS_GMSU '||g_body_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_body_defs;
end body_version;

----
-- init - инициализация пакета
--
procedure init is
begin
	select val
      into G_GMSU_DMN
      from params
     where par = 'GMSU_DMN';
end init;

----
-- canonize_phone_number - канонизирует номер телефона, убирая плюс в начале и лишние разделители
--
function canonize_phone_number(p_phone in varchar2)
return varchar2
is
    l_canonized_phone   varchar2(12);
    l_length            number;
    l_pos               number;
    l_char              varchar2(1);
begin
    l_pos := 1;
    l_length := length(p_phone);
    while l_pos <= l_length
    loop
        l_char := substr(p_phone, l_pos, 1);
        if l_char in ('0','1','2','3','4','5','6','7','8','9')
        then
            if length(l_canonized_phone) = 12
            then
                raise_application_error(-2000, 'Номер телефона после канонизации превышает 12 знаков. Исходный номер: '||p_phone);
            end if;
            l_canonized_phone := l_canonized_phone || l_char;
        end if;
        l_pos := l_pos + 1;
    end loop;
    return l_canonized_phone;
end;

----
-- submit_msg - выполняет посылку сообщения
--
procedure submit_msg(p_msgid in msg_submit_data.msg_id%type) is
    l_msg       msg_submit_data%rowtype;
    l_addr      varchar2(200);
    l_sqlerrm   varchar2(4000);
    l_mail      bars.t_bars_mail;
    l_msgid     raw(16);
    l_charset   varchar2(30);
begin
	logger.trace('bars_sms_gmsu.submit_msg(p_msgid=>'||p_msgid||'): start');
    -- получаем само сообщение
    begin
        select *
          into l_msg
          from msg_submit_data
         where msg_id=p_msgid
        for update nowait;
    exception when no_data_found then
        raise_application_error(-20000, 'Сообщение(MSG_ID='||p_msgid||') не найдено', true);
    end;
    --
    savepoint sp;
    -- проверки
    if l_msg.status not in ('NEW', 'ERROR')
    then
        raise_application_error(-20000, 'Недопустимый статус('||l_msg.status||') сообщения(MSG_ID='||p_msgid||')', true);
    end if;
    if l_msg.expiration_time<sysdate
    then
        update msg_submit_data
           set status = 'EXPIRED',
               status_time = sysdate
         where msg_id = p_msgid;
        return;
    end if;
    -- посылаем сообщение
    begin
        l_addr := canonize_phone_number(l_msg.phone)||'@'||G_GMSU_DMN;
        --
        if l_msg.encode='lat'
        then
            l_charset := 'windows-1251';
        else
            l_charset := 'utf-8';
        end if;
        --
        l_mail := new bars.t_bars_mail('<'||l_addr||'>', l_addr, '', 'text/plain', l_charset, l_msg.msg_text);
        --
        bars_mail.put_msg2queue3( l_mail, l_msgid );
        --
        -- проставляем код возврата
        update msg_submit_data
           set status          = 'SUBMITTED',
               status_time     = sysdate,
               submit_code     = null,
               last_error      = null
         where msg_id = p_msgid;
    exception
        when others then
            rollback to sp;
            l_sqlerrm := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(),1,4000);
            update msg_submit_data
               set status          = 'ERROR',
                   status_time     = sysdate,
                   last_error      = l_sqlerrm
             where msg_id = p_msgid;
            logger.error('bars_sms_gmsu.submit_msg(p_msgid=>'||p_msgid||')'||chr(10)||l_sqlerrm);
    end;
    --
    logger.trace('bars_sms_gmsu.submit_msg(p_msgid=>'||p_msgid||'): finish');
    --
end submit_msg;

----
-- query_status - выполняет проверку статуса
--
procedure query_status(p_smsid in sms_query_data.sms_id%type) is
begin
	null;
end query_status;

begin
  init;
end bars_sms_gmsu;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sms_gmsu.sql =========*** End *
 PROMPT ===================================================================================== 
 