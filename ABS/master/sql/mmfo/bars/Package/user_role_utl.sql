
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/user_role_utl.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.USER_ROLE_UTL is

    OBJ_TYPE_ROLE                  constant varchar2(30 char) := 'STAFF_ROLE';

    LT_ROLE_STATE                  constant varchar2(30 char) := 'STAFF_ROLE_STATE';
    ROLE_STATE_ACTIVE              constant integer := 1;
    ROLE_STATE_LOCKED              constant integer := 2;
    ROLE_STATE_CLOSED              constant integer := 3;

    ATTR_CODE_ROLE_NAME            constant varchar2(30 char) := 'STAFF_ROLE_NAME';
    ATTR_CODE_ROLE_STATE           constant varchar2(30 char) := 'STAFF_ROLE_STATE';

    RESOURCE_TYPE_ROLE             constant varchar2(30 char) := 'STAFF_ROLE';

    LT_ROLE_RESOURCE_ACCESS_MODE   constant varchar2(30 char) := 'ROLE_RESOURCE_ACCESS_MODE';
    ROLE_ACCESS_MODE_GRANTED       constant integer := 1;
    ROLE_ACCESS_MODE_REVOKED       constant integer := 0;

    function read_role(
        p_role_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return staff_role%rowtype;

    function read_role(
        p_role_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return staff_role%rowtype;

    function get_role_id(
        p_role_code in varchar2)
    return integer;

    function get_role_code(
        p_role_id in integer)
    return integer;

    function get_role_name(
        p_role_id in integer)
    return varchar2;

    function get_role_arms(
        p_role_id in integer)
    return number_list;

    function create_role(
        p_role_code in varchar2,
        p_role_name in varchar2)
    return integer;

    function create_or_replace_role(
        p_role_code in varchar2,
        p_role_name in varchar2)
    return integer;

    procedure edit_role(
        p_role_row in staff_role%rowtype,
        p_role_name in varchar2);

    procedure lock_role(
        p_role_row in staff_role%rowtype);

    procedure unlock_role(
        p_role_row in staff_role%rowtype);

    procedure close_role(
        p_role_row in staff_role%rowtype);

    procedure release_all_resources(
        p_role_id in integer,
        p_approve in boolean default true);

    procedure release_all_resources(
        p_role_code in varchar2,
        p_approve in boolean default true);

    procedure set_resource_access_mode(
        p_role_row in staff_role%rowtype,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer,
        p_approve in boolean default false);

    procedure set_resource_access_mode(
        p_role_code in varchar2,
        p_resource_type_code in varchar2,
        p_resource_code in varchar2,
        p_access_mode_id in integer,
        p_approve in boolean default false);

    procedure grant_arm_to_role(
        p_role_code in varchar2,
        p_arm_code in varchar2,
        p_approve in boolean default false);

    procedure grant_tts_to_role(
        p_role_code in varchar2,
        p_tts_code in varchar2,
        p_approve in boolean default false);

    procedure grant_group_to_role(
        p_role_code in varchar2,
        p_group_id in integer,
        p_access_mode_id in integer,
        p_approve in boolean default false);

    procedure grant_chk_to_role(
        p_role_code in varchar2,
        p_chk_id in integer,
        p_approve in boolean default false);

    procedure grant_klf_to_role(
        p_role_code in varchar2,
        p_kodf in varchar2,
        p_a017 in varchar2,
        p_approve in boolean default false);

    procedure grant_klf_to_role(
        p_role_code in varchar2,
        p_kodf in varchar2,
        p_approve in boolean default false);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.USER_ROLE_UTL as

    function read_role(
        p_role_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return staff_role%rowtype
    is
        l_role_row staff_role%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_role_row
            from   staff_role r
            where  r.id = p_role_id
            for update;
        else
            select *
            into   l_role_row
            from   staff_role r
            where  r.id = p_role_id;
        end if;

        return l_role_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Роль користувача з ідентифікатором {' || p_role_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_role(
        p_role_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return staff_role%rowtype
    is
        l_role_row staff_role%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_role_row
            from   staff_role r
            where  r.role_code = upper(p_role_code)
            for update;
        else
            select *
            into   l_role_row
            from   staff_role r
            where  r.role_code = upper(p_role_code);
        end if;

        return l_role_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Роль користувача з кодом {' || p_role_code || '} не знайдена');
             else return null;
             end if;
    end;

    function get_role_id(
        p_role_code in varchar2)
    return integer
    is
    begin
        return read_role(p_role_code, p_raise_ndf => false).id;
    end;

    function get_role_code(
        p_role_id in integer)
    return integer
    is
    begin
        return read_role(p_role_id, p_raise_ndf => false).role_code;
    end;

    function get_role_name(
        p_role_id in integer)
    return varchar2
    is
    begin
        return read_role(p_role_id, p_raise_ndf => false).role_name;
    end;

    function get_role_arms(
        p_role_id in integer)
    return number_list
    is
    begin
        return resource_utl.get_granted_resources(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                                  p_role_id,
                                                  string_list(user_menu_utl.RESOURCE_TYPE_WEB_ARM, user_menu_utl.RESOURCE_TYPE_CENTURA_ARM));
    end;

    function create_role(
        p_role_code in varchar2,
        p_role_name in varchar2)
    return integer
    is
        l_role_row staff_role%rowtype;
    begin
        l_role_row := read_role(p_role_code, p_lock => true, p_raise_ndf => false);
        if (l_role_row.id is null) then
            insert into staff_role (id, role_code)
            values (s_staff_role.nextval, upper(p_role_code))
            returning id
            into l_role_row.id;

            attribute_utl.set_value(l_role_row.id, user_role_utl.ATTR_CODE_ROLE_NAME, p_role_name);
            attribute_utl.set_value(l_role_row.id, user_role_utl.ATTR_CODE_ROLE_STATE, user_role_utl.ROLE_STATE_ACTIVE);
        else
            if (l_role_row.state_id = user_role_utl.ROLE_STATE_CLOSED) then
                attribute_utl.set_value(l_role_row.id,
                                        user_role_utl.ATTR_CODE_ROLE_NAME,
                                        p_role_name,
                                        p_comment => 'Відновлення ролі із закритих');
                attribute_utl.set_value(l_role_row.id,
                                        user_role_utl.ATTR_CODE_ROLE_STATE,
                                        user_role_utl.ROLE_STATE_ACTIVE,
                                        p_comment => 'Відновлення ролі із закритих');
            else
                raise_application_error(-20000, 'Роль з кодом {' || p_role_code || '} вже зареєстрована');
            end if;
        end if;
        return l_role_row.id;
    end;

    function create_or_replace_role(
        p_role_code in varchar2,
        p_role_name in varchar2)
    return integer
    is
        l_role_row staff_role%rowtype;
    begin
        l_role_row := read_role(p_role_code, p_lock => true, p_raise_ndf => false);
        if (l_role_row.id is null) then
            insert into staff_role (id, role_code)
            values (s_staff_role.nextval, upper(p_role_code))
            returning id
            into l_role_row.id;

            attribute_utl.set_value(l_role_row.id, user_role_utl.ATTR_CODE_ROLE_NAME, p_role_name);
            attribute_utl.set_value(l_role_row.id, user_role_utl.ATTR_CODE_ROLE_STATE, user_role_utl.ROLE_STATE_ACTIVE);
        else
            attribute_utl.set_value(l_role_row.id,
                                    user_role_utl.ATTR_CODE_ROLE_NAME,
                                    p_role_name,
                                    p_comment => 'Перестворення ролі');
            attribute_utl.set_value(l_role_row.id,
                                    user_role_utl.ATTR_CODE_ROLE_STATE,
                                    user_role_utl.ROLE_STATE_ACTIVE,
                                    p_comment => 'Перестворення ролі');
        end if;

        return l_role_row.id;
    end;

    procedure edit_role(
        p_role_row in staff_role%rowtype,
        p_role_name in varchar2)
    is
    begin
        attribute_utl.set_value(p_role_row.id, user_role_utl.ATTR_CODE_ROLE_NAME, p_role_name);
    end;

    procedure lock_role(
        p_role_row in staff_role%rowtype)
    is
    begin
        attribute_utl.set_value(p_role_row.id, user_role_utl.ATTR_CODE_ROLE_STATE, user_role_utl.ROLE_STATE_LOCKED);

        resource_usr.refresh_role_resources(p_role_row.id, false);
    end;

    procedure unlock_role(
        p_role_row in staff_role%rowtype)
    is
    begin
        attribute_utl.set_value(p_role_row.id, user_role_utl.ATTR_CODE_ROLE_STATE, user_role_utl.ROLE_STATE_ACTIVE);

        resource_usr.refresh_role_resources(p_role_row.id, true);
    end;

    procedure close_role(
        p_role_row in staff_role%rowtype)
    is
    begin
        attribute_utl.set_value(p_role_row.id, user_role_utl.ATTR_CODE_ROLE_STATE, user_role_utl.ROLE_STATE_CLOSED);

        resource_usr.refresh_role_resources(p_role_row.id, false);
        resource_utl.release_all_resources(user_role_utl.RESOURCE_TYPE_ROLE, p_role_row.id, p_approve => true);
    end;

    procedure release_all_resources(
        p_role_id in integer,
        p_approve in boolean default true)
    is
    begin
        resource_utl.release_all_resources(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                           p_role_id,
                                           p_approve);
    end;

    procedure release_all_resources(
        p_role_code in varchar2,
        p_approve in boolean default true)
    is
        l_role_row staff_role%rowtype;
    begin
        l_role_row := read_role(p_role_code, p_lock => true);

        resource_utl.release_all_resources(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                           l_role_row.id,
                                           p_approve);
    end;

    procedure set_resource_access_mode(
        p_role_row in staff_role%rowtype,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer,
        p_approve in boolean default false)
    is
    begin
        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                              p_role_row.id,
                                              p_resource_type_id,
                                              p_resource_id,
                                              p_access_mode_id,
                                              p_approve => p_approve);
    end;

    procedure set_resource_access_mode(
        p_role_code in varchar2,
        p_resource_type_code in varchar2,
        p_resource_code in varchar2,
        p_access_mode_id in integer,
        p_approve in boolean default false)
    is
       l_role_row staff_role%rowtype;
       l_resource_id integer;
    begin
        l_role_row := read_role(p_role_code);
        l_resource_id := resource_utl.get_resource_id(p_resource_type_code, p_resource_code);

        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                              l_role_row.id,
                                              resource_utl.get_resource_type_id(p_resource_type_code),
                                              l_resource_id,
                                              p_access_mode_id,
                                              p_approve => p_approve);
    end;

    procedure grant_arm_to_role(
        p_role_code in varchar2,
        p_arm_code in varchar2,
        p_approve in boolean default false)
    is
       l_role_row staff_role%rowtype;
       l_arm_row applist%rowtype;
    begin
        l_role_row := read_role(p_role_code);
        l_arm_row := user_menu_utl.read_arm(p_arm_code);

        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                              l_role_row.id,
                                              resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_arm_row.frontend)),
                                              l_arm_row.id,
                                              user_menu_utl.ARM_ACCESS_MODE_GRANTED,
                                              p_approve => p_approve);
    end;

    procedure grant_tts_to_role(
        p_role_code in varchar2,
        p_tts_code in varchar2,
        p_approve in boolean default false)
    is
       l_role_row staff_role%rowtype;
       l_tts_row tts%rowtype;
    begin
        l_role_row := read_role(p_role_code, p_lock => true);

        begin
            select *
            into   l_tts_row
            from   tts
            where  tt = p_tts_code
            for update wait 60;
        exception
            when no_data_found then
                 raise_application_error(-20000, 'Тип операції з кодом {' || p_tts_code || '} не знайдений');
        end;

        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                              l_role_row.id,
                                              resource_utl.get_resource_type_id('TTS'),
                                              l_tts_row.id,
                                              1,
                                              p_approve => p_approve);
    end;

    procedure grant_group_to_role(
        p_role_code in varchar2,
        p_group_id in integer,
        p_access_mode_id in integer,
        p_approve in boolean default false)
    is
       l_role_row staff_role%rowtype;
       l_group_row groups%rowtype;
    begin
        l_role_row := read_role(p_role_code, p_lock => true);

        begin
            select *
            into   l_group_row
            from   groups
            where  id = p_group_id
            for update wait 60;
        exception
            when no_data_found then
                 raise_application_error(-20000, 'Група доступу з ідентификатором [' || p_group_id || '} не знайдена');
        end;

        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                              l_role_row.id,
                                              resource_utl.get_resource_type_id('ACCOUNT_GROUP'),
                                              l_group_row.id,
                                              p_access_mode_id,
                                              p_approve => p_approve);
    end;

    procedure grant_chk_to_role(
        p_role_code in varchar2,
        p_chk_id in integer,
        p_approve in boolean default false)
    is
       l_role_row staff_role%rowtype;
       l_chklist_row chklist%rowtype;
    begin
        l_role_row := read_role(p_role_code, p_lock => true);

        select *
        into   l_chklist_row
        from   chklist
        where  idchk = p_chk_id
        for update wait 60;

        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                              l_role_row.id,
                                              resource_utl.get_resource_type_id('CHKLIST'),
                                              l_chklist_row.idchk,
                                              1,
                                              p_approve => p_approve);
    end;

    procedure grant_klf_to_role(
        p_role_code in varchar2,
        p_kodf in varchar2,
        p_a017 in varchar2,
        p_approve in boolean default false)
    is
       l_role_row staff_role%rowtype;
       l_klf_row kl_f00$global%rowtype;
    begin
        l_role_row := read_role(p_role_code, p_lock => true);

        begin
            select *
            into   l_klf_row
            from   kl_f00$global
            where  kodf = p_kodf and
                   a017 = p_a017
            for update wait 60;
        exception
            when no_data_found then
                 raise_application_error(-20000, 'Звіт НБУ з кодом {' || p_kodf || '-' || p_a017 || '} не знайдений');
        end;

        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                              l_role_row.id,
                                              resource_utl.get_resource_type_id('KLF'),
                                              l_klf_row.id,
                                              1,
                                              p_approve => p_approve);
    end;

    procedure grant_klf_to_role(
        p_role_code in varchar2,
        p_kodf in varchar2,
        p_approve in boolean default false)
    is
       l_role_row staff_role%rowtype;
       l_klf_ids number_list;
    begin
        l_role_row := read_role(p_role_code, p_lock => true);

        select id
        bulk collect into l_klf_ids
        from   kl_f00$global
        where  kodf = p_kodf
        for update wait 60;

        if (l_klf_ids is empty) then
            raise_application_error(-20000, 'Жодного звіту НБУ з кодом {' || p_kodf || '} не знайдено');
        end if;

        for i in l_klf_ids.first..l_klf_ids.last loop
            resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                                  l_role_row.id,
                                                  resource_utl.get_resource_type_id('KLF'),
                                                  l_klf_ids(i),
                                                  1,
                                                  p_approve => p_approve);
        end loop;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/user_role_utl.sql =========*** End *
 PROMPT ===================================================================================== 
 