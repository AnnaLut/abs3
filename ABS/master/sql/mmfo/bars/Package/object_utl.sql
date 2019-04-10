create or replace package object_utl is

    LT_OBJECT_TYPE_STATE           constant varchar2(30 char) := 'OBJECT_TYPE_STATE';
    OBJ_TYPE_STATE_UNDER_CONSTRUCT constant integer := 1;
    OBJ_TYPE_STATE_ACTIVE          constant integer := 2;
    OBJ_TYPE_STATE_BLOCKED         constant integer := 3;
    OBJ_TYPE_STATE_CLOSED          constant integer := 4;

    ATTR_CODE_STATE_ID             constant varchar2(30 char) := 'OBJECT_STATE';

    OBJECT_STATE_CREATED           constant varchar2(30 char) := 'CREATED';
    OBJECT_STATE_DELETED           constant varchar2(30 char) := 'DELETED';

    procedure cor_object_type(
        p_object_type_code in varchar2,
        p_object_type_name in varchar2,
        p_parent_object_type_code in varchar2);

    function read_object_type(
        p_object_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type%rowtype;

    function read_object_type(
        p_object_type_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type%rowtype;

    function read_object_type_storage(
        p_object_type_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object_type_storage%rowtype;

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
    return number_list;

    function get_inheritance_path(
        p_object_type_id in integer)
    return number_list;

    function get_inheritance_tree(
        p_object_type_code in varchar2)
    return number_list;

    function get_inheritance_path(
        p_object_type_code in varchar2)
    return number_list;

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

    function cor_object_state(
        p_object_type_id in integer,
        p_state_code in varchar2,
        p_state_name in varchar2,
        p_is_active in varchar2 default 'Y')
    return integer;

    function cor_object_state(
        p_object_type_code in varchar2,
        p_state_code in varchar2,
        p_state_name in varchar2,
        p_is_active in varchar2 default 'Y')
    return integer;

    function read_object_state(
        p_state_id in integer,
        p_raise_ndf in boolean default true)
    return object_state%rowtype;

    function read_object_state(
        p_object_type_id in integer,
        p_state_code in varchar2,
        p_raise_ndf in boolean default true)
    return object_state%rowtype;

    function read_object_state(
        p_object_type_id in integer,
        p_state_id in number,
        p_raise_ndf in boolean default true)
    return object_state%rowtype;

    function get_object_state_id(
        p_object_type_id in integer,
        p_state_code in varchar2)
    return integer;

    function get_object_state_id(
        p_object_type_code in varchar2,
        p_state_code in varchar2)
    return integer;

    function get_object_state_code(
        p_state_id in integer)
    return varchar2;

    function get_object_state_name(
        p_state_id in integer)
    return varchar2;

    function get_object_state_name(
        p_object_type_id in integer,
        p_state_code in varchar2)
    return varchar2;

    function get_object_state_name(
        p_object_type_code in varchar2,
        p_state_code in varchar2)
    return varchar2;

    function get_object_state_row(
        p_object_type_id in integer,
        p_object_state_code in varchar2,
        p_raise_ndf in boolean default true)
    return object_state%rowtype;

    function read_object(
        p_object_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object%rowtype;

    function create_object(
        p_object_type_id in integer)
    return integer;

    function create_object(
        p_object_type_code in varchar2)
    return integer;

    function create_object(
        p_object_type_id in integer,
        p_object_state_id in integer)
    return integer;

    function create_object(
        p_object_type_id in integer,
        p_object_state_code in varchar2)
    return integer;

    function create_object(
        p_object_type_code in varchar2,
        p_object_state_id in integer)
    return integer;

    function create_object(
        p_object_type_code in varchar2,
        p_object_state_code in varchar2)
    return integer;

    function get_object_state(
        p_object_id in integer,
        p_value_date in date default trunc(sysdate))
    return integer;

    procedure set_object_state(
        p_object_id in integer,
        p_state_id in integer,
        p_comment in varchar2 default null);

    procedure set_object_state(
        p_object_id in integer,
        p_state_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_object_state(
        p_object_id in integer,
        p_state_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_object_state(
        p_object_id in integer,
        p_state_code in varchar2,
        p_comment in varchar2 default null);

    procedure set_object_state(
        p_object_id in integer,
        p_state_code in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_object_state(
        p_object_id in integer,
        p_state_code in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    function get_created_object_state_id
    return integer;

    function get_deleted_object_state_id
    return integer;
end;
/
create or replace package body object_utl as

    g_object_type_id_object        integer := get_object_type_id('OBJECT');
    g_object_state_id_created      integer := get_object_state_id(g_object_type_id_object, object_utl.OBJECT_STATE_CREATED);
    g_object_state_id_deleted      integer := get_object_state_id(g_object_type_id_object, object_utl.OBJECT_STATE_DELETED);

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
            if (l_parent_object_type_row.is_active = 'N') then
                raise_application_error(-20000, 'Базовий тип об''єкту {' || l_parent_object_type_row.type_name || '} закритий - створення похідних об''єктів заборонено');
            end if;
        end if;

        l_object_type_row := read_object_type(p_object_type_code, p_lock => true, p_raise_ndf => false);
        if (l_object_type_row.id is null) then
            insert into object_type
            values (object_type_seq.nextval, p_object_type_code, p_object_type_name, l_parent_object_type_row.id, 'Y');
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
    is
        l_object_type_row object_type%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_type_row
            from   object_type t
            where  t.id = p_object_type_id
            for update;
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
    is
        l_object_type_row object_type%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_type_row
            from   object_type t
            where  t.type_code = p_object_type_code
            for update;
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
    is
        l_object_type_storage_row object_type_storage%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_type_storage_row
            from   object_type_storage t
            where  t.object_type_id = p_object_type_id
            for update;
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
        p_state_id in integer,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
    is
        l_state_row object_state%rowtype;
    begin
        select *
        into   l_state_row
        from   object_state t
        where  t.id = p_state_id;

        return l_state_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Стан угоди з ідентифікатором {' || p_state_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_object_state(
        p_object_type_id in integer,
        p_state_code in varchar2,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
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
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Стан угоди з кодом {' || p_state_code ||
                                                 '} для типу угод {' || object_utl.get_object_type_name(p_object_type_id) || '} не знайдений');
             else return null;
             end if;
    end;

    function read_object_state(
        p_object_type_id in integer,
        p_state_id in number,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
    is
        l_state_row object_state%rowtype;
    begin
        select *
        into   l_state_row
        from   object_state t
        where  t.object_type_id = p_object_type_id and
               t.id = p_state_id;

        return l_state_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Стан угоди з кодом {' || p_state_id ||
                                                 '} для типу угод {' || object_utl.get_object_type_name(p_object_type_id) || '} не знайдений');
             else return null;
             end if;
    end;

    function get_object_state_row(
        p_object_type_id in integer,
        p_object_state_code in varchar2,
        p_raise_ndf in boolean default true)
    return object_state%rowtype
    is
        l_object_state_row object_state%rowtype;
    begin
        select *
        into   l_object_state_row
        from   object_state st
        where  st.id = (select min(s.id) keep (dense_rank first order by y.inheritance_level)
                        from   object_state s
                        join   (select t.*, level inheritance_level
                                from   object_type t
                                connect by t.id = prior t.parent_type_id
                                start with t.id = p_object_type_id) y on y.id = s.object_type_id
                        where  s.state_code = p_object_state_code and
                               s.is_active = 'Y');

        return l_object_state_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Стан об''єкту з кодом {' || p_object_state_code ||
                                                 '} не знайдений для об''єктів типу {' || get_object_type_name(p_object_type_id) || '} не знайдений');
             else return null;
             end if;
    end;

    function cor_object_state(
        p_object_type_id in integer,
        p_state_code in varchar2,
        p_state_name in varchar2,
        p_is_active in varchar2 default 'Y')
    return integer
    is
        l_object_state_row object_state%rowtype;
    begin
        l_object_state_row := get_object_state_row(p_object_type_id, p_state_code, p_raise_ndf => false);

        if (l_object_state_row.id is null) then
            insert into object_state
            values (s_object_state.nextval, p_object_type_id, p_state_code, p_state_name, p_is_active)
            returning id into l_object_state_row.id;
        else
            update object_state t
            set    t.state_code = p_state_code,
                   t.state_name = p_state_name,
                   t.is_active = p_is_active
            where  t.id = l_object_state_row.id;
        end if;

        return l_object_state_row.id;
    end;

    function cor_object_state(
        p_object_type_code in varchar2,
        p_state_code in varchar2,
        p_state_name in varchar2,
        p_is_active in varchar2 default 'Y')
    return integer
    is
    begin
        return cor_object_state(object_utl.read_object_type(p_object_type_code).id, p_state_code, p_state_name, p_is_active);
    end;

    function get_object_state_id(
        p_object_type_id in integer,
        p_state_code in varchar2)
    return integer
    is
    begin
        return get_object_state_row(p_object_type_id, p_state_code, p_raise_ndf => false).id;
    end;

    function get_object_state_id(
        p_object_type_code in varchar2,
        p_state_code in varchar2)
    return integer
    is
    begin
        return get_object_state_row(object_utl.read_object_type(p_object_type_code).id, p_state_code, p_raise_ndf => false).id;
    end;

    function get_object_state_code(
        p_state_id in integer)
    return varchar2
    is
    begin
        return read_object_state(p_state_id, p_raise_ndf => false).state_code;
    end;

    function get_object_state_name(
        p_state_id in integer)
    return varchar2
    is
    begin
        return read_object_state(p_state_id, p_raise_ndf => false).state_name;
    end;

    function get_object_state_name(
        p_object_type_id in integer,
        p_state_code in varchar2)
    return varchar2
    is
    begin
        return get_object_state_row(p_object_type_id, p_state_code, p_raise_ndf => false).state_name;
    end;

    function get_object_state_name(
        p_object_type_code in varchar2,
        p_state_code in varchar2)
    return varchar2
    is
    begin
        return get_object_state_name(object_utl.get_object_type_id(p_object_type_code), p_state_code);
    end;

    function get_created_object_state_id
    return integer
    is
    begin
        return g_object_state_id_created;
    end;

    function get_deleted_object_state_id
    return integer
    is
    begin
        return g_object_state_id_deleted;
    end;

    function read_object(
        p_object_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return object%rowtype
    is
        l_object_row object%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_row
            from   object t
            where  t.id = p_object_id
            for update;
        else
            select *
            into   l_object_row
            from   object t
            where  t.id = p_object_id;
        end if;

        return l_object_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Об''єкт з ідентифікатором {' || p_object_id || '} не знайдений');
             else return null;
             end if;
    end;

    procedure check_object_new_state(
        p_object_type_id in integer,
        p_new_object_state_row in object_state%rowtype)
    is
    begin
        if (not tools.equals(p_new_object_state_row.is_active, 'Y')) then
            raise_application_error(-20000, 'Стан об''єкта {' || p_new_object_state_row.state_name ||
                                            '} позначений як не активний - об''єкти більше не можуть набувати цей статус');
        end if;

        if (p_new_object_state_row.object_type_id not member of get_inheritance_path(p_object_type_id)) then
            raise_application_error(-20000, 'Стан об''єктів {' || p_new_object_state_row.state_name ||
                                            '} відноситься до типу об''єктів {' || get_object_type_name(p_new_object_state_row.object_type_id) ||
                                            '} і не може використовуватися для об''єктів типу {' || get_object_type_name(p_object_type_id) || '}');
        end if;
    end;

    function create_object(
        p_object_type_row in object_type%rowtype,
        p_object_state_row in object_state%rowtype default null)
    return integer
    is
        l_object_id integer;
    begin
        if (p_object_type_row.is_active <> 'Y') then
            raise_application_error(-20000, 'Тип об''єктів {' || p_object_type_row.type_name ||
                                            '} деактивований - створення нових об''єктів заборонено');
        end if;

        if (p_object_state_row.id is not null and p_object_state_row.id <> g_object_state_id_created) then
            check_object_new_state(p_object_type_row.id, p_object_state_row);
        end if;

        insert into object
        values (bars_sqnc.get_nextval('s_object'), p_object_type_row.id, nvl(p_object_state_row.id, g_object_state_id_created))
        returning id
        into l_object_id;

        -- фіксуємо встановлення стану об'єкту в історії, а також викликаємо обробники встановлення стану об'єкту (якщо такі існують)
        attribute_utl.set_value(l_object_id, object_utl.ATTR_CODE_STATE_ID, nvl(p_object_state_row.id, g_object_state_id_created));

        return l_object_id;
    end;

    function create_object(
        p_object_type_id in integer)
    return integer
    is
    begin
        return create_object(read_object_type(p_object_type_id), null);
    end;

    function create_object(
        p_object_type_code in varchar2)
    return integer
    is
    begin
        return create_object(read_object_type(p_object_type_code), null);
    end;

    function create_object(
        p_object_type_id in integer,
        p_object_state_id in integer)
    return integer
    is
        l_object_type_row object_type%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_type_row := read_object_type(p_object_type_id);
        l_object_state_row := read_object_state(p_object_state_id);

        return create_object(l_object_type_row, l_object_state_row);
    end;

    function create_object(
        p_object_type_id in integer,
        p_object_state_code in varchar2)
    return integer
    is
        l_object_type_row object_type%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_type_row := read_object_type(p_object_type_id);
        l_object_state_row := get_object_state_row(l_object_type_row.id, p_object_state_code);

        return create_object(l_object_type_row, l_object_state_row);
    end;

    function create_object(
        p_object_type_code in varchar2,
        p_object_state_id in integer)
    return integer
    is
        l_object_type_row object_type%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_type_row := read_object_type(p_object_type_code);
        l_object_state_row := read_object_state(p_object_state_id);

        return create_object(l_object_type_row, l_object_state_row);
    end;

    function create_object(
        p_object_type_code in varchar2,
        p_object_state_code in varchar2)
    return integer
    is
        l_object_type_row object_type%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_type_row := read_object_type(p_object_type_code);
        l_object_state_row := get_object_state_row(l_object_type_row.id, p_object_state_code);

        return create_object(l_object_type_row, l_object_state_row);
    end;

    function get_object_state(
        p_object_id in integer,
        p_value_date in date default trunc(sysdate))
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_object_id, object_utl.ATTR_CODE_STATE_ID, p_value_date);
    end;

    procedure set_object_state(
        p_object_id in integer,
        p_state_id in integer,
        p_comment in varchar2 default null)
    is
        l_object_row object%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_row := read_object(p_object_id, p_lock => true);

        l_object_state_row := read_object_state(l_object_row.object_type_id, p_state_id);

        check_object_new_state(l_object_row.object_type_id, l_object_state_row);

        attribute_utl.set_value(p_object_id, object_utl.ATTR_CODE_STATE_ID, l_object_state_row.id, p_comment);
    end;

    procedure set_object_state(
        p_object_id in integer,
        p_state_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_object_row object%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_row := read_object(p_object_id, p_lock => true);

        l_object_state_row := read_object_state(l_object_row.object_type_id, p_state_id);

        check_object_new_state(l_object_row.object_type_id, l_object_state_row);

        attribute_utl.set_value(p_object_id, object_utl.ATTR_CODE_STATE_ID, l_object_state_row.id, p_value_date, p_comment);
    end;

    procedure set_object_state(
        p_object_id in integer,
        p_state_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
        l_object_row object%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_row := read_object(p_object_id, p_lock => true);

        l_object_state_row := read_object_state(l_object_row.object_type_id, p_state_id);

        check_object_new_state(l_object_row.object_type_id, l_object_state_row);

        attribute_utl.set_value(p_object_id, object_utl.ATTR_CODE_STATE_ID, l_object_state_row.id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_object_state(
        p_object_id in integer,
        p_state_code in varchar2,
        p_comment in varchar2 default null)
    is
        l_object_row object%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_row := read_object(p_object_id, p_lock => true);

        l_object_state_row := get_object_state_row(l_object_row.object_type_id, p_state_code);

        check_object_new_state(l_object_row.object_type_id, l_object_state_row);

        attribute_utl.set_value(p_object_id, object_utl.ATTR_CODE_STATE_ID, l_object_state_row.id, p_comment);
    end;

    procedure set_object_state(
        p_object_id in integer,
        p_state_code in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_object_row object%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_row := read_object(p_object_id, p_lock => true);

        l_object_state_row := get_object_state_row(l_object_row.object_type_id, p_state_code);

        check_object_new_state(l_object_row.object_type_id, l_object_state_row);

        attribute_utl.set_value(p_object_id, object_utl.ATTR_CODE_STATE_ID, l_object_state_row.id, p_value_date, p_comment);
    end;

    procedure set_object_state(
        p_object_id in integer,
        p_state_code in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
        l_object_row object%rowtype;
        l_object_state_row object_state%rowtype;
    begin
        l_object_row := read_object(p_object_id, p_lock => true);

        l_object_state_row := get_object_state_row(l_object_row.object_type_id, p_state_code);

        check_object_new_state(l_object_row.object_type_id, l_object_state_row);

        attribute_utl.set_value(p_object_id, object_utl.ATTR_CODE_STATE_ID, l_object_state_row.id, p_valid_from, p_valid_through, p_comment);
    end;
end;
/
