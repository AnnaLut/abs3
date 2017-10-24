
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_mail.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_MAIL is
/*
  Package MAIL - пакет процедур(заголовок) для работы с SMTP,
  рассылка почты и пр.
*/

g_header_version  constant varchar2(64)  := 'version 2.30 09/09/2010';

g_awk_header_defs constant varchar2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;

/*
  Процедура SEND_MAIL(...) для посылки сообщения по e-mail
  (протокол SMTP)
*/
procedure send_mail(
  p_smtp_host     varchar2,  -- Адрес сервера SMTP, н-р: mail.company.com.ua
  p_smtp_port     number,    -- Порт сервера SMTP (default=25)
  p_smtp_domain   varchar2,  -- SMTP domain, н-р: company.com.ua
  p_from_addr     varchar2,  -- Адрес отправителя e-mail
  p_from_name     varchar2,  -- Имя отправителя e-mail
  p_to_addr       varchar2,  -- Адрес получателя e-mail
  p_to_name       varchar2,  -- Имя получателя e-mail
  p_subject       varchar2,  -- Тема сообщения
  p_body          clob       -- Тело сообщения
);

/*
  Процедура TO_MAIL(...) для посылки сообщения по e-mail
  (протокол SMTP)
  по указанному адресу, с заданной темой и телом сообщения
*/
procedure to_mail(
  p_to_addr       varchar2,  -- Адрес получателя e-mail
  p_to_name       varchar2,  -- Имя получателя e-mail
  p_subject       varchar2,  -- Тема сообщения
  p_body          clob       -- Тело сообщения
);

/**
 * dump_mail_info - возвращает содержимое сообщения в читабельном виде
 */
function dump_mail_info(p_msg in bars.t_bars_mail) return varchar2;

/**
 * put_msg2queue3 - помещает сообщение в очередь на отправку и возвращает ID сообщения
 * @params p_msg - структура сообщения
 * @params p_msgid [out] - ID сообщения
 */
procedure put_msg2queue3(
  p_msg         in bars.t_bars_mail,
  p_msgid       out raw
);

/**
 * put_msg2queue2 - помещает сообщение в очередь на отправку и возвращает ID сообщения
 * @params p_name - Имя строковое получателя (до 256 символов)
 * @params p_addr - адрес получателя, н-р, serg@unity-bars.com.ua (до 256 символов)
 * @params p_subject - Тема сообщения (до 256 символов)
 * @params p_body - тело сообщения (CLOB)
 * @params p_msgid [out] - ID сообщения
 */
procedure put_msg2queue2(
  p_name     in varchar2,
  p_addr     in varchar2,
  p_subject  in varchar2,
  p_body     in clob,
  p_msgid   out raw
);

/**
 * put_msg2queue - помещает сообщение в очередь на отправку
 * @params p_name - Имя строковое получателя (до 256 символов)
 * @params p_addr - адрес получателя, н-р, serg@unity-bars.com.ua (до 256 символов)
 * @params p_subject - Тема сообщения (до 256 символов)
 * @params p_body - тело сообщения (CLOB)
 */
procedure put_msg2queue(
  p_name     in varchar2,
  p_addr     in varchar2,
  p_subject  in varchar2,
  p_body     in clob
);

/**
 * proc_mail_queue - рассылка сообщений из очереди
 */
procedure proc_mail_queue;

end; -- package bars_mail
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_MAIL is
/*
  Package BARS_MAIL - пакет процедур(тело) для работы с SMTP,
  рассылка почты и пр.
*/

g_body_version  constant varchar2(64)  := 'version 2.6 09/03/2017';

g_awk_body_defs constant varchar2(512) := '';

GC_SMTP_AUTH_NONE   constant varchar2(4) := 'NONE';     -- аутентификация отсутствует
GC_SMTP_AUTH_LOGIN  constant varchar2(5) := 'LOGIN';    -- аутентификация с помощью логина и пароля

-- поддерживаемые наборы символов(кодировки)
GC_CHARSET_UTF_8            constant varchar2(30) := 'utf-8';
GC_CHARSET_WINDOWS_1251     constant varchar2(30) := 'windows-1251';
GC_MODULE        constant varchar2(50) := 'MLL';

g_smtp_host     varchar2(50);  -- Адрес сервера SMTP, н-р: mail.company.com.ua
g_smtp_port     number;          -- Порт сервера SMTP (default=25)
g_smtp_domain   varchar2(50);  -- SMTP domain, н-р: company.com.ua
g_from_addr     varchar2(50);  -- Адрес отправителя e-mail
g_from_name     varchar2(50);  -- Имя отправителя e-mail
g_smtp_auth     varchar2(50);  -- Метод аутентификации при подк. к SMTP-серверу: NONE, LOGIN
g_smtp_user     varchar2(50);  -- Имя пользователя SMTP-сервера
g_smtp_pswd     varchar2(50);  -- Пароль пользователя SMTP-сервера


-- определяем исключение на отсутствие сообщений в очереди
MQ_EMPTY_OR_TIMEOUT_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(MQ_EMPTY_OR_TIMEOUT_EXCEPTION, -25228);

DEQUE_DISABLED exception;
pragma exception_init(DEQUE_DISABLED, -25226);
/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header BARS_MAIL '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body BARS_MAIL '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
end body_version;

----
-- to_base64 - преобразует строку в base64 вид
--
function to_base64(p_str in varchar2)
return varchar2
is
begin
    return
        replace(
            utl_raw.cast_to_varchar2(
                utl_encode.base64_encode(
                    utl_raw.cast_to_raw(p_str)
                )
            ), '='||chr(13)||chr(10), ''
        );
end to_base64;

----
-- to_quoted_printable - преобразует строку в quoted_printable вид
--
function to_quoted_printable(p_str in varchar2)
return varchar2
is
begin
    return
        replace(
            utl_raw.cast_to_varchar2(
                utl_encode.quoted_printable_encode(
                    utl_raw.cast_to_raw(nvl(p_str,' '))
                )
            ), '='||chr(13)||chr(10), ''
        );
end to_quoted_printable;


----
-- open_connection - открывает соединение с SMTP-сервером
--
function open_connection
return utl_smtp.connection
is
  l_con   utl_smtp.connection;
begin

  begin
     l_con := utl_smtp.open_connection(g_smtp_host,g_smtp_port);
  exception when others then
     bars_error.raise_nerror(GC_MODULE,'CANNOT_SET_CONNECTION', g_smtp_host,g_smtp_port,sqlerrm);
  end;

  utl_smtp.ehlo(l_con, g_smtp_domain);

  if g_smtp_auth=GC_SMTP_AUTH_LOGIN then
    utl_smtp.command(l_con, 'AUTH LOGIN');
    utl_smtp.command(l_con, utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(g_smtp_user))));
    utl_smtp.command(l_con, utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(g_smtp_pswd))));
  end if;
  --
  return l_con;
  --
end open_connection;

----
-- close_connection - закрываем соединение
--
procedure close_connection(p_con in out nocopy utl_smtp.connection)
is
begin
  utl_smtp.quit(p_con);
exception
  -- when utl_smtp.transient_error or utl_smtp.permanent_error then
  when others then
    null;
    -- When the SMTP server is down or unavailable, we don't have
    -- a connection to the server. The quit call will raise an
    -- exception that we can ignore.
end close_connection;

----
-- отправка одиночного сообщения
--
procedure send_single_mail(
    p_con     in utl_smtp.connection,
    p_msg     in bars.t_bars_mail
)
is
  ptr_bg                integer;
  ptr_sc                integer;
  ptr_str               varchar2(256);
  to_addr_z             varchar2(256);
  to_name_z             varchar2(256);
  tmp                   varchar2(256);
  l_msgText             varchar2(32767);
  l_length              integer;
  i                     integer;
  nn                    integer;
  c                     utl_smtp.connection;
  l_charset             varchar2(30);
  l_content_encoding    varchar2(60);
  l_body_utf8           nclob;
  l_content_type        varchar2(60);
begin
  l_content_type := nvl(p_msg.content_type, 'text/plain');
  l_charset := nvl(lower(p_msg.charset), GC_CHARSET_WINDOWS_1251);
  -- всевозможные проверки
  if l_charset not in (GC_CHARSET_UTF_8, GC_CHARSET_WINDOWS_1251)
  then
    raise_application_error(-20000, 'Неподдерживаемая кодировка: '||l_charset);
  end if;
  --
  l_content_encoding := case
                        when l_charset = GC_CHARSET_WINDOWS_1251
                        then
                            '8bit'
                        else
                            'quoted-printable'
                        end;
  --
  c := p_con;
  --
  utl_smtp.mail(c, g_from_addr);
  -- разбираем список адресов получателей
  ptr_bg := 1; ptr_sc := 1;
  to_addr_z := replace(p_msg.addr,';',',');
  --dbms_output.put_line('to_addr_z='||to_addr_z);
  loop
    tmp := substr(to_addr_z,ptr_bg);
    ptr_sc := instr(tmp,',');
    if ptr_sc=0 then ptr_sc:=length(to_addr_z)+1;
    else ptr_sc := ptr_sc+ptr_bg-1;
    end if;
    --dbms_output.put_line('address='||substr(to_addr_z,ptr_bg,ptr_sc-ptr_bg));
    utl_smtp.rcpt(c, substr(to_addr_z,ptr_bg,ptr_sc-ptr_bg));
    ptr_bg := ptr_sc+1;
    exit when ptr_sc>=length(to_addr_z);
  end loop;
  utl_smtp.open_data(c);

  if p_msg.name is null then
    to_name_z := replace(p_msg.addr,';',',');
  else
    to_name_z := replace(p_msg.name,';',',');
  end if;
  -- Пишем от кого, кому, что
  l_msgText := 'DATE: '    || to_char(sysdate, 'dd Mon yy hh24:mi:ss')           || utl_tcp.CRLF ||
               'Mime-Version: 1.0'                                               || utl_tcp.CRLF ||
               'Content-Type: '||l_content_type||'; charset='||l_charset         || utl_tcp.CRLF ||
               'Content-Transfer-Encoding: '||l_content_encoding                 || utl_tcp.CRLF ||
               'FROM: '              || g_from_name                              || utl_tcp.CRLF ||
               'TO: '                || to_name_z                                || utl_tcp.CRLF ||
               'SUBJECT: '           || case
                                        when l_charset = GC_CHARSET_WINDOWS_1251
                                        then
                                            p_msg.subject
                                        else
                                            '=?UTF-8?Q?' || to_quoted_printable(translate(p_msg.subject using nchar_cs))   || '?='
                                        end
                                     || utl_tcp.CRLF
               ;
  utl_smtp.write_raw_data(c, utl_raw.cast_to_raw(l_msgText));
  utl_smtp.write_data(c, utl_tcp.CRLF);

  if l_charset = GC_CHARSET_WINDOWS_1251
  then
    l_length    := dbms_lob.getlength(p_msg.body);
  else
    l_body_utf8 := to_nclob(p_msg.body);
    l_length    := dbms_lob.getlength(l_body_utf8);
  end if;

  i := 1;
  while i<=l_length loop
    nn := least(500, l_length-i+1);
    utl_smtp.write_raw_data
    (c,
     case
     when l_charset = GC_CHARSET_WINDOWS_1251
     then
        utl_raw.cast_to_raw(dbms_lob.substr(p_msg.body,nn,i))
     else
        utl_encode.quoted_printable_encode(utl_raw.cast_to_raw(dbms_lob.substr(l_body_utf8,nn,i)))
     end
    );
    i := i+nn;
  end loop;

  utl_smtp.close_data(c);

end send_single_mail;

/*
  Процедура SEND_MAIL(...) для посылки сообщения по e-mail
  (протокол SMTP)
*/
procedure send_mail(
  p_smtp_host     varchar2,  -- Адрес сервера SMTP, н-р: mail.company.com.ua
  p_smtp_port     number,    -- Порт сервера SMTP (default=25)
  p_smtp_domain   varchar2,  -- SMTP domain, н-р: company.com.ua
  p_from_addr     varchar2,  -- Адрес отправителя e-mail
  p_from_name     varchar2,  -- Имя отправителя e-mail
  p_to_addr       varchar2,  -- Адрес получателя e-mail
  p_to_name       varchar2,  -- Имя получателя e-mail
  p_subject       varchar2,  -- Тема сообщения
  p_body          clob       -- Тело сообщения
) is
  c       utl_smtp.connection;
  l_msg   bars.t_bars_mail;
begin
  --
  l_msg := new bars.t_bars_mail(p_to_name, p_to_addr, p_subject, null, null, p_body);
  c := open_connection();
  --
  send_single_mail(c, l_msg);
  --
  close_connection(c);
  --
exception when utl_smtp.transient_error or utl_smtp.permanent_error then
    --
    close_connection(c);
    --
    raise_application_error(-20000,
        'Failed to send mail due to the following error: ' ||
        dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
end; -- send_mail

/*
  Процедура TO_MAIL(...) для посылки сообщения по e-mail
  (протокол SMTP)
  по указанному адресу, с заданной темой и телом сообщения
*/
procedure to_mail(
  p_to_addr       varchar2,  -- Адрес получателя e-mail
  p_to_name       varchar2,  -- Имя получателя e-mail
  p_subject       varchar2,  -- Тема сообщения
  p_body          clob       -- Тело сообщения
) is
begin
  -- отсылаем e-mail
  send_mail(
      g_smtp_host,
      g_smtp_port,
      g_smtp_domain,
      g_from_addr,
      g_from_name,
      p_to_addr,
      p_to_name,
      p_subject,
      p_body
  );
end; -- to_mail

procedure param is
  ern             constant positive := 1;  -- error code
  err             exception;
  erm             varchar2(256);
begin
  -- вычитываем параметры из params
  -- SMTPHOST
  begin

    select trim(val) into g_smtp_host
    from params where par='SMTPHOST';

  exception when no_data_found then
    erm := '1 - Parameter SMTPHOST is undefined';
    raise err;
  end;
  -- SMTPPORT
  begin
    select trim(val) into g_smtp_port
    from params where par='SMTPPORT';
  exception when no_data_found then
    g_smtp_port:=25; -- default value
  end;
  -- SMTPDOMN
  begin
    select trim(val) into g_smtp_domain
    from params where par='SMTPDOMN';
  exception when no_data_found then
    erm := '2 - Parameter SMTPDOMN is undefined';
    raise err;
  end;
  -- SMTPADDR
  begin
    select trim(val) into g_from_addr
    from params where par='SMTPADDR';
  exception when no_data_found then
    erm := '3 - Parameter SMTPADDR is undefined';
    raise err;
  end;
  -- SMTPNAME
  begin
    select trim(val) into g_from_name
    from params where par='SMTPNAME';
  exception when no_data_found then
    erm := '4 - Parameter SMTPNAME is undefined';
    raise err;
  end;

  -- SMTPAUTH
  begin
    select trim(val) into g_smtp_auth
    from params where par='SMTPAUTH';
    if g_smtp_auth not in (GC_SMTP_AUTH_NONE, GC_SMTP_AUTH_LOGIN) then
        erm := '5 - Недопустимое значение параметра SMTPAUTH: '||g_smtp_auth;
        raise err;
    end if;
  exception when no_data_found then
    g_smtp_auth := GC_SMTP_AUTH_NONE;
  end;

  if g_smtp_auth=GC_SMTP_AUTH_LOGIN then
      -- SMTPUSER
      begin
        select trim(val) into g_smtp_user
        from params where par='SMTPUSER';
      exception when no_data_found then
        erm := '6 - Parameter SMTPUSER is undefined';
        raise err;
      end;
      -- SMTPPSWD
      begin
        select trim(val) into g_smtp_pswd
        from params where par='SMTPPSWD';
      exception when no_data_found then
        erm := '7 - Parameter SMTPPSWD is undefined';
        raise err;
      end;
  end if;

exception
    when err then
        bars_error.raise_nerror(GC_MODULE,'CANNOT_GET_PARAMETER',erm );
end param;

/**
 * put_msg2queue3 - помещает сообщение в очередь на отправку и возвращает ID сообщения
 * @params p_msg - структура сообщения
 * @params p_msgid [out] - ID сообщения
 */

procedure put_msg2queue3(
  p_msg         in bars.t_bars_mail,
  p_msgid       out raw
)
is
  l_enqueue_options         dbms_aq.enqueue_options_t;
  l_message_properties      dbms_aq.message_properties_t;
begin
  l_message_properties.sender_id := sys.aq$_agent ('BARS', null, null);
  dbms_aq.enqueue(
    queue_name          => 'bars.bars_mail_queue',
    enqueue_options     => l_enqueue_options,
    message_properties  => l_message_properties,
    payload             => p_msg,
    msgid               => p_msgid
  );
  bars_audit.trace('BARS_MAIL: Сообщение помещено в очередь, ID='||rawtohex(p_msgid)
                  ||chr(10)||dump_mail_info(p_msg));
end put_msg2queue3;


/**
 * put_msg2queue2 - помещает сообщение в очередь на отправку и возвращает ID сообщения
 * @params p_name - Имя строковое получателя (до 256 символов)
 * @params p_addr - адрес получателя, н-р, serg@unity-bars.com.ua (до 256 символов)
 * @params p_subject - Тема сообщения (до 256 символов)
 * @params p_body - тело сообщения (CLOB)
 * @params p_msgid [out] - ID сообщения
 */
procedure put_msg2queue2(
  p_name     in varchar2,
  p_addr     in varchar2,
  p_subject  in varchar2,
  p_body     in clob,
  p_msgid   out raw
) is
  l_msg   bars.t_bars_mail;
begin
    --
    l_msg := new bars.t_bars_mail(p_name, p_addr, p_subject, null, null, p_body);
    --
    put_msg2queue3( l_msg, p_msgid );
    --
end put_msg2queue2;

/**
 * put_msg2queue - помещает сообщение в очередь на отправку
 * @params p_name - Имя строковое получателя (до 256 символов)
 * @params p_addr - адрес получателя, н-р, serg@unity-bars.com.ua (до 256 символов)
 * @params p_subject - Тема сообщения (до 256 символов)
 * @params p_body - тело сообщения (CLOB)
 */
procedure put_msg2queue(
  p_name     in varchar2,
  p_addr     in varchar2,
  p_subject  in varchar2,
  p_body     in clob
) is
  l_msgid                   raw(16);
begin
  put_msg2queue2(
      p_name     => p_name,
      p_addr     => p_addr,
      p_subject  => p_subject,
      p_body     => p_body,
      p_msgid    => l_msgid
  );
end put_msg2queue;

/**
 * dump_mail_info - возвращает содержимое сообщения в читабельном виде
 */
function dump_mail_info(p_msg in bars.t_bars_mail) return varchar2 is
begin
  return
    case
    when p_msg.content_type is not null
    then
        'Content-Type: '||p_msg.content_type
    else
        ''
    end ||chr(10)||
    case
    when p_msg.charset is not null
    then
        'charset='||p_msg.charset
    else
        ''
    end ||chr(10)||
    'Имя получателя   : '||p_msg.name||chr(10)||
    'Адрес получателя : '||p_msg.addr||chr(10)||
    'Тема сообщения   : '||p_msg.subject||chr(10)||
    'Тело сообщения   : '||chr(10)||
    dbms_lob.substr(p_msg.body,1000)||
    case
        when dbms_lob.getlength(p_msg.body)>1000 then
             chr(10)||'...'
        else ''
    end;
end dump_mail_info;

/**
 * proc_mail_queue - рассылка сообщений из очереди
 */
procedure proc_mail_queue is
  l_dequeue_options         dbms_aq.dequeue_options_t;
  l_message_properties      dbms_aq.message_properties_t;
  l_msgid                   RAW(16);
  l_msg                     bars.t_bars_mail;
  l_con                     utl_smtp.connection;
  l_con_opened              boolean := false;
  l_need_commit             boolean := false;
  l_trace                   varchar2(1000) := 'bars_mail.proc_mail_queue: ';
begin

  bars_audit.trace(l_trace||'Начало обработки очереди e-mail сообщений');
  l_dequeue_options.consumer_name   := 'BARS';
  l_dequeue_options.wait            := dbms_aq.no_wait;
  l_dequeue_options.navigation      := dbms_aq.first_message;
  while true loop
    begin
      begin
          dbms_aq.dequeue(
        queue_name          => 'bars.bars_mail_queue',
        dequeue_options     => l_dequeue_options,
        message_properties  => l_message_properties,
        payload             => l_msg,
        msgid               => l_msgid);
      exception
          when DEQUE_DISABLED then
               -- ORA-20000: ORA-25226: dequeue failed, queue BARS.BARS_MAIL_QUEUE is not enabled for dequeue
               bars_error.raise_nerror(GC_MODULE, 'DEQUEUE_IS_DISABLED');
      end;
      l_need_commit := true;

       bars_audit.trace(l_trace||'Из очереди изъято сообщение, ID='||rawtohex(l_msgid)              ||chr(10)||dump_mail_info(l_msg));
      if not l_con_opened
      then
        l_con := open_connection();
        l_con_opened := true;
      end if;
      begin
        send_single_mail(
          p_con     => l_con,
          p_msg     => l_msg
        );
        logger.trace('BARS_MAIL: Отослано сообщение, ID='||rawtohex(l_msgid)
                        ||chr(10)||dump_mail_info(l_msg));
      exception when others then
        bars_audit.trace(l_trace||'Ошибка при посылке сообщения ID='||rawtohex(l_msgid)||' по адресу '
            ||l_msg.name||' '||l_msg.addr||chr(10)||
            substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(),1,1900));
      end;
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
      logger.trace('BARS_MAIL: Очередь не содержит больше сообщений');
      exit;
    end;
    l_dequeue_options.navigation := dbms_aq.next_message;
  end loop;
  --
  if l_need_commit
  then
    commit;
  end if;
  --
  if l_con_opened
  then
    close_connection(l_con);
    l_con_opened := false;
  end if;
  --
  if logger.trace_enabled
  then
    logger.trace('BARS_MAIL: Окончание обработки очереди e-mail сообщений');
  end if;
  --
exception
    when others then
      rollback;
      if l_con_opened
      then
        close_connection(l_con);
        l_con_opened := false;
      end if;
      raise_application_error(-20000, substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(),1,1900));
end proc_mail_queue;

begin
  param;
end;  -- package body
/
 show err;
 
PROMPT *** Create  grants  BARS_MAIL ***
grant EXECUTE                                                                on BARS_MAIL       to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_MAIL       to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_MAIL       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_mail.sql =========*** End *** =
 PROMPT ===================================================================================== 
 