create or replace package user_adm_ui is

    procedure create_user_meta(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2);

    function create_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2,
        p_user_roles in number_list)
    return integer;

    procedure edit_user(
        p_id in number,
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2);

    procedure edit_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2,
        p_user_roles in number_list);

    procedure get_user_data(
        p_login_name in out varchar2,
        p_user_name out varchar2,
        p_branch_code out varchar2,
        p_branch_name out varchar2,
        p_can_select_branch_flag out number,
        p_extended_access_flag out number,
        p_security_token_pass out varchar2,
        p_user_state_code out varchar2,
        p_user_state_name out varchar2,
        p_use_native_auth_flag out number,
        p_use_oracle_auth_flag out number,
        p_use_ad_auth_flag out number,
        p_active_directory_name out varchar2,
        p_delegated_user_login out varchar2,
        p_delegated_user_name out varchar2,
        p_delegated_from out date,
        p_delegated_through out date,
        p_delegation_comment out varchar2,
        p_user_ora_roles out string_list,
        p_adm_comments out varchar2);

    procedure add_password_failure(
        p_login_name in varchar2);

    procedure change_password(
        p_login_name in varchar2,
        p_password_hash in varchar2);

    procedure set_temp_password(
        p_login_name in varchar2,
        p_password_hash in varchar2);

    procedure change_ora_password(
        p_login_name in varchar2,
        p_password in varchar2);

    procedure lock_user(
        p_login_name in varchar2,
        p_lock_comment in varchar2);

    procedure unlock_user(
        p_login_name in varchar2);

    procedure close_user(
        p_login_name in varchar2);

    procedure change_ora_role(
        p_login_name in varchar2,
        p_role_name  in varchar2,
        p_state in integer);

    procedure delegate_user_role(
        p_id in number,
        p_role_id in integer,
        p_state in integer);

    procedure delegate_user_role(
        p_login_name in varchar2,
        p_role_id in integer);

    procedure revoke_user_role(
        p_login_name in varchar2,
        p_role_id in integer);

    procedure gelegate_user_rights(
        p_login_name in varchar2,
        p_delegated_user_login in varchar2,
        p_delegated_from in date,
        p_delegated_through in date,
        p_delegation_comment in varchar2);

    procedure cancel_user_rights_gelegation(
        p_login_name in varchar2);

    function get_user_adm_comments(
        p_user_id in integer)
    return varchar2;

    function get_user_auth_modes(
        p_user_id in integer,
        p_login_name in varchar2)
    return varchar2;

    function get_user_role_codes(
        p_user_id in integer)
    return string_list;

    function get_resource_access_mode(
        p_user_id in integer,
        p_resource_type_code in varchar2,
        p_resource_code in varchar2)
    return integer;
end;
/
create or replace package body user_adm_ui as

    procedure create_user_meta(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2)
    is
      l_id integer;
    begin
      l_id := create_user(p_login_name,
                          p_user_name,
                          p_branch_code,
                          p_can_select_branch_flag,
                          p_extended_access_flag,
                          p_security_token_pass,
                          p_use_native_auth_flag,
                          p_core_banking_password_hash,
                          p_use_oracle_auth_flag,
                          p_oracle_password,
                          null,
                          p_use_ad_auth_flag,
                          p_active_directory_name,
                          null);
    end;

    function create_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2,
        p_user_roles in number_list)
    return integer
    is
        l_user_id integer;
    begin
        bars_audit.trace('user_adm_ui.create_user' || chr(10) ||
                         'p_login_name                 : ' || p_login_name || chr(10) ||
                         'p_user_name                  : ' || p_user_name || chr(10) ||
                         'p_branch_code                : ' || p_branch_code || chr(10) ||
                         'p_can_select_branch_flag     : ' || p_can_select_branch_flag || chr(10) ||
                         'p_extended_access_flag       : ' || p_extended_access_flag || chr(10) ||
                         'p_security_token_pass        : ' || p_security_token_pass || chr(10) ||
                         'p_use_native_auth_flag       : ' || p_use_native_auth_flag || chr(10) ||
                         'p_core_banking_password_hash : ' || case when p_core_banking_password_hash is null then null else '<some password>' end || chr(10) ||
                         'p_use_oracle_auth_flag       : ' || p_use_oracle_auth_flag || chr(10) ||
                         'p_oracle_password            : ' || case when p_oracle_password is null then null else '<some password>' end || chr(10) ||
                         'p_oracle_roles               : ' || tools.words_to_string(p_oracle_roles, p_ceiling_length => 1000) || chr(10) ||
                         'p_use_ad_auth_flag           : ' || p_use_ad_auth_flag || chr(10) ||
                         'p_active_directory_name      : ' || p_active_directory_name || chr(10) ||
                         'p_user_roles                 : ' || tools.number_list_to_string(p_user_roles));

        l_user_id := user_utl.create_user(p_login_name,
                                          p_user_name,
                                          p_branch_code,
                                          tools.int_to_boolean(p_can_select_branch_flag),
                                          tools.int_to_boolean(p_extended_access_flag),
                                          p_security_token_pass);

        if (p_use_oracle_auth_flag = 1) then
            user_utl.enable_oracle_authentication(p_login_name, p_oracle_password, p_oracle_roles);
        end if;

        if (p_use_native_auth_flag = 1) then
            user_utl.enable_native_authentication(l_user_id,
                            p_login_name,
                            p_user_name,
                            p_core_banking_password_hash);
        end if;

        if (p_use_ad_auth_flag = 1) then
            user_utl.enable_ad_authentication(l_user_id, p_active_directory_name);
        end if;

        user_utl.set_user_roles(l_user_id, p_user_roles, p_approve => false);

        bars_audit.security('Створено користувача {' || p_login_name || ' - ' || p_user_name ||
                            '} у відділенні {' || p_branch_code ||
                            '} ідентифікатор користувача: ' || l_user_id);

        return l_user_id;
    end;

    procedure edit_user(
        p_id in number,
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2)
    is
        l_oracle_roles string_list;
        l_user_roles number_list;
    begin
        l_oracle_roles := user_utl.get_ora_user_roles (p_login_name);
        l_user_roles := user_utl.get_user_roles (p_id);
        edit_user(
        p_login_name,
        p_user_name,
        p_branch_code,
        p_can_select_branch_flag,
        p_extended_access_flag,
        p_security_token_pass,
        p_use_native_auth_flag,
        p_core_banking_password_hash,
        p_use_oracle_auth_flag,
        p_oracle_password,
        l_oracle_roles,
        p_use_ad_auth_flag,
        p_active_directory_name,
        l_user_roles);
    end;

    procedure edit_user(
        p_login_name in varchar2,
        p_user_name in varchar2,
        p_branch_code in varchar2,
        p_can_select_branch_flag in number,
        p_extended_access_flag in number,
        p_security_token_pass in varchar2,
        p_use_native_auth_flag in number,
        p_core_banking_password_hash in varchar2,
        p_use_oracle_auth_flag in number,
        p_oracle_password in varchar2,
        p_oracle_roles in string_list,
        p_use_ad_auth_flag in number,
        p_active_directory_name in varchar2,
        p_user_roles in number_list)
    is
        l_user_row staff$base%rowtype;
    begin
        bars_audit.security('Редагування параметрів користувача {' || p_login_name || ' - ' || p_user_name || '}');

        bars_audit.trace('user_adm_ui.edit_user' || chr(10) ||
                         'p_login_name                 : ' || p_login_name || chr(10) ||
                         'p_user_name                  : ' || p_user_name || chr(10) ||
                         'p_branch_code                : ' || p_branch_code || chr(10) ||
                         'p_can_select_branch_flag     : ' || p_can_select_branch_flag || chr(10) ||
                         'p_extended_access_flag       : ' || p_extended_access_flag || chr(10) ||
                         'p_security_token_pass        : ' || p_security_token_pass || chr(10) ||
                         'p_use_native_auth_flag       : ' || p_use_native_auth_flag || chr(10) ||
                         'p_core_banking_password_hash : ' || case when p_core_banking_password_hash is null then null else '<some password>' end || chr(10) ||
                         'p_use_oracle_auth_flag       : ' || p_use_oracle_auth_flag || chr(10) ||
                         'p_oracle_password            : ' || case when p_oracle_password is null then null else '<some password>' end || chr(10) ||
                         'p_oracle_roles               : ' || tools.words_to_string(p_oracle_roles, p_ceiling_length => 1000) || chr(10) ||
                         'p_use_ad_auth_flag           : ' || p_use_ad_auth_flag || chr(10) ||
                         'p_active_directory_name      : ' || p_active_directory_name || chr(10) ||
                         'p_user_roles                 : ' || tools.number_list_to_string(p_user_roles));

        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.edit_user(l_user_row,
                           p_user_name,
                           p_branch_code,
                           tools.int_to_boolean(p_can_select_branch_flag),
                           tools.int_to_boolean(p_extended_access_flag),
                           p_security_token_pass,
                           tools.int_to_boolean(p_use_native_auth_flag),
                           p_core_banking_password_hash,
                           tools.int_to_boolean(p_use_oracle_auth_flag),
                           p_oracle_password,
                           p_oracle_roles,
                           tools.int_to_boolean(p_use_ad_auth_flag),
                           p_active_directory_name,
                           p_user_roles);
    end;

    procedure get_user_data(
        p_login_name in out varchar2,
        p_user_name out varchar2,
        p_branch_code out varchar2,
        p_branch_name out varchar2,
        p_can_select_branch_flag out number,
        p_extended_access_flag out number,
        p_security_token_pass out varchar2,
        p_user_state_code out varchar2,
        p_user_state_name out varchar2,
        p_use_native_auth_flag out number,
        p_use_oracle_auth_flag out number,
        p_use_ad_auth_flag out number,
        p_active_directory_name out varchar2,
        p_delegated_user_login out varchar2,
        p_delegated_user_name out varchar2,
        p_delegated_from out date,
        p_delegated_through out date,
        p_delegation_comment out varchar2,
        p_user_ora_roles out string_list,
        p_adm_comments out varchar2)
    is
        l_user_row staff$base%rowtype;
        l_state_id integer;
        l_web_user_row web_usermap%rowtype;
        l_ad_user_row staff_ad_user%rowtype;
    begin
        bars_audit.trace('user_adm_ui.get_user_data' || chr(10) ||
                         'p_login_name : ' || p_login_name);

        l_user_row := user_utl.read_user(p_login_name);
        l_web_user_row := user_utl.read_web_user(l_user_row.logname, p_raise_ndf => false);

        p_user_name := l_user_row.fio;
        p_branch_code := l_user_row.branch;
        p_branch_name := branch_utl.get_branch_name(l_user_row.branch);
        p_can_select_branch_flag := tools.boolean_to_int(tools.char_to_boolean(nvl(l_user_row.can_select_branch, 'N')));
        p_extended_access_flag := tools.boolean_to_int(l_user_row.policy_group = 'CENTER');
        p_security_token_pass := l_user_row.tabn;

        l_state_id := case when (l_user_row.active = 0) then user_utl.USER_STATE_CLOSED
                           when (l_user_row.disable = 1 or l_user_row.bax is null or l_user_row.bax = 0 or l_web_user_row.blocked = 1) then user_utl.USER_STATE_LOCKED
                           else user_utl.USER_STATE_ACTIVE
                      end;

        p_user_state_code := list_utl.get_item_code(user_utl.LT_USER_STATE, l_state_id);
        p_user_state_name := list_utl.get_item_name(user_utl.LT_USER_STATE, l_state_id);

        p_use_native_auth_flag := tools.boolean_to_int(tools.char_to_boolean(user_utl.check_if_web_user_exists(l_user_row.logname)));

        p_use_oracle_auth_flag := tools.boolean_to_int(tools.char_to_boolean(user_utl.check_if_ora_user_exists(l_user_row.logname)));
        l_ad_user_row := user_utl.read_ad_user(l_user_row.id, p_raise_ndf => false);

        p_use_ad_auth_flag := tools.boolean_to_int(l_ad_user_row.active_directory_name is not null);
        p_active_directory_name := l_ad_user_row.active_directory_name;

        p_user_ora_roles := user_utl.get_ora_user_roles(l_user_row.logname);

        p_adm_comments := user_utl.get_user_adm_comments(l_user_row);
    end;

    procedure add_password_failure(
        p_login_name in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        -- процедура викликається користувачем до логіну в систему - контекст сесію не піднятий
        -- звернення до функцій, що посилаються на контекстні змінні призведе до помилок і некоректних результатів
        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.add_password_failure(l_user_row);
    end;

    procedure change_password(
        p_login_name in varchar2,
        p_password_hash in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        -- процедура викликається користувачем до логіну в систему - контекст сесію не піднятий
        -- звернення до функцій, що посилаються на контекстні змінні призведе до помилок і некоректних результатів
        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.set_password(l_user_row, p_password_hash);
    exception
        when others then
             rollback;
             bars_audit.error('user_adm_ui.change_password' || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             raise;
    end;

    procedure change_ora_password(
        p_login_name in varchar2,
        p_password in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        bars_audit.trace('user_adm_ui.change_ora_password' || chr(10) ||
                         'p_login_name    : ' || p_login_name || chr(10) ||
                         'p_password_hash : ' || case when p_password is null then null else '<some password>' end);

        bars_audit.security('Зміна пароля користувача Oracle {' || p_login_name || '}');

        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.set_ora_password(l_user_row, p_password);
    end;

    procedure set_temp_password(
        p_login_name in varchar2,
        p_password_hash in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        bars_audit.trace('user_adm_ui.set_temp_password' || chr(10) ||
                         'p_login_name    : ' || p_login_name || chr(10) ||
                         'p_password_hash : ' || case when p_password_hash is null then null else '<some password>' end);

        bars_audit.security('Користувачу {' || p_login_name || '} встановлено технічний пароль');

        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.set_temp_password(l_user_row, p_password_hash);
    exception
        when others then
             rollback;
             bars_audit.error('user_adm_ui.set_temp_password' || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             raise;
    end;

    procedure lock_user(
        p_login_name in varchar2,
        p_lock_comment in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        bars_audit.trace('user_adm_ui.lock_user' || chr(10) ||
                         'p_login_name   : ' || p_login_name || chr(10) ||
                         'p_lock_comment : ' || p_lock_comment);

        bars_audit.security('Блокування користувача {' || p_login_name || '}');

        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.lock_user(l_user_row, p_lock_comment);
    end;

    procedure unlock_user(
        p_login_name in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        bars_audit.trace('user_adm_ui.unlock_user' || chr(10) ||
                         'p_login_name : ' || p_login_name);

        bars_audit.security('Розблокування користувача {' || p_login_name || '}');

        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.unlock_user(l_user_row);
    exception
        when others then
             rollback;
             bars_audit.error('user_adm_ui.unlock_user' || chr(10) ||
                              'p_login_name : ' || p_login_name || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             raise;
    end;

    procedure close_user(
        p_login_name in varchar2)
    is
        l_user_row staff$base%rowtype;
    begin
        bars_audit.trace('user_adm_ui.close_user' || chr(10) ||
                         'p_login_name : ' || p_login_name);

        bars_audit.security('Закриття користувача {' || p_login_name || '}');

        l_user_row := user_utl.read_user(p_login_name, p_lock => true);

        user_utl.close_user(l_user_row);
    end;

    procedure change_ora_role(
        p_login_name in varchar2,
        p_role_name in varchar2,
        p_state in integer)
    is
        l_ora_roles string_list;
    begin
        l_ora_roles := tools.string_to_words(p_role_name);
        if p_state = 1 then
            user_utl.set_ora_user_roles(p_login_name, l_ora_roles);
        else
            user_utl.revoke_ora_user_roles(p_login_name, l_ora_roles);
        end if;
    end;

    procedure delegate_user_role(
        p_id in number,
        p_role_id in integer,
        p_state in integer)
    is
        l_login_name staff$base.logname%type;
    begin
        select logname into l_login_name from staff$base where id = p_id;
        if p_state = 1 then
          delegate_user_role(l_login_name, p_role_id);
        else
          revoke_user_role(l_login_name, p_role_id);
        end if;
    end;

    procedure delegate_user_role(
        p_login_name in varchar2,
        p_role_id in integer)
    is
        l_user_row staff$base%rowtype;
        l_user_resource_type_id integer;
        l_role_resource_type_id integer;
    begin
        l_user_row := user_utl.read_user(p_login_name, p_lock => true);
        l_user_resource_type_id := resource_utl.get_resource_type_id(user_utl.RESOURCE_TYPE_USER);
        l_role_resource_type_id := resource_utl.get_resource_type_id(user_utl.RESOURCE_TYPE_ROLE);
        resource_utl.set_resource_access_mode(l_user_resource_type_id, l_user_row.id, l_role_resource_type_id, p_role_id, 1);
    end;

    procedure revoke_user_role(
        p_login_name in varchar2,
        p_role_id in integer)
    is
        l_user_row staff$base%rowtype;
        l_user_resource_type_id integer;
        l_role_resource_type_id integer;
    begin
        l_user_row := user_utl.read_user(p_login_name, p_lock => true);
        l_user_resource_type_id := resource_utl.get_resource_type_id(user_utl.RESOURCE_TYPE_USER);
        l_role_resource_type_id := resource_utl.get_resource_type_id(user_utl.RESOURCE_TYPE_ROLE);
        resource_utl.set_resource_access_mode(l_user_resource_type_id, l_user_row.id, l_role_resource_type_id, p_role_id, 0);
    end;

    procedure gelegate_user_rights(
        p_login_name in varchar2,
        p_delegated_user_login in varchar2,
        p_delegated_from in date,
        p_delegated_through in date,
        p_delegation_comment in varchar2)
    is
    begin
        null;
    end;

    procedure cancel_user_rights_gelegation(
        p_login_name in varchar2)
    is
    begin
        null;
    end;

    function get_user_adm_comments(
        p_user_id in integer)
    return varchar2
    is
    begin
        return user_utl.get_user_adm_comments(user_utl.read_user(p_user_id));
    end;

    function get_user_auth_modes(
        p_user_id in integer,
        p_login_name in varchar2)
    return varchar2
    is
        l_auth_modes string_list := string_list();

    begin
        if (user_utl.check_if_ora_user_exists(p_login_name) = 'Y') then
            l_auth_modes.extend(1);
            l_auth_modes(l_auth_modes.last) := 'Oracle';
        end if;

        if (user_utl.check_if_web_user_exists(p_login_name) = 'Y') then
            l_auth_modes.extend(1);
            l_auth_modes(l_auth_modes.last) := 'Автентифікація АБС';
        end if;

        if (user_utl.check_if_ad_user_exists(p_user_id) = 'Y') then
            l_auth_modes.extend(1);
            l_auth_modes(l_auth_modes.last) := 'Active Directory';
        end if;

        return tools.words_to_string(l_auth_modes, ' + ');
    end;

    function get_user_role_codes(
        p_user_id in integer)
    return string_list
    is
        l_user_roles string_list;
    begin
        return user_utl.get_user_role_codes(p_user_id);
    end;

    function get_resource_access_mode(
        p_user_id in integer,
        p_resource_type_code in varchar2,
        p_resource_code in varchar2)
    return integer
    is
    begin
       return user_utl.get_resource_access_mode(p_user_id, p_resource_type_code, p_resource_code);
    end;
end;
/
