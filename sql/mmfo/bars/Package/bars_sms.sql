
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SMS 
is
----
--  Package BARS_SMS - ����� �������� ��� �������� SMS
--
--  SERG, 31/08/2010

--  ����������� ���������� �������� SMS:
/*

    BARS_SMS                -->  ����� - ������� ��������� ��� ���������� �������
      |
      |
    SMS_PROVIDER            -->  ��������� ��� ����������� ���������� ����� �� �������� SMS
      |
      |
    SMS_PROVIDER_<NAME>     -->  ��������� ��� ���������� ����� �� �������� SMS � ������ <NAME>,
      |                          ����������� �� SMS_PROVIDER � �������� ��������� ��� BARS_SMS_<NAME>
      |
    BARS_SMS_<NAME>         -->  ����� - ���������� ������������� ������ ��� ���������� <NAME>

*/

g_header_version  constant varchar2(64)  := 'version 2.12  12/07/2018';

g_awk_header_defs constant varchar2(512) := '';

----
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2;

----
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2;

--
-- ������� ��������� ��� ������� SMS
--
procedure CREATE_MSG
( p_msgid             in out  msg_submit_data.msg_id%type
, p_creation_time     in      msg_submit_data.creation_time%type
, p_expiration_time   in      msg_submit_data.expiration_time%type
, p_phone             in      msg_submit_data.phone%type
, p_encode            in      msg_submit_data.encode%type
, p_msg_text          in      msg_submit_data.msg_text%type
, p_rnk               in      msg_submit_data.rnk%type
, p_kf                in      msg_submit_data.kf%type  default bars_context.current_mfo()
);

--
--
--
procedure CREATE_MSG
( p_phone             in      msg_submit_data.phone%type
, p_msg_text          in      msg_submit_data.msg_text%type
, p_rnk               in      msg_submit_data.rnk%type
, p_encode            in      msg_submit_data.encode%type default 'lat'
);

----
-- submit_msg - ��������� ������� ���������
--
procedure submit_msg(p_msgid in msg_submit_data.msg_id%type);

----
-- submit_messages - ��������� ������� ���������
--
procedure submit_messages;

procedure submit_messages(p_start_id in number, p_end_id in number);
----
-- query_status - ��������� �������� �������
--
procedure query_status(p_smsid in sms_query_data.sms_id%type);

----
-- query_statuses - ��������� �������� ������� �� ���� SMS, ��������� ����� ��������
--
procedure query_statuses;

end bars_sms;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SMS 
is
----
--  Package BARS_SMS - ����� �������� ��� �������� SMS
--
--  SERG, 31/08/2010

--  ����������� ���������� �������� SMS:
/*

    BARS_SMS                -->  ����� - ������� ��������� ��� ���������� �������
      |
      |
    SMS_PROVIDER            -->  ��������� ��� ����������� ���������� ����� �� �������� SMS
      |
      |
    SMS_PROVIDER_<NAME>     -->  ��������� ��� ���������� ����� �� �������� SMS � ������ <NAME>,
      |                          ����������� �� SMS_PROVIDER � �������� ��������� ��� BARS_SMS_<NAME>
      |
    BARS_SMS_<NAME>         -->  ����� - ���������� ������������� ������ ��� ���������� <NAME>

*/

g_body_version  constant varchar2(64)  := 'version 2.23  09/11/2018';

g_awk_body_defs constant varchar2(512) := '';

G_SMS_PROV varchar2(30);                                   -- ��� ���������� ���� SMS-����������

g_sms_provider    sms_provider;    -- ��������� ���������� ���� SMS-����������

g_sms_start number;
g_sms_stop  number;
----
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2
is
begin
  return 'Package header BARS_SMS '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
end header_version;

----
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2
is
begin
  return 'Package body BARS_SMS '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
end body_version;

----
-- init - ������������� ������
--
procedure init
is
begin
    --
    -- ������� ��� ���������� ���� SMS-����������
    --
    select val
      into G_SMS_PROV
      from params$base
     where par='SMS_PROV';
    --
    -- ������������ ������
    --
    execute immediate 'begin :g_sms_provider := new '||G_SMS_PROV||'(); end;'
      using out g_sms_provider;
    --
    begin
      g_sms_start := nvl(to_number(getglobaloption('SMS_SEND_START')),800);
    exception
      when others then
        logger.info('BARS_SMS: ������� ��������� �������� ��� ��������� SMS_SEND_START: '||sqlerrm);
        g_sms_start := 800;
    end;
    begin
      g_sms_stop := nvl(to_number(getglobaloption('SMS_SEND_STOP')),2100);
    exception
      when others then
        logger.info('BARS_SMS: ������� ��������� �������� ��� ��������� SMS_SEND_STOP: '||sqlerrm);
        g_sms_stop := 2100;
    end;
      
end init;

--
-- ������� ��������� ��� ������� SMS
--
procedure CREATE_MSG
( p_msgid             in out  msg_submit_data.msg_id%type
, p_creation_time     in      msg_submit_data.creation_time%type
, p_expiration_time   in      msg_submit_data.expiration_time%type
, p_phone             in      msg_submit_data.phone%type
, p_encode            in      msg_submit_data.encode%type
, p_msg_text          in      msg_submit_data.msg_text%type
, p_rnk               in      msg_submit_data.rnk%type
, p_kf                in      msg_submit_data.kf%type default bars_context.current_mfo()
) is
begin
    if p_msgid is null
    then
      select s_msgid.nextval
        into p_msgid
        from dual;
    end if;
    --
    insert
      into MSG_SUBMIT_DATA ( MSG_ID, CREATION_TIME, EXPIRATION_TIME, PHONE, ENCODE, MSG_TEXT, KF, RNK )
    values ( p_msgid, p_creation_time, p_expiration_time, p_phone, p_encode, p_msg_text, p_kf, p_rnk );
    --
end CREATE_MSG;

--
--
--
procedure CREATE_MSG
( p_phone             in      msg_submit_data.phone%type
, p_msg_text          in      msg_submit_data.msg_text%type
, p_rnk               in      msg_submit_data.rnk%type
, p_encode            in      msg_submit_data.encode%type default 'lat'
) is
  l_msgid                     msg_submit_data.msg_id%type;
  l_crt_tm                    msg_submit_data.creation_time%type;
  l_exp_tm                    msg_submit_data.expiration_time%type;
begin

  l_crt_tm := sysdate;
  l_exp_tm := l_crt_tm + 1;

  CREATE_MSG
  ( p_msgid           => l_msgid
  , p_creation_time   => l_crt_tm
  , p_expiration_time => l_exp_tm
  , p_phone           => p_phone
  , p_encode          => p_encode
  , p_msg_text        => p_msg_text
  , p_rnk             => p_rnk
  , p_kf              => sys_context('bars_context','user_mfo')
  );

  bars_audit.trace( 'BARS_SMS.CREATE_MSG: created message #'||to_char(l_msgid) );

end CREATE_MSG;

----
-- submit_msg - ��������� ������� ���������
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
-- submit_messages - ��������� ������� ���������
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
           where to_number(to_char(sysdate, 'HH24MI')) between g_sms_start and g_sms_stop);

  if (l_cnt < 100 and l_useparallelexec = 1) or (l_useparallelexec = 0) then
    for c in (select msg_id
                from msg_submit_data
               where status in ('NEW', 'ERROR')
                 and exists
               (select 1
                        from dual
                       where to_number(to_char(sysdate, 'HH24MI')) between g_sms_start and g_sms_stop)
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

--
--
--
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
                    to_number(to_char(sysdate,'HH24MI')) between g_sms_start and g_sms_stop
               )
               and msg_id between p_start_id and p_end_id
               order by msg_id for update skip locked)
    loop
        submit_msg(c.msg_id);
    end loop;
    logger.trace('bars_sms.submit_messages: finish. #p_start_id ='||p_start_id||' p_end_id ='||p_end_id);   
end;

----
-- query_status - ��������� �������� �������
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
-- query_statuses - ��������� �������� ������� �� ���� SMS, ��������� ����� ��������
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
 