
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/list_utl.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.LIST_UTL is

    function create_list(
        p_list_code in varchar2,
        p_list_name in varchar2)
    return integer;

    function read_list_type(
        p_list_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_type%rowtype;

    function read_list_type(
        p_list_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_type%rowtype;

    function get_list_id(
        p_list_code in varchar2)
    return integer;

    function get_list_code(
        p_list_id in integer)
    return varchar2;

    function get_list_name(
        p_list_id in integer)
    return varchar2;

    function get_list_name(
        p_list_code in varchar2)
    return varchar2;

    procedure set_list_name(
        p_list_id in integer,
        p_list_name in varchar2);

    procedure set_list_name(
        p_list_code in varchar2,
        p_list_name in varchar2);

    procedure activate_list(
        p_list_id in integer);

    procedure activate_list(
        p_list_code in varchar2);

    procedure deactivate_list(
        p_list_id in integer);

    procedure deactivate_list(
        p_list_code in varchar2);

    procedure cor_list(
        p_list_code in varchar2,
        p_list_name in varchar2);

    procedure cor_list_item(
        p_list_id in integer,
        p_item_id in integer,
        p_item_code in varchar2,
        p_item_name in varchar2,
        p_parent_item_id in integer default null);

    procedure cor_list_item(
        p_list_code in varchar2,
        p_item_id in integer,
        p_item_code in varchar2,
        p_item_name in varchar2,
        p_parent_item_id in integer default null);

    function read_list_item(
        p_list_id in integer,
        p_item_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_item%rowtype;

    function read_list_item(
        p_list_id in integer,
        p_item_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_item%rowtype;

    function get_item_id(
        p_list_id in integer,
        p_item_code in varchar2)
    return integer;

    function get_item_id(
        p_list_code in varchar2,
        p_item_code in varchar2)
    return integer;

    function get_item_code(
        p_list_id in integer,
        p_item_id in integer)
    return varchar2;

    function get_item_code(
        p_list_code in varchar2,
        p_item_id in integer)
    return varchar2;

    function get_item_name(
        p_list_id in integer,
        p_item_id in integer)
    return varchar2;

    function get_item_name(
        p_list_code in varchar2,
        p_item_id in integer)
    return varchar2;

    function get_item_name(
        p_list_code in varchar2,
        p_item_code in varchar2)
    return varchar2;

    function get_list_items(
        p_list_id in integer,
        p_is_active in char default 'Y')
    return number_list;

    function is_item_in_list(
        p_list_id in integer,
        p_item_id in integer)
    return char;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.LIST_UTL as

    function create_list(
        p_list_code in varchar2,
        p_list_name in varchar2)
    return integer
    is
        l_list_id integer;
    begin
        if (p_list_code is null) then
            raise_application_error(-20000, 'Код списку не вказаний');
        end if;
        if (p_list_name is null) then
            raise_application_error(-20000, 'Назва списку не вказана');
        end if;
        l_list_id := read_list_type(p_list_code, p_raise_ndf => false).id;
        if (l_list_id is not null) then
            raise_application_error(-20000, 'Тип списку з кодом {' || p_list_code || '} вже існує');
        end if;

        insert into list_type
        values (list_type_seq.nextval, upper(p_list_code), p_list_name, 'Y')
        returning id
        into l_list_id;

        return l_list_id;
    end;

    function read_list_type(
        p_list_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_type%rowtype
    is
        l_list_type_row list_type%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_list_type_row
            from   list_type lt
            where  lt.id = p_list_id
            for update wait 60;
        else
            select *
            into   l_list_type_row
            from   list_type lt
            where  lt.id = p_list_id;
        end if;

        return l_list_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Тип списку з ідентифікатором {' || p_list_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_list_type(
        p_list_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_type%rowtype
    is
        l_list_type_row list_type%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_list_type_row
            from   list_type lt
            where  lt.list_code = upper(p_list_code)
            for update wait 60;
        else
            select *
            into   l_list_type_row
            from   list_type lt
            where  lt.list_code = upper(p_list_code);
        end if;

        return l_list_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Тип списку з кодом {' || p_list_code || '} не знайдений');
             else return null;
             end if;
    end;

    function get_list_id(p_list_code in varchar2)
    return integer
    is
    begin
        return read_list_type(p_list_code, p_raise_ndf => false).id;
    end;

    function get_list_code(p_list_id in integer)
    return varchar2
    is
    begin
        return read_list_type(p_list_id, p_raise_ndf => false).list_code;
    end;

    function get_list_name(p_list_id in integer)
    return varchar2
    is
    begin
        return read_list_type(p_list_id, p_raise_ndf => false).list_name;
    end;

    function get_list_name(p_list_code in varchar2)
    return varchar2
    is
    begin
        return read_list_type(p_list_code, p_raise_ndf => false).list_name;
    end;

    procedure set_list_name(
        p_list_id in integer,
        p_list_name in varchar2)
    is
        l_list_type_row list_type%rowtype;
    begin
        l_list_type_row := read_list_type(p_list_id, p_lock => true);

        update list_type lt
        set    lt.list_name = p_list_name
        where  lt.id = l_list_type_row.id;
    end;

    procedure set_list_name(
        p_list_code in varchar2,
        p_list_name in varchar2)
    is
        l_list_type_row list_type%rowtype;
    begin
        l_list_type_row := read_list_type(p_list_code, p_lock => true);

        update list_type lt
        set    lt.list_name = p_list_name
        where  lt.id = l_list_type_row.id;
    end;

    procedure activate_list(
        p_list_id in integer)
    is
        l_list_type_row list_type%rowtype;
    begin
        l_list_type_row := read_list_type(p_list_id, p_lock => true);

        update list_type lt
        set    lt.is_active = 'Y'
        where  lt.id = l_list_type_row.id;
    end;

    procedure activate_list(
        p_list_code in varchar2)
    is
        l_list_type_row list_type%rowtype;
    begin
        l_list_type_row := read_list_type(p_list_code, p_lock => true);

        update list_type lt
        set    lt.is_active = 'Y'
        where  lt.list_code = l_list_type_row.id;
    end;

    procedure deactivate_list(
        p_list_id in integer)
    is
        l_list_type_row list_type%rowtype;
    begin
        l_list_type_row := read_list_type(p_list_id, p_lock => true);

        update list_type lt
        set    lt.is_active = 'N'
        where  lt.id = l_list_type_row.id;
    end;

    procedure deactivate_list(
        p_list_code in varchar2)
    is
        l_list_type_row list_type%rowtype;
    begin
        l_list_type_row := read_list_type(p_list_code, p_lock => true);

        update list_type lt
        set    lt.is_active = 'N'
        where  lt.list_code = l_list_type_row.id;
    end;

    procedure cor_list(
        p_list_code in varchar2,
        p_list_name in varchar2)
    is
        l_list_row list_type%rowtype;
    begin
        l_list_row := read_list_type(p_list_code, p_lock => true, p_raise_ndf => false);
        if (l_list_row.id is null) then
            tools.hide_hint(create_list(p_list_code, p_list_name));
        else
            set_list_name(p_list_code, p_list_name);
        end if;
    end;

    function read_list_item(
        p_list_id in integer,
        p_item_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_item%rowtype
    is
        l_list_item_row list_item%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_list_item_row
            from   list_item li
            where  li.list_type_id = p_list_id and
                   li.list_item_id = p_item_id
            for update wait 60;
        else
            select *
            into   l_list_item_row
            from   list_item li
            where  li.list_type_id = p_list_id and
                   li.list_item_id = p_item_id;
        end if;

        return l_list_item_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Елемент списку з ідентифікатором {' || p_item_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_list_item(
        p_list_id in integer,
        p_item_code in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return list_item%rowtype
    is
        l_list_item_row list_item%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_list_item_row
            from   list_item li
            where  li.list_type_id = p_list_id and
                   li.list_item_code = p_item_code
            for update wait 60;
        else
            select *
            into   l_list_item_row
            from   list_item li
            where  li.list_type_id = p_list_id and
                   li.list_item_code = p_item_code;
        end if;

        return l_list_item_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Елемент списку з кодом {' || p_item_code || '} не знайдений');
             else return null;
             end if;
    end;

    procedure cor_list_item(
        p_list_row in list_type%rowtype,
        p_item_id in integer,
        p_item_code in varchar2,
        p_item_name in varchar2,
        p_parent_item_row in list_item%rowtype)
    is
        l_list_item_row list_item%rowtype;
    begin
        l_list_item_row := read_list_item(p_list_row.id, p_item_id, p_lock => true, p_raise_ndf => false);

        if (l_list_item_row.list_item_id is null) then
            insert into list_item
            values (p_list_row.id, p_item_id, p_item_code, p_item_name, p_parent_item_row.list_item_id, 'Y');
        else
             update list_item li
             set    li.list_item_code = p_item_code,
                    li.list_item_name = p_item_name,
                    li.parent_list_item_id = p_parent_item_row.list_item_id
             where  li.list_type_id = p_list_row.id and
                    li.list_item_id = p_item_id;
        end if;
    end;

    procedure cor_list_item(
        p_list_id in integer,
        p_item_id in integer,
        p_item_code in varchar2,
        p_item_name in varchar2,
        p_parent_item_id in integer default null)
    is
    begin
        cor_list_item(read_list_type(p_list_id),
                      p_item_id,
                      p_item_code,
                      p_item_name,
                      case when p_parent_item_id is null then null
                           else read_list_item(p_list_id, p_parent_item_id)
                      end);
    end;

    procedure cor_list_item(
        p_list_code in varchar2,
        p_item_id in integer,
        p_item_code in varchar2,
        p_item_name in varchar2,
        p_parent_item_id in integer default null)
    is
        l_list_row list_type%rowtype;
        l_parent_item_row list_item%rowtype;
    begin
        l_list_row := read_list_type(p_list_code);
        if (p_parent_item_id is not null) then
            l_parent_item_row := read_list_item(l_list_row.id, p_parent_item_id);
        end if;

        cor_list_item(l_list_row, p_item_id, p_item_code, p_item_name, l_parent_item_row);
    end;

    function get_item_id(
        p_list_id in integer,
        p_item_code in varchar2)
    return integer
    is
    begin
        return read_list_item(p_list_id, p_item_code, p_raise_ndf => false).list_item_id;
    end;

    function get_item_id(
        p_list_code in varchar2,
        p_item_code in varchar2)
    return integer
    is
    begin
        return read_list_item(get_list_id(p_list_code), p_item_code, p_raise_ndf => false).list_item_id;
    end;

    function get_item_code(
        p_list_id in integer,
        p_item_id in integer)
    return varchar2
    is
    begin
        return read_list_item(p_list_id, p_item_id, p_raise_ndf => false).list_item_code;
    end;

    function get_item_code(
        p_list_code in varchar2,
        p_item_id in integer)
    return varchar2
    is
    begin
        return read_list_item(get_list_id(p_list_code), p_item_id, p_raise_ndf => false).list_item_code;
    end;

    function get_item_name(
        p_list_id in integer,
        p_item_id in integer)
    return varchar2
    is
    begin
        return read_list_item(p_list_id, p_item_id, p_raise_ndf => false).list_item_name;
    end;

    function get_item_name(
        p_list_code in varchar2,
        p_item_id in integer)
    return varchar2
    is
    begin
        return read_list_item(get_list_id(p_list_code), p_item_id, p_raise_ndf => false).list_item_name;
    end;

    function get_item_name(
        p_list_code in varchar2,
        p_item_code in varchar2)
    return varchar2
    is
    begin
        return read_list_item(get_list_id(p_list_code), p_item_code, p_raise_ndf => false).list_item_name;
    end;

    function get_parent_item(
        p_list_id in integer,
        p_item_id in integer)
    return integer
    is
    begin
        return read_list_item(p_list_id, p_item_id, p_raise_ndf => false).parent_list_item_id;
    end;

    function get_list_items(
        p_list_id in integer,
        p_is_active in char default 'Y')
    return number_list
    is
        l_items number_list;
    begin
        select list_item_id
        bulk collect into l_items
        from   list_item li
        where  li.list_type_id = p_list_id and
               (p_is_active is null or li.is_active = p_is_active);

        return l_items;
    end;

    function is_item_in_list(
        p_list_id in integer,
        p_item_id in integer)
    return char
    is
        l_item_in_list_flag char(1 byte);
    begin
        select 'Y'
        into   l_item_in_list_flag
        from   list_item li
        where  li.list_type_id = p_list_id and
               li.list_item_id = p_item_id;

        return l_item_in_list_flag;
    exception
        when no_data_found then
             return 'N';
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  LIST_UTL ***
grant EXECUTE                                                                on LIST_UTL        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/list_utl.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 