
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_enumeration.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_ENUMERATION IS


    function read_enumeration_type(
        p_enum_type_id  in integer,
        p_raise_ndf  in boolean default true)
    return enumeration_type%rowtype;

    function read_enumeration_value(
        p_enum_type_id  in integer,
        p_enum_value_id in integer,
        p_is_raise_ndf  in boolean default true)
    return enumeration_value%rowtype;

    function get_enumeration_name(
        p_enum_type_id  in integer,
        p_enum_value_id in integer)
    return varchar2;

    function get_enumeration_code(
        p_enum_type_id  in integer,
        p_enum_value_id in integer)
    return varchar2;

    procedure cor_enumeration_type(
        p_id        in integer,
        p_name      in varchar2);

    procedure cor_enumeration_value(
        p_type_id   in integer,
        p_id        in integer,
        p_name      in varchar2,
        p_code      in varchar2 default null,
        p_parent_id in varchar2 default null);

    --Сравнивает вхождение p_enum_id и всей родительской ветки на вхождение в коллекцию p_enum_coll
    function is_enum_eq(
        p_enum_type in integer,
        p_enum_id   in integer,
        p_enum_coll in t_number_list)
    return boolean;

    --Возвращает все вышестоящие связанные занчения (родительские) перечисления для p_enum_id
    function get_enum_root(
        p_enum_type in integer,
        p_enum_id   in integer)
    return t_number_list;

    function get_enum_root_id(
        p_enum_type in integer,
        p_enum_id   in integer)
    return integer;

    function read_enumeration_value(
        p_enum_type_id  in integer,
        p_enum_code     in varchar2,
        p_is_raise_ndf  in boolean default true,
        p_is_raise_tmr  in boolean default true)
    return enumeration_value%rowtype;

end cdb_enumeration;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_ENUMERATION is
    --
    function read_enumeration_type(p_enum_type_id in integer, p_raise_ndf in boolean default true)
    return enumeration_type%rowtype
    is
        l_enum_type_row enumeration_type%rowtype;
    begin
        select *
        into   l_enum_type_row
        from   enumeration_type ev
        where  ev.id = p_enum_type_id;

        return l_enum_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Тип списку з ідентифікатором {' || p_enum_type_id || '} не знайдений');
             else return null;
             end if;
    end;

    --
    procedure cor_enumeration_type(
        p_id        in integer,  -- id типа перечисления (константа)
        p_name      in varchar2) --имя перечисления
    is
    begin
        if  read_enumeration_type(p_id, false).id is null then
            insert into enumeration_type values (p_id, p_name);
        else
            update enumeration_type t
               set t.enumeration_name = p_name
             where t.id = p_id;
        end if;
    end cor_enumeration_type;

    function read_enumeration_value(
        p_enum_type_id  in integer,
        p_enum_value_id in integer,
        p_is_raise_ndf  in boolean default true)
    return enumeration_value%rowtype
    is
        l_row_enum_val  enumeration_value%rowtype;
    begin
        select *
          into l_row_enum_val
          from enumeration_value ev
         where ev.enumeration_type_id = p_enum_type_id
           and ev.enumeration_id = p_enum_value_id;

        return l_row_enum_val;
    exception
        when no_data_found then
             if p_is_raise_ndf then
                raise_application_error(cdb_exception.NO_DATA_FOUND, 'Значение перечисления:' || p_enum_value_id ||' для типа:' || p_enum_type_id || ' не найдено');
             else
                return null;
             end if;
    end read_enumeration_value;

    function read_enumeration_value(
        p_enum_type_id  in integer,
        p_enum_code     in varchar2,
        p_is_raise_ndf  in boolean default true,
        p_is_raise_tmr  in boolean default true)
    return enumeration_value%rowtype
    is
        l_row_enum_val  enumeration_value%rowtype;
    begin
        select *
          into l_row_enum_val
          from enumeration_value ev
         where ev.enumeration_type_id = p_enum_type_id
           and ev.enumeration_code = p_enum_code;

        return l_row_enum_val;
    exception
        when no_data_found then
             if p_is_raise_ndf then
                raise_application_error(cdb_exception.NO_DATA_FOUND, 'Значение перечисления с кодом:' || p_enum_code ||' для типа:' || p_enum_type_id || ' не найдено');
             else
                return null;
             end if;
        when too_many_rows then
             if p_is_raise_tmr then
                raise_application_error(cdb_exception.NO_DATA_FOUND, 'Найдено больше одного значения с кодом:' || p_enum_code ||' для типа перечисления:' || p_enum_type_id);
             else
                return null;
             end if;
    end read_enumeration_value;

    procedure cor_enumeration_value(
        p_type_id   in integer,
        p_id        in integer,
        p_name      in varchar2,
        p_code      in varchar2 default null,
        p_parent_id in varchar2 default null)
    is
    begin
        if  read_enumeration_value(p_type_id, p_id, p_is_raise_ndf => false).enumeration_id is null then
            insert into enumeration_value values (p_type_id, p_id, p_code, p_name, p_parent_id);
        else
            update enumeration_value t
               set t.enumeration_name = p_name,
                   t.enumeration_code = p_code,
                   t.parent_id = p_parent_id
             where t.enumeration_type_id = p_type_id
               and t.enumeration_id = p_id;
        end if;
    end cor_enumeration_value;

    function get_enumeration_name(
        p_enum_type_id  in integer,
        p_enum_value_id in integer)
    return varchar2
    is
    begin
        return read_enumeration_value(p_enum_type_id, p_enum_value_id, p_is_raise_ndf => false).enumeration_name;
    end get_enumeration_name;

    function get_enumeration_code(
        p_enum_type_id  in integer,
        p_enum_value_id in integer)
    return varchar2
    is
    begin
        return read_enumeration_value(p_enum_type_id, p_enum_value_id, p_is_raise_ndf => false).enumeration_code;
    end get_enumeration_code;

    --Возвращает все вышестоящие связанные занчения (родительские) перечисления для p_enum_id
    FUNCTION get_enum_root(
        p_enum_type IN INTEGER,
        p_enum_id   IN INTEGER)
    RETURN t_number_list
    IS
        l_ret_val   t_number_list;
    BEGIN
        SELECT ev.enumeration_id
          BULK COLLECT
          INTO l_ret_val
          FROM enumeration_value ev
         WHERE ev.enumeration_type_id = p_enum_type
    CONNECT BY ev.enumeration_id = PRIOR ev.parent_id
         START WITH ev.enumeration_id = p_enum_id;

        RETURN l_ret_val;
    END get_enum_root;

    function get_enum_root_id(
        p_enum_type in integer,
        p_enum_id   in integer)
    return integer
    is
        l_ret_val integer;
    begin
        select min(ev.enumeration_id) keep (dense_rank last order by level)
        into   l_ret_val
        from   enumeration_value ev
        where  ev.enumeration_type_id = p_enum_type
        connect by ev.enumeration_id = prior ev.parent_id
        start with ev.enumeration_id = p_enum_id;

        return l_ret_val;
    end;

    --Сравнивает вхождение p_enum_id и всей родительской ветки на вхождение в коллекцию p_enum_coll
    FUNCTION is_enum_eq(
        p_enum_type IN INTEGER,
        p_enum_id   IN INTEGER,
        p_enum_coll IN t_number_list)
    RETURN BOOLEAN
    IS
        l_enum_root_path t_number_list;
        l_common_elements t_number_list;
    BEGIN
        l_enum_root_path := get_enum_root(p_enum_type, p_enum_id);
        l_common_elements := l_enum_root_path multiset intersect p_enum_coll;

        return l_common_elements is not empty;
    END is_enum_eq;

END cdb_enumeration;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_enumeration.sql =========*** End 
 PROMPT ===================================================================================== 
 