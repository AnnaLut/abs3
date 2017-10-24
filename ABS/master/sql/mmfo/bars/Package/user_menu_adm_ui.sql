
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/user_menu_adm_ui.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.USER_MENU_ADM_UI is

    function create_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer)
    return integer;

    procedure edit_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer);

    procedure remove_arm(
        p_arm_code in varchar2);

    function check_if_arm_has_resources(
        p_arm_code in varchar2)
    return integer;

    procedure set_resource_access_mode(
        p_arm_code in varchar2,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.USER_MENU_ADM_UI as

    function create_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer)
    return integer
    is
    begin
        return user_menu_utl.create_arm(p_arm_code, p_arm_name, p_application_type_id);
    end;

    procedure edit_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer)
    is
        l_arm_row applist%rowtype;
    begin
        l_arm_row := user_menu_utl.read_arm(p_arm_code, p_lock => true);

        user_menu_utl.edit_arm(l_arm_row, p_arm_name, p_application_type_id);
    end;

    procedure remove_arm(
        p_arm_code in varchar2)
    is
        l_arm_row applist%rowtype;
        l_arm_roles number_list;
        l_arm_role_names string_list;
        l integer;
    begin
        l_arm_row := user_menu_utl.read_arm(p_arm_code, p_lock => true);

        l_arm_roles := resource_utl.get_resource_grantees(l_arm_row.id,
                                                          user_menu_utl.get_arm_resource_type_id(l_arm_row.frontend),
                                                          resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE));
        if (l_arm_roles is not null and l_arm_roles is not empty) then
            l_arm_role_names := string_list();
            l := l_arm_roles.first;
            while (l is not null) loop
                l_arm_role_names.extend(1);
                l_arm_role_names(l_arm_role_names.last) := user_role_utl.get_role_name(l_arm_roles(l));
                l := l_arm_roles.next(l);
            end loop;

            raise_application_error(-20000, 'АРМ {' || p_arm_code || '} виданий ролям: ' ||
                                            tools.words_to_string(l_arm_role_names,
                                                                  p_splitting_symbol => ', ',
                                                                  p_ceiling_length => 200,
                                                                  p_ignore_nulls => 'Y'));
        end if;

        user_menu_utl.remove_arm(l_arm_row);
    end;

    function check_if_arm_has_resources(
        p_arm_code in varchar2)
    return integer
    is
        l_arm_row applist%rowtype;
    begin
        l_arm_row := user_menu_utl.read_arm(p_arm_code);

        return case when resource_utl.check_if_grantee_has_any_res(
                             resource_utl.get_resource_type_id(
                                 user_menu_utl.get_arm_resource_type_code(l_arm_row.frontend)),
                             l_arm_row.id) = 'Y' then 1
                    else 0
               end;
    end;

    procedure set_resource_access_mode(
        p_arm_code in varchar2,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer)
    is
        l_arm_row applist%rowtype;
    begin
        l_arm_row := user_menu_utl.read_arm(p_arm_code, p_lock => true);

        resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_arm_row.frontend)),
                                              l_arm_row.id,
                                              p_resource_type_id,
                                              p_resource_id,
                                              p_access_mode_id);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  USER_MENU_ADM_UI ***
grant EXECUTE                                                                on USER_MENU_ADM_UI to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/user_menu_adm_ui.sql =========*** En
 PROMPT ===================================================================================== 
 