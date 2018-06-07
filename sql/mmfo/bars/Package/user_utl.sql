create or replace package user_utl is

    OBJ_TYPE_USER                  constant varchar2(30 char) := 'STAFF_USER';

    RESOURCE_TYPE_USER             constant varchar2(30 char) := 'STAFF_USER';
    RESOURCE_TYPE_ROLE             constant varchar2(30 char) := 'STAFF_ROLE';

    ATTR_CODE_USER_NAME            constant varchar2(30 char) := 'STAFF_USER_NAME';
    ATTR_CODE_BRANCH               constant varchar2(30 char) := 'STAFF_USER_BRANCH';
    ATTR_CODE_POLICY_GROUP         constant varchar2(30 char) := 'STAFF_USER_POLICY_GROUP';
    ATTR_CODE_SECURITY_TOKEN_PASS  constant varchar2(30 char) := 'STAFF_USER_SECURITY_TOKEN_PASS';
    ATTR_CODE_CAN_SELECT_BRANCH    constant varchar2(30 char) := 'STAFF_USER_CAN_SELECT_BRANCH';

    LT_USER_STATE                  constant varchar2(30 char) := 'STAFF_USER_STATE';
    USER_STATE_NEW                 constant integer := 1;
    USER_STATE_ACTIVE              constant integer := 2;
    USER_STATE_LOCKED              constant integer := 3;
    USER_STATE_CLOSED              constant integer := 4;

    LT_USER_DELEGATION_STATE       constant varchar2(30 char) := 'STAFF_USER_DELEGATION_STATE';
    DELEGATION_STATE_ACTIVE        constant integer := 1;
    DELEGATION_STATE_CLOSED        constant integer := 2;

    function read_user(
        p_user_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff$base%rowtype;

    function read_user(
        p_login_name in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff$base%rowtype;

    function read_web_user(
        p_login_name in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return web_usermap%rowtype;

    function read_ad_user(
        p_user_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff_ad_user%rowtype;

    function read_ad_user(
        p_active_directory_name in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff_ad_user%rowtype;

    function get_user_id(
        p_login_name in varchar2)
    return integer;

    function get_ad_user_id(
        p_login_name in varchar2)
    return varchar2;

    function get_login_name(
        p_user_id in integer)
    return varchar2;

    function get_user_name(
        p_user_id in integer)
    return varchar2;

    function get_user_branch(
        p_user_id in integer)
    return varchar2;

    function get_user_roles(
        p_user_id in integer)
    return number_list;

    function get_user_role_codes(
        p_user_id in integer)
    return string_list;

    function get_ora_user_roles(
        p_login_name in varchar2)
    return string_list;

    procedure set_user_branch(
        p_user_row in staff$base%rowtype,
        p_branch_code in varchar2);

    procedure set_user_roles(
        p_user_id in integer,
        p_user_roles in number_list,
        p_approve in boolean default false);

    function create_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in boolean,
        p_extended_access_flag in boolean,
        p_security_token_pass in varchar2)
    return integer;

    function create_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in boolean,
        p_extended_access_flag in boolean,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in boolean,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in boolean,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in boolean,
        p_active_directory_name in varchar2,
        p_user_roles in number_list,
        p_approve_roles in boolean default false)
    return integer;

    procedure edit_user(
        p_user_row in staff$base%rowtype,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in boolean,
        p_extended_access_flag in boolean,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in boolean,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in boolean,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in boolean,
        p_active_directory_name in varchar2,
        p_user_roles in number_list);

    procedure set_password(
        p_user_row in staff$base%rowtype,
        p_password_hash in varchar2);

    procedure set_ora_password(
        p_user_row in staff$base%rowtype,
        p_password in varchar2);

    procedure set_temp_password(
        p_user_row in staff$base%rowtype,
        p_password_hash in varchar2);

    procedure add_password_failure(
        p_user_row in staff$base%rowtype);

    procedure lock_user(
        p_user_row in staff$base%rowtype,
        p_lock_comment in varchar2);

    procedure unlock_user(
        p_user_row in staff$base%rowtype);

    procedure enable_native_authentication(
        p_user_id in integer,
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_temp_password in varchar2);

    procedure disable_native_authentication(
        p_login_name in varchar2);

    procedure enable_oracle_authentication(
        p_login_name in varchar2,
        p_identified_by in varchar2,
        p_ora_roles in string_list);

    procedure disable_oracle_authentication(
        p_login_name in varchar2);

    procedure enable_ad_authentication(
        p_user_id in integer,
        p_active_directory_name in varchar2);

    procedure disable_ad_authentication(
        p_user_id in integer);

    procedure close_user(
        p_user_row in staff$base%rowtype,
        p_force in boolean default false);

    function check_if_ora_user_exists(
        p_login_name in varchar2)
    return char;

    function check_if_web_user_exists(
        p_login_name in varchar2)
    return char;

    function check_if_ad_user_exists(
        p_user_id in integer)
    return char;

    function get_user_adm_comments(
        p_user_row in staff$base%rowtype)
    return varchar2;

    procedure revoke_ora_user_roles(
        p_login_name in varchar2,
        p_revoked_roles in string_list);

    procedure set_ora_user_roles(
        p_login_name in varchar2,
        p_new_roles in string_list);

    procedure reset_ora_user_roles(
        p_login_name in varchar2,
        p_oracle_roles in string_list);

    function get_resource_access_mode(
        p_user_id in integer,
        p_resource_type_code in varchar2,
        p_resource_id in integer)
    return integer;

    function get_resource_access_mode(
        p_user_id in integer,
        p_resource_type_code in varchar2,
        p_resource_code in varchar2)
    return integer;
end;
/
create or replace package body user_utl as

    user_doesnt_exists exception;
    pragma exception_init(user_doesnt_exists, -1918);

    -- common user routine
    function read_user(
        p_user_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff$base%rowtype
    is
        l_user_row staff$base%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_user_row
            from   staff$base t
            where  t.id = p_user_id
            for update wait 60;
        else
            select *
            into   l_user_row
            from   staff$base t
            where  t.id = p_user_id;
        end if;

        return l_user_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Користувач з ідентифікатором {' || to_char(p_user_id) || '} не знайдений');
             else return null;
             end if;
    end;

    function read_user(
        p_login_name in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff$base%rowtype
    is
        l_user_row staff$base%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_user_row
            from   staff$base t
            where  t.logname = upper(p_login_name)
            for update wait 60;
        else
            select *
            into   l_user_row
            from   staff$base t
            where  t.logname = upper(p_login_name);
        end if;

        return l_user_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Користувач з логіном {' || p_login_name || '} не знайдений');
             else return null;
             end if;
    end;

    function read_ora_user(
        p_login_name in varchar2,
        p_raise_ndf in boolean default true)
    return dba_users%rowtype
    is
        l_ora_user_row dba_users%rowtype;
    begin
        select *
        into   l_ora_user_row
        from   dba_users t
        where  t.username = upper(p_login_name);

        return l_ora_user_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Користувач Oracle з іменем {' || p_login_name || '} не знайдений');
             else return null;
             end if;
    end;

    function get_user_id(
        p_login_name in varchar2)
    return integer
    is
    begin
        return read_user(p_login_name, p_raise_ndf => false).id;
    end;

    function get_login_name(
        p_user_id in integer)
    return varchar2
    is
    begin
        return read_user(p_user_id, p_raise_ndf => false).logname;
    end;

    function get_user_name(
        p_user_id in integer)
    return varchar2
    is
    begin
        return read_user(p_user_id, p_raise_ndf => false).fio;
    end;

    function get_user_branch(
        p_user_id in integer)
    return varchar2
    is
    begin
        return read_user(p_user_id, p_raise_ndf => false).branch;
    end;

    function get_user_roles(
        p_user_id in integer)
    return number_list
    is
        l_user_roles number_list;
        l_active_user_roles number_list;
    begin
        l_user_roles := resource_utl.get_granted_resources(user_utl.RESOURCE_TYPE_USER,
                                                           p_user_id,
                                                           string_list(user_role_utl.RESOURCE_TYPE_ROLE));

        if (l_user_roles is not null and l_user_roles is not empty) then
            select r.id
            bulk collect into l_active_user_roles
            from   staff_role r
            where  r.id in (select column_value from table(l_user_roles)) and
                   r.state_id = user_role_utl.ROLE_STATE_ACTIVE;
        end if;

        return l_active_user_roles;
    end;

    function get_user_role_codes(
        p_user_id in integer)
    return string_list
    is
        l_user_roles number_list;
        l_active_user_roles string_list;
    begin
        l_user_roles := resource_utl.get_granted_resources(user_utl.RESOURCE_TYPE_USER,
                                                           p_user_id,
                                                           string_list(user_role_utl.RESOURCE_TYPE_ROLE));

        if (l_user_roles is not null and l_user_roles is not empty) then
            select r.role_code
            bulk collect into l_active_user_roles
            from   staff_role r
            where  r.id in (select column_value from table(l_user_roles)) and
                   r.state_id = user_role_utl.ROLE_STATE_ACTIVE;
        end if;

        return l_active_user_roles;
    end;

    procedure set_user_roles(
        p_user_row in staff$base%rowtype,
        p_user_roles in number_list,
        p_approve in boolean default false)
    is
        l_user_resource_type_id integer;
        l_role_resource_type_id integer;
        l_current_roles number_list;
        l_revoked_roles number_list;
        l_added_roles number_list;

        l integer;
    begin
        l_user_resource_type_id := resource_utl.get_resource_type_id(user_utl.RESOURCE_TYPE_USER);
        l_role_resource_type_id := resource_utl.get_resource_type_id(user_utl.RESOURCE_TYPE_ROLE);

        l_current_roles := resource_utl.get_granted_resources(l_user_resource_type_id, p_user_row.id, number_list(l_role_resource_type_id));

        if (p_user_roles is not null) then
            l_revoked_roles := l_current_roles multiset except p_user_roles;
            l_added_roles := p_user_roles multiset except l_current_roles;
        else
            l_revoked_roles := l_current_roles;
        end if;

        if (l_added_roles is not null and l_added_roles is not empty) then
            l := l_added_roles.first;
            while (l is not null) loop
                -- bars_audit.security('Користувачу ' || p_user_row.logname || ' надається роль ' || user_role_utl.get_role_name(l_added_roles(l)));
                resource_utl.set_resource_access_mode(l_user_resource_type_id, p_user_row.id, l_role_resource_type_id, l_added_roles(l), 1, p_approve => p_approve);
                l := l_added_roles.next(l);
            end loop;
        end if;

        if (l_revoked_roles is not null and l_revoked_roles is not empty) then
            l := l_revoked_roles.first;
            while (l is not null) loop
                -- bars_audit.security('Відміняється доступ користувача ' || p_user_row.logname || ' до ролі ' || user_role_utl.get_role_name(l_revoked_roles(l)));
                resource_utl.set_resource_access_mode(l_user_resource_type_id, p_user_row.id, l_role_resource_type_id, l_revoked_roles(l), 0, p_approve => p_approve);
                l := l_revoked_roles.next(l);
            end loop;
        end if;
    end;

    procedure set_user_roles(
        p_user_id in integer,
        p_user_roles in number_list,
        p_approve in boolean default false)
    is
    begin
        set_user_roles(read_user(p_user_id), p_user_roles, p_approve);
    end;

    procedure set_user_branch(
        p_user_row in staff$base%rowtype,
        p_branch_code in varchar2)
    is
        l_policy_group varchar2(30 char);
    begin
        if (not tools.equals(p_user_row.branch, p_branch_code)) then
            bars_audit.security('Відділення користувача ' || p_user_row.logname || ' змінюється на "' || p_branch_code ||
                                '". Попереднє значення відділення - "' || p_user_row.branch || '"');
            attribute_utl.set_value(p_user_row.id, user_utl.ATTR_CODE_BRANCH, p_branch_code);
        end if;

        -- група політик CENTER не змінюється при зміні відділення, для всіх решти група політик прив'язується до рівня відділення
        if (not tools.equals(p_user_row.policy_group, 'CENTER')) then
            l_policy_group := case when p_branch_code = '/' then 'WHOLE' else 'FILIAL' end;

            if (not tools.equals(p_user_row.policy_group, l_policy_group)) then
                bars_audit.security('Група політик користувача ' || p_user_row.logname || ' змінюється на "' || l_policy_group ||
                                    '". Попереднє значення - "' || p_user_row.policy_group || '"');
                attribute_utl.set_value(p_user_row.id, user_utl.ATTR_CODE_POLICY_GROUP, l_policy_group);
            end if;
        end if;
    end;

    procedure check_login_name_uniqueness(
        p_login_name in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        l_user_row := read_user(p_login_name, p_raise_ndf => false);

        if (l_user_row.id is not null) then
            raise_application_error(-20000, 'Користувач з логіном {' || p_login_name || '} вже зареєстрований');
        end if;
    end;

    -- Oracle-user routine
    function check_if_ora_user_exists(
        p_login_name in varchar2)
    return char
    is
    begin
        return case when read_ora_user(p_login_name, p_raise_ndf => false).username is null then 'N'
                    else 'Y'
               end;
    end;

    function check_if_ora_user_is_locked(
        p_login_name in varchar2)
    return char
    is
    begin
        return case when instr(read_ora_user(p_login_name, p_raise_ndf => false).account_status, 'LOCKED') > 0 then 'Y'
                    else 'N'
               end;
    end;

    function get_ora_user_roles(
        p_login_name in varchar2)
    return string_list
    is
        l_granted_roles string_list;
    begin
        select p.granted_role
        bulk collect into l_granted_roles
        from   dba_role_privs p
        where  p.grantee = upper(p_login_name);

        return l_granted_roles;
    end;

    procedure revoke_ora_user_roles(
        p_login_name in varchar2,
        p_revoked_roles in string_list)
    is
        l integer;
    begin
        if (p_revoked_roles is not null and p_revoked_roles is not empty) then
            l := p_revoked_roles.first;
            while (l is not null) loop
                execute immediate 'revoke ' || p_revoked_roles(l) || ' from ' || p_login_name;
                bars_audit.security('Відміняється доступ користувача ' || p_login_name || ' до ролі Oracle ' || p_revoked_roles(l));
                l := p_revoked_roles.next(l);
            end loop;
        end if;
    end;

    procedure set_ora_user_roles(
        p_login_name in varchar2,
        p_new_roles in string_list)
    is
        l integer;
    begin
        if (p_new_roles is not null and p_new_roles is not empty) then
            l := p_new_roles.first;
            while (l is not null) loop
                execute immediate 'grant ' || p_new_roles(l) || ' to ' || p_login_name;
                bars_audit.security('Користувачу ' || p_login_name || ' надається доступ до ролі Oracle ' || p_new_roles(l));
                l := p_new_roles.next(l);
            end loop;
        end if;
    end;

    procedure reset_ora_user_roles(
        p_login_name in varchar2,
        p_oracle_roles in string_list)
    is
        l_new_roles string_list;
        l_current_ora_roles string_list;
        l_revoked_roles string_list;
        l integer;
    begin
        l_current_ora_roles := get_ora_user_roles(p_login_name);
        if (p_oracle_roles is not null) then
            l_new_roles := p_oracle_roles multiset except l_current_ora_roles;
            l_revoked_roles := l_current_ora_roles multiset except p_oracle_roles;
        else
            l_revoked_roles := l_current_ora_roles;
        end if;

        set_ora_user_roles(p_login_name, l_new_roles);
        revoke_ora_user_roles(p_login_name, l_revoked_roles);
    end;

    procedure lock_ora_user_utl(
        p_login_name in varchar2)
    is
        pragma autonomous_transaction;
        l_ora_user_row dba_users%rowtype;
    begin
        l_ora_user_row := read_ora_user(p_login_name);

        if (instr(l_ora_user_row.account_status, 'LOCKED') = 0) then
            execute immediate 'alter user ' || p_login_name || ' account lock';

            bars_audit.security('Користувачу {' || p_login_name || '} заборонена автентифікації Oracle - обліковий запис Oracle заблокований');
        end if;
    end;

    procedure unlock_ora_user_utl(
        p_login_name in varchar2)
    is
        pragma autonomous_transaction;
        l_ora_user_row dba_users%rowtype;
    begin
        l_ora_user_row := read_ora_user(p_login_name);

        if (instr(l_ora_user_row.account_status, 'LOCKED') <> 0) then
            execute immediate 'alter user ' || p_login_name || ' account unlock';

            bars_audit.security('Користувача Oracle ' || p_login_name || ' розблоковано');
        end if;
    end;

    procedure set_ora_user_pass_utl(
        p_login_name in varchar2,
        p_oracle_password in varchar2)
    is
        pragma autonomous_transaction;
    begin
        if (p_oracle_password is null) then
            raise_application_error(-20000, 'Пароль користувача не може бути пустим');
        end if;

        execute immediate 'alter user ' || p_login_name || ' identified by ' || p_oracle_password;

        bars_audit.security('Змінено пароль користувача Oracle ' || p_login_name);
    end;

    procedure enable_oracle_authentication(
        p_login_name in varchar2,
        p_identified_by in varchar2,
        p_ora_roles in string_list)
    is
        pragma autonomous_transaction;
    begin
        if (lower(p_login_name) in ('sys', 'system', 'outln', 'scott', 'adams', 'jones', 'clark', 'blake', 'hr', 'oe', 'sh', 'demo',
                                    'anonymous', 'aurora$orb$unauthenticated', 'awr_stage', 'csmig', 'ctxsys', 'dbsnmp', 'dip', 'dmsys',
                                    'dssys', 'exfsys', 'lbacsys', 'mdsys', 'oracle_ocm', 'ordplugins', 'ordsys', 'perfstat', 'tracesvr', 'tsmsys', 'xdb')) then
            raise_application_error(-20000, 'Логін користувача АБС не може співпадати з іменем стандартного користувача Oracle');
        end if;

        if (p_identified_by is null) then
            raise_application_error(-20000, 'Пароль користувача Oracle не вказаний');
        end if;

        if (check_if_ora_user_exists(p_login_name) = 'N') then
            execute immediate 'create user ' || p_login_name || ' identified by ' || p_identified_by;
            execute immediate 'grant create session to ' || p_login_name;

            bars_audit.security('Створено схему Oracle для користувача АБС: ' || p_login_name);
        else
            if (check_if_ora_user_is_locked(p_login_name) = 'Y') then
                unlock_ora_user_utl(p_login_name);
            end if;
        end if;

        reset_ora_user_roles(p_login_name, p_ora_roles);
    end;

    procedure disable_oracle_authentication(
        p_login_name in varchar2)
    is
    begin
        lock_ora_user_utl(p_login_name);
    end;

    -- web-user routine
    function read_web_user(
        p_login_name in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return web_usermap%rowtype
    is
        l_web_user_row web_usermap%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_web_user_row
            from   web_usermap t
            where  t.webuser = lower(p_login_name)
            for update wait 60;
        else
            select *
            into   l_web_user_row
            from   web_usermap t
            where  t.webuser = lower(p_login_name);
        end if;

        return l_web_user_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Користувач з ідентифікатором {' || to_char(p_login_name) || '} не знайдений');
             else return null;
             end if;
    end;

    function check_if_web_user_exists(
        p_login_name in varchar2)
    return char
    is
    begin
        return case when read_web_user(p_login_name, p_raise_ndf => false).webuser is null then 'N'
                    else 'Y'
               end;
    end;

    procedure enable_native_authentication(
        p_user_id in integer,
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_temp_password in varchar2)
    is
    begin
        if (p_temp_password is null) then
            raise_application_error(-20000, 'Пароль користувача для автентифікації в web не вказаний');
        end if;

        insert into web_usermap
        values (lower(p_login_name),
                upper(p_login_name),
                1,
                null,
                p_temp_password,
                p_user_name || ' (Код = ' || p_user_id || ')',
                null,
                0,
                0);

        bars_audit.security('Для користувача {' || p_login_name || '} дозволено автентифікація через веб-інтерфейсі АБС');
    end;

    procedure lock_web_user_utl(
        p_web_user_row in web_usermap%rowtype)
    is
    begin
        if (p_web_user_row.blocked = 1) then
            return;
        end if;

        update web_usermap t
        set    t.blocked = 1
        where  t.webuser = p_web_user_row.webuser;
    end;

    procedure unlock_web_user_utl(
        p_web_user_row in web_usermap%rowtype)
    is
    begin
        if (p_web_user_row.blocked = 0) then
            return;
        end if;

        update web_usermap t
        set    t.blocked = 0
        where  t.webuser = p_web_user_row.webuser;
    end;

    procedure set_web_user_temp_pass_utl(
        p_web_user_row in web_usermap%rowtype,
        p_temp_password in varchar2)
    is
    begin
        if (p_temp_password is null) then
            raise_application_error(-20000, 'Пароль користувача для автентифікації в web не вказаний');
        end if;

        update web_usermap t
        set    t.adminpass = p_temp_password,
               t.webpass = null,
               t.attempts = 0
        where  t.webuser = p_web_user_row.webuser;

        bars_audit.security('Користувачу ' || p_web_user_row.dbuser || ' встановлений технічний пароль для автентифікації у веб-інтерфейсі АБС');
    end;

    procedure set_web_user_pass_utl(
        p_web_user_row in web_usermap%rowtype,
        p_password in varchar2)
    is
    begin
        if (p_password is null) then
            raise_application_error(-20000, 'Пароль користувача для автентифікації в web не вказаний');
        end if;

        update web_usermap t
        set    t.adminpass = null,
               t.webpass = p_password,
               t.attempts = 0,
               t.chgdate = sysdate
        where  t.webuser = p_web_user_row.webuser;

        bars_audit.security('Користувачу ' || p_web_user_row.dbuser || ' встановлений пароль для автентифікації у веб-інтерфейсі АБС');
    end;

    procedure disable_native_authentication(
        p_login_name in varchar2)
    is
    begin
        delete web_usermap t
        where  t.webuser = lower(p_login_name);

        bars_audit.security('Автентифікація користувача ' || p_login_name || ' через веб-інтерфейс АБС заборонена');
    end;

    -- Active Directory user routine
    function read_ad_user(
        p_user_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff_ad_user%rowtype
    is
        l_ad_user_row staff_ad_user%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_ad_user_row
            from   staff_ad_user t
            where  t.user_id = p_user_id
            for update wait 60;
        else
            select *
            into   l_ad_user_row
            from   staff_ad_user t
            where  t.user_id = p_user_id;
        end if;

        return l_ad_user_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Параметри Active Directory для користувача з ідентифікатором {' || to_char(p_user_id) || '} не знайдені');
             else return null;
             end if;
    end;

    function read_ad_user(
        p_active_directory_name in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return staff_ad_user%rowtype
    is
        l_ad_user_row staff_ad_user%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_ad_user_row
            from   staff_ad_user t
            where  t.active_directory_name = upper(p_active_directory_name)
            for update wait 60;
        else
            select *
            into   l_ad_user_row
            from   staff_ad_user t
            where  t.active_directory_name = upper(p_active_directory_name);
        end if;

        return l_ad_user_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Користувач АБС, що відповідає користувачу Active Directory {' || p_active_directory_name || '} не знайдений');
             else return null;
             end if;
    end;

    function get_ad_user_id(
        p_login_name in varchar2)
    return varchar2
    is
    begin
        return read_ad_user(p_login_name, p_raise_ndf => false).user_id;
    end;

    function check_if_ad_user_exists(
        p_user_id in integer)
    return char
    is
    begin
        return case when read_ad_user(p_user_id, p_raise_ndf => false).active_directory_name is null then 'N'
                    else 'Y'
               end;
    end;

    procedure check_ad_user_uniqueness(
        p_user_id in integer)
    is
        l_ad_user_row staff_ad_user%rowtype;
    begin
        l_ad_user_row := read_ad_user(p_user_id, p_raise_ndf => false);

        if (l_ad_user_row.user_id is not null) then
            raise_application_error(-20000, 'Користувач Active Directory з ідентифікатором {' || p_user_id || '} вже зареєстрований');
        end if;
    end;

    procedure check_ad_name_uniqueness(
        p_active_directory_name in varchar2)
    is
    begin
        if (read_ad_user(p_active_directory_name, p_raise_ndf => false).user_id is not null) then
            raise_application_error(-20000, 'Користувач Active Directory {' || p_active_directory_name || '} вже зареєстрований');
        end if;
    end;

    procedure enable_ad_authentication(
        p_user_id in integer,
        p_active_directory_name in varchar2)
    is
    begin
        if (p_user_id is null) then
            raise_application_error(-20000, 'Ідентифкатор користувача в АБС не вказаний');
        end if;

        if (p_active_directory_name is null) then
            raise_application_error(-20000, 'Ім''я користувача в Active Directory не вказано');
        end if;

        check_ad_user_uniqueness(p_user_id);
        check_ad_name_uniqueness(p_active_directory_name);

        insert into staff_ad_user
        values (p_user_id, upper(p_active_directory_name));

        bars_audit.security('Користувачу АБС ' || get_login_name(p_user_id) || ' дозволена автентифікація через Active Directory');
    end;

    procedure disable_ad_authentication(
        p_user_id in integer)
    is
    begin
        delete staff_ad_user t
        where  t.user_id = p_user_id;

        bars_audit.security('Автентифікація користувача ' || get_login_name(p_user_id) || ' в АБС через Active Directory припинена');
    end;

    function create_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in boolean,
        p_extended_access_flag in boolean,
        p_security_token_pass in varchar2)
    return integer
    is
        l_user_id integer;
        l_login_name varchar2(30 char) default upper(p_login_name);

        l_licpermfree number;
        l_lictempfree number;

        l_reclicexp   date;
        l_reclickey   staff$base.chksum%type;

        l_can_select_branch char(1) := case when p_can_select_branch_flag then 'Y' else null end;
        l_policy_group varchar2(30 char);

        function imake_tkey(
            p_recid in integer,
            p_reclogname in varchar2,
            p_recexp in date)
        return varchar2
        is
            l_buf varchar2(1000);
        begin
            -- Функция расчета временной контрольной суммы записи пользователя
            -- Дублируем эту функцию из пакета BARS_USERADM здесь чтобы не выносить в объявление пакета

            l_buf := to_char(p_recid) ||
                     p_reclogname ||
                     '1' ||
                     to_char(p_recexp, 'ddmmyyyyhh24miss');

            return to_hex(dbms_obfuscation_toolkit.md5(input_string=> l_buf));
        end;
    begin
        if (p_login_name is null) then
            raise_application_error(-20000, 'Логін користувача не вказаний');
        end if;

        if (p_user_name is null) then
            raise_application_error(-20000, 'Повне ім''я користувача не може бути пустим');
        end if;

        if (p_branch_code is null) then
            raise_application_error(-20000, 'Код відділення користувача не заповнений');
        end if;

        check_login_name_uniqueness(p_login_name);

        -- розрахунок параметрів ліцензії користувача
        bars_lic.get_user_license(l_licpermfree, l_lictempfree);

        l_user_id := bars_sqnc.get_nextval('s_staff');

        if (l_licpermfree = 0) then
            l_reclicexp := sysdate + 30;
            l_reclickey := imake_tkey(l_user_id, l_login_name, l_reclicexp);
        end if;

        l_policy_group := case when p_extended_access_flag then 'CENTER'
                               else case when p_branch_code = '/' then 'WHOLE'
                                         else 'FILIAL'
                                    end
                               end;

        insert into staff$base(id,
                               fio,
                               logname,
                               bax,
                               type,
                               tabn,
                               disable,
                               clsid,
                               approve,
                               web_profile,
                               policy_group,
                               usearc,
                               cschema,
                               usegtw,
                               active,
                               branch,
                               can_select_branch,
                               created,
                               expired,
                               chksum,
                               chgpwd,
                               tip)
        values (l_user_id,
                p_user_name,
                l_login_name,
                1,
                1,
                p_security_token_pass,
                0,
                0,
                1,
                'DEFAULT_PROFILE',
                l_policy_group,
                0,
                'BARS',
                0,
                1,
                p_branch_code,
                l_can_select_branch,
                sysdate,
                l_reclicexp,
                l_reclickey,
                'Y',
                null);

        bars_lic.set_user_license(l_login_name);

        bars_audit.security('Створюється новий користувач АБС ' || p_user_name || ' (' || p_login_name || ') у відділенні ' || p_branch_code);

        return l_user_id;
    end;

    function create_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in boolean,
        p_extended_access_flag in boolean,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in boolean,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in boolean,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in boolean,
        p_active_directory_name in varchar2,
        p_user_roles in number_list,
        p_approve_roles in boolean default false)
    return integer
    is
        l_user_id integer;
    begin
        l_user_id := create_user(p_login_name, p_user_name, p_branch_code, p_can_select_branch_flag, p_extended_access_flag, p_security_token_pass);

        if (p_use_oracle_auth_flag) then
            enable_oracle_authentication(p_login_name, p_oracle_password, p_oracle_roles);
        end if;

        if (p_use_native_auth_flag) then
            enable_native_authentication(l_user_id,
                            p_login_name,
                            p_user_name,
                            p_core_banking_password_hash);
        end if;

        if (p_use_ad_auth_flag) then
            enable_ad_authentication(l_user_id, p_active_directory_name);
        end if;

        set_user_roles(l_user_id, p_user_roles, p_approve_roles);

        bars_audit.security('Створено користувача {' || p_login_name || ' - ' || p_user_name ||
                            '} у відділенні {' || p_branch_code ||
                            '} ідентифікатор користувача: ' || l_user_id);

        return l_user_id;
    end;

    procedure edit_user(
        p_user_row in staff$base%rowtype,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in boolean,
        p_extended_access_flag in boolean,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in boolean,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in boolean,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in boolean,
        p_active_directory_name in varchar2,
        p_user_roles in number_list)
    is
        l_ora_user_row dba_users%rowtype;
        l_web_user_row web_usermap%rowtype;
        l_ad_user_row staff_ad_user%rowtype;
        l_policy_group varchar2(30 char);
        l_can_select_branch char(1 byte);
    begin
        if (p_user_row.active = 0) then
            raise_application_error(-20000, 'Закритого користувача заборонено редагувати');
        end if;

        if (p_user_name is null) then
            raise_application_error(-20000, 'Повне ім''я користувача не може бути пустим');
        end if;

        if (p_branch_code is null) then
            raise_application_error(-20000, 'Код відділення користувача не заповнений');
        end if;

        if (not tools.equals(p_user_row.fio, p_user_name)) then
            attribute_utl.set_value(p_user_row.id, user_utl.ATTR_CODE_USER_NAME, p_user_name);

            bars_audit.security('ПІБ користувача {' || p_user_row.logname ||
                                '} змінено на {' || p_user_name ||
                                '}, попереднє значення {' || p_user_row.fio || '}');
        end if;

        if (not tools.equals(p_user_row.branch, p_branch_code)) then
            attribute_utl.set_value(p_user_row.id, user_utl.ATTR_CODE_BRANCH, p_branch_code);

            bars_audit.security('Відділення користувача {' || p_user_row.logname ||
                                '} змінено на {' || p_branch_code ||
                                '}, попереднє значення {' || p_user_row.branch || '}');
        end if;

        l_policy_group := case when p_extended_access_flag then 'CENTER'
                               else case when p_branch_code = '/' then 'WHOLE'
                                         else 'FILIAL'
                                    end
                               end;

        if (not tools.equals(p_user_row.policy_group, l_policy_group)) then
            attribute_utl.set_value(p_user_row.id, user_utl.ATTR_CODE_POLICY_GROUP, l_policy_group);

            bars_audit.security('Групу політик користувача {' || p_user_row.logname ||
                                '} змінено на {' || l_policy_group ||
                                '}, попереднє значення {' || p_user_row.policy_group || '}');
        end if;

        l_can_select_branch := case when p_can_select_branch_flag then 'Y' else null end;

        if (not tools.equals(p_user_row.can_select_branch, l_can_select_branch)) then
            attribute_utl.set_value(p_user_row.id, user_utl.ATTR_CODE_CAN_SELECT_BRANCH, l_can_select_branch);

            if (p_can_select_branch_flag) then
                bars_audit.security('Користувачу {' || p_user_row.logname || '} надано право змінювати відділення');
            else
                bars_audit.security('Для користувача {' || p_user_row.logname || '} відмінено право змінювати відділення');
            end if;
        end if;

        if (not tools.equals(p_user_row.tabn, p_security_token_pass)) then
            attribute_utl.set_value(p_user_row.id, user_utl.ATTR_CODE_SECURITY_TOKEN_PASS, p_security_token_pass);

            bars_audit.security('Ключ цифрового підпису користувача {' || p_user_row.logname ||
                                '} змінено на {' || p_security_token_pass ||
                                '}, попереднє значення {' || p_user_row.tabn || '}');
        end if;

        l_ora_user_row := read_ora_user(p_user_row.logname, p_raise_ndf => false);
        if (p_use_oracle_auth_flag) then

            if (l_ora_user_row.username is not null) then
                -- користувач Oracle вже існує - оновимо його параметри

                -- зміна паролю, якщо адміністратор ввів будь-яке значення відмінне від null
                if (p_oracle_password is not null) then
                    set_ora_user_pass_utl(l_ora_user_row.username, p_oracle_password);
                end if;

                -- синхронізація набору ролей користувача Oracle
                reset_ora_user_roles(l_ora_user_row.username, p_oracle_roles);
            else
                -- Користувач Oracle не існує - створюємо його, оскільки адміністратор відмітив
                -- флаг автентифікації за допомогою Oracle
                enable_oracle_authentication(p_user_row.logname, p_oracle_password, p_oracle_roles);
            end if;
        else
            if (l_ora_user_row.username is not null) then
                -- Користувач Oracle існує, а автентифікацію за допомогою Oracle відмінили -
                -- блокуємо користувача Oracle
                lock_ora_user_utl(l_ora_user_row.username);
            end if;
        end if;

        l_web_user_row := read_web_user(p_user_row.logname, p_lock => true, p_raise_ndf => false);
        if (p_use_native_auth_flag) then
            if (l_web_user_row.webuser is not null) then
                if (p_core_banking_password_hash is not null) then
                    set_web_user_temp_pass_utl(l_web_user_row, p_core_banking_password_hash);
                end if;
            else
                enable_native_authentication(p_user_row.id, p_user_row.logname, p_user_row.fio, p_core_banking_password_hash);
            end if;
        else
            if (l_web_user_row.webuser is not null) then
                disable_native_authentication(p_user_row.logname);
            end if;
        end if;

        l_ad_user_row := read_ad_user(p_user_row.id, p_lock => true, p_raise_ndf => false);
        if (p_use_ad_auth_flag) then
            if (p_active_directory_name is null) then
                raise_application_error(-20000, 'Ім''я користувача в Active Directory не заповнено');
            end if;

            if (l_ad_user_row.active_directory_name is not null) then
                begin
                    update staff_ad_user t
                    set    t.active_directory_name = upper(p_active_directory_name)
                    where  t.user_id = p_user_row.id;
                exception
                    when dup_val_on_index then
                         raise_application_error(-20000, 'Користувач Active Directory {' || p_active_directory_name || '} вже зареєстрований');
                end;
            else
                enable_ad_authentication(p_user_row.id, upper(p_active_directory_name));
            end if;
        else
            if (l_ad_user_row.active_directory_name is not null) then
                delete staff_ad_user t
                where t.user_id = p_user_row.id;
            end if;
        end if;


        set_user_roles(p_user_row, p_user_roles, false);
    end;

     procedure set_password(
        p_user_row in staff$base%rowtype,
        p_password_hash in varchar2)
    is
        l_web_user_row web_usermap%rowtype;
    begin
        l_web_user_row := read_web_user(p_user_row.logname, p_lock => true);

        if (l_web_user_row.webuser is null) then
            raise_application_error(-20000, 'Встановлення паролю допускається лише для користувачів, що автентифікуються АБС');
        end if;

        if (p_password_hash is null) then
            raise_application_error(-20000, 'Пароль користувача не може бути пустим');
        end if;

        if (p_password_hash = coalesce(l_web_user_row.webpass, l_web_user_row.adminpass)) then
            raise_application_error(-20000, 'Новий пароль не може повторювати старий');
        end if;

        update web_usermap t
        set    t.webpass = p_password_hash,
               t.adminpass = null,
               t.attempts = 0
        where  t.webuser = l_web_user_row.webuser;

        update staff$base t
        set    t.chgpwd = 'N'
        where  t.id = p_user_row.id;
    end;

    procedure set_temp_password(
        p_user_row in staff$base%rowtype,
        p_password_hash in varchar2)
    is
        l_web_user_row web_usermap%rowtype;
    begin
        l_web_user_row := read_web_user(p_user_row.logname, p_lock => true);

        if (l_web_user_row.webuser is null) then
            raise_application_error(-20000, 'Встановлення паролю допускається лише для користувачів, що автентифікуються АБС');
        end if;

        if (p_password_hash is null) then
            raise_application_error(-20000, 'Пароль користувача не може бути пустим');
        end if;

        update web_usermap t
        set    t.webpass   = null,
               t.adminpass = p_password_hash,
               t.attempts  = 0
        where  t.webuser = l_web_user_row.webuser;

        update staff$base t
        set    t.chgpwd = 'N'
        where  t.id = p_user_row.id;
    end;

    procedure set_ora_password(
        p_user_row in staff$base%rowtype,
        p_password in varchar2)
    is
        l_ora_user_row dba_users%rowtype;
    begin
        l_ora_user_row := read_ora_user(p_user_row.logname);

        set_ora_user_pass_utl(l_ora_user_row.username, p_password);
    end;

    procedure add_password_failure(
        p_user_row in staff$base%rowtype)
    is
        l_fails_count integer;
        l_web_user_row web_usermap%rowtype;
    begin
        l_web_user_row := read_web_user(p_user_row.logname, p_lock => true);

        l_fails_count := nvl(l_web_user_row.attempts, 0) + 1;

        update web_usermap t
        set    t.attempts = l_fails_count
        where  t.webuser = l_web_user_row.webuser;

        if (l_fails_count >= 5) then
            lock_user(p_user_row, 'Перевищена кількість спроб вводу пароля');
        end if;
    end;

    procedure lock_user(
        p_user_row in staff$base%rowtype,
        p_lock_comment in varchar2)
    is
        l_web_user_row web_usermap%rowtype;
    begin
        update staff$base t
        set    t.disable = 1
        where  t.id = p_user_row.id;

        l_web_user_row := read_web_user(p_user_row.logname, p_raise_ndf => false, p_lock => true);

        if (l_web_user_row.webuser is not null) then
            update web_usermap t
            set    t.blocked = 1
            where  t.webuser = l_web_user_row.webuser;
        end if;

        if (check_if_ora_user_exists(p_user_row.logname) = 'Y') then
            lock_ora_user_utl(p_user_row.logname);
        end if;
    end;

    procedure unlock_user(
        p_user_row in staff$base%rowtype)
    is
        l_web_user_row web_usermap%rowtype;
    begin
        update staff$base t
        set    t.disable = 0,
               t.bax = 1
        where  t.id = p_user_row.id;

        l_web_user_row := read_web_user(p_user_row.logname, p_raise_ndf => false, p_lock => true);

        if (l_web_user_row.webuser is not null) then
            update web_usermap t
            set    t.blocked = 0,
                   t.attempts = 0
            where  t.webuser = l_web_user_row.webuser;
        end if;

        if (check_if_ora_user_exists(p_user_row.logname) = 'Y') then
            unlock_ora_user_utl(p_user_row.logname);
        end if;
    end;

    procedure close_user(
        p_user_row in staff$base%rowtype,
        p_force in boolean default false)
    is
    begin
        update staff$base t
        set    t.active = 0
        where  t.id = p_user_row.id;

        if (p_force) then
            for i in (select t.client_id
                      from   user_login_sessions t
                      where  t.user_id = p_user_row.id) loop
                bars_login.clear_session(i.client_id, p_kill_session => 1);
            end loop;
        end if;
    end;

    function get_user_adm_comments(
        p_user_row in staff$base%rowtype)
    return varchar2
    is
        l_adm_comments string_list := string_list();
    begin
/*
        if (verify_user_check_sum(p_user_row) = 'N') then
            l_adm_comments.extend(1);
            l_adm_comments(l_adm_comments.last) := 'Порушена контрольна сума по користувачу';
        end if;

        if (p_user_row.password_expires_at <= sysdate) then
            l_adm_comments.extend(1);
            l_adm_comments(l_adm_comments.last) := 'Термін дії паролю закінчився - користувач повинен змінити пароль';
        elsif (p_user_row.password_expires_at < sysdate + 3) then
            l_adm_comments.extend(1);
            l_adm_comments(l_adm_comments.last) := 'Термін дії паролю спливає через ' || trunc((p_user_row.password_expires_at - sysdate), 0) || ' день (дні)';
        end if;

        if (p_user_row.password_failures_count > 0) then
            l_adm_comments.extend(1);
            l_adm_comments(l_adm_comments.last) := 'Кількість спроб вводу невірного пароля: ' || p_user_row.password_failures_count;
        end if;
*/
        return tools.words_to_string(l_adm_comments, chr(13) || chr(10));
    end;

    function get_resource_access_mode(
        p_user_id in integer,
        p_resource_type_code in varchar2,
        p_resource_id in integer)
    return integer
    is
        l_user_roles number_list;
        l_role_resource_type_id integer;
        l_resource_type_id integer;
        l_resource_access_mode integer default 0;
    begin
        if (p_user_id is null or p_resource_type_code is null or p_resource_id is null) then
            return null;
        end if;

        l_user_roles := user_utl.get_user_roles(p_user_id);

        l_role_resource_type_id := resource_utl.get_resource_type_id('STAFF_ROLE');
        l_resource_type_id := resource_utl.get_resource_type_id(p_resource_type_code);

        begin
            select t.access_mode_id
            into   l_resource_access_mode
            from   adm_resource t
            where  t.grantee_type_id = l_role_resource_type_id and
                   t.grantee_id in (select column_value from table(l_user_roles)) and
                   t.resource_type_id = l_resource_type_id and
                   t.resource_id = p_resource_id;
        exception
            when no_data_found then
                 null;
        end;

        return l_resource_access_mode;
    end;

    function get_resource_access_mode(
        p_user_id in integer,
        p_resource_type_code in varchar2,
        p_resource_code in varchar2)
    return integer
    is
    begin
       return get_resource_access_mode(p_user_id, p_resource_type_code, resource_utl.get_resource_id(p_resource_type_code, p_resource_code));
    end;
end;
/
 show err;
