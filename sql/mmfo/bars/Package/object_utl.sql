
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/object_utl.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.OBJECT_UTL is

    LT_OBJECT_TYPE_STATE           constant varchar2(30 char) := 'OBJECT_TYPE_STATE';
    OBJ_TYPE_STATE_UNDER_CONSTRUCT constant integer := 1;
    OBJ_TYPE_STATE_ACTIVE          constant integer := 2;
    OBJ_TYPE_STATE_BLOCKED         constant integer := 3;
    OBJ_TYPE_STATE_CLOSED          constant integer := 4;

    procedure cor_object_type(
        p_object_type_code in varchar2,
        p_object_type_name in varchar2,
        p_parent_object_type_code in varchar2);

    function read_object_type(
        p_object_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type%rowtype
    result_cache;

    function read_object_type(
        p_object_type_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type%rowtype
    result_cache;

    function read_object_type_storage(
        p_object_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type_storage%rowtype
    result_cache;

    function get_object_type_id(
        p_object_type_code in varchar2)
    return integer;

    function get_object_type_code(
        p_object_type_id in integer)
    return varchar2;

    function get_object_type_name(
        p_object_type_id in integer)
    return varchar2;

    function get_object_type_name(
        p_object_type_code in varchar2)
    return varchar2;

    function get_parent_type_id(
        p_object_type_id in integer)
    return integer;

    function get_parent_type_id(
        p_object_type_code in varchar2)
    return integer;

    function get_parent_type_code(
        p_object_type_id in integer)
    return varchar2;

    function get_parent_type_code(
        p_object_type_code in varchar2)
    return varchar2;

    function get_inheritance_tree(
        p_object_type_id in integer)
    return number_list
    result_cache;

    function get_inheritance_path(
        p_object_type_id in integer)
    return number_list
    result_cache;

    function get_inheritance_tree(
        p_object_type_code in varchar2)
    return number_list
    result_cache;

    function get_inheritance_path(
        p_object_type_code in varchar2)
    return number_list
    result_cache;

    function is_of_type(
        p_child_type_id in integer,
        p_parent_type_id in integer)
    return char;

    function is_of_type(
        p_child_type_code in varchar2,
        p_parent_type_code in varchar2)
    return char;

    function check_if_any_objects_exists(
        p_object_type_id in integer)
    return char;

    procedure cor_object_state(
        p_object_type_code in varchar2,
        p_state_id in integer,
        p_state_code in varchar2,
        p_state_name in varchar2);

    function read_object_state(
        p_object_type_id in integer,
        p_state_id in integer,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
    result_cache;

    function read_object_state(
        p_object_type_id in integer,
        p_state_code in varchar2,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
    result_cache;

    function get_object_state_name(
        p_object_type_id in integer,
        p_state_id in integer)
    return varchar2;

    function get_object_state_name(
        p_object_type_code in varchar2,
        p_state_code in varchar2)
    return varchar2;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.OBJECT_UTL as

    procedure cor_object_type(
        p_object_type_code in varchar2,
        p_object_type_name in varchar2,
        p_parent_object_type_code in varchar2)
    is
        l_object_type_row object_type%rowtype;
        l_parent_object_type_row object_type%rowtype;
    begin
        if (p_parent_object_type_code is not null) then
            l_parent_object_type_row := read_object_type(p_parent_object_type_code);
            if (l_parent_object_type_row.state_id = object_utl.OBJ_TYPE_STATE_CLOSED) then
                raise_application_error(-20000, 'Базовий тип об''єкту {' || l_parent_object_type_row.type_name || '} закритий - створення похідних об''єктів заборонено');
            end if;
        end if;

        l_object_type_row := read_object_type(p_object_type_code, p_lock => true, p_raise_ndf => false);
        if (l_object_type_row.id is null) then
            insert into object_type
            values (object_type_seq.nextval, p_object_type_code, p_object_type_name, object_utl.OBJ_TYPE_STATE_UNDER_CONSTRUCT, l_parent_object_type_row.id);
        else
            update object_type o
            set    o.type_name = p_object_type_name,
                   o.parent_type_id = l_parent_object_type_row.id
            where  o.type_code = p_object_type_code;
        end if;
    end;

    function read_object_type(
        p_object_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type%rowtype
    result_cache
    is
        l_object_type_row object_type%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_type_row
            from   object_type t
            where  t.id = p_object_type_id
            for update wait 60;
        else
            select *
            into   l_object_type_row
            from   object_type t
            where  t.id = p_object_type_id;
        end if;

        return l_object_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Тип об''єкту з ідентифікатором {' || p_object_type_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_object_type(
        p_object_type_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type%rowtype
    result_cache
    is
        l_object_type_row object_type%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_type_row
            from   object_type t
            where  t.type_code = p_object_type_code
            for update wait 60;
        else
            select *
            into   l_object_type_row
            from   object_type t
            where  t.type_code = p_object_type_code;
        end if;

        return l_object_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Тип об''єкту з кодом {' || p_object_type_code || '} не знайдений');
             else return null;
             end if;
    end;

    function read_object_type_storage(
        p_object_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type_storage%rowtype
    result_cache
    is
        l_object_type_storage_row object_type_storage%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_type_storage_row
            from   object_type_storage t
            where  t.object_type_id = p_object_type_id
            for update wait 60;
        else
            select *
            into   l_object_type_storage_row
            from   object_type_storage t
            where  t.object_type_id = p_object_type_id;
        end if;

        return l_object_type_storage_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Параметри зберігання даних для типу об''єкту з ідентифікатором {' || p_object_type_id || '} не знайдені');
             else return null;
             end if;
    end;

    function get_object_type_id(
        p_object_type_code in varchar2)
    return integer
    is
    begin
        return read_object_type(p_object_type_code, p_raise_ndf => false).id;
    end;

    function get_object_type_code(
        p_object_type_id in integer)
    return varchar2
    is
    begin
        return read_object_type(p_object_type_id, p_raise_ndf => false).type_code;
    end;

    function get_object_type_name(
        p_object_type_id in integer)
    return varchar2
    is
    begin
        return read_object_type(p_object_type_id, p_raise_ndf => false).type_name;
    end;

    function get_object_type_name(
        p_object_type_code in varchar2)
    return varchar2
    is
    begin
        return read_object_type(p_object_type_code, p_raise_ndf => false).type_name;
    end;

    function get_parent_type_id(
        p_object_type_id in integer)
    return integer
    is
    begin
        return read_object_type(p_object_type_id, p_raise_ndf => false).parent_type_id;
    end;

    function get_parent_type_id(
        p_object_type_code in varchar2)
    return integer
    is
    begin
        return read_object_type(p_object_type_code, p_raise_ndf => false).parent_type_id;
    end;

    function get_parent_type_code(
        p_object_type_id in integer)
    return varchar2
    is
    begin
        return get_object_type_code(get_parent_type_id(p_object_type_id));
    end;

    function get_parent_type_code(
        p_object_type_code in varchar2)
    return varchar2
    is
    begin
        return get_object_type_code(get_parent_type_id(p_object_type_code));
    end;

    function get_inheritance_tree(
        p_object_type_id in integer)
    return number_list
    result_cache
    is
        l_child_types number_list;
    begin
        select id
        bulk collect into l_child_types
        from   object_type t
        connect by prior t.id = t.parent_type_id
        start with t.id = p_object_type_id;

        return l_child_types;
    end;

    function get_inheritance_path(
        p_object_type_id in integer)
    return number_list
    result_cache
    is
        l_parent_types number_list;
    begin
        select id
        bulk collect into l_parent_types
        from   object_type t
        connect by t.id = prior t.parent_type_id
        start with t.id = p_object_type_id
        order by level;

        return l_parent_types;
    end;

    function get_inheritance_tree(
        p_object_type_code in varchar2)
    return number_list
    result_cache
    is
        l_child_types number_list;
    begin
        select id
        bulk collect into l_child_types
        from   object_type t
        connect by prior t.id = t.parent_type_id
        start with t.type_code = p_object_type_code;

        return l_child_types;
    end;

    function get_inheritance_path(
        p_object_type_code in varchar2)
    return number_list
    result_cache
    is
        l_parent_types number_list;
    begin
        select id
        bulk collect into l_parent_types
        from   object_type t
        connect by t.id = prior t.parent_type_id
        start with t.type_code = p_object_type_code
        order by level;

        return l_parent_types;
    end;

    function is_of_type(
        p_child_type_id in integer,
        p_parent_type_id in integer)
    return char
    is
    begin
        return tools.boolean_to_char(p_parent_type_id member of get_inheritance_path(p_child_type_id));
    end;

    function is_of_type(
        p_child_type_code in varchar2,
        p_parent_type_code in varchar2)
    return char
    is
    begin
        return tools.boolean_to_char(get_object_type_id(p_parent_type_code) member of get_inheritance_path(get_object_type_id(p_child_type_code)));
    end;

    function check_if_any_objects_exists(
        p_object_type_id in integer)
    return char
    is
        l_object_type_storage_row object_type_storage%rowtype;
        l_statement varchar2(32767 byte);
        l_objects_exists_flag char(1 byte);
    begin
        l_object_type_storage_row := read_object_type_storage(p_object_type_id);
        l_statement := 'select /*+FIRST_ROW*/ ''Y'' from ' ||
                       case when l_object_type_storage_row.table_owner is null then null
                            else l_object_type_storage_row.table_owner || '.'
                       end ||
                       l_object_type_storage_row.table_name ||
                       ' where rownum = 1' ||
                       case when l_object_type_storage_row.object_type_column_name is null then null
                            else ' and ' || l_object_type_storage_row.object_type_column_name || ' = :object_type_id'
                       end ||
                       case when l_object_type_storage_row.where_clause is null then null
                            else ' and (' || l_object_type_storage_row.where_clause || ')'
                       end;

        begin
            execute immediate l_statement using out l_objects_exists_flag, p_object_type_id;
        exception
            when no_data_found then
                 l_objects_exists_flag := 'N';
        end;

        return l_objects_exists_flag;
    end;

    function read_object_state(
        p_object_type_id in integer,
        p_state_id in integer,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
    result_cache
    is
        l_state_row object_state%rowtype;
    begin
        select *
        into   l_state_row
        from   object_state t
        where  t.object_type_id = p_object_type_id and
               t.state_id = p_state_id;

        return l_state_row;
    exception
        when others then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Стан угоди з ідентифікатором {' || p_state_id ||
                                                 	'} для типу угод {' || object_utl.get_object_type_name(p_object_type_id) || '} не знайдений');
             else return null;
             end if;
    end;

    function read_object_state(
        p_object_type_id in integer,
        p_state_code in varchar2,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
    result_cache
    is
        l_state_row object_state%rowtype;
    begin
        select *
        into   l_state_row
        from   object_state t
        where  t.object_type_id = p_object_type_id and
               t.state_code = p_state_code;

        return l_state_row;
    exception
        when others then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Стан угоди з кодом {' || p_state_code ||
                                                 '} для типу угод {' || object_utl.get_object_type_name(p_object_type_id) || '} не знайдений');
             else return null;
             end if;
    end;

    procedure cor_object_state(
        p_object_type_code in varchar2,
        p_state_id in integer,
        p_state_code in varchar2,
        p_state_name in varchar2)
    is
        l_deal_type_row object_type%rowtype;
    begin
        l_deal_type_row := object_utl.read_object_type(p_object_type_code);

        merge into object_state a
        using DUAL
        on (a.object_type_id = l_deal_type_row.id and
            a.state_id = p_state_id)
        when matched then update
             set a.state_code = p_state_code,
                 a.state_name = p_state_name
        when not matched then insert
             values (l_deal_type_row.id, p_state_id, p_state_code, p_state_name);
    end;

    function get_object_state_name(
        p_object_type_id in integer,
        p_state_id in integer)
    return varchar2
    is
    begin
        return read_object_state(p_object_type_id, p_state_id, p_raise_ndf => false).state_name;
    end;

    function get_object_state_name(
        p_object_type_code in varchar2,
        p_state_code in varchar2)
    return varchar2
    is
    begin
        return read_object_state(object_utl.get_object_type_id(p_object_type_code), p_state_code, p_raise_ndf => false).state_name;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  OBJECT_UTL ***
grant EXECUTE                                                                on OBJECT_UTL      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/object_utl.sql =========*** End *** 
 PROMPT ===================================================================================== 
 