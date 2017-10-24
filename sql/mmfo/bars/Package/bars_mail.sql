
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_mail.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_MAIL is
/*
  Package MAIL - ����� ��������(���������) ��� ������ � SMTP,
  �������� ����� � ��.
*/

g_header_version  constant varchar2(64)  := 'version 2.30 09/09/2010';

g_awk_header_defs constant varchar2(512) := '';

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2;

/*
  ��������� SEND_MAIL(...) ��� ������� ��������� �� e-mail
  (�������� SMTP)
*/
procedure send_mail(
  p_smtp_host     varchar2,  -- ����� ������� SMTP, �-�: mail.company.com.ua
  p_smtp_port     number,    -- ���� ������� SMTP (default=25)
  p_smtp_domain   varchar2,  -- SMTP domain, �-�: company.com.ua
  p_from_addr     varchar2,  -- ����� ����������� e-mail
  p_from_name     varchar2,  -- ��� ����������� e-mail
  p_to_addr       varchar2,  -- ����� ���������� e-mail
  p_to_name       varchar2,  -- ��� ���������� e-mail
  p_subject       varchar2,  -- ���� ���������
  p_body          clob       -- ���� ���������
);

/*
  ��������� TO_MAIL(...) ��� ������� ��������� �� e-mail
  (�������� SMTP)
  �� ���������� ������, � �������� ����� � ����� ���������
*/
procedure to_mail(
  p_to_addr       varchar2,  -- ����� ���������� e-mail
  p_to_name       varchar2,  -- ��� ���������� e-mail
  p_subject       varchar2,  -- ���� ���������
  p_body          clob       -- ���� ���������
);

/**
 * dump_mail_info - ���������� ���������� ��������� � ����������� ����
 */
function dump_mail_info(p_msg in bars.t_bars_mail) return varchar2;

/**
 * put_msg2queue3 - �������� ��������� � ������� �� �������� � ���������� ID ���������
 * @params p_msg - ��������� ���������
 * @params p_msgid [out] - ID ���������
 */
procedure put_msg2queue3(
  p_msg         in bars.t_bars_mail,
  p_msgid       out raw
);

/**
 * put_msg2queue2 - �������� ��������� � ������� �� �������� � ���������� ID ���������
 * @params p_name - ��� ��������� ���������� (�� 256 ��������)
 * @params p_addr - ����� ����������, �-�, serg@unity-bars.com.ua (�� 256 ��������)
 * @params p_subject - ���� ��������� (�� 256 ��������)
 * @params p_body - ���� ��������� (CLOB)
 * @params p_msgid [out] - ID ���������
 */
procedure put_msg2queue2(
  p_name     in varchar2,
  p_addr     in varchar2,
  p_subject  in varchar2,
  p_body     in clob,
  p_msgid   out raw
);

/**
 * put_msg2queue - �������� ��������� � ������� �� ��������
 * @params p_name - ��� ��������� ���������� (�� 256 ��������)
 * @params p_addr - ����� ����������, �-�, serg@unity-bars.com.ua (�� 256 ��������)
 * @params p_subject - ���� ��������� (�� 256 ��������)
 * @params p_body - ���� ��������� (CLOB)
 */
procedure put_msg2queue(
  p_name     in varchar2,
  p_addr     in varchar2,
  p_subject  in varchar2,
  p_body     in clob
);

/**
 * proc_mail_queue - �������� ��������� �� �������
 */
procedure proc_mail_queue;

end; -- package bars_mail
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_MAIL is
/*
  Package BARS_MAIL - ����� ��������(����) ��� ������ � SMTP,
  �������� ����� � ��.
*/

g_body_version  constant varchar2(64)  := 'version 2.6 09/03/2017';

g_awk_body_defs constant varchar2(512) := '';

GC_SMTP_AUTH_NONE   constant varchar2(4) := 'NONE';     -- �������������� �����������
GC_SMTP_AUTH_LOGIN  constant varchar2(5) := 'LOGIN';    -- �������������� � ������� ������ � ������

-- �������������� ������ ��������(���������)
GC_CHARSET_UTF_8            constant varchar2(30) := 'utf-8';
GC_CHARSET_WINDOWS_1251     constant varchar2(30) := 'windows-1251';
GC_MODULE        constant varchar2(50) := 'MLL';

g_smtp_host     varchar2(50);  -- ����� ������� SMTP, �-�: mail.company.com.ua
g_smtp_port     number;          -- ���� ������� SMTP (default=25)
g_smtp_domain   varchar2(50);  -- SMTP domain, �-�: company.com.ua
g_from_addr     varchar2(50);  -- ����� ����������� e-mail
g_from_name     varchar2(50);  -- ��� ����������� e-mail
g_smtp_auth     varchar2(50);  -- ����� �������������� ��� ����. � SMTP-�������: NONE, LOGIN
g_smtp_user     varchar2(50);  -- ��� ������������ SMTP-�������
g_smtp_pswd     varchar2(50);  -- ������ ������������ SMTP-�������


-- ���������� ���������� �� ���������� ��������� � �������
MQ_EMPTY_OR_TIMEOUT_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(MQ_EMPTY_OR_TIMEOUT_EXCEPTION, -25228);

DEQUE_DISABLED exception;
pragma exception_init(DEQUE_DISABLED, -25226);
/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2 is
begin
  return 'Package header BARS_MAIL '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
end header_version;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2 is
begin
  return 'Package body BARS_MAIL '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
end body_version;

----
-- to_base64 - ����������� ������ � base64 ���
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
-- to_quoted_printable - ����������� ������ � quoted_printable ���
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
-- open_connection - ��������� ���������� � SMTP-��������
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
-- close_connection - ��������� ����������
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
-- �������� ���������� ���������
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
  -- ������������ ��������
  if l_charset not in (GC_CHARSET_UTF_8, GC_CHARSET_WINDOWS_1251)
  then
    raise_application_error(-20000, '���������������� ���������: '||l_charset);
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
  -- ��������� ������ ������� �����������
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
  -- ����� �� ����, ����, ���
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
  ��������� SEND_MAIL(...) ��� ������� ��������� �� e-mail
  (�������� SMTP)
*/
procedure send_mail(
  p_smtp_host     varchar2,  -- ����� ������� SMTP, �-�: mail.company.com.ua
  p_smtp_port     number,    -- ���� ������� SMTP (default=25)
  p_smtp_domain   varchar2,  -- SMTP domain, �-�: company.com.ua
  p_from_addr     varchar2,  -- ����� ����������� e-mail
  p_from_name     varchar2,  -- ��� ����������� e-mail
  p_to_addr       varchar2,  -- ����� ���������� e-mail
  p_to_name       varchar2,  -- ��� ���������� e-mail
  p_subject       varchar2,  -- ���� ���������
  p_body          clob       -- ���� ���������
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
  ��������� TO_MAIL(...) ��� ������� ��������� �� e-mail
  (�������� SMTP)
  �� ���������� ������, � �������� ����� � ����� ���������
*/
procedure to_mail(
  p_to_addr       varchar2,  -- ����� ���������� e-mail
  p_to_name       varchar2,  -- ��� ���������� e-mail
  p_subject       varchar2,  -- ���� ���������
  p_body          clob       -- ���� ���������
) is
begin
  -- �������� e-mail
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
  -- ���������� ��������� �� params
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
        erm := '5 - ������������ �������� ��������� SMTPAUTH: '||g_smtp_auth;
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
 * put_msg2queue3 - �������� ��������� � ������� �� �������� � ���������� ID ���������
 * @params p_msg - ��������� ���������
 * @params p_msgid [out] - ID ���������
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
  bars_audit.trace('BARS_MAIL: ��������� �������� � �������, ID='||rawtohex(p_msgid)
                  ||chr(10)||dump_mail_info(p_msg));
end put_msg2queue3;


/**
 * put_msg2queue2 - �������� ��������� � ������� �� �������� � ���������� ID ���������
 * @params p_name - ��� ��������� ���������� (�� 256 ��������)
 * @params p_addr - ����� ����������, �-�, serg@unity-bars.com.ua (�� 256 ��������)
 * @params p_subject - ���� ��������� (�� 256 ��������)
 * @params p_body - ���� ��������� (CLOB)
 * @params p_msgid [out] - ID ���������
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
 * put_msg2queue - �������� ��������� � ������� �� ��������
 * @params p_name - ��� ��������� ���������� (�� 256 ��������)
 * @params p_addr - ����� ����������, �-�, serg@unity-bars.com.ua (�� 256 ��������)
 * @params p_subject - ���� ��������� (�� 256 ��������)
 * @params p_body - ���� ��������� (CLOB)
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
 * dump_mail_info - ���������� ���������� ��������� � ����������� ����
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
    '��� ����������   : '||p_msg.name||chr(10)||
    '����� ���������� : '||p_msg.addr||chr(10)||
    '���� ���������   : '||p_msg.subject||chr(10)||
    '���� ���������   : '||chr(10)||
    dbms_lob.substr(p_msg.body,1000)||
    case
        when dbms_lob.getlength(p_msg.body)>1000 then
             chr(10)||'...'
        else ''
    end;
end dump_mail_info;

/**
 * proc_mail_queue - �������� ��������� �� �������
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

  bars_audit.trace(l_trace||'������ ��������� ������� e-mail ���������');
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

       bars_audit.trace(l_trace||'�� ������� ������ ���������, ID='||rawtohex(l_msgid)              ||chr(10)||dump_mail_info(l_msg));
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
        logger.trace('BARS_MAIL: �������� ���������, ID='||rawtohex(l_msgid)
                        ||chr(10)||dump_mail_info(l_msg));
      exception when others then
        bars_audit.trace(l_trace||'������ ��� ������� ��������� ID='||rawtohex(l_msgid)||' �� ������ '
            ||l_msg.name||' '||l_msg.addr||chr(10)||
            substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(),1,1900));
      end;
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
      logger.trace('BARS_MAIL: ������� �� �������� ������ ���������');
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
    logger.trace('BARS_MAIL: ��������� ��������� ������� e-mail ���������');
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
 