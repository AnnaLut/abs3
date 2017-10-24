
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_firewall.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_FIREWALL is
/**
	����� bars_firewall ��������� ������ ����������� �������
	������������� � ���
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 22/06/2006';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2;

/**
 * restrict_access - ��������� �������� ������������ �������� ����������
 */
procedure restrict_access;

/**
 * restrict_by_module - ��������� �������� ����� ������ ���������� ������� ������
 */
procedure restrict_by_module(p_job in number);


end bars_firewall;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_FIREWALL is
/**
	����� bars_firewall ��������� ������ ����������� �������
	������������� � ���
*/

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.1 19/04/2007';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

G_CON_REJECT constant integer := 0;
G_CON_ACCEPT constant integer := 1;

-- ID ������������ �� STAFF
g_uid			staff.id%type;

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2 is
begin
  return 'Package header BARS_FIREWALL '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2 is
begin
  return 'Package body BARS_FIREWALL '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

/**
 * find_abs_user_id - ������� staff.id ������������ ��� ���������� null
 */
function find_abs_user_id return staff.id%type is
  l_uid  staff.id%type;
begin
  begin
    select id into l_uid from staff where logname=ora_login_user;
  exception when no_data_found then
    l_uid := null;
  end;
  return l_uid;
end find_abs_user_id;

/**
 * restrict_by_module - ��������� �������� �� ip-������ �������� ����������
 */
procedure restrict_by_ip_address is
  ern CONSTANT POSITIVE := 1;
  erm VARCHAR2(256);
  err EXCEPTION;
  mask_ip_address	firewall_user_ip_address.ip_address%type;
  user_ip_address	firewall_user_ip_address.ip_address%type;
begin
  user_ip_address := sys_context('userenv','ip_address');
  -- �������� �� ���� �������� ������� ������������
  for c in (select usrid,ord,ip_address,action from firewall_user_ip_address where usrid in (g_uid,-1)
  order by usrid desc, ord asc)
  loop
	mask_ip_address := replace(replace(c.ip_address,'*','%'),'?','_');
	if user_ip_address like mask_ip_address then
	  if c.action=G_CON_REJECT then
	    bars_audit.error('���������������� ������! ������������ '||ora_login_user||' (staff.id='||g_uid||').'
	    ||' IP ����� '''||user_ip_address||'''.'
	    ||chr(13)||chr(10)||'���������� ���������� �������� (usrid,ord)=('||c.usrid||','||c.ord||') � ������ ������ '''
	    ||c.ip_address||'''.');
	    erm := '9532 - � �''������ ���������. ��������� �� ������������ ���.';
	    raise err;
	  elsif c.action=G_CON_ACCEPT then
	    bars_audit.info('������������ '||ora_login_user||' (staff.id='||g_uid||').'
	    ||' IP ����� '''||user_ip_address||'''.'
	    ||chr(13)||chr(10)||'���������� ������� �� ������� (usrid,ord)=('||c.usrid||','||c.ord||') � ������ ������ '''
	    ||c.ip_address||'''.');
	    return;
	  end if;
	end if;
  end loop;
  -- ����� ���� => ��� ����� �� ������������� �� ������ ������� => �������� � ����������
  bars_audit.error('���������������� ������! ������������ '||ora_login_user||' (staff.id='||g_uid||').'
  ||' IP ����� '''||user_ip_address||'''.'
  ||chr(13)||chr(10)||'���������� �� ������������� �������� �����������.');
  erm := '9532 - � �''������ ���������. ��������� �� ������������ ���.';
  raise err;
exception when err then
  raise_application_error(-(20000+ern),'\'||erm,TRUE);
end restrict_by_ip_address;

/**
 * restrict_by_module - ��������� �������� ����� ������ ���������� ������� ������
 */
procedure restrict_by_module(p_job in number)
 is
  ern CONSTANT POSITIVE := 2;
  erm VARCHAR2(256);
  err EXCEPTION;
  mask_module		firewall_user_module.module%type;
  user_module		firewall_user_module.module%type;

  l_sid		 number;
  l_serial	 number;
  l_uid      number;
  l_username varchar2(30);

  l_timeout			number;  -- timeout in seconds
  l_start_date		date;
  l_must_kill   	boolean;
  l_module_filled   boolean;
  l_stmt			varchar2(128);
begin
  bars_context.set_context;
  -- ������ ��������� �������
  begin
    select sid,serial#,u_id,username into l_sid,l_serial,l_uid,l_username
    from firewall_job_module_params where job=p_job;
    delete from firewall_job_module_params where job=p_job;
  exception when no_data_found then
	bars_audit.error('��������� ������� #'||p_job||'(bars_firewall.restrict_by_module) �� �������.');
	return;
  end;
  -- �������� ����� �������� ������ ����� ������ �����������
  begin
    select to_number(val) into l_timeout from params
    where par='AUTHTIME';
  exception when no_data_found then
    l_timeout := 3;
  end;
  -- ���� ����� ������
  l_start_date    := SYSDATE;
  l_module_filled := FALSE;
  while ((SYSDATE-l_start_date)*86400<l_timeout) and not l_module_filled
  loop
    begin
      select module into user_module from v$session
      where sid=l_sid and serial#=l_serial and username=l_username;
    exception when no_data_found then
      -- ������� ������ ��� �� ���������� ==> ��������������� � �������� ������
	  bars_audit.error('������ ������������ '||l_username||' (sid,serial)=('
	  ||l_sid||','||l_serial||') �� �������.'
	  );
	  return;
    end;
    if user_module is not null then
      l_module_filled := TRUE;
    else
      dbms_lock.sleep(1);
    end if;
  end loop;
  -- ��������� �������
  l_must_kill := FALSE;
  begin
	  -- �������� �� ���� �������� ������� ������������
	  for c in (select usrid,ord,module,action from firewall_user_module where usrid in (l_uid,-1)
	  order by usrid desc, ord asc)
	  loop
		mask_module := replace(replace(c.module,'*','%'),'?','_');
		if (user_module like mask_module) or (user_module is null and mask_module='%') then
		  if c.action=G_CON_REJECT then
			bars_audit.error('���������������� ������! ������������ '||l_username||' (staff.id='||l_uid||').'
			||' ������ '''||user_module||'''.'
			||chr(13)||chr(10)||'���������� ���������� �������� (usrid,ord)=('||c.usrid||','||c.ord||') � ������ ������ '''
			||c.module||'''.');
			raise err;
		  elsif c.action=G_CON_ACCEPT then
			bars_audit.info('������������ '||l_username||' (staff.id='||l_uid||').'
			||' ������ '''||user_module||'''.'
			||chr(13)||chr(10)||'���������� ������� �� ������� (usrid,ord)=('||c.usrid||','||c.ord||') � ������ ������ '''
			||c.module||'''.');
			return;
		  end if;
		end if;
	  end loop;
	  -- ����� ���� => ��� ����� �� ������������� �� ������ ������� => �������� � ����������
	  bars_audit.error('���������������� ������! ������������ '||l_username||' (staff.id='||l_uid||').'
	  ||' ������ '''||user_module||'''.'
	  ||chr(13)||chr(10)||'���������� �� ������������� �������� �����������.');
	  raise err;
  exception when err then
	  l_must_kill := TRUE;
  end;
  -- ������� ����������, ���� ����
  if l_must_kill then
     l_stmt := 'ALTER SYSTEM KILL SESSION '''||l_sid||','||l_serial||'''';
	 execute immediate(l_stmt);
  end if;

end restrict_by_module;

procedure submit_job_restrict_by_module is
  l_sid  	   number;
  l_serial 	   number;
  l_username   varchar2(30);
  l_job		   BINARY_INTEGER;
  l_what       VARCHAR2(32767);
begin
  -- getting all necessary information about this session
  select sid,serial#,username into l_sid,l_serial,l_username
  from v$session where sid=(select sid from v$mystat where rownum=1);
  -- construction the body of job
  l_what := 'bars.bars_firewall.restrict_by_module(job);';
  -- create the job
  sys.dbms_job.submit(job => l_job, what => l_what, next_date => SYSDATE);
  -- mandatory update! otherwise we have infinite recursion looping
  --update sys.job$ set lowner='BARS' where job=l_job;
  -- store parameters for this job
  insert into firewall_job_module_params(job,sid,serial#,u_id,username)
  values(l_job,l_sid,l_serial,g_uid,l_username);
end submit_job_restrict_by_module;

/**
 * restrict_access - ��������� �������� ������������ �������� ����������
 */
procedure restrict_access is
begin
  g_uid := find_abs_user_id;
  if g_uid is null then
    -- ������������ �� ORACLE, �� ���������� �������������� ���, �� ��������������
    return;
  end if;
  -- ������� ������� �� IP-������
  restrict_by_ip_address;
  -- ������� ������� �� ����� ������ ����������
  submit_job_restrict_by_module;
end restrict_access;

begin
  null;
end;
/
 show err;
 
PROMPT *** Create  grants  BARS_FIREWALL ***
grant EXECUTE                                                                on BARS_FIREWALL   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_firewall.sql =========*** End *
 PROMPT ===================================================================================== 
 