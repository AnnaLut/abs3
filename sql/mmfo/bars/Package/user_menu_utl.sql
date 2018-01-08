
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/user_menu_utl.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.USER_MENU_UTL is
------------------------------------------------------------------
--
--  Пакет внутреннего пользования для управления ресурсами АРМ-а
--
------------------------------------------------------------------

    APPLICATION_TYPE_CENTURA       constant integer := 0;
    APPLICATION_TYPE_WEB           constant integer := 1;

    RESOURCE_TYPE_WEB_ARM          constant varchar2(30 char) := 'ARM_WEB';
    RESOURCE_TYPE_CENTURA_ARM      constant varchar2(30 char) := 'ARM_CENTURA';

    LT_ARM_ACCESS_MODE             constant varchar2(30 char) := 'COMMON_RESOURCE_ACCESS_MODE';
    ARM_ACCESS_MODE_NO_ACCESS      constant integer := 0;
    ARM_ACCESS_MODE_GRANTED        constant integer := 1;

    RESOURCE_TYPE_WEB_FUNCTION     constant varchar2(30 char) := 'FUNCTION_WEB';
    RESOURCE_TYPE_CENTURA_FUNCTION constant varchar2(30 char) := 'FUNCTION_CENTURA';
    RESOURCE_TYPE_REPORT           constant varchar2(30 char) := 'REPORTS';
    RESOURCE_TYPE_REFERENCE        constant varchar2(30 char) := 'DIRECTORIES';

    LT_FUNCTION_ACCESS_MODE        constant varchar2(30 char) := 'COMMON_RESOURCE_ACCESS_MODE';
    FUNC_ACCESS_MODE_NO_ACCESS     constant integer := 0;
    FUNC_ACCESS_MODE_GRANTED       constant integer := 1;


    LT_REPORT_ACCESS_MODE          constant varchar2(30 char) := 'COMMON_RESOURCE_ACCESS_MODE';
    REP_ACCESS_MODE_NO_ACCESS      constant integer := 0;
    REP_ACCESS_MODE_GRANTED        constant integer := 1;

    LT_DIRECTORY_ACCESS_MODE       constant varchar2(30 char) := 'DIRECTORY_ACCESS_MODE';
    DIR_ACCESS_MODE_NO_ACCESS      constant integer := 0; -- NO Відсутній
    DIR_ACCESS_MODE_READ_ONLY      constant integer := 1; -- RO Перегляд
    DIR_ACCESS_MODE_READ_WRITE     constant integer := 2; -- RW Редагування

    function read_arm(
        p_arm_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return applist%rowtype;

    function read_arm(
        p_arm_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return applist%rowtype;

    function get_arm_id(
        p_arm_code in varchar2)
    return integer;

    function get_arm_code(
        p_arm_id in integer)
    return varchar2;

    function get_arm_functions(
        p_arm_id in integer)
    return number_list;

    function create_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer)
    return integer;

    procedure edit_arm(
        p_arm_row in applist%rowtype,
        p_arm_name in varchar2,
        p_application_type_id in integer);

   -----------------------------------------------------------------
   --    cor_arm
   --
   --   create or replace ARM
   --
    procedure cor_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer);

    procedure remove_arm(
        p_arm_row in applist%rowtype);

    procedure remove_arm(
        p_arm_code in varchar2);

    function get_arm_resource_type_code(
        p_application_type_id in integer)
    return varchar2;

    function get_func_resource_type_code(
        p_application_type_id in integer)
    return varchar2;

    function get_arm_resource_type_id(
        p_application_type_id in integer)
    return integer;

    function get_func_resource_type_id(
        p_application_type_id in integer)
    return integer;

    function get_reference_resource_type_id
    return integer;

    function get_report_resource_type_id
    return integer;

    procedure set_resource_access_mode(
        p_arm_row in applist%rowtype,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer);

    procedure release_arm_resources(
        p_arm_id in integer,
        p_approve in boolean default true);

    procedure release_arm_resources(
        p_arm_code in varchar2,
        p_approve in boolean default true);

    procedure remove_function(
        p_function_id in integer);

    procedure remove_function(
        p_function_path in varchar2);

    --------------------------------------------------------------
    --
    --  add_func2arm
    --
    --  добавить функцию в АРМ
    --
    procedure add_func2arm(
        p_func_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    procedure remove_func_from_arm(
        p_func_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    --------------------------------------------------------------
    --
    --  add_report2arm
    --
    --  добавить отчет в АРМ по коду отчета
    --
    procedure add_report2arm(
        p_report_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    procedure remove_report_from_arm(
        p_report_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    --------------------------------------------------------------
    --
    --  add_refernce2arm
    --
    --  добавить справочник в АРМ по коду справочника
    --
    procedure add_reference2arm(
        p_reference_id references.tabid%type,
        p_arm_code applist.codeapp%type,
        p_access_mode_id in integer,
        p_approve number default 0);

    procedure remove_reference_from_arm(
        p_reference_id references.tabid%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

  --------------------------------------------------------------
    --
    --  add_func2arm_bypath
    --
    --  добавить функцию в АРМ по коду вызова функции
    --
    procedure add_func2arm_bypath(
        p_func_path operlist.funcname%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    procedure remove_func_from_arm_bypath(
        p_func_path operlist.funcname%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    --------------------------------------------------------------
    --
    --  add_report2arm_byname
    --
    --  добавить отчет в АРМ по наименованию отчета
    --
    procedure add_report2arm_byname(
        p_report_name reports.name%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    procedure remove_report_from_arm_byname(
        p_report_name reports.name%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);

    --------------------------------------------------------------
    --
    --  add_report2arm_by_folder
    --
    --  добавить в АРМ все отчеты, содержащиеся в заданой папке
    --
    procedure add_report2arm_by_folder(
        p_folder_id in integer,
        p_arm_code in varchar2,
        p_approve number default 0);

    procedure remove_rep_from_arm_by_folder(
        p_folder_id in integer,
        p_arm_code in varchar2,
        p_approve number default 0);

   --------------------------------------------------------------
    --
    --  add_refernce2arm_bytabname
    --
    --  добавить справочник в АРМ по имени таблицы справочника
    --
    procedure add_reference2arm_bytabname(
        p_reference_tabname meta_tables.tabname%type,
        p_arm_code applist.codeapp%type,
        p_access_mode_id in integer,
        p_approve number default 0);

    procedure remove_ref_from_arm_bytabname(
        p_reference_tabname meta_tables.tabname%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.USER_MENU_UTL as
------------------------------------------------------------------
--
--  Пакет внутреннего пользования для управления АРМ-ами и его ресурсами
--
------------------------------------------------------------------

    G_TRACE  varchar2(50) := 'user_menu_utl.';

    -----------------------------------------------------------------
    --   read_arm
    --
    function read_arm(
        p_arm_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return applist%rowtype
    is
        l_arm_row applist%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_arm_row
            from   applist a
            where  a.id = p_arm_id
            for update;
        else
            select *
            into   l_arm_row
            from   applist a
            where  a.id = p_arm_id;
        end if;

        return l_arm_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'АРМ з ідентифікатором {' || p_arm_id || '} не знайдений');
             else return null;
             end if;
    end;

    -----------------------------------------------------------------
    --   read_arm
    --
    function read_arm(
        p_arm_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return applist%rowtype
    is
        l_arm_code varchar2(30 char) := p_arm_code;
        l_arm_row applist%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_arm_row
            from   applist a
            where  a.codeapp = l_arm_code
            for update;
        else
            select *
            into   l_arm_row
            from   applist a
            where  a.codeapp = l_arm_code;
        end if;

        return l_arm_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'АРМ з кодом {' || p_arm_code || '} не знайдений');

             else return null;
             end if;
    end;

    -----------------------------------------------------------------
    --   get_arm_id
    --
    function get_arm_id(
        p_arm_code in varchar2)
    return integer
    is
    begin
        return read_arm(p_arm_code, p_raise_ndf => false).id;
    end;

    -----------------------------------------------------------------
    --   get_arm_code
    --
    function get_arm_code(
        p_arm_id in integer)
    return varchar2
    is
    begin
        return read_arm(p_arm_id, p_raise_ndf => false).codeapp;
    end;

    -----------------------------------------------------------------
    --   check_arm_code_uniqueness
    --
    procedure check_arm_code_uniqueness(
        p_arm_code in varchar2)
    is
        l_arm_row applist%rowtype;
    begin
        l_arm_row := read_arm(p_arm_code, p_raise_ndf => false);

        if (l_arm_row.codeapp is not null) then
            raise_application_error(-20000, 'АРМ з кодом {' || p_arm_code || '} вже існує');
        end if;
    end;
    -----------------------------------------------------------------
    --   create_arm
    --
    function create_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer)
    return integer
    is
        l_arm_id number(38);
    begin
        if (length(p_arm_code) > 30) then
            raise_application_error(-20000, 'Код АРМу не може перевищувати довжину в 30 символів');
        end if;

        if (p_application_type_id not in (user_menu_utl.APPLICATION_TYPE_CENTURA, user_menu_utl.APPLICATION_TYPE_WEB)) then
            raise_application_error(-20000, 'Неочікуваний тип клієнтської програми з ідентифікатором {' || p_application_type_id || '}');
        end if;

        check_arm_code_uniqueness(p_arm_code);

        insert into applist
        values (p_arm_code, p_arm_name, null, p_application_type_id, s_applist.nextval)
        returning id
        into l_arm_id;

        return l_arm_id;
    end;

    -----------------------------------------------------------------
    --   edit_arm
    --
    procedure edit_arm(
        p_arm_row in applist%rowtype,
        p_arm_name in varchar2,
        p_application_type_id in integer)
    is
    begin
        if (p_application_type_id not in (user_menu_utl.APPLICATION_TYPE_CENTURA, user_menu_utl.APPLICATION_TYPE_WEB)) then
            raise_application_error(-20000, 'Неочікуваний тип клієнтської програми з ідентифікатором {' || p_application_type_id || '}');
        end if;

        update applist t
        set    t.name = p_arm_name,
               t.frontend = p_application_type_id
        where  t.id = p_arm_row.id;
    end;

   -----------------------------------------------------------------
   --    COR_ARM
   --
   --   create or replace ARM
   --
   procedure cor_arm(
        p_arm_code in varchar2,
        p_arm_name in varchar2,
        p_application_type_id in integer)
    is
        l_arm_row applist%rowtype;
    begin
        if (p_application_type_id not in (user_menu_utl.APPLICATION_TYPE_CENTURA, user_menu_utl.APPLICATION_TYPE_WEB)) then
            raise_application_error(-20000, 'Неочікуваний тип клієнтської програми з ідентифікатором {' || p_application_type_id || '}');
        end if;

        l_arm_row := read_arm(p_arm_code, p_lock => true, p_raise_ndf => false);

        if (l_arm_row.id is null) then
            if (length(p_arm_code) > 30) then
                raise_application_error(-20000, 'Код АРМу не може перевищувати довжину в 30 символи');
            end if;

	     loop
                begin
                    insert into applist
                    values (p_arm_code, p_arm_name, null, p_application_type_id, s_applist.nextval);
                    exit;
                exception when dup_val_on_index then
                   null; -- давим, чтобы просто sequence увеличился, пока не найдем что вставить
                end;
            end loop;
        else
            update applist t
            set    t.name = p_arm_name,
                   t.frontend = p_application_type_id
            where  t.id = l_arm_row.id;
        end if;
    end;

    -----------------------------------------------------------------
    --   remove_arm
    --
    procedure remove_arm(
        p_arm_row in applist%rowtype)
    is
    begin
        resource_utl.release_all_resources(get_arm_resource_type_code(p_arm_row.frontend), p_arm_row.id, p_approve => true);

        delete operapp_acs t
        where  t.codeapp = p_arm_row.codeapp;

        delete operapp t
        where  t.codeapp = p_arm_row.codeapp;

        delete refapp t
        where  t.codeapp = p_arm_row.codeapp;

        delete app_rep t
        where  t.codeapp = p_arm_row.codeapp;

        delete applist_staff t
        where  t.codeapp = p_arm_row.codeapp;

        delete applist t
        where  t.id = p_arm_row.id;

        bars_audit.security('АРМ {' || p_arm_row.codeapp || ' - ' || p_arm_row.name || '} з ідентифікатором {' || p_arm_row.id || '} видалено');
    end;

    procedure remove_arm(
        p_arm_code in varchar2)
    is
    begin
        remove_arm(read_arm(p_arm_code, p_lock => true));
    end;

    -----------------------------------------------------------------
    --   get_arm_resource_type_code
    --
    function get_arm_resource_type_code(
        p_application_type_id in integer)
    return varchar2
    is
    begin
        return case when p_application_type_id = user_menu_utl.APPLICATION_TYPE_WEB then user_menu_utl.RESOURCE_TYPE_WEB_ARM
                    else user_menu_utl.RESOURCE_TYPE_CENTURA_ARM
               end;
    end;

    -----------------------------------------------------------------
    --   get_func_resource_type_code
    --
    function get_func_resource_type_code(
        p_application_type_id in integer)
    return varchar2
    is
    begin
        return case when p_application_type_id = user_menu_utl.APPLICATION_TYPE_WEB then user_menu_utl.RESOURCE_TYPE_WEB_FUNCTION
                    else user_menu_utl.RESOURCE_TYPE_CENTURA_FUNCTION
               end;
    end;

    -----------------------------------------------------------------
    --   get_arm_resource_type_id
    --
    function get_arm_resource_type_id(
        p_application_type_id in integer)
    return integer
    is
    begin
        return resource_utl.get_resource_type_id(get_arm_resource_type_code(p_application_type_id));
    end;

    -----------------------------------------------------------------
    --   get_func_resource_type_id
    --
    function get_func_resource_type_id(
        p_application_type_id in integer)
    return integer
    is
    begin
        return resource_utl.get_resource_type_id(get_func_resource_type_code(p_application_type_id));
    end;

    -----------------------------------------------------------------
    --   get_report_resource_type_id
    --
    function get_report_resource_type_id
    return integer
    is
    begin
        return resource_utl.get_resource_type_id( user_menu_utl.RESOURCE_TYPE_REPORT);
    end;

    -----------------------------------------------------------------
    --   get_reference_resource_type_id
    --
    function get_reference_resource_type_id
    return integer
    is
    begin
        return resource_utl.get_resource_type_id(user_menu_utl.RESOURCE_TYPE_REFERENCE);
    end;

    -----------------------------------------------------------------
    --   get_arm_functions
    --
    function get_arm_functions(
        p_arm_id in integer)
    return number_list
    is
        l_arm_row applist%rowtype;
    begin
        l_arm_row := read_arm(p_arm_id);

        return resource_utl.get_granted_resources(get_arm_resource_type_id(l_arm_row.frontend),
                                                  p_arm_id,
                                                  number_list(get_func_resource_type_id(l_arm_row.frontend)));
    end;

    -----------------------------------------------------------------
    --   set_resource_access_mode
    --
    procedure set_resource_access_mode(
        p_arm_row in applist%rowtype,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer)
    is
    begin
        resource_utl.set_resource_access_mode(get_arm_resource_type_id(p_arm_row.frontend),
                                              p_arm_row.id,
                                              p_resource_type_id,
                                              p_resource_id,
                                              p_access_mode_id);
    end;

    procedure release_arm_resources(
        p_arm_row in applist%rowtype,
        p_approve in boolean default true)
    is
    begin
        resource_utl.release_all_resources(get_arm_resource_type_id(p_arm_row.frontend),
                                           p_arm_row.id,
                                           p_approve => p_approve);

        delete operapp t where t.codeapp = p_arm_row.codeapp;
        delete refapp t where t.codeapp = p_arm_row.codeapp;
        delete app_rep t where t.codeapp = p_arm_row.codeapp;
    end;

    procedure release_arm_resources(
        p_arm_id in integer,
        p_approve in boolean default true)
    is
        l_arm_row applist%rowtype;
    begin
        l_arm_row := read_arm(p_arm_id, p_lock => true);

        release_arm_resources(l_arm_row, p_approve => p_approve);
    end;

    procedure release_arm_resources(
        p_arm_code in varchar2,
        p_approve in boolean default true)
    is
        l_arm_row applist%rowtype;
    begin
        l_arm_row := read_arm(p_arm_code, p_lock => true);

        release_arm_resources(l_arm_row, p_approve => p_approve);
    end;

    -----------------------------------------------------------------
    --   read_func
    --
    function read_function(
        p_function_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return operlist%rowtype
    is
        l_function_row operlist%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_function_row
            from   operlist a
            where  a.codeoper = p_function_id
            for update;
        else
            select *
            into   l_function_row
            from   operlist a
            where  a.codeoper = p_function_id;
        end if;

        return l_function_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Функція з кодом {' || p_function_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_function(
        p_function_path in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return operlist%rowtype
    is
        l_function_row operlist%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_function_row
            from   operlist a
            where  a.funcname = p_function_path
            for update;
        else
            select *
            into   l_function_row
            from   operlist a
            where  a.funcname = p_function_path;
        end if;

        return l_function_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Функція з кодом виклику {' || p_function_path || '} не знайдена');
             else return null;
             end if;
    end;

    -----------------------------------------------------------------
    --   read_report
    --
    function read_report(
        p_report_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return reports%rowtype
    is
        l_report_row reports%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_report_row
            from   reports a
            where  a.id = p_report_id
            for update;
        else
            select *
            into   l_report_row
            from   reports a
            where  a.id = p_report_id;
        end if;

        return l_report_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Звіт з кодом {' || p_report_id || '} не знайдено');
             else return null;
             end if;
    end;

    -----------------------------------------------------------------
    --   read_reference
    --
    function read_reference(
        p_reference_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return references%rowtype
    is
        l_reference_row references%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_reference_row
            from   references a
            where  a.tabid = p_reference_id
            for update;
        else
            select *
            into   l_reference_row
            from   references a
            where  a.tabid = p_reference_id;
        end if;

        return l_reference_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Довідник з кодом {' || p_reference_id || '} не знайдено');
             else return null;
             end if;
    end;

    procedure remove_function(
        p_function_row in operlist%rowtype)
    is
    begin
        if (p_function_row.codeoper is null) then
            return;
        end if;

        delete operapp t
        where  t.codeoper = p_function_row.codeoper;

        delete list_funcset t
        where  t.func_id = p_function_row.codeoper;

        update meta_columns t
        set    t.oper_id = null
        where  t.oper_id = p_function_row.codeoper;

        delete operlist_deps t
        where  p_function_row.codeoper in (t.id_parent, t.id_child);

        delete operlist t
        where  t.codeoper = p_function_row.codeoper;
    end;

    procedure remove_function(
        p_function_id in integer)
    is
    begin
        remove_function(read_function(p_function_id, p_lock => true, p_raise_ndf => false));
    end;

    procedure remove_function(
        p_function_path in varchar2)
    is
    begin
        remove_function(read_function(p_function_path, p_lock => true, p_raise_ndf => false));
    end;

    procedure set_function_access_mode(
        p_function_id in integer,
        p_arm_code in varchar2,
        p_access_mode_id in integer,
        p_approve in boolean default false)
    is
        l_trace varchar2(1000) := g_trace||'set_function_access_mode: ';
        l_arm_row applist%rowtype;
        l_function_row operlist%rowtype;
    begin
        l_arm_row := read_arm( p_arm_code => p_arm_code);
        l_function_row := read_function( p_function_id => p_function_id);

        resource_utl.set_resource_access_mode(user_menu_utl.get_arm_resource_type_id(l_arm_row.frontend),
                                              l_arm_row.id,
                                              user_menu_utl.get_func_resource_type_id(l_arm_row.frontend),
                                              l_function_row.codeoper,
                                              p_access_mode_id,
                                              p_approve => p_approve);

        bars_audit.info(l_trace || 'функции ' || p_function_id ||
                                   ' установлен режим доступа ' || list_utl.get_item_name(user_menu_utl.LT_FUNCTION_ACCESS_MODE, p_access_mode_id) ||
                                   ' в составе АРМа ' || p_arm_code);
    end;

    procedure set_report_access_mode(
        p_report_id in integer,
        p_arm_code in varchar2,
        p_access_mode_id in integer,
        p_approve in boolean default false)
    is
        l_trace varchar2(1000) := g_trace||'set_report_access_mode: ';
        l_arm_row applist%rowtype;
        l_report_row reports%rowtype;
    begin
        l_arm_row := read_arm( p_arm_code => p_arm_code);
        l_report_row := read_report( p_report_id => p_report_id);

        resource_utl.set_resource_access_mode(user_menu_utl.get_arm_resource_type_id(l_arm_row.frontend),
                                              l_arm_row.id,
                                              user_menu_utl.get_report_resource_type_id(),
                                              l_report_row.id,
                                              p_access_mode_id,
                                              p_approve => p_approve);

        bars_audit.info(l_trace || 'отчету ' || p_report_id ||
                                   ' установлен режим доступа ' || list_utl.get_item_name(user_menu_utl.LT_REPORT_ACCESS_MODE, p_access_mode_id) ||
                                   ' в составе АРМа ' || p_arm_code);
    end;

    procedure set_reference_access_mode(
        p_reference_id in integer,
        p_arm_code in varchar2,
        p_access_mode_id in integer,
        p_approve in boolean default false)
    is
        l_trace varchar2(1000) := g_trace||'set_reference_access_mode: ';
        l_arm_row applist%rowtype;
        l_reference_row references%rowtype;
    begin
        l_arm_row := read_arm( p_arm_code => p_arm_code);
        l_reference_row := read_reference( p_reference_id => p_reference_id);

        resource_utl.set_resource_access_mode(user_menu_utl.get_arm_resource_type_id(l_arm_row.frontend),
                                              l_arm_row.id,
                                              user_menu_utl.get_reference_resource_type_id(),
                                              l_reference_row.tabid,
                                              p_access_mode_id,
                                              p_approve => p_approve);

        bars_audit.info(l_trace || 'справочнику ' || p_reference_id ||
                                   ' установлен режим доступа ' || list_utl.get_item_name(user_menu_utl.LT_REPORT_ACCESS_MODE, p_access_mode_id) ||
                                   ' в составе АРМа ' || p_arm_code);
    end;

    --------------------------------------------------------------
    --
    --  add_func2arm
    --
    --  добавить функцию в АРМ по идентификатору функции
    --
    procedure add_func2arm(
        p_func_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
    begin
        set_function_access_mode(p_func_id, p_arm_code, user_menu_utl.FUNC_ACCESS_MODE_GRANTED, p_approve => tools.int_to_boolean(p_approve));
    end;

    procedure remove_func_from_arm(
        p_func_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
    begin
        set_function_access_mode(p_func_id, p_arm_code, user_menu_utl.FUNC_ACCESS_MODE_NO_ACCESS, p_approve => tools.int_to_boolean(p_approve));
    end;

    --------------------------------------------------------------
    --
    --  add_func2arm_bypath
    --
    --  добавить функцию в АРМ по коду вызова функции
    --
    procedure add_func2arm_bypath(
        p_func_path operlist.funcname%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
    begin
        add_func2arm(p_func_id  => read_function(p_func_path).codeoper, p_arm_code=> p_arm_code, p_approve => p_approve);
    end;

    procedure remove_func_from_arm_bypath(
        p_func_path operlist.funcname%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
    begin
        remove_func_from_arm(p_func_id  => read_function(p_func_path).codeoper, p_arm_code => p_arm_code, p_approve => p_approve);
    end;

    --------------------------------------------------------------
    --
    --  add_report2arm
    --
    --  добавить отчет в АРМ по коду отчета
    --
    procedure add_report2arm(
        p_report_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
    begin
        set_report_access_mode(p_report_id, p_arm_code, user_menu_utl.REP_ACCESS_MODE_GRANTED, p_approve => tools.int_to_boolean(p_approve));
    end;

    procedure remove_report_from_arm(
        p_report_id operlist.codeoper%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
    begin
        set_report_access_mode(p_report_id, p_arm_code, user_menu_utl.REP_ACCESS_MODE_NO_ACCESS, p_approve => tools.int_to_boolean(p_approve));
    end;

    --------------------------------------------------------------
    --
    --  add_report2arm_byname
    --
    --  добавить отчет в АРМ по наименованию отчета
    --
    procedure add_report2arm_byname(
        p_report_name reports.name%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
        l_id number;
    begin
       select min(id)
       into   l_id
       from   reports
       where  lower(description) = lower(p_report_name);

       if (l_id is null) then
           raise_application_error(-20000, 'Звіт {' || p_report_name || '} не знайдено');
       end if;

       add_report2arm(p_report_id => l_id, p_arm_code => p_arm_code, p_approve => p_approve);
    end;

    procedure remove_report_from_arm_byname(
        p_report_name reports.name%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
        l_id number;
    begin
        select min(id)
        into   l_id
        from   reports
        where  lower(description) = lower(p_report_name);

        if (l_id is null) then
            raise_application_error(-20000, 'Звіт {' || p_report_name || '} не знайдено');
        end if;

        remove_report_from_arm(p_report_id => l_id, p_arm_code => p_arm_code, p_approve => p_approve);
    end;

    --------------------------------------------------------------
    --
    --  add_report2arm_by_folder
    --
    --  добавить в АРМ все отчеты, содержащиеся в заданой папке
    --
    procedure add_report2arm_by_folder(
        p_folder_id in integer,
        p_arm_code in varchar2,
        p_approve number default 0)
    is
    begin
        for i in (select id
                  from   reports t
                  where  t.idf = p_folder_id) loop
           add_report2arm(p_report_id => i.id, p_arm_code => p_arm_code, p_approve => p_approve);
       end loop;
    end;

    procedure remove_rep_from_arm_by_folder(
        p_folder_id in integer,
        p_arm_code in varchar2,
        p_approve number default 0)
    is
    begin
        for i in (select id
                  from   reports t
                  where  t.idf = p_folder_id) loop
           remove_report_from_arm(p_report_id => i.id, p_arm_code => p_arm_code, p_approve => p_approve);
       end loop;
    end;

    --------------------------------------------------------------
    --
    --  add_refernce2arm
    --
    --  добавить справочник в АРМ по коду справочника
    --
    procedure add_reference2arm(
        p_reference_id references.tabid%type,
        p_arm_code applist.codeapp%type,
        p_access_mode_id in integer,
        p_approve number default 0)
    is
    begin
        set_reference_access_mode(p_reference_id, p_arm_code, p_access_mode_id, p_approve => tools.int_to_boolean(p_approve));
    end;

    procedure remove_reference_from_arm(
        p_reference_id references.tabid%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
    begin
        set_reference_access_mode(p_reference_id, p_arm_code, user_menu_utl.DIR_ACCESS_MODE_NO_ACCESS, p_approve => tools.int_to_boolean(p_approve));
    end;

    --------------------------------------------------------------
    --
    --  add_refernce2arm_bytabname
    --
    --  добавить справочник в АРМ по имени таблицы справочника
    --
    procedure add_reference2arm_bytabname(
        p_reference_tabname meta_tables.tabname%type,
        p_arm_code applist.codeapp%type,
        p_access_mode_id in integer,
        p_approve number default 0)
    is
        l_tabid   number;
    begin
        begin
           select m.tabid into l_tabid from meta_tables m, references r
            where upper(tabname) = upper(p_reference_tabname)
              and m.tabid = r.tabid
              and rownum = 1;
        exception when no_data_found then
           raise_application_error(-20000, 'Довідник за таблицею  {' || p_reference_tabname || '} не знайдено');
        end;

        add_reference2arm(l_tabid, p_arm_code, p_access_mode_id, p_approve => p_approve);
    end;

    procedure remove_ref_from_arm_bytabname(
        p_reference_tabname meta_tables.tabname%type,
        p_arm_code applist.codeapp%type,
        p_approve number default 0)
    is
        l_tabid   number;
    begin
        begin
           select m.tabid into l_tabid from meta_tables m, references r
            where upper(tabname) = upper(p_reference_tabname)
              and m.tabid = r.tabid
              and rownum = 1;
        exception when no_data_found then
           raise_application_error(-20000, 'Довідник за таблицею  {' || p_reference_tabname || '} не знайдено');
        end;

        remove_reference_from_arm(l_tabid, p_arm_code, p_approve => p_approve);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  USER_MENU_UTL ***
grant EXECUTE                                                                on USER_MENU_UTL   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/user_menu_utl.sql =========*** End *
 PROMPT ===================================================================================== 
 