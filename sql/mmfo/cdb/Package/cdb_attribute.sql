
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_attribute.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_ATTRIBUTE is

    YES                            constant integer := 1;
    NO                             constant integer := 0;

    VALUE_TYPE_NUMBER              constant integer := 1;
    VALUE_TYPE_STRING              constant integer := 2;
    VALUE_TYPE_DATE                constant integer := 3;

    function read_attribute_kind(
        p_attribute_kind_id in integer,
        p_raise_ndf      in boolean default true)
    return attribute_kind%ROWTYPE;

    procedure cor_attribute_kind(
        p_attribute_kind_id in integer,
        p_attribute_name           in varchar2,
        p_value_type               in integer,
        p_column_name              in varchar2);

    procedure delete_attribute_kind(
        p_attribute_kind_id in integer);

    function get_attribute_kind_name(
        p_attribute_id in integer)
    return varchar2;

    function get_num_attribute_value(
        p_deal_id     in integer,
        p_attribute_id  in integer)
    return number;

    function get_str_attribute_value(
        p_deal_id     in integer,
        p_attribute_id  in integer)
    return varchar2;

    function get_date_attribute_value(
        p_deal_id in integer,
        p_attribute_id in integer)
    return date;

    procedure create_attribute_history(p_deal_id in integer, p_attribute_id in integer, p_value in number, p_operation_id in integer default null);
    procedure create_attribute_history(p_deal_id in integer, p_attribute_id in integer, p_value in varchar2, p_operation_id in integer default null);
    procedure create_attribute_history(p_deal_id in integer, p_attribute_id in integer, p_value in date, p_operation_id in integer default null);

    procedure set_attribute_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_value        in number,
        p_operation_id in integer default null);

    procedure set_attribute_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_value        in varchar2,
        p_operation_id in integer default null);

    procedure set_attribute_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_value        in date,
        p_operation_id in integer default null);

    function get_prev_num_value(
        p_operation_id in integer,
        p_attribute_kind_id in integer)
    return number;

    function get_prev_string_value(
        p_operation_id in integer,
        p_attribute_kind_id in integer)
    return string;

    function get_prev_date_value(
        p_operation_id in integer,
        p_attribute_kind_id in integer)
    return date;

    procedure remove_history_record(
        p_history_id in integer);

    procedure set_null_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_operation_id in integer default null);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_ATTRIBUTE as

    function read_attribute_kind(
        p_attribute_kind_id in integer,
        p_raise_ndf      in boolean default true)
    return attribute_kind%rowtype
    is
        l_attribute_kind_row attribute_kind%rowtype;
    begin
        select *
        into   l_attribute_kind_row
        from   attribute_kind oak
        where  oak.id = p_attribute_kind_id;

        return l_attribute_kind_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Вид атрибута с идентификатором {' || p_attribute_kind_id || '} не найден');
             else return null;
             end if;
    end;

    procedure cor_attribute_kind(
        p_attribute_kind_id in integer,
        p_attribute_name           in varchar2,
        p_value_type               in integer,
        p_column_name              in varchar2)
    is
        l_attribute_kind_row attribute_kind%rowtype;
    begin
        l_attribute_kind_row := read_attribute_kind(p_attribute_kind_id, p_raise_ndf => false);
        if (l_attribute_kind_row.id is null) then
            insert into attribute_kind
            values (p_attribute_kind_id,
                    p_attribute_name,
                    p_value_type,
                    p_column_name,
                    cdb_attribute.NO);
        else
            update attribute_kind oak
            set    oak.attribute_name          = p_attribute_name,
                   oak.value_type              = p_value_type,
                   oak.field_name              = p_column_name
            where  oak.id = p_attribute_kind_id;
        end if;
    end;

    procedure delete_attribute_kind(
        p_attribute_kind_id in integer)
    is
    begin
        update attribute_kind oak
        set    oak.is_delete = cdb_attribute.YES
        where oak.id = p_attribute_kind_id;

        if (sql%rowcount = 0) then
            raise_application_error(cdb_exception.NO_DATA_FOUND,
                                    'Вид атрибута с идентификатором {' || p_attribute_kind_id || '} не найден');
        end if;
    end;

    function get_attribute_kind_name(
        p_attribute_id in integer)
    return varchar2
    is
    begin
        return read_attribute_kind(p_attribute_id, p_raise_ndf => false).attribute_name;
    end;

    function get_num_attribute_value(
        p_deal_id in integer,
        p_attribute_id in integer)
    return number
    is
        l_value number;
        l_row_attr_kind attribute_kind%rowtype;
    begin
        l_row_attr_kind := read_attribute_kind(p_attribute_id);

        execute immediate 'select ' || l_row_attr_kind.field_name || ' from deal where id = :id' into l_value using p_deal_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_str_attribute_value(
        p_deal_id in integer,
        p_attribute_id in integer)
    return varchar2
    is
        l_value varchar2(500 char);
        l_row_attr_kind attribute_kind%rowtype;
    begin
        l_row_attr_kind := read_attribute_kind(p_attribute_id);

        execute immediate 'select ' || l_row_attr_kind.field_name || ' from deal where id = :id' into l_value using p_deal_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_date_attribute_value(
        p_deal_id in integer,
        p_attribute_id in integer)
    return date
    is
        l_value date;
        l_row_attr_kind attribute_kind%rowtype;
    begin
        l_row_attr_kind := read_attribute_kind(p_attribute_id);

        execute immediate 'select ' || l_row_attr_kind.field_name || ' from deal where id = :id' into l_value using p_deal_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    procedure link_history_to_operation(
        p_history_id in integer,
        p_operation_id in integer)
    is
    begin
        insert into attribute_operation_history
        values (p_operation_id, p_history_id);
    end;

    function create_attribute_history_item(
        p_deal_id in integer,
        p_attribute_id in integer,
        p_operation_id in integer default null)
    return integer
    is
        l_history_id integer;
    begin

        insert into attribute_history
        values (attribute_history_seq.nextval, p_deal_id, p_attribute_id, sysdate, cdb_attribute.NO)
        returning id
        into l_history_id;

        if (p_operation_id is not null) then
            link_history_to_operation(l_history_id, p_operation_id);
        end if;

        return l_history_id;
    end;

    function read_attribute_history(
        p_history_id             in integer,
        p_raise_ndf in boolean default true)
    return attribute_history%rowtype
    is
        l_attribute_history_row attribute_history%rowtype;
    begin
        select *
        into   l_attribute_history_row
        from   attribute_history oah
        where  oah.id = p_history_id;

        return l_attribute_history_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Запись в истории атрибутов с идентификатором {' || p_history_id || '} не найдена');
             else return null;
             end if;
    end;

    procedure create_attribute_history(
        p_deal_id     in integer,
        p_attribute_id  in integer,
        p_value         in number,
        p_operation_id  in integer default null)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_attribute_history_item(p_deal_id, p_attribute_id, p_operation_id);

        insert into attribute_history_num values (l_attribute_history_id, p_value);
    end;

    procedure create_attribute_history(p_deal_id in integer, p_attribute_id in integer, p_value in varchar2, p_operation_id in integer default null)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_attribute_history_item(p_deal_id, p_attribute_id, p_operation_id);

        insert into attribute_history_string values (l_attribute_history_id, p_value);
    end;

    procedure create_attribute_history(p_deal_id in integer, p_attribute_id in integer, p_value in date, p_operation_id in integer default null)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_attribute_history_item(p_deal_id, p_attribute_id, p_operation_id);

        insert into attribute_history_date values (l_attribute_history_id, p_value);
    end;

    procedure set_attribute_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_value        in number,
        p_operation_id in integer default null)
    is
        l_attribute_kind_row attribute_kind%rowtype;
    begin
        l_attribute_kind_row := read_attribute_kind(p_attribute_id);

        execute immediate 'update deal ' ||
                          'set ' || l_attribute_kind_row.field_name || ' = :new_value ' ||
                          'where id = :deal_id'
        using p_value, p_deal_id;

        create_attribute_history(p_deal_id, p_attribute_id, p_value, p_operation_id);
    end;

    procedure set_attribute_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_value        in varchar2,
        p_operation_id in integer default null)
    is
        l_attribute_kind_row attribute_kind%rowtype;
    begin
        l_attribute_kind_row := read_attribute_kind(p_attribute_id);

        execute immediate 'update deal ' ||
                          'set ' || l_attribute_kind_row.field_name || ' = :new_value ' ||
                          'where id = :deal_id'
        using p_value, p_deal_id;

        create_attribute_history(p_deal_id, p_attribute_id, p_value, p_operation_id);
    end;

    procedure set_attribute_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_value        in date,
        p_operation_id in integer default null)
    is
        l_attribute_kind_row attribute_kind%rowtype;
    begin
        l_attribute_kind_row := read_attribute_kind(p_attribute_id);

        execute immediate 'update deal ' ||
                          'set ' || l_attribute_kind_row.field_name || ' = :new_value ' ||
                          'where id = :deal_id'
        using p_value, p_deal_id;

        create_attribute_history(p_deal_id, p_attribute_id, p_value, p_operation_id);
    end;

    function get_previous_history_id(
        p_history_id   in integer,
        p_deal_id    in integer,
        p_attribute_id in integer)
    return integer
    is
        l_prev_history_id integer;
    begin
        select min(oah.id) keep (dense_rank last order by oah.id)
        into   l_prev_history_id
        from   attribute_history oah
        where  oah.deal_id = p_deal_id and
               oah.attribute_id = p_attribute_id and
               oah.is_delete = cdb_attribute.NO and
               oah.id < p_history_id;

        return l_prev_history_id;
    end;

    function is_last_history_record(
        p_history_id   in integer,
        p_deal_id    in integer,
        p_attribute_id in integer)
    return boolean
    is
        l_history_records_count integer;
    begin
        select count(*)
        into   l_history_records_count
        from   attribute_history oah
        where  oah.deal_id = p_deal_id and
               oah.attribute_id = p_attribute_id and
               oah.is_delete = cdb_attribute.NO and
               oah.id > p_history_id;

        return l_history_records_count = 0;
    end;

    procedure delete_history_record(p_history_id in integer)
    is
    begin
        update attribute_history oah
        set    oah.is_delete = cdb_attribute.YES
        where  oah.id = p_history_id;

        if (sql%rowcount = 0) then
            raise_application_error(cdb_exception.NO_DATA_FOUND,
                                    'Запись в истории атрибутов с идентификатором {' || p_history_id || '} не найдена');
        end if;
    end;

    function get_num_value_from_hist(p_history_id in integer)
    return number
    is
        l_value number(32, 12);
    begin
        select oahn.value
        into   l_value
        from   attribute_history_num oahn
        where  oahn.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_str_value_from_hist(p_history_id in integer)
    return varchar2
    is
        l_value varchar2(500 char);
    begin
        select oahs.value
        into   l_value
        from   attribute_history_string oahs
        where  oahs.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_date_value_from_hist(p_history_id in integer)
    return date
    is
        l_value date;
    begin
        select oahd.value
        into   l_value
        from   attribute_history_date oahd
        where  oahd.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    procedure restore_prev_num_value(
        p_history_row in attribute_history%rowtype,
        p_attribute_kind_row in attribute_kind%rowtype)
    is
        l_prev_history_id integer;
        l_prev_value  number(32, 12);
    begin
        l_prev_history_id := get_previous_history_id(p_history_row.id,
                                                     p_history_row.deal_id,
                                                     p_history_row.attribute_id);

        l_prev_value := get_num_value_from_hist(l_prev_history_id);

        execute immediate 'update deal ' ||
                          'set ' || p_attribute_kind_row.field_name || ' = :prev_value ' ||
                          'where id = :deal_id'
        using l_prev_value, p_history_row.deal_id;
    end;

    procedure restore_prev_str_value(
        p_history_row in attribute_history%rowtype,
        p_attribute_kind_row in attribute_kind%rowtype)
    is
        l_prev_history_id integer;
        l_prev_value  varchar2(500 char);
    begin
        l_prev_history_id := get_previous_history_id(p_history_row.id,
                                                     p_history_row.deal_id,
                                                     p_history_row.attribute_id);

        l_prev_value := get_str_value_from_hist(l_prev_history_id);

        execute immediate 'update deal ' ||
                          'set ' || p_attribute_kind_row.field_name || ' = :prev_value ' ||
                          'where id = :deal_id'
        using l_prev_value, p_history_row.deal_id;
    end;

    procedure restore_prev_date_value(
        p_history_row in attribute_history%rowtype,
        p_attribute_kind_row in attribute_kind%rowtype)
    is
        l_prev_history_id integer;
        l_prev_value  date;
    begin
        l_prev_history_id := get_previous_history_id(p_history_row.id,
                                                     p_history_row.deal_id,
                                                     p_history_row.attribute_id);

        l_prev_value := get_date_value_from_hist(l_prev_history_id);

        execute immediate 'update deal ' ||
                          'set ' || p_attribute_kind_row.field_name || ' = :prev_value ' ||
                          'where id = :deal_id'
        using l_prev_value, p_history_row.deal_id;
    end;

    procedure remove_history_record(
        p_history_id in integer)
    is
        l_history_row               attribute_history%rowtype;
        l_attribute_kind_row attribute_kind%rowtype;
    begin
        l_history_row := read_attribute_history(p_history_id, true);

        l_attribute_kind_row := read_attribute_kind(l_history_row.attribute_id);

        if (is_last_history_record(p_history_id,
                                   l_history_row.deal_id,
                                   l_history_row.attribute_id)) then

            case l_attribute_kind_row.value_type
            when cdb_attribute.VALUE_TYPE_NUMBER then
                 restore_prev_num_value(l_history_row, l_attribute_kind_row);
            when cdb_attribute.VALUE_TYPE_STRING then
                 restore_prev_str_value(l_history_row, l_attribute_kind_row);
            when cdb_attribute.VALUE_TYPE_DATE then
                 restore_prev_date_value(l_history_row, l_attribute_kind_row);
            else
                 raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                         'Неожиданный тип значения атрибута {' || l_attribute_kind_row.value_type || '}');
            end case;
        else
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Удаляемое значение истории {' || p_history_id ||
                                    '} атрибута {' || l_attribute_kind_row.attribute_name ||
                                    '} по объекту {' || l_history_row.deal_id ||
                                    '} не последнее в истории - удалять записи из средины истории запрещено');
        end if;

        delete_history_record(p_history_id);
    end;

    function get_previous_history_id(
        p_operation_id in integer,
        p_attribute_id in integer)
    return integer
    is
        l_attribute_history_id integer;
        l_deal_id integer;
    begin
        begin
            select ah.id, o.deal_id
            into   l_attribute_history_id, l_deal_id
            from   operation o
            join   attribute_operation_history aoh on aoh.operation_id = o.id
            join   attribute_history ah on ah.id = aoh.attribute_history_id and
                                           ah.is_delete = cdb_attribute.NO and
                                           ah.attribute_id = p_attribute_id
            where  o.id = p_operation_id;
        exception
            when too_many_rows then
                 raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                         'Не удалось получить предыдущее значение атрибута {' || get_attribute_kind_name(p_attribute_id) ||
                                         '} по объекту {' || l_deal_id || '} для операции {' || p_operation_id ||
                                         '}: операция изменила один атрибут более одного раза');
            when no_data_found then
                 null;
        end;

        return get_previous_history_id(l_attribute_history_id, l_deal_id, p_attribute_id);
    end;

    function get_prev_num_value(
        p_operation_id in integer,
        p_attribute_kind_id in integer)
    return number
    is
        l_prev_history_id integer;
    begin
        l_prev_history_id := get_previous_history_id(p_operation_id, p_attribute_kind_id);
        if (l_prev_history_id is not null) then
            return get_num_value_from_hist(l_prev_history_id);
        else return null;
        end if;
    end;

    function get_prev_string_value(
        p_operation_id in integer,
        p_attribute_kind_id in integer)
    return string
    is
        l_prev_history_id integer;
    begin
        l_prev_history_id := get_previous_history_id(p_operation_id, p_attribute_kind_id);
        if (l_prev_history_id is not null) then
            return get_str_value_from_hist(l_prev_history_id);
        else return null;
        end if;
    end;

    function get_prev_date_value(
        p_operation_id in integer,
        p_attribute_kind_id in integer)
    return date
    is
        l_prev_history_id integer;
    begin
        l_prev_history_id := get_previous_history_id(p_operation_id, p_attribute_kind_id);
        if (l_prev_history_id is not null) then
            return get_date_value_from_hist(l_prev_history_id);
        else return null;
        end if;
    end;

    procedure set_null_value(
        p_deal_id    in integer,
        p_attribute_id in integer,
        p_operation_id in integer default null)
    is
        l_row_kind  attribute_kind%rowtype;
    begin
        l_row_kind := read_attribute_kind(p_attribute_id);
        if  l_row_kind.value_type = cdb_attribute.VALUE_TYPE_NUMBER then
            set_attribute_value(p_deal_id, p_attribute_id, cast(null as number), p_operation_id);
        elsif   l_row_kind.value_type = cdb_attribute.VALUE_TYPE_STRING then
            set_attribute_value(p_deal_id, p_attribute_id, cast(null as varchar2), p_operation_id);
        elsif   l_row_kind.value_type = cdb_attribute.VALUE_TYPE_DATE then
            set_attribute_value(p_deal_id, p_attribute_id, cast(null as date), p_operation_id);
        end if;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_attribute.sql =========*** End **
 PROMPT ===================================================================================== 
 