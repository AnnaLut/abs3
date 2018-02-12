prompt create package BARS_LOGIN 
  CREATE OR REPLACE PACKAGE BARS.BARS_LOGIN 
is

/**
 *
 * ����� BARS_LOGIN �������� ���������, ����������� �����
 * ����� ������������ � �������
 *
 **/

/**
    ������� ��� ������:
    --
    �����       - �������� ������������� (������-���)
 */

    VERSION_HEADER       constant varchar2(64)  := 'version 1.31 21.03.2017';
    VERSION_HEADER_DEFS  constant varchar2(512) := ''
                    ;

    -----------------------------------------------------------------
    -- ���� ������
    --
    --
    --
    subtype t_sess_clientid is varchar2(64);




    -----------------------------------------------------------------
    -- LOGIN_USER()
    --
    --     ��������� ����� ������������ � ��������
    --
    --
    procedure login_user(
                  p_sessionid  in  varchar2,
                  p_userid     in  number,
                  p_hostname   in  varchar2,
                  p_appname    in  varchar2 );


    procedure login_user(
        p_session_id in varchar2,
        p_login_name in varchar2,
        p_authentication_mode in varchar2,
        p_host_name in varchar2,
        p_application_name in varchar2);

    -----------------------------------------------------------------
    -- LOGOUT_USER()
    --
    --     ��������� ������ ������������ �� ���������
    --
    --
    procedure logout_user;


    -----------------------------------------------------------------
    -- SET_USER_SESSION()
    --
    --     ��������� ������������� ���������������� ������
    --
    --
    procedure set_user_session(
                  p_sessionid  in  varchar2 );


    -----------------------------------------------------------------
    -- SET_USER_BANKDATE()
    --
    --     ��������� ���������� ���� ������������
    --
    --
    procedure set_user_bankdate(
                  p_bankdate  in  date );


    -----------------------------------------------------------------
    -- CHANGE_USER_APPSCHEMA()
    --
    --    ����� ������� ����� ���������������� ������
    --
    --
    procedure change_user_appschema(
                  p_appschema varchar2 );


    procedure start_temporary_session(
        p_user_id in integer);

    -----------------------------------------------------------------
    -- GET_SESSION_CLIENTID()
    --
    --    ��������� ��. �������������� ������� ������
    --
    --
    function get_session_clientid return t_sess_clientid;


    -----------------------------------------------------------------
    -- CLEAR_EXPIRED_SESSION()
    --
    --    ������� ������ ��� �������� ������
    --
    --
    procedure clear_expired_session;


    procedure set_ldap_user(
        p_login_name in varchar2,
        p_password in varchar2);

    function prepare_ad_user(
        p_login_name in varchar2)
    return integer;

    procedure clear_session(
        p_client_id varchar2,
        p_kill_session in integer default 1);

    procedure set_exclusive_mode;

    procedure release_exclusive_mode;

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ��������� ������ ��������� ������
    --
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ��������� ������ ���� ������
    --
    --
    function body_version return varchar2;

    -----------------------------------------------------------------
    -- RESTORE_SESSION()
    --
    --    ��������������� �������� ����������� �������������� ������
    --    �� ���������� ���������
    --    ������������ ��� ���������� ������ ����� ����������� �� dblink
    --
    procedure restore_session;

/*
    -----------------------------------------------------------------
    -- SET_USER_LASTCALL_DEBUG()
    --
    --     ��������� ����/������� ���������� ��������� ������������
    --
    --
    procedure set_user_lastcall_debug(p_date date);
*/

    procedure set_long_session(p_expires date default sysdate + 1);
    procedure cleare_long_session;
    function is_long_session return boolean;
end bars_login;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_LOGIN 
is

/**
 *
 * ����� BARS_LOGIN �������� ���������, ����������� �����
 * ����� ������������ � �������
 *
 **/

/**
    ������� ��� ������:
    --
    WEB       - �������� ������������� (������-���)
    WEB       - ��� (������-���)
 */

    VERSION_BODY       constant varchar2(64)  := 'version 1.20 21.03.2017';
    VERSION_BODY_DEFS  constant varchar2(512) := ''
                    || 'WEB      - ���������� BARSWEB'                  || chr(10)
                    ;


    LOCAL_CTX           constant varchar2(30) := 'bars_local';
    GLOBAL_CTX          constant varchar2(30) := 'bars_global';
    CONTEXT_CTX         constant varchar2(30) := 'bars_context';

    CTXPAR_USERID       constant varchar2(30) := 'user_id';
    CTXPAR_USERNAME     constant varchar2(30) := 'user_name';
    CTXPAR_APPSCHEMA    constant varchar2(30) := 'user_appschema';
    CTXPAR_USERSTMT     constant varchar2(30) := 'user_login_stmt';
    CTXPAR_APPNAME      constant varchar2(30) := 'application_name';
    CTXPAR_HOSTNAME     constant varchar2(30) := 'host_name';
    CTXPAR_LASTCALL     constant varchar2(30) := 'last_call';
    CTXPAR_SESSIONID    constant varchar2(30) := 'session_id';
    CTXPAR_USERBANKDATE constant varchar2(30) := 'user_bankdate';

    CTXPAR_GLOBALDATE   constant varchar2(30) := 'global_bankdate';

    USER_LOGINSTMT_EXEC constant number       := 1;

    CLIID_PREFIX        constant varchar2(4)  := 'BRS-';

    MAX_HOSTNAME_LEN    constant number       := 64;
    MAX_CLIENTID_LEN    constant number       := 64;
    MAX_SESSION_TIMEOUT constant number       := 60;  -- � �������

    -- ��������� ��� ������
    ERR_DUP_SESSION     constant number       := -20980;
    ERR_SESSION_NULL    constant number       := -20981;
    ERR_SESSION_EMPTY   constant number       := -20982;
    ERR_USER_NOTFOUND   constant number       := -20983;
    ERR_BANKDATE_CLOSED constant number       := -20984;
    ERR_USER_NOTALLOWED constant number       := -20985;
    ERR_INVALID_SCHEMA  constant number       := -20986;
    ERR_USER_IS_CLOSED  constant number       := -20987;

    DATETIME_FORMAT     constant varchar2(30) := 'dd.mm.yyyy hh24:mi:ss';
    DATE_FORMAT         constant varchar2(30) := 'mm/dd/yyyy';

    -----------------------------------------------------------------
    -- ���������� ����������
    g_clientid   varchar2(64);   -- ���������� ������������� ��� ������ ������

    -----------------------------------------------------------------
    -- RAISE_INTERNAL_ERROR()
    --
    --     ��������� ������ ��������� �� ������ � ������, �����
    --     ��� ���������� ��������� � ������ bars_error
    --
    procedure raise_internal_error(
                  p_errcode in number )
    is
    --
    l_errtext  varchar2(2048);
    --
    begin

        l_errtext := (case
                          when (p_errcode = ERR_DUP_SESSION)     then 'Duplicate session registration'
                          when (p_errcode = ERR_SESSION_NULL)    then 'Session identifier is null'
                          when (p_errcode = ERR_SESSION_EMPTY)   then 'Session is not initialized'
                          when (p_errcode = ERR_USER_NOTFOUND)   then 'User not found'
                          when (p_errcode = ERR_BANKDATE_CLOSED) then 'Bankdate is closed'
                          when (p_errcode = ERR_USER_NOTALLOWED) then 'Schema change for this user not allowed'
                          when (p_errcode = ERR_INVALID_SCHEMA)  then 'Invalid application schema'
                          when (p_errcode = ERR_BANKDATE_CLOSED) then 'Bankdate is closed'
                          when (p_errcode = ERR_USER_IS_CLOSED)  then 'User is closed'
                          else 'Unhandled application error'
                      end);

        raise_application_error(p_errcode, l_errtext, true);

    end raise_internal_error;

    -----------------------------------------------------------------
    -- ADD_USER_SESSION()
    --
    --     ��������� ����������� ������ � ������� �������� ������
    --
    --
    procedure add_user_session(
        p_clientid  in varchar2,
        p_userid    in number,
        p_proxyuser in varchar2,
        p_program   in varchar2 default null,
        p_host      in varchar2 default null)
    is
    pragma autonomous_transaction;
    begin
        -- ������ ����� ������������ � ���
        insert into staff_user_session
        values (s_staff_user_session.nextval, p_clientid, p_userid, p_host, p_program, sysdate, null);

        -- ��������� ������� ���
        insert into user_login_sessions
        values (p_clientid, p_userid, p_proxyuser);

        commit;
    end add_user_session;


    -----------------------------------------------------------------
    -- DROP_USER_SESSION()
    --
    --     ��������� �������� ������ �� ������ �������� ������
    --
    --
    procedure drop_user_session(
        p_clientid in varchar2)
    is
    pragma autonomous_transaction;
    begin
        -- �������� ����� ����������� � ���
        update staff_user_session
        set    logout_time = sysdate
        where  client_identifier = p_clientid;

        -- ��������� � �������� ����
        delete user_login_sessions
        where  client_id = p_clientid;

        commit;
    end drop_user_session;





    -----------------------------------------------------------------
    -- EXEC_SESSION_LOGINSTMT()
    --
    --     ���������� ����� ������������� ������ ������������
    --
    --
    procedure exec_session_loginstmt(
                  p_loginstmt  in  varchar2 )
    is
    begin
        if (p_loginstmt is not null) then execute immediate p_loginstmt;
        end if;
    end exec_session_loginstmt;


    -----------------------------------------------------------------
    -- GET_USER_CLIENTID()
    --
    --     ������� ��������� ����������� �����. �� ������������
    --
    --
    function get_user_clientid(
                  p_sessionid in  varchar2 ) return varchar2
    is
    begin
        return CLIID_PREFIX || p_sessionid;
    end get_user_clientid;


    -----------------------------------------------------------------
    -- SET_USER_CLIENTID()
    --
    --     ��������� ��������� ����������� ��������������
    --
    --
    procedure set_user_clientid(
                  p_clientid  in  varchar2 )
    is
    begin
$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.set_user_clientid(p_clientid=>'||nvl(p_clientid,'null')||'), '||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')
        );
$end

        if (p_clientid is not null) then
            sys.dbms_session.set_identifier(p_clientid);
        end if;
    end set_user_clientid;


    -----------------------------------------------------------------
    -- SET_USER_APPSCHEMA()
    --
    --     ��������� ��������� ����� ���������� ��� ������������
    --
    --
    procedure set_user_appschema(
                  p_appschema  in  varchar2 )
    is
    begin
        if (p_appschema is not null) then
            execute immediate 'alter session set current_schema = ' || p_appschema;
        end if;
    end set_user_appschema;


    -----------------------------------------------------------------
    -- SET_USER_LASTCALL()
    --
    --     ��������� ����/������� ���������� ��������� ������������
    --
    --
    procedure set_user_lastcall(
        p_client_identifier in varchar2 default null)
    is
    begin
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_LASTCALL, to_char(sysdate, DATETIME_FORMAT), client_id => nvl(p_client_identifier, g_clientid));
    end set_user_lastcall;

    -----------------------------------------------------------------
    -- INIT_USER_CONTEXT()
    --
    --     ������������� ����������������� ���������
    --
    --
    procedure init_user_context
    is
    begin

        bars_context.set_context;

        -- ��������� ����������� ����������� ���
        if (web_utl.is_bankdate_open = 0) then
                bars_context.clear_session_context;
                raise_internal_error(ERR_BANKDATE_CLOSED);
        end if;

    end init_user_context;




    -----------------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT()
    --
    --    ������� ���������� ���������� ������� ������
    --
    --
    procedure clear_session_context
    is
    begin
$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.clear_session_context() invoked, client_id='||sys_context('userenv','client_identifier'));
$end

        -- �������� �� ���� ���������� ����������
        for c in (select package
                    from dba_context
                   where schema     = 'BARS'
                     and type       = 'ACCESSED GLOBALLY'
                     and namespace != 'BARS_GLOBAL'      )
        loop
            begin
                execute immediate 'begin ' || c.package || '.clear_session_context; end;';
            exception
                when OTHERS then null;
            end;
        end loop;

        -- ��������� ������� ������ ���������
        sys.dbms_session.clear_context(GLOBAL_CTX, client_id=> get_session_clientid);
    end clear_session_context;



    procedure start_temporary_session(
        p_user_id in integer)
    is
        l_user_row staff$base%rowtype;
        l_client_identifier varchar2(64 char);
    begin
        l_user_row := user_utl.read_user(p_user_id);

        if (l_user_row.active = 0) then
            raise_internal_error(ERR_USER_IS_CLOSED);
        end if;

        l_client_identifier := get_user_clientid(sys_guid());
        set_user_clientid(l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERID, to_char(l_user_row.id), client_id => l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERNAME, l_user_row.logname, client_id => l_client_identifier);
        bars_context.set_context;
    end;

    -----------------------------------------------------------------
    -- SET_USER_SESSION()
    --
    --     ��������� ������������� ���������������� ������
    --
    --
    procedure set_user_session(
                  p_sessionid  in  varchar2 )
    is
    begin

        -- ��������� ���������� ��. ������
        if (p_sessionid is null) then raise_internal_error(ERR_SESSION_NULL);
        end if;

        -- ����� p_sessionid � ��������� ��������,
        -- ����� ������� ����� ������ ��������� �������
        sys.dbms_session.set_context(LOCAL_CTX, CTXPAR_SESSIONID, p_sessionid);

        -- �������� ������. �������������
        g_clientid := get_user_clientid(p_sessionid);

        -- ������������� ��. �������������
        set_user_clientid(g_clientid);

        -- ���� �����. ������ ��������� ����� login_user
        if (sys_context(GLOBAL_CTX, CTXPAR_USERID) is not null) then

            -- ���� ��� ������� ���������� ���������, �� ��������� �����������������
            if (sys_context(CONTEXT_CTX, CTXPAR_LASTCALL) is null) then

                -- ������������ �������� ������������
                init_user_context;

            end if;

            -- ���������� ����� ������������� ������������
            exec_session_loginstmt(sys_context(GLOBAL_CTX, CTXPAR_USERSTMT));

            -- ��������� ����� ������������
            set_user_appschema(sys_context(GLOBAL_CTX, CTXPAR_APPSCHEMA));

            -- ��������� ����� ����������
            dbms_application_info.set_client_info(sys_context(GLOBAL_CTX, CTXPAR_APPNAME));

            -- ��������� ���� ���������� ���������
            set_user_lastcall;

            -- ������� ��������� �������
            sys.dbms_session.reset_package;

        else
            raise_internal_error(ERR_SESSION_EMPTY);
        end if;

    end set_user_session;






    -----------------------------------------------------------------
    -- LOGIN_USER()
    --
    --     ��������� ����� ������������ � ��������
    --
    --
    procedure login_user(
        p_sessionid  in  varchar2,
        p_userid     in  number,
        p_hostname   in  varchar2,
        p_appname    in  varchar2 )
    is
        l_user_row          staff$base%rowtype;

        l_hostname          varchar2(64);      -- ��� ����������� �����
        l_session_id        varchar2(32);      -- �����. ������
        l_client_identifier varchar2(64 char); -- ������������� ���������� ������
        l_exculsive_mode_flag varchar2(4000 byte);
        l_mark                integer;
    begin
$if $$trace2alert $then
        sys.dbms_system.ksdddt;
        sys.dbms_system.ksdwrt(3, 'bars_login.login_user('
            ||'p_sessionid=>'||nvl(p_sessionid,'null')||', '
            ||'p_userid=>'||nvl(to_char(p_userid),'null')||', '
            ||'p_hostname=>'||nvl(p_hostname,'null')||', '
            ||'p_appname=>'||nvl(p_appname,'null')
            ||') start, '||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')
        );
$end

        if (p_sessionid is null and p_userid is null) then -- ������ ����������
            -- �������� ��������� ������������
            l_user_row := user_utl.read_user(ora_login_user(), p_raise_ndf => false);

            if (l_user_row.id is null) then
                return;   -- ���� ������������ �� ���, �������
            end if;

            -- ��� ����� ����� �� ���������
            l_hostname := nvl(substr(nvl(p_hostname, sys_context('userenv', 'terminal')), 1, MAX_HOSTNAME_LEN), 'NOT AVAILABLE');

            -- ���������� ��. ������
            l_session_id := substr(sys_guid(), 1, 32);
        else
            -- ��������� ���������� ��. ������
            if (p_sessionid is null) then
                raise_internal_error(ERR_SESSION_NULL);
            end if;

            -- �������� ��������� ������������
            l_user_row := user_utl.read_user(p_userid);

            l_hostname  := nvl(p_hostname, 'NOT AVAILABLE');
            l_session_id := substr(p_sessionid, 1, 32);
        end if;

        l_exculsive_mode_flag := branch_attribute_utl.get_value('/', 'EXCLUSIVE_MODE');
        if (l_exculsive_mode_flag = '1') then
            select c.mark
            into   l_mark
            from   staff_class c
            where  c.clsid = l_user_row.clsid;

            if (l_mark < branch_attribute_utl.get_value('/', 'MARKDATE')) then
                raise_internal_error(ERR_BANKDATE_CLOSED);
            end if;
        end if;

        -- ��������� ��. �������������
        l_client_identifier := get_user_clientid(l_session_id);

        set_user_clientid(l_client_identifier);

        -- ������� ���������� ��������� ������� ������
        clear_session_context;

        -- ������������ ������
        add_user_session(l_client_identifier, l_user_row.id, sys_context('userenv', 'proxy_user'), nvl(p_appname, sys_context('userenv', 'module')), l_hostname);

        -- ������������� �������� � ��������
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERID      , to_char(l_user_row.id), client_id=> l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERNAME    , l_user_row.logname    , client_id=> l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_APPSCHEMA   , l_user_row.cschema    , client_id=> l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_APPNAME     , p_appname             , client_id=> l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_HOSTNAME    , l_hostname            , client_id=> l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_SESSIONID   , l_session_id          , client_id=> l_client_identifier);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERBANKDATE, null                  , client_id=> l_client_identifier);

        -- ��������� ��������� ���������� � ������
        set_user_session(l_session_id);

        --������������� ������� � ������
        sec.call_getmask;

        -- ������������� ���������� ���� ������������ ��� ����������
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERBANKDATE, sys_context(CONTEXT_CTX, CTXPAR_GLOBALDATE), client_id=> l_client_identifier);

        bars_audit.info('���������� ' || l_user_row.logname || ' ������ �� ������� - �������� �����������: ' ||
                        sys_context('bars_context', 'user_branch') || ', ��������� ����: ' || sys_context('bars_gl', 'bankdate'));

$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.login_user('
            ||'p_sessionid=>'||nvl(p_sessionid,'null')||', '
            ||'p_userid=>'||nvl(to_char(p_userid),'null')||', '
            ||'p_hostname=>'||nvl(p_hostname,'null')||', '
            ||'p_appname=>'||nvl(p_appname,'null')
            ||') finish, '||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')
        );
$end
    end login_user;

    procedure set_ldap_user(
        p_login_name in varchar2,
        p_password in varchar2)
    is
    begin
        if (p_login_name is null) then
            raise_application_error(-20000, '��''� ����������� ��� ���������� �� ������ LDAP �� ���� ���� ������');
        end if;

        if (p_password is null) then
            raise_application_error(-20000, '������ ����������� ��� ���������� �� ������ LDAP �� ���� ���� ������');
        end if;

        branch_attribute_utl.set_attribute_value('/',
                                                 'LDAP_USER',
                                                 dbms_crypto.encrypt(utl_raw.cast_to_raw(p_login_name),
                                                                     dbms_crypto.ENCRYPT_AES256 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5,
                                                                     '71C35128A5A305B8B3C72AE4A67338F8B292517E3038570A2D2B5D5060B81B93'));
        branch_attribute_utl.set_attribute_value('/',
                                                 'LDAP_USER_PASS',
                                                 dbms_crypto.encrypt(utl_raw.cast_to_raw(p_password),
                                                                     dbms_crypto.ENCRYPT_AES256 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5,
                                                                     '71C35128A5A305B8B3C72AE4A67338F8B292517E3038570A2D2B5D5060B81B93'));
    end;

    procedure ldap_dig_into_groups_hierarchy(
        p_session in dbms_ldap.session,
        p_baseDN in varchar2,
        p_group_distinguished_name in varchar2,
        p_groups_list in out nocopy string_list)
    is
        res_attrs            dbms_ldap.string_collection;
        search_filter        varchar2(32767 byte);
        res_message          dbms_ldap.message;
        l_entry              dbms_ldap.message;
        l_attribute_values   dbms_ldap.string_collection;
    begin
        res_attrs(1) := 'memberOf';
        search_filter   := '(&(distinguishedName=' || p_group_distinguished_name || ')(objectClass=group))';

        tools.hide_hint(
            dbms_ldap.search_s(
                ld       => p_session,
                base     => p_baseDN,
                scope    => dbms_ldap.SCOPE_SUBTREE,
                filter   => search_filter,
                attrs    => res_attrs,
                attronly => 0,
                res      => res_message));

        l_entry := dbms_ldap.first_entry(p_session, res_message);

        l_attribute_values := dbms_ldap.get_values(p_session, l_entry, 'memberOf');
        if (l_attribute_values.count > 0) then
            for i in l_attribute_values.first..l_attribute_values.last loop
                if (l_attribute_values(i) not member of p_groups_list) then
                    p_groups_list.extend(1);
                    p_groups_list(p_groups_list.last) := l_attribute_values(i);

                    ldap_dig_into_groups_hierarchy(p_session, p_baseDN, l_attribute_values(i), p_groups_list);
                end if;
            end loop;
        end if;
    end;

    procedure ldap_user_data(
        p_user_name in varchar2,
        p_user_display_name out varchar2,
        p_user_division out varchar2,
        p_groups_list out string_list,
        p_digital_sign_code out varchar2)
    is
        ldap_host            varchar2(512);          -- The LDAP Directory Host
        ldap_port            varchar2(512);          -- The LDAP Directory Port
        ldap_user            varchar2(512);          -- The LDAP Directory User
        ldap_passwd          varchar2(512);          -- The LDAP Directory Password
        ldap_baseDN          varchar2(512);          -- The starting (base) DN
        retval               pls_integer;            -- Used for all API return values.
        my_session           dbms_ldap.session;      -- Used to store our LDAP Session
        res_attrs            dbms_ldap.string_collection;
        search_filter        varchar2(32767 byte);
        res_message          dbms_ldap.message;
        l_entry              dbms_ldap.message;
        l_attribute_values   dbms_ldap.string_collection;

        l_login_name varchar2(32767 byte);
    begin

        dbms_ldap.use_exception := true;

        ldap_host    := branch_attribute_utl.get_attribute_value('/', 'LDAP_IP_ADDRESS', p_raise_expt => 1, p_parent_lookup => 0, p_check_exist => 1);
        ldap_port    := branch_attribute_utl.get_attribute_value('/', 'LDAP_PORT', p_raise_expt => 0, p_parent_lookup => 0, p_check_exist => 1, p_def_value => '389');
        ldap_user    := utl_raw.cast_to_varchar2(
                            dbms_crypto.decrypt(
                                branch_attribute_utl.get_attribute_value('/', 'LDAP_USER', p_raise_expt => 1, p_parent_lookup => 0, p_check_exist => 1),
                                dbms_crypto.ENCRYPT_AES256 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5,
                                '71C35128A5A305B8B3C72AE4A67338F8B292517E3038570A2D2B5D5060B81B93'));
        ldap_passwd  := utl_raw.cast_to_varchar2(
                            dbms_crypto.decrypt(
                                branch_attribute_utl.get_attribute_value('/', 'LDAP_USER_PASS', p_raise_expt => 1, p_parent_lookup => 0, p_check_exist => 1),
                                dbms_crypto.ENCRYPT_AES256 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5,
                                '71C35128A5A305B8B3C72AE4A67338F8B292517E3038570A2D2B5D5060B81B93'));
        ldap_baseDN  := branch_attribute_utl.get_attribute_value('/', 'LDAP_BASE_DN', p_raise_expt => 1, p_parent_lookup => 0, p_check_exist => 1);

        res_attrs(1) := 'memberOf';
        res_attrs(2) := 'displayName';
        res_attrs(3) := 'division';
        res_attrs(4) := 'extensionAttribute13';

        l_login_name := p_user_name || '@' || parameter_utl.get_value_for_bank('STAFF_FULL_DOMAIN_NAME');

        search_filter   := '(&(userPrincipalName=' || l_login_name || ')(objectClass=person))';

        my_session := dbms_ldap.init(ldap_host, ldap_port);

        begin
            tools.hide_hint(dbms_ldap.simple_bind_s(my_session, ldap_user, ldap_passwd));

            tools.hide_hint(
                dbms_ldap.search_s(
                    ld       => my_session,
                    base     => ldap_baseDN,
                    scope    => dbms_ldap.SCOPE_SUBTREE,
                    filter   => search_filter,
                    attrs    => res_attrs,
                    attronly => 0,
                    res      => res_message));

            retval := dbms_ldap.count_entries(my_session, res_message);

            if (retval = 0) then
                raise_application_error(-20000, '���������� {' || l_login_name || '} �� ��������� � Active Directory');
            elsif (retval > 1) then
                raise_application_error(-20000, '����������� {' || l_login_name || '} ������� ����� ������ �������� � Active Directory');
            end if;

            l_entry := dbms_ldap.first_entry(my_session, res_message);

            l_attribute_values := dbms_ldap.get_values(my_session, l_entry, 'displayName');
            if (l_attribute_values.count > 0) then
                p_user_display_name := l_attribute_values(l_attribute_values.first);
            end if;

            l_attribute_values := dbms_ldap.get_values(my_session, l_entry, 'division');
            if (l_attribute_values.count > 0) then
                p_user_division := l_attribute_values(l_attribute_values.first);
            end if;

            l_attribute_values := dbms_ldap.get_values(my_session, l_entry, 'memberOf');
            if (l_attribute_values.count > 0) then
                p_groups_list := string_list();
                p_groups_list.extend(l_attribute_values.count);

                for i in l_attribute_values.first..l_attribute_values.last loop
                    p_groups_list(i + 1) := l_attribute_values(i);
                end loop;

                for i in p_groups_list.first..p_groups_list.last loop
                    ldap_dig_into_groups_hierarchy(my_session, ldap_baseDN, p_groups_list(i), p_groups_list);
                end loop;
            end if;

            l_attribute_values := dbms_ldap.get_values(my_session, l_entry, 'extensionAttribute13');
            if (l_attribute_values.count > 0) then
                p_digital_sign_code := l_attribute_values(l_attribute_values.first);
            end if;

            tools.hide_hint(dbms_ldap.unbind_s(my_session));
        exception
            when others then
                 tools.hide_hint(dbms_ldap.unbind_s(my_session));
                 raise;
        end;
    end;

    function prepare_ad_user(
        p_login_name in varchar2)
    return integer
    is
        l_user_name varchar2(32767 byte);
        l_user_domain_name varchar2(32767 byte);
        l_user_display_name varchar2(32767 byte);
        l_branch_code varchar2(30 char);
        l_groups_list string_list;
        l_digital_sign_token_name varchar2(32767 byte);
        l_role_list number_list;
        l_ad_synchronization_user varchar2(4000 byte);
        l_ad_synchronization_user_row staff$base%rowtype;
        l_ad_user_row staff_ad_user%rowtype;
        l_user_row staff$base%rowtype;
    begin
        l_user_name := substr(p_login_name, instr(p_login_name, '\') + 1);
        l_user_domain_name := substr(p_login_name, 1, instr(p_login_name, '\') - 1);

        if (l_user_name is null or l_user_domain_name is null) then
            raise_application_error(-20000, '������� ��''� ����������� {' || p_login_name || '} �� ������� ������� "domainname\username"');
        end if;

        ldap_user_data(l_user_name, l_user_display_name, l_branch_code, l_groups_list, l_digital_sign_token_name);

        -- �������� ����� �������� ���� ��� ��� OU= � �.�.
        if (l_groups_list is not null and l_groups_list is not empty) then
            for i in l_groups_list.first..l_groups_list.last loop
                l_groups_list(i) := upper(regexp_replace(l_groups_list(i), '(^CN=)|(,.{1,})', modifier => 'i'));
            end loop;
        end if;

        -- �������� ������ �����, ���� ���� ���������� ������ ����, ��������� � Active Directory
        select r.id
        bulk collect into l_role_list
        from   staff_role r
        where  r.role_code in (select column_value from table(l_groups_list)) and
               r.state_id = user_role_utl.ROLE_STATE_ACTIVE;

        if (l_digital_sign_token_name is null or -- ���� ��'� ����� ������, ��������� ������� �� �������
            length(l_digital_sign_token_name) = 6 or -- ���� ������� ���� ����� 6 ����� - ������� �� ��������� ��������� ��� ����1 � �������� �� �������� ��� ���
            branch_attribute_utl.get_attribute_value('/', 'CRYPTO_USE_VEGA2', p_raise_expt => 0, p_check_exist => 0) = '1') then -- ���� �������� ���������� ����2 - �������� ����-��� �������� ��� ���
            null;
        elsif (length(l_digital_sign_token_name) = 8) then
            -- ���� ���� ������������ ����2 �� ������������, �������, �� ���������� ��������� � ����1. � ������ ���, ��������� 8-�������� ��'� �����,
            -- ������������� ����� 6 ������� �����. ����� ��� ������� �������������� ������ ����������� � ��������� ��� � �� ����������� � ����� �����������
            l_digital_sign_token_name := substr(l_digital_sign_token_name, 3, 6);
        else
            raise_application_error(-20000, '������� �������� �������������� ��������� ������ �����������: ' || l_digital_sign_token_name ||
                                            '. ������������ ����� 6-��������� ��� 8-��������� (� ����� ������) �������������');
        end if;

        l_ad_user_row := user_utl.read_ad_user(p_login_name, p_raise_ndf => false, p_lock => true);

        -- ���������� �������� ��������� ��� ����������� ��������� �����������
        l_ad_synchronization_user := branch_attribute_utl.get_attribute_value('/', 'AD_SYNCHRONIZATION_USER', p_raise_expt => 1, p_parent_lookup => 1, p_check_exist => 1);
        l_ad_synchronization_user_row := user_utl.read_user(l_ad_synchronization_user);

        start_temporary_session(l_ad_synchronization_user_row.id);

        if (l_ad_user_row.user_id is null) then

            l_user_row := user_utl.read_user(l_user_name, p_raise_ndf => false);

            if (l_user_row.id is not null) then
                raise_application_error(-20000, '���������� ��� ' || l_user_name ||
                                                ' (' || l_user_row.fio ||
                                                ') ����, ��� ���� ���������� �������������� ����� Active Directory - ��������� �� ������������ ���');
            else
                if (l_branch_code is null) then
                    raise_application_error(-20000, '�� ������� �������� �������� ����������� {' || p_login_name ||
                                                    '} � Active Directory - ��������� �� ������������ ���');
                else
                    -- ���������� �������� ������ ������
                    tools.hide_hint(branch_utl.read_branch(l_branch_code, p_raise_ndf => true).branch);
                end if;

                l_user_row.id :=
                    user_utl.create_user(
                         p_login_name => l_user_name,
                         p_user_name => l_user_display_name,
                         p_branch_code => l_branch_code,
                         p_can_select_branch_flag => true,
                         p_extended_access_flag => false,
                         p_security_token_pass => l_digital_sign_token_name);

                user_utl.enable_ad_authentication(l_user_row.id, p_login_name);

                if (l_role_list is not null and l_role_list is not empty) then
                    user_utl.set_user_roles(l_user_row.id, l_role_list, p_approve => true);
                end if;

                bars_audit.security('��������� ��������� ������ � ��� ��� ����������� Active Directory ' || l_user_display_name || ' (' || p_login_name ||
                                    ') ���������. ��� ����������� {' || tools.number_list_to_string(l_role_list, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || '}');
            end if;
        else
            l_user_row := user_utl.read_user(l_ad_user_row.user_id, p_lock => true);

            -- ���� �������� ����������� �� ������� ��������� � Active Directory, �������� ������� �������� ��� ���
            -- ������ ��������� �������� �����������
            if (l_branch_code is not null and l_user_row.branch <> l_branch_code) then
                -- ���������� �������� ������ ������
                tools.hide_hint(branch_utl.read_branch(l_branch_code, p_raise_ndf => true).branch);

                user_utl.set_user_branch(l_user_row, l_branch_code);
            end if;

            if (l_user_row.fio <> l_user_display_name) then
                bars_audit.security('ϲ� ����������� ' || l_user_row.logname || ' ��������� �� "' || l_user_display_name ||
                                    '" �������� �� ����������� ��������. �������� �������� - "' || l_user_row.fio || '"');
                attribute_utl.set_value(l_user_row.id, user_utl.ATTR_CODE_USER_NAME, l_user_display_name);
            end if;

            -- ���� ��� ����� ��������� ������ �� ������� ��������� � Active Directory, �������� ������� �������� ��� ���
            -- ������ ��������� ��������
            if (not tools.equals(l_digital_sign_token_name, l_user_row.tabn)) then
                bars_audit.security('������������� ����� ��������� ������ ����������� ' || l_user_row.logname || ' ��������� �� "' || l_digital_sign_token_name ||
                                    '" �������� �� ����������� ��������. �������� �������� - "' || l_user_row.tabn || '"');
                attribute_utl.set_value(l_user_row.id, user_utl.ATTR_CODE_SECURITY_TOKEN_PASS, l_digital_sign_token_name);
            end if;

            user_utl.set_user_roles(l_user_row.id, l_role_list, p_approve => true);
        end if;

       -- ������� �������� ��������� ��� (���������� �����)
        clear_session_context();

        return l_user_row.id;
    end;

    procedure login_user(
        p_session_id in varchar2,
        p_login_name in varchar2,
        p_authentication_mode in varchar2,
        p_host_name in varchar2,
        p_application_name in varchar2)
    is
        l_user_id integer;
    begin
        begin
            if (p_authentication_mode = 'ORACLE') then
                select s.id
                into   l_user_id
                from   staff$base s
                where  s.logname = upper(p_login_name);
            elsif (p_authentication_mode = 'ACTIVE DIRECTORY') then
                l_user_id := prepare_ad_user(p_login_name);
            elsif (p_authentication_mode = 'BARSWEB') then
                select s.id
                into   l_user_id
                from   staff$base s
                where  s.logname = (select w.dbuser
                                    from   web_usermap w
                                    where  w.webuser = lower(p_login_name));
            else
                raise_application_error(-2000, '������������ ��� �������������� {' || p_authentication_mode || '}');
            end if;
        exception
            when no_data_found then
                raise_application_error(-20000, '���������� � ������ {' || p_login_name || '} �� ���������');
        end;

        login_user(p_session_id, l_user_id, p_host_name, p_application_name);
    end;

    -----------------------------------------------------------------
    -- LOGOUT_USER()
    --
    --     ��������� ������ ������������ �� ���������
    --
    --
    procedure logout_user
    is
        l_login_name varchar2(32767 byte);
    begin

$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.logout_user() start'||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')||', '
            ||'client_id='||nvl(sys_context('userenv','client_identifier'),'null')
        );
$end

        if (get_session_clientid is null or is_long_session)
            then return;
        end if;

        l_login_name := sys_context('bars_global', 'user_name');

        -- ������� ������
        drop_user_session(get_session_clientid);

        bars_audit.info('���������� ' || l_login_name || ' �������� ������ � ���');

$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.logout_user() finish'||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')||', '
            ||'client_id='||nvl(sys_context('userenv','client_identifier'),'null')
        );
$end
        -- ������� ���������� ��������� ������� ������
        clear_session_context;

    end logout_user;


    -----------------------------------------------------------------
    --     ��������� ���������� ���� ������������
    procedure set_user_bankdate(
                  p_bankdate  in  date )
    is
    begin
        if (p_bankdate is not null) then
            sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERBANKDATE, to_char(p_bankdate, DATE_FORMAT), client_id=> get_session_clientid);
            sys.dbms_session.reset_package;
        end if;
    end set_user_bankdate;


    -----------------------------------------------------------------
    --    ����� ������� ����� ���������������� ������
    procedure change_user_appschema(
                  p_appschema varchar2 )
    is
    begin

        -- ��� ������������� BARS, HIST ������ ����� ������
        if (sys_context(GLOBAL_CTX, CTXPAR_USERNAME) in ('BARS', 'HIST')) then
            raise_internal_error(ERR_USER_NOTALLOWED);
        end if;

        -- ��������� ���������� �����
        if (p_appschema not in ('BARS', 'HIST')) then
            raise_internal_error(ERR_INVALID_SCHEMA);
        end if;

        -- �������� ����� � ���������
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_APPSCHEMA, p_appschema, client_id=> get_session_clientid);

        -- �������� ����� � ������
        set_user_appschema(p_appschema);

    end change_user_appschema;


    -----------------------------------------------------------------
    --    ��������� ��. �������������� ������� ������
    function get_session_clientid return t_sess_clientid
    is
    begin
        return substr(sys_context('userenv', 'client_identifier'), 1, MAX_CLIENTID_LEN);
    end get_session_clientid;

    function check_if_ora_session_is_active(
        p_client_identifier in varchar2)
    return char
    is
        l_result char(1 byte);
    begin
        select min('Y')
        into   l_result
        from   gv$session s
        where  s.client_identifier = p_client_identifier and
               s.status = 'ACTIVE';

        return nvl(l_result, 'N');
    end;

    function check_if_ora_session_is_alive(
        p_client_identifier in varchar2)
    return char
    is
        l_result char(1 byte);
    begin
        select min('Y')
        into   l_result
        from   gv$session s
        where  s.client_identifier = p_client_identifier and
               s.status <> 'KILLED';

        return nvl(l_result, 'N');
    end;

    -----------------------------------------------------------------
    --    ������� ���������� ��� �������� ������
    --    ����������� job'�� clear_expired_session_job
    --
    procedure clear_expired_session
    is
        l_client_identifier t_sess_clientid;
        l_programs_with_finite_session string_list;
    begin
        ddl_utl.refresh_mview_autonomous('mv_global_context');

        l_programs_with_finite_session := tools.string_to_words(branch_attribute_utl.get_value(p_branch_code => '/',
                                                                                               p_attribute_code => 'PROGRAMS_WITH_FINITE_SESSION'),
                                                                p_splitting_symbol => ',',
                                                                p_trim_words => 'Y',
                                                                p_ignore_nulls => 'Y');

        -- ��������� ���� ��. �������������
        l_client_identifier := get_session_clientid();

        -- �������� �� ���� �����������. �������, ����� �����������
        for i in (select s.*, to_date(c.last_activity_at, DATETIME_FORMAT) last_activity_at, u.logname
                  from   staff_user_session s
                  left join staff$base u on u.id = s.user_id
                  left join mv_global_context c on c.client_identifier = s.client_identifier
                  where  s.client_identifier <> l_client_identifier and
                         s.logout_time is null) loop

            -- ��� ������, ���������� �� ����� ��������, ������� �� ������ ����������� ���������, ��������� ����� ��������� ����������
            -- ��� ��������� �������� (sqlplus, toad, ������ ����������� job-��� � �.�.) ����������� ������� ����� ������ Oracle
            if (nvl(tools.contains_at_least_one(i.program_name, l_programs_with_finite_session), 'N') = 'Y') then
                -- ����� ��������� ���������� ����� ���� ����� (MAX_SESSION_TIMEOUT = 60 �����) ���
                -- ���� ����� ��������� ���������� ����������, �� �� ����� ����� � ������� ����� � �������
                if (i.last_activity_at < sysdate - MAX_SESSION_TIMEOUT / 60 / 24 or (i.last_activity_at is null and i.login_time < sysdate - 1 / 24)) then
                    -- �� ������ ������ ��������� ������� �������� ��������� ������ ��� ������� ����������� ��������������,
                    -- ���� �������� ������ Oracle ����������, ������ ��������� ���-�� ����� ������� - ��������� ������ ������������ �� ��� ������,
                    -- ����� ������������� ��. ������������� ����� ������ ��� ������� � �� ���������� � ������� ��
                    if (check_if_ora_session_is_active(i.client_identifier) = 'N') then
                        drop_user_session(i.client_identifier);
                        bars_audit.info('���� ����������� ' || i.logname || ' (' || i.client_identifier || ') ��������� ����� �����������' || chr(10) ||
                                        '������� ���������  : ' || to_char(i.last_activity_at, DATETIME_FORMAT) || chr(10) ||
                                        '��� ����� � ������� : ' || to_char(i.login_time, DATETIME_FORMAT));

                        set_user_clientid(i.client_identifier);
                        clear_session_context();
                        set_user_clientid(l_client_identifier);
                    end if;
                end if;
            else
                -- ������� ����� ������ Oracle - ���� ������ ���, ������� ��������
                if (check_if_ora_session_is_alive(i.client_identifier) = 'N') then
                    drop_user_session(i.client_identifier);
                    bars_audit.info('���� ����������� ' || i.logname || ' (' || i.client_identifier || ') ��������� ����� �����������' || chr(10) ||
                                    '������� ���������  : ' || to_char(i.last_activity_at, DATETIME_FORMAT) || chr(10) ||
                                    '��� ����� � ������� : ' || to_char(i.login_time, DATETIME_FORMAT));

                    set_user_clientid(i.client_identifier);
                    clear_session_context();
                    set_user_clientid(l_client_identifier);
                end if;
            end if;
        end loop;
    exception
        when others then
            -- ��������������� ���� ��. �������������
            set_user_clientid(l_client_identifier);
            -- ��������� ������
            raise;
    end;


    procedure clear_session(
        p_client_id varchar2,
        p_kill_session in integer default 1)
    is
        l_my_client_id varchar2(64 char);
        l_sid varchar2(30 char);
        l_serial varchar2(30 char);
    begin
        /*bars_audit.log_security('bars_login.clear_session',
                                '���������� ��� ����������� {' || p_client_id || '}',
                                p_make_context_snapshot => true);*/

        if (p_kill_session = 1) then
            for i in (select s.sid, s.serial#
                      from   gv$session s
                      where  s.client_identifier = p_client_id and
                             exists (select 1
                                     from   staff$base u
                                     where  u.logname = s.username)) loop
                 begin
                     execute immediate 'alter system kill session ''' || i.sid || ',' || i.serial# || ''' immediate';
                 exception
                     when others then
                          bars_audit.log_error('bars_login.clear_session (kill session exception)',
                                               'p_client_id : ' || p_client_id || chr(10) ||
                                               'sid         : ' || i.sid || chr(10) ||
                                               'serial#     : ' || i.serial# || chr(10) ||
                                               sqlerrm || chr(10) || dbms_utility.format_error_backtrace() || chr(10) ||
                                               dbms_utility.format_call_stack());
                          raise;
                 end;
             end loop;
         end if;

         l_my_client_id := get_session_clientid();

         begin
             -- ����������� ����� ����
             set_user_clientid(p_client_id);
             clear_session_context;

             -- ����������� � ��� ��������
             set_user_clientid(l_my_client_id);
         exception
             when others then
                  set_user_clientid(l_my_client_id);
                  bars_audit.log_error('bars_login.clear_session',
                                       sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
                  raise;
         end;

        drop_user_session(p_client_id);
/*
        bars_audit.log_security('bars_login.clear_session',
                                '���� ����������� ' || p_client_id || ') ��������� ���������' || chr(10) ||
                                dbms_utility.format_call_stack());*/
    end;

    -----------------------------------------------------------------
    --    ������������ �������� �� ���� ������������ �� ����� ��������� ������������ ��������.
    --    ����� �������� ������ ��� ���� ���� ��� ���������, ���� ������� ��������� ������������ ��������
    --
    procedure set_exclusive_mode
    is
        l_run_id integer;
        l_tms_run_row tms_run%rowtype;
        l_exclusive_mode_persist_users string_list := string_list('BARS', 'BARS_DM', 'BARSUPL', 'BARSAQ', 'PFU', 'SBON');
        l_additional_survivors string_list;
    begin
        branch_attribute_utl.set_attribute_value('/', 'EXCLUSIVE_MODE', '1');

        commit;

        l_run_id := pul.get('RUN_ID');
        l_tms_run_row := tms_utl.read_run(l_run_id, p_raise_ndf => false);

        -- �� ��������� ��� �����������, ���� ������ ���� ��������� ����
        l_exclusive_mode_persist_users.extend(1);
        l_exclusive_mode_persist_users(l_exclusive_mode_persist_users.last) := user_utl.get_login_name(l_tms_run_row.user_id);

        -- �� ��������� ��� ��� (���� �� ��������� � ������������, ���� �������� ���� ��������� ����, � ��� ��������,
        -- ���� ��������� ����������� �� �������� ���������)
        l_exclusive_mode_persist_users.extend(1);
        l_exclusive_mode_persist_users(l_exclusive_mode_persist_users.last) := user_utl.get_login_name(sys_context('bars_global', 'user_id'));

        -- ������ ������������, �� ������ ��������������� �������������� ���
        l_additional_survivors := tools.string_to_words(p_string => branch_attribute_utl.get_attribute_value('/',
                                                                           'EXCLUSIVE_MODE_PERSISTENT_USER',
                                                                           p_raise_expt => 0,
                                                                           p_parent_lookup => 1,
                                                                           p_check_exist => 0),
                                                        p_splitting_symbol => ',',
                                                        p_trim_words => 'Y',
                                                        p_ignore_nulls => 'Y');

        if (l_additional_survivors is not null and l_additional_survivors is not empty) then
            l_exclusive_mode_persist_users := l_exclusive_mode_persist_users multiset union l_additional_survivors;
        end if;

        ddl_utl.refresh_mview_autonomous('MV_GLOBAL_CONTEXT');

        for i in (select c.client_identifier
                  from   mv_global_context c
                  where  c.login_name not in (select column_value
                                              from   table(l_exclusive_mode_persist_users)
                                              where  column_value is not null)) loop
            begin
                clear_session(i.client_identifier, 0);
            exception
                when others then
                     -- ������ ������� � ��������� ��� - ������ ���� ����������� ��� �� ���� ���������� �����
                     -- ����������� �������� �������� ���� ���
                     bars_audit.log_error('bars_login.set_exclusive_mode (exception)',
                                          '������� ������� ��� ����������� ��� �볺�������� �������������� : ' || i.client_identifier || chr(10) ||
                                          sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                                          p_make_context_snapshot => true);
            end;
        end loop;
    end;

    -----------------------------------------------------------------
    --    ³���� �������� �� ���� ������������ ���� ���������� ��������� ������������ ��������.
    --
    procedure release_exclusive_mode
    is
        l_current_mode varchar2(4000 byte);
    begin
        l_current_mode := branch_attribute_utl.get_value('/', 'EXCLUSIVE_MODE');

        if (l_current_mode <> '0') then
            branch_attribute_utl.set_attribute_value('/', 'EXCLUSIVE_MODE', '0');
        end if;
    end;

    -----------------------------------------------------------------
    --     ������� ��������� ������ ��������� ������
    function header_version return varchar2
    is
    begin
        return 'Package header BARS_LOGIN '  || VERSION_HEADER || '.' || chr(10) ||
               'package header definition: ' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;


    -----------------------------------------------------------------
    --     ������� ��������� ������ ���� ������
    function body_version return varchar2
    is
    begin
        return 'Package body BARS_LOGIN '  || VERSION_BODY || '.' || chr(10) ||
               'package body definition: ' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


    -----------------------------------------------------------------
    --    ��������������� �������� ����������� �������������� ������
    --    �� ���������� ���������
    --    ������������ ��� ���������� ������ ����� ����������� �� dblink
    procedure restore_session is
    begin
        set_user_session( sys_context(LOCAL_CTX, CTXPAR_SESSIONID) );
    end restore_session;

    -----------------------------------------------------------------
    -- �������� ������� �� ������ client_identifier
    procedure set_long_session(p_expires date default sysdate + 1) is
    pragma autonomous_transaction;
    begin
      merge into staff_web_long_session s
      using (select substr(sys_context('userenv', 'client_identifier'), 1, max_clientid_len) client_identifier,
                    p_expires expires
               from dual) t
      on (s.client_identifier = t.client_identifier)
      when not matched then
        insert
          (client_identifier, expires)
        values
          (t.client_identifier, t.expires)
      when matched then
        update set expires = t.expires;
      commit;
    end;

    procedure cleare_long_session is
      pragma autonomous_transaction;
    begin

      delete from staff_web_long_session sw
       where sw.client_identifier =
             substr(sys_context('userenv', 'client_identifier'), 1, max_clientid_len);
      commit;
    end;

    function is_long_session return boolean
      is
      l_count number;
    begin
      select count(*)
        into l_count
        from staff_web_long_session sw
       where sw.client_identifier = substr(sys_context('userenv', 'client_identifier'), 1, max_clientid_len) and sw.expires >= sysdate;

       if l_count = 1 then
         return true;
       else
         return false;
       end if;

    end;
end bars_login;
/
 show err;
 
PROMPT *** Create  grants  BARS_LOGIN ***
grant EXECUTE                                                                on BARS_LOGIN      to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_LOGIN      to BARSREADER_ROLE;
grant EXECUTE                                                                on BARS_LOGIN      to BARSUPL;
grant EXECUTE                                                                on BARS_LOGIN      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_LOGIN      to SYSTEM;
grant EXECUTE                                                                on BARS_LOGIN      to UPLD;
grant EXECUTE                                                                on BARS_LOGIN      to USER100101;
grant EXECUTE                                                                on BARS_LOGIN      to WCS_SYNC_USER;
grant EXECUTE                                                                on BARS_LOGIN      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BARS_LOGIN      to BARS_DM;