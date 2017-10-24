
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/user_role_adm_ui.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.USER_ROLE_ADM_UI is

    function create_role(
        p_role_code in varchar2,
        p_role_name in varchar2)
    return integer;

    procedure edit_role(
        p_role_code in varchar2,
        p_role_name in varchar2);

    procedure lock_role(
        p_role_code in varchar2);

    procedure unlock_role(
        p_role_code in varchar2);

    procedure close_role(
        p_role_code in varchar2);

    procedure set_resource_access_mode(
        p_role_code in varchar2,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.USER_ROLE_ADM_UI as

    function create_role(
        p_role_code in varchar2,
        p_role_name in varchar2)
    return integer
    is
    begin
        bars_audit.info('Створення ролі {' || p_role_code || ', ' || p_role_name || '}');

        if (length(p_role_code) > 255) then
            raise_application_error(-20000, 'Довжина коду ролі не повинна перевищувати 255 символів');
        end if;

        if (length(p_role_name) > 300) then
            raise_application_error(-20000, 'Довжина назви ролі не повинна перевищувати 300 символів');
        end if;

        return user_role_utl.create_role(upper(p_role_code), p_role_name);
    end;

    procedure edit_role(
        p_role_code in varchar2,
        p_role_name in varchar2)
    is
        l_role_row staff_role%rowtype;
    begin
        bars_audit.info('Редагування ролі {' || p_role_code || '}');

        if (length(p_role_name) > 300) then
            raise_application_error(-20000, 'Довжина назви ролі не повинна перевищувати 300 символів');
        end if;

        l_role_row := user_role_utl.read_role(p_role_code, p_lock => true);

        user_role_utl.edit_role(l_role_row, p_role_name);
    end;

    procedure lock_role(
        p_role_code in varchar2)
    is
        l_role_row staff_role%rowtype;
    begin
        bars_audit.info('Блокування ролі {' || p_role_code || '}');

        l_role_row := user_role_utl.read_role(p_role_code, p_lock => true);

        user_role_utl.lock_role(l_role_row);
    end;

    procedure unlock_role(
        p_role_code in varchar2)
    is
        l_role_row staff_role%rowtype;
    begin
        bars_audit.info('Активація ролі {' || p_role_code || '}');

        l_role_row := user_role_utl.read_role(p_role_code, p_lock => true);

        user_role_utl.unlock_role(l_role_row);
    end;

    procedure close_role(
        p_role_code in varchar2)
    is
        l_role_row staff_role%rowtype;
    begin
        bars_audit.info('Закриття ролі {' || p_role_code || '}');

        l_role_row := user_role_utl.read_role(p_role_code, p_lock => true);

        user_role_utl.close_role(l_role_row);
    end;

    procedure set_resource_access_mode(
        p_role_code in varchar2,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer)
    is
        l_role_row staff_role%rowtype;
    begin
        bars_audit.info('Оновлення ресурсів ролі {' || p_role_code ||
                        '} - тип ресурсу: ' || resource_utl.get_resource_type_name(p_resource_type_id) ||
                        ', id ресурсу: ' || p_resource_id ||
                        ', тип доступу: ' || p_access_mode_id);

        l_role_row := user_role_utl.read_role(p_role_code, p_lock => true);

        user_role_utl.set_resource_access_mode(l_role_row, p_resource_type_id, p_resource_id, p_access_mode_id);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  USER_ROLE_ADM_UI ***
grant EXECUTE                                                                on USER_ROLE_ADM_UI to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/user_role_adm_ui.sql =========*** En
 PROMPT ===================================================================================== 
 