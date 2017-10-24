
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_role_auth.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ROLE_AUTH authid current_user
is

    --*************************************************************--
    --                                                             --
    --                                                             --
    --            ����� ���������� ������ ���������                --
    --                                                             --
    --                                                             --
    --*************************************************************--


    -------------------------------------------------------
    -- ���������                                         --
    -------------------------------------------------------

    VERSION_HEADER       constant varchar2(64)  := 'version 1.01 10.09.2007';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';



    --------------------------------------------------------
    -- GET_ROLE_DATA()
    --
    --     ������� ��������� ������ ��� ���������
    --     ���������� ����
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    function get_role_data(
                 p_role   in  varchar2 ) return varchar2;

    --------------------------------------------------------
    -- SET_ROLE_BY_DATA()
    --
    --     ��������� ���������� ����
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    procedure set_role_by_data(
                  p_roledata   in  varchar2 );

    --------------------------------------------------------
    -- SET_ROLE()
    --
    --     ��������� ������������ ����
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    procedure set_role(
                  p_role   in  varchar2 );

    --------------------------------------------------------
    -- INTERNAL_()
    --
    --     ���������� ��������� ��������� ������
    --
    --     ���������:
    --
    --         p_buf1   ����� 1
    --
    --         p_buf2   ����� 2
    --
    function internal_(
                 p_buf1   in  varchar2,
                 p_buf2   in  varchar2 ) return varchar2;

    --------------------------------------------------------
    -- SET_ROLE_INT()
    --
    --     ���������� ��������� ��������� ����
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    procedure set_role_int(
                  p_role   in  varchar2 );

    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ��������� ������ ��������� ������
    --
    --
    --
    function header_version return varchar2;

    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ��������� ������ ���� ������
    --
    --
    --
    function body_version return varchar2;


end bars_role_auth;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ROLE_AUTH 
is

    --*************************************************************--
    --                                                             --
    --                                                             --
    --            ����� ���������� ������ ���������                --
    --                                                             --
    --                                                             --
    --*************************************************************--


    -------------------------------------------------------
    -- ���������                                         --
    -------------------------------------------------------

    VERSION_BODY       constant varchar2(64)  := 'version 1.05 10.10.2007';
    VERSION_BODY_DEFS  constant varchar2(512) := '';

    -- ��� ����������������� ���������
    PARAM_ROLEAUTH     constant params.par%type := 'ROLEAUTH';

    -- �������� ��������������
    AUTH_OFF           constant number          := 0;
    AUTH_ON            constant number          := 1;

    -- ������� �������������� �����������
    APPAUTH_OFF        constant number          := 0;
    APPAUTH_ON         constant number          := 1;


    -- ��� �������������� ����
    ROLEAUTH_NONE      constant number          := 0;
    ROLEAUTH_APP       constant number          := 1;

    -- ��� ������ ��� ������ � ���������
    MODCODE            constant varchar2(3)     := 'SVC';


    -------------------------------------------------------
    -- ���������� ����������                             --
    -------------------------------------------------------

    g_roleauth     number;         /* ������� �������������� ����� */
    g_roles        varchar2(4000); /*        ������ �������� ����� */

    g_currrole     varchar2(30);   /*                  ���� ������ */
    g_currbuf      varchar2(48);   /*       ��������������� ������ */



    --------------------------------------------------------
    -- IGET_ROLES()
    --
    --     ������� ��������� ������ �������� �����
    --
    --
    --
    function iget_roles return varchar2
    is

    l_res   varchar2(4000); /* ������ �������� ����� (����� �������) */

    begin

        for c in (select role
                    from session_roles)
        loop

            if (l_res is null) then
                l_res := ' ' || c.role || ' ';
            else
                l_res := l_res || ', ' || c.role || ' ';
            end if;

        end loop;

        return l_res;

    end iget_roles;



    --------------------------------------------------------
    -- ISET_ROLE()
    --
    --     ��������� ��������� ���� (�������, ����������,
    --     ����������)
    --
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    procedure iset_role(
                 p_role   in  varchar2 )
    is

    l_authflag    roles$base.authenticated%type;    /*        ������� �����. ���� */
    l_appflag     roles$base.application_role%type; /* ������� �����. ����������� */

    begin

        bars_audit.trace('roleauth.isetrole: entry point par[0]=>%s', p_role);

        -- ����� ��� ����
        begin
            select nvl(authenticated, 0), nvl(application_role, 0)
              into l_authflag, l_appflag
              from roles$base
             where role_name = p_role;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'ROLE_NOT_FOUND', p_role);
        end;

        bars_audit.trace('roleauth.isetrole: got role req [%s][%s]', to_char(l_authflag), to_char(l_appflag));

        -- ��������� ������ �������� �����
        if (g_roles is null) then
            bars_audit.trace('roleauth.isetrole: getting active role list...');
            g_roles := iget_roles;
        end if;

        bars_audit.trace('roleauth.isetrole: role list exists. %s', g_roles);

        -- ��������� ��������� ��������������� ����
        if (instr(g_roles, ' ' || p_role || ' ') != 0) then
            -- ���� ��� �������
            bars_audit.trace('roleauth.isetrole: role already set.');
        else
            if (g_roles is not null) then
                g_roles := g_roles || ',';
            end if;

            g_roles := g_roles || ' ' || p_role || ' ';
        end if;

        -- ��������� ����������� �� ������������� ���� START1
        if (nvl(instr(g_roles, ' START1 '), 0) = 0) then

                if (g_roles is null) then
                    g_roles := ' START1 ';
                else
                    g_roles := g_roles || ', START1 ';
                end if;

        end if;

        bars_audit.trace('roleauth.isetrole: role list=>%s', g_roles);

        -- ����������
        dbms_session.set_role(g_roles);

    end iset_role;


    --------------------------------------------------------
    -- GET_ROLE_DATA()
    --
    --     ������� ��������� ������ ��� ���������
    --     ���������� ����
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    function get_role_data(
                 p_role   in  varchar2 ) return varchar2
    is

    l_role        varchar2(30);                     /* ��� ���� � ������� �������� */
    l_authflag    roles$base.authenticated%type;    /*         ������� �����. ���� */
    l_databuf     varchar2(2048);                   /*        �������������� ����� */
    l_datahash    varchar2(2048);                   /*      ��� �� �������. ������ */

    begin

        bars_audit.trace('roleauth.getroledt: entry point par[0]=>%s', p_role);

        -- �������� � �������� ��������
        l_role := upper(p_role);

        -- �������� �������� ����
        begin
            select nvl(authenticated, 0)  into l_authflag
              from roles$base
             where role_name = l_role;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'ROLE_NOT_FOUND', l_role);
        end;

        -- ��������� ��� ����
        g_currrole := l_role;
        g_currbuf  := null;

        -- ��������� ����� ��� ���������� ������. � ������������� ����� �����. ����
        if (g_roleauth = AUTH_ON and l_authflag = AUTH_ON) then

            -- ��������� �����
            l_databuf := l_role || to_char(current_timestamp) || user_id;

            -- �������� ��� �� ������
            l_datahash := bars_role_int.get_hash_value(l_databuf,           999,  1024) ||
                          bars_role_int.get_hash_value(l_databuf || '09', 99999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '08', 89999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '07', 79999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '06', 69999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '0-', 59999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '04', 49999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '03', 39999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '02', 29999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '01', 19999, 16384);

            -- ��������� ���
            g_currbuf  := substr(rpad(l_datahash, 48, '0'), 1, 48);

        end if;

        return g_currbuf;

    end get_role_data;


    --------------------------------------------------------
    -- SET_ROLE_BY_DATA()
    --
    --     ��������� ���������� ����
    --
    --     ���������:
    --
    --         p_roledata   ����� ������ ��� ����
    --
    --
    procedure set_role_by_data(
                  p_roledata   in  varchar2 )
    is

    APP_PASSWD  constant  varchar2(24) := '-B857^H!3D#uL3_Ke$(!s)*S';

    l_roledata   varchar2(2048);

    begin

        bars_audit.trace('roleauth.setrolebydt: entry point par[0]=><wrapped>');

        -- ��������� ��� ��� ����� get_role_data()
        if (g_currrole is null) then
            bars_error.raise_nerror(MODCODE, 'ROLEAUTH_INVALID_CALL', 'ROLE_NAME');
        end if;

        -- ��������� ���������� ����� ��� ���������� �����.
        if (g_roleauth = AUTH_ON) then

            -- ���� ���������� ����� ���� ����, ������ ���� ��� �����.
            if (g_currbuf is not null) then

                if (p_roledata is null) then
                    bars_error.raise_nerror(MODCODE, 'ROLEAUTH_INVALID_CALL', 'ROLE_DATA_NULL');
                end if;

                if (p_roledata != substr(internal_(g_currbuf, APP_PASSWD), 1, 100)) then
                    bars_error.raise_nerror(MODCODE, 'ROLEAUTH_INVALID_CALL', 'ROLE_DATA');
                end if;

            end if;

        end if;

        bars_audit.trace('roleauth.setrolebydt: app roledata check compeleted.');

        -- ���������� ����
        iset_role(g_currrole);

    end set_role_by_data;









    --------------------------------------------------------
    -- SET_ROLE()
    --
    --     ��������� ������������ ���� ��� ���� ����������
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    procedure set_role(
                  p_role   in  varchar2 )
    is

    l_role        varchar2(30);                     /* ��� ���� � ������� �������� */
    l_authflag    roles$base.authenticated%type;    /*         ������� �����. ���� */

    begin

        -- ��� ���� � ������� �������
        l_role := upper(trim(p_role));

        -- �������� �������� ����
        begin
            select nvl(authenticated, 0) into l_authflag
              from roles$base
             where role_name = l_role;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'ROLE_NOT_FOUND', l_role);
        end;

        -- ���� �����. ������. � ���������� ����. ������ ����
        if (g_roleauth = AUTH_ON and l_authflag = AUTH_ON) then

            -- ���������� ����������� ����� proxy-������������
            if (nvl(sys_context('userenv', 'proxy_user'), ' ') != 'APPSERVER') then
                bars_error.raise_nerror(MODCODE, 'APPAUTH_REQUIRED', l_role);
            end if;

        end if;

        -- ������������� ����
        iset_role(l_role);

    end set_role;


    --------------------------------------------------------
    -- INTERNAL_()
    --
    --     ���������� ��������� ��������� ������
    --
    --     ���������:
    --
    --         p_buf1   ����� 1
    --
    --         p_buf2   ����� 2
    --
    function internal_(
                 p_buf1   in  varchar2,
                 p_buf2   in  varchar2 ) return varchar2
    is
    l_res    varchar2(2048) := null;
    begin

        if (g_roleauth = AUTH_ON) then
            bars_role_int.encrypt(p_buf1, p_buf2, l_res);
        end if;

        return l_res;

    end internal_;



    --------------------------------------------------------
    -- SET_ROLE_INT()
    --
    --     ���������� ��������� ��������� ����
    --
    --     ���������:
    --
    --         p_role   ��� ����
    --
    --
    procedure set_role_int(
                  p_role   in  varchar2 )
    is

    l_dbname  global_name.global_name%type;

    begin

        -- �������� ��� ����
        select global_name  into l_dbname
          from global_name;

        -- ��������� ���� �������� ������ �� ���������� �����
        if (substr(l_dbname, -10, 10) != 'BARS.LOCAL') then
            return;
        end if;

        -- ������������� ����
        iset_role(p_role);

    end set_role_int;


    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ��������� ������ ��������� ������
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_ROLE_AUTH ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):'  || chr(10) || VERSION_HEADER_DEFS;
    end header_version;


    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ��������� ������ ���� ������
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_ROLE_AUTH ' || VERSION_BODY || chr(10) ||
               'package body definition(s):'  || chr(10) || VERSION_BODY_DEFS;
    end body_version;


begin
    --
    -- ���� ������������� ������
    --
    g_roleauth := bars_role_int.get_role_auth;

end bars_role_auth;
/
 show err;
 
PROMPT *** Create  grants  BARS_ROLE_AUTH ***
grant EXECUTE                                                                on BARS_ROLE_AUTH  to ABS_ADMIN;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to BARS_CONNECT;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to BASIC_INFO;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to PUBLIC;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to START1;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_role_auth.sql =========*** End 
 PROMPT ===================================================================================== 
 