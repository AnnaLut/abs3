
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/resource_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.RESOURCE_UTL is

    RESOLUTION_TYPE_APPROVE        constant integer := 1;
    RESOLUTION_TYPE_REJECT         constant integer := 2;
    RESOLUTION_TYPE_OVERWRITE      constant integer := 3;

    function read_resource_type(
        p_resource_type_id in integer,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return adm_resource_type%rowtype;

    function read_resource_type(
        p_resource_type_code in varchar2,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return adm_resource_type%rowtype;

    function read_resource_activity(
        p_activity_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return adm_resource_activity%rowtype;

    function get_resource_type_id(
        p_resource_type_code in varchar2)
    return integer;

    function get_resource_type_code(
        p_resource_type_id in integer)
    return varchar2;

    function get_resource_type_name(
        p_resource_type_id in integer)
    return varchar2;

    function get_resource_type_name(
        p_resource_type_code in varchar2)
    return varchar2;

    procedure cor_resource_type(
        p_resource_type_code in varchar2,
        p_resource_type_name in varchar2,
        p_table_name in varchar2,
        p_resource_id_column_name in varchar2,
        p_resource_code_column_name in varchar2,
        p_resource_name_column_name in varchar2);

    procedure set_resource_type_data_source(
        p_resource_type_id in integer,
        p_table_name in varchar2,
        p_resource_id_column_name in varchar2,
        p_resource_code_column_name in varchar2,
        p_resource_name_column_name in varchar2);

    procedure set_resource_type_data_source(
        p_resource_type_code in varchar2,
        p_table_name in varchar2,
        p_resource_id_column_name in varchar2,
        p_resource_code_column_name in varchar2,
        p_resource_name_column_name in varchar2);

    function get_granted_resources(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_types in number_list,
        p_access_modes in number_list,
        p_exclude_access_modes in number_list)
    return number_list;

    function get_granted_resources(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer,
        p_resource_types in string_list,
        p_access_modes in number_list,
        p_exclude_access_modes in number_list)
    return number_list;

    function get_granted_resources(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_types in number_list)
    return number_list;

    function get_granted_resources(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer,
        p_resource_types in string_list)
    return number_list;

    function get_resource_grantees(
        p_resource_id in integer,
        p_resource_type_id in integer,
        p_grantee_type_id in integer)
    return number_list;

/*    function get_resource_grantees(
        p_resource_id in integer,
        p_resource_type_code in varchar2,
        p_grantee_type_code in varchar2)
    return number_list;
*/
    function get_available_resources(
        p_resource_type_id in integer)
    return t_lookup;
/*
    function get_available_resources(
        p_resource_type_code in varchar2)
    return t_lookup;
*/
    function check_if_grantee_has_any_res(
        p_grantee_type_id in integer,
        p_grantee_id in integer)
    return char;
/*
    function check_if_grantee_has_any_res(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer)
    return char;
*/
    procedure approve_resource_access(
        p_activity_row in adm_resource_activity%rowtype,
        p_approvement_comment in varchar2);

    procedure approve_resource_access(
        p_activity_id in integer,
        p_approvement_comment in varchar2);

    procedure reject_resource_access(
        p_activity_row in adm_resource_activity%rowtype,
        p_rejection_comment in varchar2);

    procedure reject_resource_access(
        p_activity_id in integer,
        p_rejection_comment in varchar2);

    procedure set_resource_access_mode(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer,
        p_approve in boolean default false);
/*
    procedure set_resource_access_mode(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer,
        p_resource_type_code in varchar2,
        p_resource_id in integer,
        p_access_mode_id in integer,
        p_approve in boolean default false);
*/
    function get_resource_id(
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_code in varchar2)
    return integer;

    function get_resource_id(
        p_resource_type_id in integer,
        p_resource_code in varchar2)
    return integer;

    function get_resource_id(
        p_resource_type_code in varchar2,
        p_resource_code in varchar2)
    return integer;

    function get_resource_code(
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_id in integer)
    return varchar2;

    function get_resource_code(
        p_resource_type_id in integer,
        p_resource_id in integer)
    return varchar2;
/*
    function get_resource_code(
        p_resource_type_code in varchar2,
        p_resource_id in integer)
    return varchar2;
*/
    function get_resource_name(
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_id in integer)
    return varchar2;

    function get_resource_name(
        p_resource_type_id in integer,
        p_resource_id in integer)
    return varchar2;
/*
    function get_resource_name(
        p_resource_type_code in varchar2,
        p_resource_id in integer)
    return varchar2;
*/
    function check_if_resource_exists(
        p_resource_type_id in integer,
        p_resource_id in integer)
    return char;
/*
    function check_if_resource_exists(
        p_resource_type_code in varchar2,
        p_resource_id in integer)
    return char;
*/
    procedure revoke_resource_access(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_approve in boolean default false);

    procedure release_all_resources(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_approve in boolean default true);

    procedure release_all_resources(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer,
        p_approve in boolean default true);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.RESOURCE_UTL as

    type t_resource_type_id_directory is table of adm_resource_type%rowtype index by pls_integer;
    type t_resource_type_code_directory is table of adm_resource_type%rowtype index by varchar2(30 char);

    g_resource_type_id_directory t_resource_type_id_directory;
    g_resource_type_code_directory t_resource_type_code_directory;

    procedure flush_directories_cache
    is
    begin
        g_resource_type_id_directory.delete();
        g_resource_type_code_directory.delete();
    end;

    function read_resource_type(
        p_resource_type_id in integer,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return adm_resource_type%rowtype
    is
        l_resource_type_row adm_resource_type%rowtype;
    begin
        if (p_use_cache and g_resource_type_id_directory.exists(p_resource_type_id)) then
            return g_resource_type_id_directory(p_resource_type_id);
        end if;

        select *
        into   l_resource_type_row
        from   adm_resource_type t
        where  t.id = p_resource_type_id;

        if (p_use_cache) then
            g_resource_type_id_directory(p_resource_type_id) := l_resource_type_row;
        end if;

        return l_resource_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид ресурсів з ідентифікатором {' || p_resource_type_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_resource_type(
        p_resource_type_code in varchar2,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return adm_resource_type%rowtype
    is
        l_resource_type_row adm_resource_type%rowtype;
    begin
        if (p_use_cache and g_resource_type_code_directory.exists(p_resource_type_code)) then
            return g_resource_type_code_directory(p_resource_type_code);
        end if;

        select *
        into   l_resource_type_row
        from   adm_resource_type t
        where  t.resource_code = p_resource_type_code;

        if (p_use_cache) then
            g_resource_type_code_directory(p_resource_type_code) := l_resource_type_row;
        end if;

        return l_resource_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид ресурсів з кодом {' || p_resource_type_code || '} не знайдений');
             else return null;
             end if;
    end;

    function lock_resource_type(
        p_resource_type_id in integer)
    return adm_resource_type%rowtype
    is
        l_resource_type_row adm_resource_type%rowtype;
    begin
        select *
        into   l_resource_type_row
        from   adm_resource_type t
        where  t.id = p_resource_type_id
        for update;

        return l_resource_type_row;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Вид ресурсів з ідентифікатором {' || p_resource_type_id || '} не знайдений');
    end;

    function lock_resource_type(
        p_resource_type_code in varchar2)
    return adm_resource_type%rowtype
    is
        l_resource_type_row adm_resource_type%rowtype;
    begin
        select *
        into   l_resource_type_row
        from   adm_resource_type t
        where  t.resource_code = p_resource_type_code
        for update;

        return l_resource_type_row;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Вид ресурсів з кодом {' || p_resource_type_code || '} не знайдений');
    end;

    function read_resource_activity(
        p_activity_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return adm_resource_activity%rowtype
    is
        l_resource_activity_row adm_resource_activity%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_resource_activity_row
            from   adm_resource_activity t
            where  t.id = p_activity_id
            for update;
        else
            select *
            into   l_resource_activity_row
            from   adm_resource_activity t
            where  t.id = p_activity_id;
        end if;

        return l_resource_activity_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Операція зміни доступу до ресурсу з ідентифікатором {' || p_activity_id || '} не знайдена');
             else return null;
             end if;
    end;

    function get_resource_type_id(
        p_resource_type_code in varchar2)
    return integer
    is
    begin
        return read_resource_type(p_resource_type_code, p_raise_ndf => false).id;
    end;

    function get_resource_type_ids(
        p_resource_type_codes in string_list)
    return number_list
    is
        l_resource_type_ids number_list;
    begin
        select t.id
        bulk collect into l_resource_type_ids
        from   adm_resource_type t
        where  t.resource_code member of p_resource_type_codes;

        return l_resource_type_ids;
    end;

    function get_resource_type_code(
        p_resource_type_id in integer)
    return varchar2
    is
    begin
        return read_resource_type(p_resource_type_id, p_raise_ndf => false).resource_code;
    end;

    function get_resource_type_codes(
        p_resource_type_ids in number_list)
    return string_list
    is
        l_resource_type_codes string_list;
    begin
        select t.resource_code
        bulk collect into l_resource_type_codes
        from   adm_resource_type t
        where  t.id member of p_resource_type_ids;

        return l_resource_type_codes;
    end;

    function get_resource_type_name(
        p_resource_type_id in integer)
    return varchar2
    is
    begin
        return read_resource_type(p_resource_type_id, p_raise_ndf => false).resource_name;
    end;

    function get_resource_type_name(
        p_resource_type_code in varchar2)
    return varchar2
    is
    begin
        return read_resource_type(p_resource_type_code, p_raise_ndf => false).resource_name;
    end;

    procedure cor_resource_type(
        p_resource_type_code in varchar2,
        p_resource_type_name in varchar2,
        p_table_name in varchar2,
        p_resource_id_column_name in varchar2,
        p_resource_code_column_name in varchar2,
        p_resource_name_column_name in varchar2)
    is
        l_resource_type_row adm_resource_type%rowtype;
    begin
        l_resource_type_row := read_resource_type(p_resource_type_code, p_raise_ndf => false);

        if (l_resource_type_row.id is null) then
            insert into adm_resource_type
            values (s_adm_resource_type.nextval,
                    p_resource_type_code,
                    p_resource_type_name,
                    p_table_name,
                    p_resource_id_column_name,
                    p_resource_code_column_name,
                    p_resource_name_column_name);
        else
            l_resource_type_row := lock_resource_type(p_resource_type_code);

            update adm_resource_type t
            set    t.resource_name = p_resource_type_name,
                   t.source_table_name = p_table_name,
                   t.source_id_column_name = p_resource_id_column_name,
                   t.source_code_column_name = p_resource_code_column_name,
                   t.source_name_column_name = p_resource_name_column_name
            where  t.id = l_resource_type_row.id;
        end if;

        flush_directories_cache();
    end;

    procedure set_resource_type_data_source(
        p_resource_type_id in integer,
        p_table_name in varchar2,
        p_resource_id_column_name in varchar2,
        p_resource_code_column_name in varchar2,
        p_resource_name_column_name in varchar2)
    is
        l_resource_type_row adm_resource_type%rowtype;
    begin
        l_resource_type_row := lock_resource_type(p_resource_type_id);

        update adm_resource_type t
        set    t.source_table_name = p_table_name,
               t.source_id_column_name = p_resource_id_column_name,
               t.source_code_column_name = p_resource_code_column_name,
               t.source_name_column_name = p_resource_name_column_name
        where t.id = l_resource_type_row.id;
    end;

    procedure set_resource_type_data_source(
        p_resource_type_code in varchar2,
        p_table_name in varchar2,
        p_resource_id_column_name in varchar2,
        p_resource_code_column_name in varchar2,
        p_resource_name_column_name in varchar2)
    is
        l_resource_type_row adm_resource_type%rowtype;
    begin
        l_resource_type_row := lock_resource_type(p_resource_type_code);

        update adm_resource_type t
        set    t.source_table_name = p_table_name,
               t.source_id_column_name = p_resource_id_column_name,
               t.source_code_column_name = p_resource_code_column_name,
               t.source_name_column_name = p_resource_name_column_name
        where t.id = l_resource_type_row.id;
    end;

    function get_resource_type_relation_row(
        p_grantee_type_id in integer,
        p_resource_type_id in integer)
    return adm_resource_type_relation%rowtype
    is
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
    begin
        select *
        into   l_resource_type_relation_row
        from   adm_resource_type_relation t
        where  t.grantee_type_id = p_grantee_type_id and
               t.resource_type_id = p_resource_type_id;

        return l_resource_type_relation_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_available_resources(
        p_resource_type_row in adm_resource_type%rowtype)
    return t_lookup
    is
        l_statement varchar2(32767 byte);
        l_granted_resources t_lookup;
    begin
        l_statement := ' select t_lookup_item(' || p_resource_type_row.source_id_column_name || ', ' ||
                                                   p_resource_type_row.source_code_column_name || ', ' ||
                                                   p_resource_type_row.source_name_column_name || ')' ||
                       ' from ' || p_resource_type_row.source_table_name;

        bars_audit.info('resource_utl.get_available_resources' || chr(10) ||
                         'p_resource_type_id   : ' || p_resource_type_row.id || chr(10) ||
                         'statement            : ' || l_statement);

        execute immediate l_statement
        bulk collect into l_granted_resources;

        return l_granted_resources;
    end;

    function get_available_resources(
        p_resource_type_id in integer)
    return t_lookup
    is
    begin
        return get_available_resources(read_resource_type(p_resource_type_id));
    end;

    function get_available_resources(
        p_resource_type_code in varchar2)
    return t_lookup
    is
    begin
        return get_available_resources(read_resource_type(p_resource_type_code));
    end;

    function get_granted_resources(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_types in number_list)
    return number_list
    is
        l_granted_resources number_list;
    begin
        if (p_resource_types is null or p_resource_types is empty) then
            return number_list();
        end if;

        select resource_id
        bulk collect into l_granted_resources
        from   adm_resource t
        join   (select rtr.grantee_type_id, rtr.resource_type_id, rtr.no_access_item_id
                from   adm_resource_type_relation rtr
                where  rtr.grantee_type_id = p_grantee_type_id and
                       rtr.resource_type_id in (select column_value
                                                from   table(p_resource_types))) f on f.grantee_type_id = t.grantee_type_id and
                                                                                      f.resource_type_id = t.resource_type_id and
                                                                                      t.access_mode_id <> f.no_access_item_id
        where  t.grantee_id = p_grantee_id;

        return l_granted_resources;
    end;

    function get_granted_resources(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer,
        p_resource_types in string_list)
    return number_list
    is
    begin
        return get_granted_resources(get_resource_type_id(p_grantee_type_code),
                                     p_grantee_id,
                                     get_resource_type_ids(p_resource_types));
    end;

    function get_granted_resources(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_types in number_list,
        p_access_modes in number_list,
        p_exclude_access_modes in number_list)
    return number_list
    is
        l_granted_resources number_list;
    begin
        if (p_resource_types is null or p_resource_types is empty) then
            return number_list();
        end if;

        select resource_id
        bulk collect into l_granted_resources
        from   adm_resource t
        where  t.grantee_type_id = p_grantee_type_id and
               t.grantee_id = p_grantee_id and
               t.resource_type_id in (select column_value from table(p_resource_types)) and
               (p_access_modes is null or p_access_modes is empty or t.access_mode_id in (select column_value from table(p_access_modes))) and
               (p_exclude_access_modes is null or p_exclude_access_modes is empty or t.access_mode_id not in (select column_value from table(p_exclude_access_modes)));

        return l_granted_resources;
    end;

    function get_granted_resources(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer,
        p_resource_types in string_list,
        p_access_modes in number_list,
        p_exclude_access_modes in number_list)
    return number_list
    is
    begin
        return get_granted_resources(get_resource_type_id(p_grantee_type_code),
                                     p_grantee_id,
                                     get_resource_type_ids(p_resource_types),
                                     p_access_modes,
                                     p_exclude_access_modes);
    end;

    function get_resource_grantees(
        p_resource_id in integer,
        p_resource_type_id in integer,
        p_grantee_type_id in integer)
    return number_list
    is
        l_resource_grantees number_list;
    begin
        select t.grantee_id
        bulk collect into l_resource_grantees
        from   adm_resource t
        join   (select rtr.grantee_type_id, rtr.resource_type_id, rtr.no_access_item_id
                from   adm_resource_type_relation rtr
                where  rtr.grantee_type_id = p_grantee_type_id and
                       rtr.resource_type_id = p_resource_type_id) f on f.grantee_type_id = t.grantee_type_id and
                                                                       f.resource_type_id = t.resource_type_id and
                                                                       t.access_mode_id <> f.no_access_item_id
        where  t.resource_id = p_resource_id;

        return l_resource_grantees;
    end;

    function check_if_resource_exists(
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_id in integer)
    return char
    is
        l_flag char(1 byte);
        l_statement varchar2(32767 byte);
    begin
        l_statement := ' select ''Y''' ||
                       ' from ' || p_resource_type_row.source_table_name ||
                       ' where ' || p_resource_type_row.source_id_column_name || ' = :p_resource_id';

        bars_audit.debug('resource_utl.check_if_resource_exists' || chr(10) ||
                         'p_resource_type_id   : ' || p_resource_type_row.id || chr(10) ||
                         'p_resource_type_code : ' || p_resource_type_row.resource_code || chr(10) ||
                         'p_resource_type_name : ' || p_resource_type_row.resource_name || chr(10) ||
                         'p_resource_id        : ' || p_resource_id || chr(10) ||
                         'statement            : ' || l_statement);

        execute immediate l_statement
        into l_flag
        using p_resource_id;

        return l_flag;
    exception
        when no_data_found then
             return 'N';
    end;

    function check_if_resource_exists(
        p_resource_type_id in integer,
        p_resource_id in integer)
    return char
    is
    begin
        return check_if_resource_exists(read_resource_type(p_resource_type_id), p_resource_id);
    end;

    function check_if_resource_granted(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_type_id in integer,
        p_resource_id in integer)
    return char
    is
        l_last_set_access_mode_id integer;
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
    begin
        l_resource_type_relation_row := get_resource_type_relation_row(p_grantee_type_id, p_resource_type_id);

        select min(a.access_mode_id) keep (dense_rank last order by a.id)
        into   l_last_set_access_mode_id
        from   adm_resource_activity a
        where  a.grantee_type_id = p_grantee_type_id and
               a.grantee_id = p_grantee_id and
               a.resource_type_id = p_resource_type_id and
               a.resource_id = p_resource_id and
               a.resolution_type_id <> resource_utl.RESOLUTION_TYPE_REJECT;

        return case when tools.equals(nvl(l_last_set_access_mode_id, l_resource_type_relation_row.no_access_item_id),
                                      l_resource_type_relation_row.no_access_item_id) then 'N'
                    else 'Y'
               end;
    end;

    function check_if_resource_approved(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_type_id in integer,
        p_resource_id integer)
    return char
    is
        l_approved_access_mode_id integer;
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
    begin
        l_resource_type_relation_row := get_resource_type_relation_row(p_grantee_type_id, p_resource_type_id);

        select a.access_mode_id
        into   l_approved_access_mode_id
        from   adm_resource a
        where  a.grantee_type_id = p_grantee_type_id and
               a.grantee_id = p_grantee_id and
               a.resource_type_id = p_resource_type_id and
               a.resource_id = p_resource_id;

        return case when tools.equals(nvl(l_approved_access_mode_id, l_resource_type_relation_row.no_access_item_id),
                                      l_resource_type_relation_row.no_access_item_id) then 'N'
                    else 'Y'
               end;
    end;

    function check_if_grantee_has_any_res(
        p_grantee_type_id in integer,
        p_grantee_id in integer)
    return char
    is
        l_history_exists_flag char(1 byte);
    begin
        begin
            select 'Y'
            into   l_history_exists_flag
            from   adm_resource t
            where  t.grantee_type_id = p_grantee_type_id and
                   t.grantee_id = p_grantee_id and
                   rownum = 1;
        exception
            when no_data_found then
                 l_history_exists_flag := 'N';
                 /*begin
                     select 'Y'
                     into   l_history_exists_flag
                     from   adm_resource_activity t
                     where  t.grantee_type_id = p_grantee_type_id and
                            t.grantee_id = p_grantee_id and
                            rownum = 1;
                 exception
                     when no_data_found then
                          l_history_exists_flag := 'N';
                 end;*/
        end;

        return l_history_exists_flag;
    end;

    function get_resource_row(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_type_id in integer,
        p_resource_id in integer)
    return adm_resource%rowtype
    is
        l_resource_row adm_resource%rowtype;
    begin
        select *
        into   l_resource_row
        from   adm_resource r
        where  r.grantee_type_id = p_grantee_type_id and
               r.grantee_id = p_grantee_id and
               r.resource_type_id = p_resource_type_id and
               r.resource_id = p_resource_id;

        return l_resource_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_resource_id(
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_code in varchar2)
    return integer
    is
        l_statement varchar2(32767 byte);
        l_resource_id integer;
    begin
        l_statement := ' select ' || p_resource_type_row.source_id_column_name ||
                       ' from ' || p_resource_type_row.source_table_name ||
                       ' where ' || p_resource_type_row.source_code_column_name || ' = :p_resource_code';
/*
        bars_audit.debug('resource_utl.get_resource_id' || chr(10) ||
                         'p_resource_type_id   : ' || p_resource_type_row.id || chr(10) ||
                         'p_resource_type_code : ' || p_resource_type_row.resource_code || chr(10) ||
                         'p_resource_type_name : ' || p_resource_type_row.resource_name || chr(10) ||
                         'statement            : ' || l_statement);*/
        begin
            execute immediate l_statement
            into l_resource_id
            using p_resource_code;
        exception
            when no_data_found then null;
        end;

        return l_resource_id;
    end;

    function get_resource_code(
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_id in integer)
    return varchar2
    is
        l_statement varchar2(32767 byte);
        l_resource_code varchar2(32767 byte);
    begin
        l_statement := ' select ' || p_resource_type_row.source_code_column_name ||
                       ' from ' || p_resource_type_row.source_table_name ||
                       ' where ' || p_resource_type_row.source_id_column_name || ' = :p_resource_id';
/*
        bars_audit.debug('resource_utl.get_resource_id' || chr(10) ||
                         'p_resource_type_id   : ' || p_resource_type_row.id || chr(10) ||
                         'p_resource_type_code : ' || p_resource_type_row.resource_code || chr(10) ||
                         'p_resource_type_name : ' || p_resource_type_row.resource_name || chr(10) ||
                         'statement            : ' || l_statement);*/
        begin
            execute immediate l_statement
            into l_resource_code
            using p_resource_id;
        exception
            when no_data_found then null;
        end;

        return l_resource_code;
    end;

    function get_resource_name(
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_id in integer)
    return varchar2
    is
        l_statement varchar2(32767 byte);
        l_resource_name varchar2(32767 byte);
    begin
        l_statement := ' select ' || p_resource_type_row.source_name_column_name ||
                       ' from ' || p_resource_type_row.source_table_name ||
                       ' where ' || p_resource_type_row.source_id_column_name || ' = :p_resource_id';
/*
        bars_audit.debug('resource_utl.get_resource_id' || chr(10) ||
                         'p_resource_type_id   : ' || p_resource_type_row.id || chr(10) ||
                         'p_resource_type_code : ' || p_resource_type_row.resource_code || chr(10) ||
                         'p_resource_type_name : ' || p_resource_type_row.resource_name || chr(10) ||
                         'statement            : ' || l_statement);*/
        begin
            execute immediate l_statement
            into l_resource_name
            using p_resource_id;
        exception
            when no_data_found then null;
        end;

        return l_resource_name;
    end;

    function get_resource_id(
        p_resource_type_id in integer,
        p_resource_code in varchar2)
    return integer
    is
    begin
        return get_resource_id(read_resource_type(p_resource_type_id), p_resource_code);
    end;

    function get_resource_id(
        p_resource_type_code in varchar2,
        p_resource_code in varchar2)
    return integer
    is
    begin
        return get_resource_id(read_resource_type(p_resource_type_code), p_resource_code);
    end;

    function get_resource_code(
        p_resource_type_id in integer,
        p_resource_id in integer)
    return varchar2
    is
    begin
        return get_resource_code(read_resource_type(p_resource_type_id), p_resource_id);
    end;

    function get_resource_name(
        p_resource_type_id in integer,
        p_resource_id in integer)
    return varchar2
    is
    begin
        return get_resource_name(read_resource_type(p_resource_type_id), p_resource_id);
    end;

    procedure resolve_resource_access(
        p_activity_id in integer,
        p_resolution_type_id in integer,
        p_resolution_comment in varchar2)
    is
    begin
        update adm_resource_activity t
        set    t.resolution_type_id = p_resolution_type_id,
               t.resolution_time = sysdate,
               t.resolution_user_id = user_id(),
               t.resolution_comment = p_resolution_comment
        where  t.id = p_activity_id;
    end;

    procedure approve_resource_access(
        p_activity_row in adm_resource_activity%rowtype,
        p_approvement_comment in varchar2)
    is
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
    begin
        if (p_activity_row.resolution_type_id is not null) then
            raise_application_error(-20000, 'Зміна режиму доступу до ресурсу {' || get_resource_name(p_activity_row.resource_type_id, p_activity_row.resource_id) ||
                                            '} з ідентифікаторм {' || p_activity_row.id || '} вже виконана');
        end if;

        l_resource_type_relation_row := get_resource_type_relation_row(p_activity_row.grantee_type_id, p_activity_row.resource_type_id);

        if (p_activity_row.access_mode_id = l_resource_type_relation_row.no_access_item_id) then
            delete adm_resource t
            where  t.grantee_type_id = p_activity_row.grantee_type_id and
                   t.grantee_id = p_activity_row.grantee_id and
                   t.resource_type_id = p_activity_row.resource_type_id and
                   t.resource_id = p_activity_row.resource_id;
        else
            merge into adm_resource a
            using DUAL s
            on (a.grantee_type_id = p_activity_row.grantee_type_id and
                a.grantee_id = p_activity_row.grantee_id and
                a.resource_type_id = p_activity_row.resource_type_id and
                a.resource_id = p_activity_row.resource_id)
            when matched then update
                 set a.access_mode_id = p_activity_row.access_mode_id
            when not matched then insert
                 values (p_activity_row.grantee_type_id,
                         p_activity_row.grantee_id,
                         p_activity_row.resource_type_id,
                         p_activity_row.resource_id,
                         p_activity_row.access_mode_id);
        end if;

        resolve_resource_access(p_activity_row.id, resource_utl.RESOLUTION_TYPE_APPROVE, p_approvement_comment);

        if (l_resource_type_relation_row.on_resolve_event_handler is not null) then
            execute immediate 'begin ' || l_resource_type_relation_row.on_resolve_event_handler || '(:p_activity_id); end;'
            using p_activity_row.id;
        end if;
    end;

    procedure approve_resource_access(
        p_activity_id in integer,
        p_approvement_comment in varchar2)
    is
        l_activity_row adm_resource_activity%rowtype;
    begin
        l_activity_row := read_resource_activity(p_activity_id, p_lock => true);

        approve_resource_access(l_activity_row, p_approvement_comment);
    end;

    procedure reject_resource_access(
        p_activity_row in adm_resource_activity%rowtype,
        p_rejection_comment in varchar2)
    is
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
    begin
        resolve_resource_access(p_activity_row.id, resource_utl.RESOLUTION_TYPE_REJECT, p_rejection_comment);

        l_resource_type_relation_row := get_resource_type_relation_row(p_activity_row.grantee_type_id, p_activity_row.resource_type_id);
        if (l_resource_type_relation_row.on_resolve_event_handler is not null) then
            execute immediate 'begin ' || l_resource_type_relation_row.on_resolve_event_handler || '(:p_activity_id); end;'
            using p_activity_row.id;
        end if;
    end;

    procedure reject_resource_access(
        p_activity_id in integer,
        p_rejection_comment in varchar2)
    is
        l_activity_row adm_resource_activity%rowtype;
    begin
        l_activity_row := read_resource_activity(p_activity_id, p_lock => true);

        resolve_resource_access(l_activity_row.id, resource_utl.RESOLUTION_TYPE_REJECT, p_rejection_comment);
    end;

    procedure set_resource_access_mode(
        p_grantee_type_row in adm_resource_type%rowtype,
        p_grantee_id in integer,
        p_resource_type_row in adm_resource_type%rowtype,
        p_resource_id in integer,
        p_access_mode_id in integer,
        p_resolution_type_id in integer,
        p_resolution_comment in varchar2)
    is
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
        l_activity_id integer;
    begin
        l_resource_type_relation_row := get_resource_type_relation_row(p_grantee_type_row.id, p_resource_type_row.id);

        update adm_resource_activity t
        set    t.resolution_type_id = resource_utl.RESOLUTION_TYPE_OVERWRITE,
               t.resolution_time = sysdate,
               t.resolution_comment = 'Не підтверджене значення замінюється новим значенням'
        where  t.grantee_type_id = p_grantee_type_row.id and
               t.grantee_id = p_grantee_id and
               t.resource_type_id = p_resource_type_row.id and
               t.resource_id = p_resource_id and
               t.resolution_type_id is null;

        insert into adm_resource_activity
        values (s_adm_resource_activity.nextval,
                p_grantee_type_row.id,
                p_grantee_id,
                p_resource_type_row.id,
                p_resource_id,
                p_access_mode_id,
                sysdate,
                user_id(),
                null,
                null,
                null,
                null)
        returning id
        into l_activity_id;

        if (p_resolution_type_id = resource_utl.RESOLUTION_TYPE_APPROVE) then
            approve_resource_access(l_activity_id, p_resolution_comment);
            bars_audit.security('Для об''єкта {' || get_resource_name(p_grantee_type_row, p_grantee_id) || '} типу {' || p_grantee_type_row.resource_name ||
                                '} встановлюється режим доступу {' || list_utl.get_item_name(l_resource_type_relation_row.access_mode_list_id, p_access_mode_id) ||
                                '} до ресурсу {' || get_resource_name(p_resource_type_row, p_resource_id) || '} типу {' || p_resource_type_row.resource_name ||
                                '}. Зміна доступу не потребує підтвердження');
        else
            bars_audit.security('Для об''єкта {' || get_resource_name(p_grantee_type_row, p_grantee_id) || '} типу {' || p_grantee_type_row.resource_name ||
                                '} встановлюється режим доступу {' || list_utl.get_item_name(l_resource_type_relation_row.access_mode_list_id, p_access_mode_id) ||
                                '} до ресурсу {' || get_resource_name(p_resource_type_row, p_resource_id) || '} типу {' || p_resource_type_row.resource_name ||
                                '}. Зміна доступу потребує підтвердження');
        end if;
    end;

    procedure set_resource_access_mode(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_access_mode_id in integer,
        p_approve in boolean default false)
    is
        l_resource_row adm_resource%rowtype;
        l_grantee_type_row adm_resource_type%rowtype;
        l_resource_type_row adm_resource_type%rowtype;
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
        l_resolution_type_id integer;
        l_resolution_comment varchar2(4000 byte);
    begin
        l_grantee_type_row := read_resource_type(p_grantee_type_id);
        l_resource_type_row := read_resource_type(p_resource_type_id);

        l_resource_type_relation_row := get_resource_type_relation_row(p_grantee_type_id, p_resource_type_id);

        l_resource_row := get_resource_row(p_grantee_type_id, p_grantee_id, p_resource_type_id, p_resource_id);

        if (list_utl.is_item_in_list(l_resource_type_relation_row.access_mode_list_id, p_access_mode_id) = 'N') then
            raise_application_error(-20000, 'Режим доступу {' || p_access_mode_id ||
                                            '} не входить до списку допустимих режимів доступу ресурсу {' || l_resource_type_row.resource_name || '}');
        end if;

        if (check_if_resource_exists(l_resource_type_row, p_resource_id) = 'N') then
            raise_application_error(-20000, 'Ресурс типу {' || l_resource_type_row.resource_name || '} з ідентифікатором {' || p_resource_id || '} не знайдений');
        end if;

        if (p_approve) then
            l_resolution_type_id := resource_utl.RESOLUTION_TYPE_APPROVE;
            l_resolution_comment := 'Переданий флаг автоматичного підтвердження доступу';
        else
            if (l_resource_row.access_mode_id = p_access_mode_id) then
                l_resolution_type_id := resource_utl.RESOLUTION_TYPE_APPROVE;
                l_resolution_comment := 'Встановлюваний режим доступу співпадає з поточним';
            else
                l_resolution_type_id := case when l_resource_type_relation_row.must_be_approved = 'Y' and getglobaloption('LOSECURE') = '0' then null
                                             else resource_utl.RESOLUTION_TYPE_APPROVE
                                        end;
                l_resolution_comment := 'Зміна режиму доступу не потребує підтвердження згідно з налаштуваннями системи';
            end if;
        end if;

        set_resource_access_mode(l_grantee_type_row, p_grantee_id, l_resource_type_row, p_resource_id, p_access_mode_id, l_resolution_type_id, l_resolution_comment);
    end;

    procedure revoke_resource_access(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_resource_type_id in integer,
        p_resource_id in integer,
        p_approve in boolean default false)
    is
        l_resource_type_relation_row adm_resource_type_relation%rowtype;
    begin
        l_resource_type_relation_row := get_resource_type_relation_row(p_grantee_type_id, p_resource_type_id);

        set_resource_access_mode(p_grantee_type_id, p_grantee_id, p_resource_type_id, p_resource_id, l_resource_type_relation_row.no_access_item_id, p_approve => p_approve);
    end;

    procedure release_all_resources(
        p_grantee_type_row in adm_resource_type%rowtype,
        p_grantee_id in integer,
        p_approve in boolean default true)
    is
    begin
        for i in (select *
                  from   adm_resource_activity ra
                  where  ra.grantee_type_id = p_grantee_type_row.id and
                         ra.grantee_id = p_grantee_id and
                         ra.resolution_type_id is null
                  for update) loop
            reject_resource_access(i, 'Виконується звільнення від всіх ресурсів');
        end loop;

        for i in (select r.resource_type_id, r.resource_id, rr.no_access_item_id
                  from   adm_resource r
                  join   adm_resource_type_relation rr on rr.grantee_type_id = r.grantee_type_id and
                                                          rr.resource_type_id = r.resource_type_id
                  where  r.grantee_type_id = p_grantee_type_row.id and
                         r.grantee_id = p_grantee_id and
                         r.access_mode_id <> rr.no_access_item_id) loop

            set_resource_access_mode(p_grantee_type_row,
                                     p_grantee_id,
                                     read_resource_type(i.resource_type_id),
                                     i.resource_id,
                                     i.no_access_item_id,
                                     case when p_approve then resource_utl.RESOLUTION_TYPE_APPROVE else null end,
                                     'Виконується звільнення від всіх ресурсів');
        end loop;
    end;

    procedure release_all_resources(
        p_grantee_type_id in integer,
        p_grantee_id in integer,
        p_approve in boolean default true)
    is
    begin
        release_all_resources(read_resource_type(p_grantee_type_id), p_grantee_id, p_approve => p_approve);
    end;

    procedure release_all_resources(
        p_grantee_type_code in varchar2,
        p_grantee_id in integer,
        p_approve in boolean default true)
    is
    begin
        release_all_resources(read_resource_type(p_grantee_type_code), p_grantee_id, p_approve => p_approve);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  RESOURCE_UTL ***
grant EXECUTE                                                                on RESOURCE_UTL    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RESOURCE_UTL    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/resource_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 