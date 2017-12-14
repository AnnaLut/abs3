 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/attribute_utl.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ATTRIBUTE_UTL is

    -- Author  : Artem Yurchenko
    -- Date    : 2015-04-20
    -- Purpose : Пакет для роботи з атрибутами об'єктів АБС

    OBJECT_TYPE_ATTRIBUTE          constant varchar2(30 char) := 'ATTRIBUTE';
    ATTR_TYPE_FIXED                constant varchar2(30 char) := 'FIXED_PARAMETER';
    ATTR_TYPE_DYNAMIC              constant varchar2(30 char) := 'DYNAMIC_ATTRIBUTE';
    ATTR_TYPE_CALCULATED           constant varchar2(30 char) := 'CALCULATED_ATTRIBUTE';

    LT_ATTRIBUTE_STATE             constant varchar2(30 char) := 'ATTRIBUTE_STATE';
    ATTR_STATE_UNDER_CONSTRUCTION  constant integer := 1;
    ATTR_STATE_ACTIVE              constant integer := 2;
    ATTR_STATE_CLOSED              constant integer := 3;

    LT_ATTRIBUTE_VALUE_TYPE        constant varchar2(30 char) := 'ATTRIBUTE_VALUE_TYPE';
    VALUE_TYPE_NUMBER              constant integer := 1;
    VALUE_TYPE_STRING              constant integer := 2;
    VALUE_TYPE_DATE                constant integer := 3;
    VALUE_TYPE_CLOB                constant integer := 4;
    VALUE_TYPE_BLOB                constant integer := 5;
    VALUE_TYPE_LIST                constant integer := 6;
    VALUE_TYPE_DEAL                constant integer := 7;
    VALUE_TYPE_ACCOUNT             constant integer := 8;
    VALUE_TYPE_CUSTOMER            constant integer := 9;

    LT_ATTRIBUTE_HISTORY_MODE      constant varchar2(30 char) := 'ATTRIBUTE_HISTORY_MODE';
    HISTORY_MODE_NO_HISTORY        constant integer := 1;
    HISTORY_MODE_VALUES_ONLY       constant integer := 2;
    HISTORY_MODE_VALUES_BY_DATE    constant integer := 3;

    ATTR_CODE_NAME                 constant varchar2(30 char) := 'ATTR_NAME';
    ATTR_CODE_OBJECT_TYPE          constant varchar2(30 char) := 'ATTR_OBJECT_TYPE';
    ATTR_CODE_VALUE_TYPE           constant varchar2(30 char) := 'ATTR_VALUE_TYPE';
    ATTR_CODE_VALUE_TABLE_OWNER    constant varchar2(30 char) := 'ATTR_VALUE_TABLE_OWNER';
    ATTR_CODE_VALUE_TABLE_NAME     constant varchar2(30 char) := 'ATTR_VALUE_TABLE_NAME';
    ATTR_CODE_KEY_COLUMN_NAME      constant varchar2(30 char) := 'ATTR_KEY_COLUMN_NAME';
    ATTR_CODE_VALUE_COLUMN_NAME    constant varchar2(30 char) := 'ATTR_VALUE_COLUMN_NAME';
    ATTR_CODE_REGULAR_EXPRESSION   constant varchar2(30 char) := 'ATTR_REGULAR_EXPRESSION';
    ATTR_CODE_LIST_TYPE            constant varchar2(30 char) := 'ATTR_LIST_TYPE';
    ATTR_CODE_MULTY_VALUE_FLAG     constant varchar2(30 char) := 'ATTR_MULTY_VALUE_FLAG';
    ATTR_CODE_HISTORY_MODE         constant varchar2(30 char) := 'ATTR_HISTORY_MODE';
    ATTR_CODE_GET_VALUE_FUNCTION   constant varchar2(30 char) := 'ATTR_GET_VALUE_FUNCTION';
    ATTR_CODE_GET_VALUES_FUNCTION  constant varchar2(30 char) := 'ATTR_GET_VALUES_FUNCTION';
    ATTR_CODE_SET_VALUE_PROCEDURE  constant varchar2(30 char) := 'ATTR_SET_VALUE_PROCEDURE';
    ATTR_CODE_DEL_VALUE_PROCEDURE  constant varchar2(30 char) := 'ATTR_DEL_VALUE_PROCEDURE';
    ATTR_CODE_STATE                constant varchar2(30 char) := 'ATTR_STATE';

    function create_parameter(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_value_table_owner        in varchar2 default null,
        p_value_table_name         in varchar2 default null,
        p_key_column_name          in varchar2 default null,
        p_value_column_name        in varchar2 default null,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_history_saving_mode_id   in integer default attribute_utl.HISTORY_MODE_VALUES_ONLY,
        p_set_value_procedure      in varchar2 default null,
        p_del_value_procedure      in varchar2 default null)
    return integer;

    function create_dynamic_attribute(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_multy_value_flag         in char default 'N',
        p_history_saving_mode_id   in integer default attribute_utl.HISTORY_MODE_VALUES_ONLY,
        p_set_value_procedure      in varchar2 default null,
        p_del_value_procedure      in varchar2 default null)
    return integer;

    function create_calculated_attribute(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_multy_value_flag         in char default 'N',
        p_get_value_function       in varchar2 default null,
        p_get_values_function      in varchar2 default null,
        p_set_value_procedure      in varchar2 default null,
        p_del_value_procedure      in varchar2 default null)
    return integer;

    function read_attribute(
        p_attribute_id in integer,
        p_raise_ndf in boolean default true)
    return attribute_kind%rowtype
    result_cache;

    function read_attribute(
        p_attribute_code in varchar2,
        p_raise_ndf in boolean default true)
    return attribute_kind%rowtype
    result_cache;

    function get_attribute_id(
        p_attribute_code in varchar2)
    return integer;

    function get_attribute_code(
        p_attribute_id in integer)
    return varchar2;

    function get_attribute_name(
        p_attribute_id in integer)
    return varchar2;

    function get_attribute_name(
        p_attribute_code in varchar2)
    return varchar2;

    function get_number_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number;

    function get_number_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number;

    function get_number_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number_list;

    function get_number_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number_list;

    function get_string_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2;

    function get_string_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2;

    function get_string_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2_list;

    function get_string_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2_list;

    function get_date_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date;

    function get_date_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date;

    function get_date_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date_list;

    function get_date_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date_list;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob_list;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob_list;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob_list;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob_list;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in varchar2_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in varchar2_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in varchar2_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in varchar2_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in varchar2_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in varchar2_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_comment in varchar2 default null);

    procedure remove_history(
        p_history_id in integer,
        p_comment in varchar2);

    procedure on_set_attribute_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_object_type(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_value_type(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_value_table_owner(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_value_table_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_key_column_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_value_column_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_regular_expression(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_list_type(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_multy_value_flag(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_history_saving_mode(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_get_value_function(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_get_values_function(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_set_value_procedure(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure on_set_del_value_procedure(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date);

    procedure put_under_construction(
        p_attribute_id in integer);

    procedure activate_attribute(
        p_attribute_id in integer);

    procedure close_attribute(
        p_attribute_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.ATTRIBUTE_UTL as

    function map_value_type_to_oracle_type(
        p_value_type_id in integer)
    return varchar2
    is
    begin
        case when p_value_type_id in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST, attribute_utl.VALUE_TYPE_DEAL,
                                      attribute_utl.VALUE_TYPE_ACCOUNT, attribute_utl.VALUE_TYPE_CUSTOMER) then
                  return 'NUMBER';
             when p_value_type_id = attribute_utl.VALUE_TYPE_STRING then
                  return 'VARCHAR2';
             when p_value_type_id = attribute_utl.VALUE_TYPE_DATE then
                  return 'DATE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_BLOB then
                  return 'BLOB';
             when p_value_type_id = attribute_utl.VALUE_TYPE_CLOB then
                  return 'CLOB';
        end case;
    end;

    procedure check_attribute_uniqueness(p_attribute_code in varchar2)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code, p_raise_ndf => false);

        if (l_attribute_row.id is not null) then
            raise_application_error(-20000, 'Атрибут з кодом {' || p_attribute_code || '} вже існує');
        end if;
    end;

    procedure check_attribute_value_storage(
        p_attribute_name in varchar2,
        p_object_type_id in integer,
        p_value_type_id in integer,
        p_value_table_owner in varchar2,
        p_value_table_name in varchar2,
        p_key_column_name in varchar2,
        p_value_column_name in varchar2)
    is
        l_value_table_owner varchar2(30 char) default p_value_table_owner;
        l_value_table_name varchar2(30 char) default p_value_table_name;
        l_key_column_name varchar2(30 char) default p_key_column_name;
        l_object_type_storage_row object_type_storage%rowtype;
    begin
        if (p_value_column_name is null) then
            raise_application_error(-20000, 'Поле, що зберігає значення параметру {' || p_attribute_name || '} не вказане');
        end if;

        if (l_value_table_name is null) then
            l_object_type_storage_row := object_utl.read_object_type_storage(p_object_type_id);
            l_value_table_name := l_object_type_storage_row.table_name;
            l_value_table_owner := l_object_type_storage_row.table_owner;
            l_key_column_name := l_object_type_storage_row.key_column_name;
        end if;

        if (l_value_table_name is null) then
            raise_application_error(-20000, 'Таблиця, що зберігає значення параметру {' || p_attribute_name || '} не вказана');
        end if;

        if (l_key_column_name is null) then
            raise_application_error(-20000, 'Поле, що зберігає унікальний ідентифікатор об''єкту в таблиці {' || l_value_table_name || '} не вказане');
        end if;

        ddl_utl.check_if_table_exists(l_value_table_name, l_value_table_owner);
        ddl_utl.check_if_column_exists(l_value_table_name, l_key_column_name, l_value_table_owner);
        ddl_utl.check_if_column_exists(l_value_table_name, p_value_column_name, l_value_table_owner);

        if (ddl_utl.get_column_data_type(p_value_table_name, p_value_column_name, p_value_table_owner) <> map_value_type_to_oracle_type(p_value_type_id)) then
            raise_application_error(-20000, 'Тип значень параметру {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_value_type_id) ||
                                            '} не відповідає типу поля {' || map_value_type_to_oracle_type(p_value_type_id) || '}');
        end if;
    end;

    procedure check_attribute(
        p_attribute_type_code in varchar2,
        p_attribute_name in varchar2,
        p_value_type_id in integer,
        p_regular_expression in varchar2,
        p_list_type_code in varchar2,
        p_history_saving_mode_id in integer)
    is
        l_list_type_row list_type%rowtype;
    begin
        if (p_attribute_type_code not in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC, attribute_utl.ATTR_TYPE_CALCULATED)) then
            raise_application_error(-20000, 'Неочікуваний тип атрибуту {' || p_attribute_type_code || '}');
        end if;

        if (p_attribute_name is null) then
            raise_application_error(-20000, 'Назва атрибуту не вказана');
        end if;

        if (p_value_type_id is null) then
            raise_application_error(-20000, 'Тип значеннь, що зберігає атрибут {' || p_attribute_name || '} не вказаний');
        end if;

        if (p_history_saving_mode_id is null) then
            raise_application_error(-20000, 'Режим історизації значень атрибуту {' || p_attribute_name || '} не вказаний');
        end if;

        if (p_history_saving_mode_id not in (attribute_utl.HISTORY_MODE_NO_HISTORY, attribute_utl.HISTORY_MODE_VALUES_ONLY, attribute_utl.HISTORY_MODE_VALUES_BY_DATE)) then
            raise_application_error(-20000, 'Неочікуваний ідентифікатор режиму історизації {' || p_history_saving_mode_id || '}');
        end if;

        if (p_value_type_id not in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_STRING, attribute_utl.VALUE_TYPE_DATE,
                                    attribute_utl.VALUE_TYPE_CLOB, attribute_utl.VALUE_TYPE_BLOB, attribute_utl.VALUE_TYPE_LIST,
                                    attribute_utl.VALUE_TYPE_DEAL, attribute_utl.VALUE_TYPE_ACCOUNT, attribute_utl.VALUE_TYPE_CUSTOMER)) then
            raise_application_error(-20000, 'Неочікуваний тип значення атрибуту {' || p_value_type_id || '}');
        end if;

        if (p_regular_expression is not null and p_value_type_id <> attribute_utl.VALUE_TYPE_STRING) then
            raise_application_error(-20000, 'Шаблон перевірки регулярного виразу може використовуватися лише для атрибутів, що зберігають строкові значення');
        end if;

        if (p_value_type_id = attribute_utl.VALUE_TYPE_LIST) then
            if (p_list_type_code is null) then
                raise_application_error(-20000, 'Тип значення атрибуту "Список", але тип списку не вказаний');
            end if;

            l_list_type_row := list_utl.read_list_type(p_list_type_code);

            if (l_list_type_row.is_active = 'N') then
                raise_application_error(-20000, 'Тип списку {' || l_list_type_row.list_name || '} не активний - його використання заборонено');
            end if;
        end if;
    end;

    procedure check_state_before_change(
        p_attribute_row in attribute_kind%rowtype)
    is
    begin
        if (not tools.equals(p_attribute_row.state_id, attribute_utl.ATTR_STATE_UNDER_CONSTRUCTION)) then
            raise_application_error(-20000, 'Для зміни налаштувань атрибуту {' || p_attribute_row.attribute_name || '}, його необхідно перевести в режим конструювання');
        end if;
    end;

    procedure check_new_parameter(
        p_attribute_code in varchar2,
        p_attribute_name in varchar2,
        p_object_type_id in integer,
        p_value_type_id in integer,
        p_value_table_owner in varchar2,
        p_value_table_name in varchar2,
        p_key_column_name in varchar2,
        p_value_column_name in varchar2,
        p_regular_expression in varchar2,
        p_list_type_code in varchar2,
        p_history_saving_mode_id in integer)
    is
    begin
        check_attribute_uniqueness(p_attribute_code);

        check_attribute(attribute_utl.ATTR_TYPE_FIXED,
                        p_attribute_name,
                        p_value_type_id,
                        p_regular_expression,
                        p_list_type_code,
                        p_history_saving_mode_id);

        check_attribute_value_storage(p_attribute_name,
                                      p_object_type_id,
                                      p_value_type_id,
                                      p_value_table_owner,
                                      p_value_table_name,
                                      p_key_column_name,
                                      p_value_column_name);
    end;

    procedure check_new_dynamic_attribute(
        p_attribute_code in varchar2,
        p_attribute_name in varchar2,
        p_value_type_id in integer,
        p_regular_expression in varchar2,
        p_list_type_code in varchar2,
        p_multy_value_flag in char,
        p_history_saving_mode_id in integer)
    is
    begin
        check_attribute_uniqueness(p_attribute_code);

        check_attribute(attribute_utl.ATTR_TYPE_DYNAMIC,
                        p_attribute_name,
                        p_value_type_id,
                        p_regular_expression,
                        p_list_type_code,
                        p_history_saving_mode_id);

       if (p_multy_value_flag is null) then
           raise_application_error(-20000, 'Ознака допустимості множинних значень атрибуту не вказана');
       end if;
    end;

    procedure check_new_calculated_attribute(
        p_attribute_code in varchar2,
        p_attribute_name in varchar2,
        p_value_type_id in integer,
        p_regular_expression in varchar2,
        p_list_type_code in varchar2,
        p_multy_value_flag in char,
        p_history_saving_mode_id in integer,
        p_get_value_function in varchar2,
        p_get_values_function in varchar2)
    is
    begin
        check_attribute_uniqueness(p_attribute_code);

        check_attribute(attribute_utl.ATTR_TYPE_DYNAMIC,
                        p_attribute_name,
                        p_value_type_id,
                        p_regular_expression,
                        p_list_type_code,
                        p_history_saving_mode_id);

       if (p_multy_value_flag is null) then
           raise_application_error(-20000, 'Ознака допустимості множинних значень атрибуту не вказана');
       end if;

       if (p_multy_value_flag = 'Y' and p_get_values_function is null) then
            raise_application_error(-20000, 'Функція отримання значень для розрахункового атрибуту не вказана');
        elsif (p_multy_value_flag = 'N' and p_get_value_function is null) then
            raise_application_error(-20000, 'Функція отримання значень для розрахункового атрибуту не вказана');
        end if;
    end;

    procedure validate_attribute(
        p_attribute_row in attribute_kind%rowtype)
    is
        l_attribute_type_code varchar2(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attribute(l_attribute_type_code,
                        p_attribute_row.attribute_name,
                        p_attribute_row.value_type_id,
                        p_attribute_row.regular_expression,
                        list_utl.get_list_code(p_attribute_row.list_type_id),
                        p_attribute_row.history_saving_mode_id);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            check_attribute_value_storage(p_attribute_row.attribute_name,
                                          p_attribute_row.object_type_id,
                                          p_attribute_row.value_type_id,
                                          p_attribute_row.value_table_owner,
                                          p_attribute_row.value_table_name,
                                          p_attribute_row.key_column_name,
                                          p_attribute_row.value_column_name);

        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            if (p_attribute_row.multy_value_flag = 'Y' and p_attribute_row.get_values_function is null) then
                raise_application_error(-20000, 'Функція отримання значень для розрахункового атрибуту не вказана');
            elsif (p_attribute_row.multy_value_flag = 'N' and p_attribute_row.get_value_function is null) then
                raise_application_error(-20000, 'Функція отримання значень для розрахункового атрибуту не вказана');
            end if;
        end if;
    end;

    function create_attribute(
        p_attribute_type_code      in varchar2,
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_id           in integer,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_history_saving_mode_id   in integer default attribute_utl.HISTORY_MODE_VALUES_ONLY,
        p_set_value_procedure      in varchar2 default null,
        p_del_value_procedure      in varchar2 default null)
    return integer
    is
        l_attribute_id integer;
    begin
        insert into attribute_kind(id, attribute_type_id, attribute_code, state_id)
        values (attribute_kind_seq.nextval,
                object_utl.get_object_type_id(p_attribute_type_code),
                upper(p_attribute_code),
                attribute_utl.ATTR_STATE_UNDER_CONSTRUCTION)
        returning id into l_attribute_id;

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_NAME, p_attribute_name);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_OBJECT_TYPE, p_object_type_id);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_TYPE, p_value_type_id);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_REGULAR_EXPRESSION, p_regular_expression);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_LIST_TYPE, list_utl.get_list_id(p_list_type_code));
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_HISTORY_MODE, p_history_saving_mode_id);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_SET_VALUE_PROCEDURE, p_set_value_procedure);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_DEL_VALUE_PROCEDURE, p_del_value_procedure);

        return l_attribute_id;
    end;

    function create_parameter(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_value_table_owner        in varchar2 default null,
        p_value_table_name         in varchar2 default null,
        p_key_column_name          in varchar2 default null,
        p_value_column_name        in varchar2 default null,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_history_saving_mode_id   in integer default attribute_utl.HISTORY_MODE_VALUES_ONLY,
        p_set_value_procedure      in varchar2 default null,
        p_del_value_procedure      in varchar2 default null)
    return integer
    is
        l_attribute_id integer;
        l_object_type_row object_type%rowtype;
    begin
        l_object_type_row := object_utl.read_object_type(p_object_type_code);

        check_new_parameter(p_attribute_code,
                            p_attribute_name,
                            l_object_type_row.id,
                            p_value_type_id,
                            p_value_table_owner,
                            p_value_table_name,
                            p_key_column_name,
                            p_value_column_name,
                            p_regular_expression,
                            p_list_type_code,
                            p_history_saving_mode_id);

        l_attribute_id := create_attribute(attribute_utl.ATTR_TYPE_FIXED,
                                           p_attribute_code,
                                           p_attribute_name,
                                           l_object_type_row.id,
                                           p_value_type_id,
                                           p_regular_expression => p_regular_expression,
                                           p_list_type_code => p_list_type_code,
                                           p_history_saving_mode_id => p_history_saving_mode_id,
                                           p_set_value_procedure => p_set_value_procedure,
                                           p_del_value_procedure => p_del_value_procedure);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_TABLE_OWNER, p_value_table_owner);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_TABLE_NAME, p_value_table_name);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_KEY_COLUMN_NAME, p_key_column_name);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_COLUMN_NAME, p_value_column_name);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_MULTY_VALUE_FLAG, 'N');

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_STATE, attribute_utl.ATTR_STATE_ACTIVE);

        return l_attribute_id;
    end;

    function create_dynamic_attribute(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_multy_value_flag         in char default 'N',
        p_history_saving_mode_id   in integer default attribute_utl.HISTORY_MODE_VALUES_ONLY,
        p_set_value_procedure      in varchar2 default null,
        p_del_value_procedure      in varchar2 default null)
    return integer
    is
        l_attribute_id integer;
        l_object_type_row object_type%rowtype;
    begin
        l_object_type_row := object_utl.read_object_type(p_object_type_code);

        check_new_dynamic_attribute(p_attribute_code,
                                    p_attribute_name,
                                    p_value_type_id,
                                    p_regular_expression,
                                    p_list_type_code,
                                    p_multy_value_flag,
                                    attribute_utl.HISTORY_MODE_NO_HISTORY);

        l_attribute_id := create_attribute(attribute_utl.ATTR_TYPE_DYNAMIC,
                                           p_attribute_code,
                                           p_attribute_name,
                                           l_object_type_row.id,
                                           p_value_type_id,
                                           p_regular_expression => p_regular_expression,
                                           p_list_type_code => p_list_type_code,
                                           p_history_saving_mode_id => p_history_saving_mode_id,
                                           p_set_value_procedure => p_set_value_procedure,
                                           p_del_value_procedure => p_del_value_procedure);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_MULTY_VALUE_FLAG, p_multy_value_flag);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_STATE, attribute_utl.ATTR_STATE_ACTIVE);

        return l_attribute_id;
    end;

    function create_calculated_attribute(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_multy_value_flag         in char default 'N',
        p_get_value_function       in varchar2 default null,
        p_get_values_function      in varchar2 default null,
        p_set_value_procedure      in varchar2 default null,
        p_del_value_procedure      in varchar2 default null)
    return integer
    is
        l_attribute_id integer;
        l_object_type_row object_type%rowtype;
    begin
        l_object_type_row := object_utl.read_object_type(p_object_type_code);

        check_new_calculated_attribute(p_attribute_code,
                                       p_attribute_name,
                                       p_value_type_id,
                                       p_regular_expression,
                                       p_list_type_code,
                                       p_multy_value_flag,
                                       attribute_utl.HISTORY_MODE_NO_HISTORY,
                                       p_get_value_function,
                                       p_get_values_function);

        l_attribute_id := create_attribute(attribute_utl.ATTR_TYPE_CALCULATED,
                                           p_attribute_code,
                                           p_attribute_name,
                                           l_object_type_row.id,
                                           p_value_type_id,
                                           p_regular_expression => p_regular_expression,
                                           p_list_type_code => p_list_type_code,
                                           p_history_saving_mode_id => attribute_utl.HISTORY_MODE_NO_HISTORY,
                                           p_set_value_procedure => p_set_value_procedure,
                                           p_del_value_procedure => p_del_value_procedure);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_MULTY_VALUE_FLAG, p_multy_value_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_GET_VALUE_FUNCTION, p_get_value_function);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_GET_VALUES_FUNCTION, p_get_values_function);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_STATE, attribute_utl.ATTR_STATE_ACTIVE);

        return l_attribute_id;
    end;

    procedure lock_attribute(
        p_attribute_id in integer,
        p_raise_ndf in boolean default true)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        select *
        into   l_attribute_row
        from   attribute_kind oak
        where  oak.id = p_attribute_id
        for update wait 60;

    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид атрибуту з ідентифікатором {' || p_attribute_id || '} не знайдений');
             else null;
             end if;
    end;

    procedure lock_attribute(
        p_attribute_code in varchar2,
        p_raise_ndf in boolean default true)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        select *
        into   l_attribute_row
        from   attribute_kind oak
        where  oak.attribute_code = p_attribute_code
        for update wait 60;

    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид атрибуту з кодом {' || p_attribute_code || '} не знайдений');
             else null;
             end if;
    end;

    function read_attribute(
        p_attribute_id in integer,
        p_raise_ndf in boolean default true)
    return attribute_kind%rowtype
    result_cache
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        select *
        into   l_attribute_row
        from   attribute_kind oak
        where  oak.id = p_attribute_id;

        return l_attribute_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид атрибуту з ідентифікатором {' || p_attribute_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_attribute(
        p_attribute_code in varchar2,
        p_raise_ndf in boolean default true)
    return attribute_kind%rowtype
    result_cache
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        select *
        into   l_attribute_row
        from   attribute_kind oak
        where  oak.attribute_code = p_attribute_code;

        return l_attribute_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Вид атрибуту з кодом {' || p_attribute_code || '} не знайдений');
             else return null;
             end if;
    end;

    function get_attribute_id(
        p_attribute_code in varchar2)
    return integer
    is
    begin
        return read_attribute(p_attribute_code, p_raise_ndf => false).id;
    end;

    function get_attribute_code(
        p_attribute_id in integer)
    return varchar2
    is
    begin
        return read_attribute(p_attribute_id, p_raise_ndf => false).attribute_code;
    end;

    function get_attribute_name(
        p_attribute_id in integer)
    return varchar2
    is
    begin
        return read_attribute(p_attribute_id, p_raise_ndf => false).attribute_name;
    end;

    function get_attribute_name(
        p_attribute_code in varchar2)
    return varchar2
    is
    begin
        return read_attribute(p_attribute_code, p_raise_ndf => false).attribute_name;
    end;
/*
    function get_set_value_handlers(p_attribute_id in integer)
    return varchar2_list
    is
    begin

    end;
*/
    function read_attribute_domain(
        p_attribute_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return attribute_domain%rowtype
    result_cache
    is
        l_attribute_domain_row attribute_domain%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_attribute_domain_row
            from   attribute_domain d
            where  d.attribute_id = p_attribute_id
            for update wait 60;
        else
            select *
            into   l_attribute_domain_row
            from   attribute_domain d
            where  d.attribute_id = p_attribute_id;
        end if;

        return l_attribute_domain_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Налаштування для отримання набору допустимих значень атрибуту з ідентифікатором {' ||
                                                 p_attribute_id || '} не знайдено');
             else return null;
             end if;
    end;

    procedure validate_attribute_domain(
        p_attribute_domain_row in attribute_domain%rowtype)
    is
    begin
        if (p_attribute_domain_row.data_source is null) then
            raise_application_error(-20000, 'Таблиця або джерело даних для побудови запиту не вказано');
        end if;
        if (p_attribute_domain_row.key_column is null) then
            raise_application_error(-20000, 'Поле, що містить ідентифікатор значення атрибуту, не вказане');
        end if;
        if (p_attribute_domain_row.name_expression is null) then
            raise_application_error(-20000, 'Поле, що містить назву значення атрибуту, не вказане');
        end if;
    end;

    function get_fixed_attribute_statement(
        p_attribute_row in attribute_kind%rowtype,
        p_lock in boolean)
    return varchar2
    is
        l_table_name varchar2(100 char);
        l_key_column_name varchar2(30 char);
        l_object_type_storage_row object_type_storage%rowtype;
    begin
        if (p_attribute_row.value_table_name is null) then
            l_object_type_storage_row := object_utl.read_object_type_storage(p_attribute_row.object_type_id);

            l_table_name := case when l_object_type_storage_row.table_owner is null then null
                                 else l_object_type_storage_row.table_owner || '.'
                            end || l_object_type_storage_row.table_name;
            l_key_column_name := l_object_type_storage_row.key_column_name;
        else
            l_table_name := case when p_attribute_row.value_table_owner is null then null
                                 else p_attribute_row.value_table_owner || '.'
                            end || p_attribute_row.value_table_name;
            l_key_column_name := p_attribute_row.key_column_name;
        end if;

        return ' select ' || p_attribute_row.value_column_name ||
               ' from ' || l_table_name ||
               ' where ' || l_key_column_name || ' = :object_id' ||
               case when p_lock then ' for update wait 60'
                    else null
               end;
    end;

    function set_fixed_attribute_statement(
        p_attribute_row in attribute_kind%rowtype)
    return varchar2
    is
        l_object_type_storage_row object_type_storage%rowtype;
        l_table_name varchar2(100 char);
        l_key_column_name varchar2(30 char);
    begin
        if (p_attribute_row.value_table_name is null) then
            l_object_type_storage_row := object_utl.read_object_type_storage(p_attribute_row.object_type_id);
            l_table_name := case when l_object_type_storage_row.table_owner is null then null
                                 else l_object_type_storage_row.table_owner || '.'
                            end || l_object_type_storage_row.table_name;
            l_key_column_name := l_object_type_storage_row.key_column_name;
        else
            l_table_name := case when p_attribute_row.value_table_owner is null then null
                                 else p_attribute_row.value_table_owner || '.'
                            end || p_attribute_row.value_table_name;
            l_key_column_name := p_attribute_row.key_column_name;
        end if;

        return ' update ' || l_table_name ||
               ' set ' || p_attribute_row.value_column_name || ' = :value' ||
               ' where ' || l_key_column_name || ' = :object_id';
    end;

    function get_domain_data_statement(
        p_attribute_row in attribute_kind%rowtype)
    return varchar2
    is
        l_attribute_domain_row attribute_domain%rowtype;
        l_query_statement varchar2(32767 byte);
    begin
        l_attribute_domain_row := read_attribute_domain(p_attribute_row.id, p_raise_ndf => false);

        if (l_attribute_domain_row.attribute_id is not null) then
            validate_attribute_domain(l_attribute_domain_row);

            l_query_statement := 'select ' || l_attribute_domain_row.key_column || ' id, ' ||
                                              nvl(l_attribute_domain_row.code_expression, 'null') || ' code, ' ||
                                              l_attribute_domain_row.name_expression || ' name ' ||
                                 'from (' || l_attribute_domain_row.data_source || ')' ||
                                 case when l_attribute_domain_row.where_clause is null then null
                                      else ' where ' || l_attribute_domain_row.where_clause
                                 end;
        end if;

        return l_query_statement;
    end;

    function get_domain_check_statement(
        p_attribute_row in attribute_kind%rowtype)
    return varchar2
    is
        l_attribute_domain_row attribute_domain%rowtype;
        l_query_statement varchar2(32767 byte);
    begin
        l_attribute_domain_row := read_attribute_domain(p_attribute_row.id, p_raise_ndf => false);

        if (l_attribute_domain_row.attribute_id is not null) then
            validate_attribute_domain(l_attribute_domain_row);

            l_query_statement := 'select ''Y'' ' ||
                                 'from (' || l_attribute_domain_row.data_source || ') ' ||
                                 'where ' || case when p_attribute_row.value_type_id in (attribute_utl.VALUE_TYPE_BLOB, attribute_utl.VALUE_TYPE_CLOB) then
                                                       'dbms_lob.compare(' || l_attribute_domain_row.key_column || ', :p_value) = 0'
                                                  else l_attribute_domain_row.key_column || ' = :p_value'
                                              end ||
                                              case when l_attribute_domain_row.where_clause is null then null
                                                   else ' and ' || l_attribute_domain_row.where_clause
                                              end;
            l_query_statement := 'select nvl((' || l_query_statement || '), ''N'') from dual';
        end if;

        return l_query_statement;
    end;

    function get_domain_check_list_stmt(
        p_attribute_row in attribute_kind%rowtype)
    return varchar2
    is
        l_attribute_domain_row attribute_domain%rowtype;
        l_query_statement varchar2(32767 byte);
    begin
        l_attribute_domain_row := read_attribute_domain(p_attribute_row.id, p_raise_ndf => false);

        if (l_attribute_domain_row.attribute_id is not null) then
            validate_attribute_domain(l_attribute_domain_row);

            l_query_statement := 'select column_value from table(:p_values) where column_value not in (' ||
                                 'select ' || l_attribute_domain_row.key_column || ' ' ||
                                 'from (' || l_attribute_domain_row.data_source || ')' ||
                                 case when l_attribute_domain_row.where_clause is null then null
                                      else ' where ' || l_attribute_domain_row.where_clause
                                 end ||
                                 ')';
        end if;

        return l_query_statement;
    end;

    function get_lob_domain_check_list_stmt(
        p_attribute_row in attribute_kind%rowtype)
    return varchar2
    is
        l_attribute_domain_row attribute_domain%rowtype;
        l_query_statement varchar2(32767 byte);
    begin
        l_attribute_domain_row := read_attribute_domain(p_attribute_row.id, p_raise_ndf => false);

        if (l_attribute_domain_row.attribute_id is not null) then
            validate_attribute_domain(l_attribute_domain_row);

            l_query_statement := 'select column_value from table(:p_values) ' ||
                                 'where not exists (select 1 from (' || l_attribute_domain_row.data_source ||
                                 ') where dbms_lob.compare(column_value, ' || l_attribute_domain_row.key_column || ') = 0' ||
                                 case when l_attribute_domain_row.where_clause is null then null
                                      else ' and ' || l_attribute_domain_row.where_clause
                                 end || ')';
        end if;

        return l_query_statement;
    end;

    procedure check_attr_for_single_value(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code in varchar2)
    is
    begin
        if (not tools.equals(p_attribute_row.state_id, attribute_utl.ATTR_STATE_ACTIVE)) then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name ||
                                            '} знаходиться в стані {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_STATE, p_attribute_row.state_id) ||
                                            '} - виконувати дії зі значеннями атрибуту не можливо');
        end if;

        if (p_attribute_row.value_type_id not member of p_valid_value_types) then
            raise_application_error(-20000, 'Неочікуване звернення до функції: атрибут {' || p_attribute_row.attribute_name ||
                                            '} має тип значення {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_attribute_row.value_type_id) ||
                                            '} і для його отримання слід використовувати іншу функцію');
        end if;

        if (p_attribute_row.multy_value_flag = 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name || '} передбачає збереження множини значень - ' ||
                                            'для отримання результату, необхідно використовувати функцію, що повертає колекцію значень, а не одне значення');
        end if;

        if (p_attribute_type_code not in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC, attribute_utl.ATTR_TYPE_CALCULATED)) then
            raise_application_error(-20000, 'Неочікуваний тип {' || p_attribute_row.attribute_type_id || '} атрибуту {' || p_attribute_row.attribute_name || '}');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and p_attribute_row.get_value_function is null) then
            raise_application_error(-20000, 'Функція отримання значення розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;
    end;

    procedure check_attr_for_single_value(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_type in integer,
        p_attribute_type_code in varchar2)
    is
    begin
        check_attr_for_single_value(p_attribute_row, number_list(p_valid_value_type), p_attribute_type_code);
    end;

    procedure check_attr_for_multiple_values(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code in varchar2)
    is
    begin
        if (not tools.equals(p_attribute_row.state_id, attribute_utl.ATTR_STATE_ACTIVE)) then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name ||
                                            '} знаходиться в стані {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_STATE, p_attribute_row.state_id) ||
                                            '} - виконувати дії зі значеннями атрибуту не можливо');
        end if;

        if (p_attribute_row.value_type_id  not member of p_valid_value_types) then
            raise_application_error(-20000, 'Неочікуване звернення до функції: атрибут {' || p_attribute_row.attribute_name ||
                                            '} має тип значення {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_attribute_row.value_type_id) ||
                                            '} і для його отримання слід використовувати іншу функцію');
        end if;

        if (p_attribute_row.multy_value_flag <> 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name || '} не передбачає збереження множинних значень');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            raise_application_error(-20000, 'Стаціонарний параметр {' || p_attribute_row.attribute_name || '} не може зберігати множинні значення');
        end if;

        if (p_attribute_type_code not in (attribute_utl.ATTR_TYPE_DYNAMIC, attribute_utl.ATTR_TYPE_CALCULATED)) then
            raise_application_error(-20000, 'Неочікуваний тип {' || p_attribute_row.attribute_type_id || '} атрибуту {' || p_attribute_row.attribute_name || '}');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and p_attribute_row.get_values_function is null) then
            raise_application_error(-20000, 'Функція отримання списку значень розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;
    end;

    procedure check_attr_for_multiple_values(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_type in integer,
        p_attribute_type_code in varchar2)
    is
    begin
        check_attr_for_multiple_values(p_attribute_row, number_list(p_valid_value_type), p_attribute_type_code);
    end;

    procedure check_attr_before_single_value(
        p_attribute_row in attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code in varchar2)
    is
    begin
        if (not tools.equals(p_attribute_row.state_id, attribute_utl.ATTR_STATE_ACTIVE)) then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name ||
                                            '} знаходиться в стані {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_STATE, p_attribute_row.state_id) ||
                                            '} - виконувати дії зі значеннями атрибуту не можливо');
        end if;

        if (p_attribute_type_code not in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC, attribute_utl.ATTR_TYPE_CALCULATED)) then
            raise_application_error(-20000, 'Неочікуваний тип {' || p_attribute_row.attribute_type_id || '} атрибуту {' || p_attribute_row.attribute_name || '}');
        end if;

        if (p_attribute_row.value_type_id not member of p_valid_value_types) then
            raise_application_error(-20000, 'Неочікуване звернення до функції: атрибут {' || p_attribute_row.attribute_name ||
                                            '} має тип значення {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_attribute_row.value_type_id) ||
                                            '} - для встановлення його значення повинна використовувати інша процедура');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and p_attribute_row.set_value_procedure is null) then
            raise_application_error(-20000, 'Процедура встановлення значення розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;

        if (p_attribute_row.multy_value_flag = 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name || '} передбачає збереження одночасно декількох значень - ' ||
                                            'для встановлення його значення повинна використовуватись інша процедура');
        end if;
    end;

    procedure check_attr_before_single_value(
        p_attribute_row in attribute_kind%rowtype,
        p_valid_value_type in integer,
        p_attribute_type_code in varchar2)
    is
    begin
        check_attr_before_single_value(p_attribute_row, number_list(p_valid_value_type), p_attribute_type_code);
    end;

    procedure check_attr_before_multi_values(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code varchar2)
    is
    begin
        if (not tools.equals(p_attribute_row.state_id, attribute_utl.ATTR_STATE_ACTIVE)) then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name ||
                                            '} знаходиться в стані {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_STATE, p_attribute_row.state_id) ||
                                            '} - виконувати дії зі значеннями атрибуту не можливо');
        end if;

        if (p_attribute_type_code not in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC, attribute_utl.ATTR_TYPE_CALCULATED)) then
            raise_application_error(-20000, 'Неочікуваний тип {' || p_attribute_row.attribute_type_id || '} атрибуту {' || p_attribute_row.attribute_name || '}');
        end if;

        if (p_attribute_row.value_type_id not member of p_valid_value_types) then
            raise_application_error(-20000, 'Неочікуване звернення до функції: атрибут {' || p_attribute_row.attribute_name ||
                                            '} має тип значення {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_attribute_row.value_type_id) ||
                                            '} - для встановлення його значення повинна використовувати інша процедура');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and p_attribute_row.set_value_procedure is null) then
            raise_application_error(-20000, 'Процедура встановлення значення розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;

        if (p_attribute_row.multy_value_flag <> 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name ||
                                            '} не передбачає збереження одночасно декількох значень - ' ||
                                            'для встановлення його значення повинна використовуватись інша процедура');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            raise_application_error(-20000, 'Стаціонарний параметр {' || p_attribute_row.attribute_name || '} не може зберігати множинні значення');
        end if;
    end;

    procedure check_attr_before_multi_values(
        p_attribute_row in attribute_kind%rowtype,
        p_valid_value_type in integer,
        p_attribute_type_code varchar2)
    is
    begin
        check_attr_before_multi_values(p_attribute_row, number_list(p_valid_value_type), p_attribute_type_code);
    end;

    procedure check_list_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_value in number)
    is
    begin
        if (p_value is not null and p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_LIST) then
             if (list_utl.is_item_in_list(p_attribute_row.list_type_id, p_value) = 'N') then
                 raise_application_error(-20000, 'Значення {' || p_value || ' - ' || list_utl.get_item_name(p_attribute_row.list_type_id, p_value) ||
                                                 '} не входить до набору допустимих значень списку {' ||
                                                 list_utl.get_list_name(p_attribute_row.list_type_id) || '}');
             end if;
         end if;
    end;

    procedure check_list_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_values in number_list)
    is
        l_list_items number_list;
    begin
        if (p_values is not null and p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_LIST) then
             l_list_items := list_utl.get_list_items(p_attribute_row.list_type_id);
             l_list_items := p_values multiset except l_list_items;

             if (l_list_items is not empty) then
                 raise_application_error(-20000, 'Значення {' || tools.number_list_to_string(l_list_items, ', ') ||
                                                 '} не входять до набору допустимих значень списку {' ||
                                                 list_utl.get_list_name(p_attribute_row.list_type_id) || '}');
             end if;
         end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_value in number)
    is
        l_value_in_range_flag char(1 byte);
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_value is not null) then
            l_check_query_statement := get_domain_check_statement(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                into l_value_in_range_flag
                using p_value;

                if (l_value_in_range_flag = 'N') then
                    raise_application_error(-20000, 'Значення {' || p_value ||
                                                    '} не входить в допустимий набір значень атрибуту {' || p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_value in varchar2)
    is
        l_value_in_range_flag char(1 byte);
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_value is not null) then
            l_check_query_statement := get_domain_check_statement(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                into l_value_in_range_flag
                using p_value;

                if (l_value_in_range_flag = 'N') then
                    raise_application_error(-20000, 'Значення {' || p_value ||
                                                    '} не входить в допустимий набір значень атрибуту {' || p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_value in date)
    is
        l_value_in_range_flag char(1 byte);
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_value is not null) then
            l_check_query_statement := get_domain_check_statement(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                into l_value_in_range_flag
                using p_value;

                if (l_value_in_range_flag = 'N') then
                    raise_application_error(-20000, 'Значення {' || p_value ||
                                                    '} не входить в допустимий набір значень атрибуту {' || p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_value in blob)
    is
        l_value_in_range_flag char(1 byte);
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_value is not null) then
            l_check_query_statement := get_domain_check_statement(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                into l_value_in_range_flag
                using p_value;

                if (l_value_in_range_flag = 'N') then
                    raise_application_error(-20000, 'Встановлюване значення не входить в допустимий набір значень атрибуту {' || p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_value in clob)
    is
        l_value_in_range_flag char(1 byte);
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_value is not null) then
            l_check_query_statement := get_domain_check_statement(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                into l_value_in_range_flag
                using p_value;

                if (l_value_in_range_flag = 'N') then
                    raise_application_error(-20000, 'Значення {' || dbms_lob.substr(p_value, 1, 150) ||
                                                     '...} не входить в допустимий набір значень атрибуту {' || p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_values in number_list)
    is
        l_values_not_in_range number_list;
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_values is not null and p_values is not empty) then
            l_check_query_statement := get_domain_check_list_stmt(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                bulk collect into l_values_not_in_range
                using p_values;

                if (l_values_not_in_range is not empty) then
                     raise_application_error(-20000, 'Значення {' || tools.number_list_to_string(l_values_not_in_range, ', ') ||
                                                     '} не входять до набору допустимих значень атрибуту {' ||
                                                     p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_values in varchar2_list)
    is
        l_values_not_in_range string_list;
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_values is not null and p_values is not empty) then
            l_check_query_statement := get_domain_check_list_stmt(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                bulk collect into l_values_not_in_range
                using p_values;

                if (l_values_not_in_range is not empty) then
                     raise_application_error(-20000, 'Значення {' || tools.words_to_string(l_values_not_in_range, ', ') ||
                                                     '} не входять до набору допустимих значень атрибуту {' ||
                                                     p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_values in date_list)
    is
        l_values_not_in_range date_list;
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_values is not null and p_values is not empty) then
            l_check_query_statement := get_domain_check_list_stmt(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                bulk collect into l_values_not_in_range
                using p_values;

                if (l_values_not_in_range is not empty) then
                     raise_application_error(-20000, 'Значення {' || tools.date_list_to_string(l_values_not_in_range, ', ') ||
                                                     '} не входять до набору допустимих значень атрибуту {' ||
                                                     p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_values in blob_list)
    is
        l_values_not_in_range blob_list;
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_values is not null and p_values is not empty) then
            l_check_query_statement := get_lob_domain_check_list_stmt(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                bulk collect into l_values_not_in_range
                using p_values;

                if (l_values_not_in_range is not empty) then
                     raise_application_error(-20000, 'Встановлюване значення не входить в допустимий набір значень атрибуту {' ||
                                                     p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_domain_attribute(
        p_attribute_row in attribute_kind%rowtype,
        p_values in clob_list)
    is
        l_values_not_in_range clob_list;
        l_check_query_statement varchar2(32767 byte);
    begin
        if (p_values is not null and p_values is not empty) then
            l_check_query_statement := get_lob_domain_check_list_stmt(p_attribute_row);

            if (l_check_query_statement is not null) then
                execute immediate l_check_query_statement
                bulk collect into l_values_not_in_range
                using p_values;

                if (l_values_not_in_range is not empty) then
                     raise_application_error(-20000, 'Значення {' || dbms_lob.substr(l_values_not_in_range(l_values_not_in_range.first), 150) ||
                                                     '...} не входить до набору допустимих значень атрибуту {' ||
                                                     p_attribute_row.attribute_name || '}');
                end if;
            end if;
        end if;
    end;

    procedure check_validity_period(
        p_attribute_row in attribute_kind%rowtype,
        p_valid_from in date,
        p_valid_through in date)
    is
    begin
        if (p_attribute_row.history_saving_mode_id <> attribute_utl.HISTORY_MODE_VALUES_BY_DATE and
            (tools.compare_range_borders(p_valid_from, bankdate()) > 0 or
             tools.compare_range_borders(bankdate(), p_valid_through) > 0)) then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name ||
                                            '} не зберігає історію редагування - для нього може встановлювати лише поточне значення.' ||
                                            ' Період дії значення {' || nvl(to_char(p_valid_from, 'dd.mm.yyyy'), 'не обмежено') || ' - ' ||
                                            nvl(to_char(p_valid_through, 'dd.mm.yyyy'), 'не обмежено') ||
                                            '} повинен включати поточну банківську дату: ' || to_char(bankdate(), 'dd.mm.yyyy'));
        end if;
        if (tools.compare_range_borders(p_valid_from, p_valid_through) > 0) then
            raise_application_error(-20000, 'Дата початку дії значення {' || nvl(to_char(p_valid_from, 'dd.mm.yyyy'), 'не обмежено') ||
                                            '} атрибуту {' || p_attribute_row.attribute_name ||
                                            '} не може перевищувати дату завершення його дії {' ||
                                            nvl(to_char(p_valid_through, 'dd.mm.yyyy'), 'не обмежено') || '}');
        end if;
    end;

    function read_history(
        p_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return attribute_history%rowtype
    is
        l_history_row attribute_history%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_history_row
            from   attribute_history h
            where  h.id = p_id
            for update wait 60;
        else
            select *
            into   l_history_row
            from   attribute_history h
            where  h.id = p_id;
        end if;

        return l_history_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Рядок історії значень атрибуту з ідентифікатором {' || p_id || '} не знайдений');
             else return null;
             end if;
    end;

    function get_history_id_for_date(
        p_object_id in integer,
        p_attribute_id in integer,
        p_anchor_date in date)
    return integer
    is
        l_history_id integer;
    begin
        select min(h.id) keep (dense_rank last order by h.value_date nulls first, h.id)
        into   l_history_id
        from   attribute_history h
        where  h.object_id = p_object_id and
               h.attribute_id = p_attribute_id and
               tools.compare_range_borders(h.value_date, p_anchor_date) <= 0 and
               h.is_delete = 'N';

        return l_history_id;
    end;

    function get_history_id_after_date(
        p_object_id in integer,
        p_attribute_id in integer,
        p_anchor_date in date)
    return integer
    is
        l_history_id integer;
    begin
        select min(h.id) keep (dense_rank first order by h.value_date nulls first, h.id desc)
        into   l_history_id
        from   attribute_history h
        where  h.object_id = p_object_id and
               h.attribute_id = p_attribute_id and
               tools.compare_range_borders(p_anchor_date, h.value_date) <= 0 and
               h.is_delete = 'N';

         return l_history_id;
    end;

    function get_history_row_for_date(
        p_object_id in integer,
        p_attribute_id in integer,
        p_anchor_date in date,
        p_lock in boolean default false)
    return attribute_history%rowtype
    is
        l_history_id integer;
    begin
        l_history_id := get_history_id_for_date(p_object_id, p_attribute_id, p_anchor_date);

        if (l_history_id is not null) then
            return read_history(l_history_id, p_lock => p_lock);
        else return null;
        end if;
    end;

    function get_history_row_after_date(
        p_object_id in integer,
        p_attribute_id in integer,
        p_anchor_date in date,
        p_lock in boolean default false)
    return attribute_history%rowtype
    is
        l_history_id integer;
    begin
        l_history_id := get_history_id_after_date(p_object_id, p_attribute_id, p_anchor_date);

        if (l_history_id is not null) then
            return read_history(l_history_id, p_lock => p_lock);
        else return null;
        end if;
    end;

    function get_previous_history_id(
        p_history_row attribute_history%rowtype)
    return integer
    is
        l_history_id integer;
    begin
        select min(h.id) keep (dense_rank last order by h.value_date nulls first, h.id)
        into   l_history_id
        from   attribute_history h
        where  h.object_id = p_history_row.object_id and
               h.attribute_id = p_history_row.attribute_id and
               tools.compare_range_borders(h.value_date, p_history_row.value_date) <= 0 and
               h.id <> p_history_row.id and
               h.is_delete = 'N';

         return l_history_id;
    end;

    function get_number_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number
    is
        l_value number(32, 12);
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_number_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_number_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function get_string_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return varchar2
    is
        l_value varchar2(4000 byte);
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_string_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_string_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function get_date_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return date
    is
        l_value date;
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_date_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_date_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function get_blob_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return blob
    is
        l_value blob;
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_blob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_blob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function get_clob_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return clob
    is
        l_value clob;
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_clob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_clob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;
/*
    function get_deal_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number
    is
        l_value number(10);
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_deal_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_deal_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function get_account_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number
    is
        l_value number(38);
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_account_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_account_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function get_customer_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number
    is
        l_value number(38);
    begin
        if (p_lock) then
            select oan.value
            into   l_value
            from   attribute_customer_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            into   l_value
            from   attribute_customer_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;
*/
    function get_number_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number_list
    is
        l_values number_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_number_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_number_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;

    function get_string_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return varchar2_list
    is
        l_values varchar2_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_string_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_string_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;

    function get_date_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return date_list
    is
        l_values date_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_date_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_date_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;

    function get_blob_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return blob_list
    is
        l_values blob_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_blob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_blob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;

    function get_clob_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return clob_list
    is
        l_values clob_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_clob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_clob_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;
/*
    function get_deal_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number_list
    is
        l_values number_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_deal_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_deal_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;

    function get_account_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number_list
    is
        l_values number_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_account_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_account_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;

    function get_customer_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_lock in boolean)
    return number_list
    is
        l_values number_list;
    begin
        if (p_lock) then
            select oan.value
            bulk collect into l_values
            from   attribute_customer_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id
            for update wait 60;
        else
            select oan.value
            bulk collect into l_values
            from   attribute_customer_value oan
            where  oan.object_id = p_object_id and
                   oan.attribute_id = p_attribute_id;
        end if;

        return l_values;
    end;
*/
    function get_number_value_for_hist(
        p_history_id in integer)
    return number
    is
        l_value attribute_number_value.value%type;
    begin
        select oahn.value
        into   l_value
        from   attribute_number_history oahn
        where  oahn.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_number_values_for_hist(p_history_id in integer)
    return number_list
    is
        l_values number_list;
    begin
        select oahn.value
        bulk collect into l_values
        from   attribute_number_history oahn
        where  oahn.id = p_history_id;

        return l_values;
    end;

    function get_string_value_for_hist(p_history_id in integer)
    return varchar2
    is
        l_value attribute_string_value.value%type;
    begin
        select oahs.value
        into   l_value
        from   attribute_string_history oahs
        where  oahs.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_string_values_for_hist(p_history_id in integer)
    return varchar2_list
    is
        l_values varchar2_list;
    begin
        select oahs.value
        bulk collect into l_values
        from   attribute_string_history oahs
        where  oahs.id = p_history_id;

        return l_values;
    end;

    function get_date_value_for_hist(p_history_id in integer)
    return date
    is
        l_value date;
    begin
        select hv.value
        into   l_value
        from   attribute_date_history hv
        where  hv.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_date_values_for_hist(p_history_id in integer)
    return date_list
    is
        l_values date_list;
    begin
        select hv.value
        bulk collect into l_values
        from   attribute_date_history hv
        where  hv.id = p_history_id;

        return l_values;
    end;

    function get_blob_value_for_hist(p_history_id in integer)
    return blob
    is
        l_value blob;
    begin
        select oahb.value
        into   l_value
        from   attribute_blob_history oahb
        where  oahb.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_blob_values_for_hist(p_history_id in integer)
    return blob_list
    is
        l_values blob_list;
    begin
        select hv.value
        bulk collect into l_values
        from   attribute_blob_history hv
        where  hv.id = p_history_id;

        return l_values;
    end;

    function get_clob_value_for_hist(p_history_id in integer)
    return clob
    is
        l_value clob;
    begin
        select oahc.value
        into   l_value
        from   attribute_clob_history oahc
        where  oahc.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_clob_values_for_hist(p_history_id in integer)
    return clob_list
    is
        l_values clob_list;
    begin
        select hv.value
        bulk collect into l_values
        from   attribute_clob_history hv
        where  hv.id = p_history_id;

        return l_values;
    end;
/*
    function get_deal_value_for_hist(p_history_id in integer)
    return integer
    is
        l_value integer;
    begin
        select hv.value
        into   l_value
        from   attribute_deal_history hv
        where  hv.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_deal_values_for_hist(p_history_id in integer)
    return number_list
    is
        l_values number_list;
    begin
        select hv.value
        bulk collect into l_values
        from   attribute_deal_history hv
        where  hv.id = p_history_id;

        return l_values;
    end;

    function get_account_value_for_hist(p_history_id in integer)
    return integer
    is
        l_value integer;
    begin
        select hv.value
        into   l_value
        from   attribute_account_history hv
        where  hv.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_account_values_for_hist(p_history_id in integer)
    return number_list
    is
        l_values number_list;
    begin
        select hv.value
        bulk collect into l_values
        from   attribute_account_history hv
        where  hv.id = p_history_id;

        return l_values;
    end;

    function get_customer_value_for_hist(p_history_id in integer)
    return integer
    is
        l_value integer;
    begin
        select hv.value
        into   l_value
        from   attribute_customer_history hv
        where  hv.id = p_history_id;

        return l_value;
    exception
        when no_data_found then return null;
    end;

    function get_customer_values_for_hist(p_history_id in integer)
    return number_list
    is
        l_values number_list;
    begin
        select hv.value
        bulk collect into l_values
        from   attribute_customer_history hv
        where  hv.id = p_history_id;

        return l_values;
    end;
*/
    function get_number_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return number
    is
        l_value number;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_history_row attribute_history%rowtype;
        l_attribute_type_code varchar2(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_single_value(p_attribute_row,
                                    number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST, attribute_utl.VALUE_TYPE_DEAL,
                                                attribute_utl.VALUE_TYPE_ACCOUNT, attribute_utl.VALUE_TYPE_CUSTOMER),
                                    l_attribute_type_code);


        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);

                if (l_history_id is null) then
                    l_value := null;
                else
                    if (p_lock) then
                        l_history_row := read_history(l_history_id, p_lock => true);
                    end if;

                    l_value := get_number_value_for_hist(l_history_row.id);
                end if;
            else
                if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
                    begin
                        execute immediate get_fixed_attribute_statement(p_attribute_row, p_lock)
                        into l_value using p_object_id;
                    exception
                        when no_data_found then
                             l_value := null;
                    end;
                elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
                    l_value := get_number_value_utl(p_object_id, p_attribute_row.id, p_lock);
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_number_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number
    is
    begin
        return get_number_value(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_number_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number
    is
    begin
        return get_number_value(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;

    function get_number_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return number_list
    is
        l_values number_list;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_multiple_values(p_attribute_row,
                                       number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST, attribute_utl.VALUE_TYPE_DEAL,
                                                   attribute_utl.VALUE_TYPE_ACCOUNT, attribute_utl.VALUE_TYPE_CUSTOMER),
                                       l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_values_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);
                if (l_history_id is null) then
                    l_values := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;

                    l_values := get_number_values_for_hist(l_history_id);
                end if;
            else
                l_values := get_number_values_utl(p_object_id, p_attribute_row.id, p_lock);
            end if;
        end if;

        return l_values;
    end;

    function get_number_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number_list
    is
    begin
        return get_number_values(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_number_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return number_list
    is
    begin
        return get_number_values(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;

    function get_string_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return varchar2
    is
        l_value varchar2(500 char);
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_STRING, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);

                if (l_history_id is null) then
                    l_value := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;

                    l_value := get_string_value_for_hist(l_history_id);
                end if;
            else
                if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
                    begin
                        execute immediate get_fixed_attribute_statement(p_attribute_row, p_lock)
                        into l_value using p_object_id;
                    exception
                        when no_data_found then
                             l_value := null;
                    end;
                elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
                    l_value := get_string_value_utl(p_object_id, p_attribute_row.id, p_lock);
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_string_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2
    is
    begin
        return get_string_value(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_string_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2
    is
    begin
        return get_string_value(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;

    function get_string_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return varchar2_list
    is
        l_values varchar2_list;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_multiple_values(p_attribute_row, attribute_utl.VALUE_TYPE_STRING, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_values_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);
                if (l_history_id is null) then
                    l_values := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;
                        l_values := get_string_values_for_hist(l_history_id);
                end if;
            else
                l_values := get_string_values_utl(p_object_id, p_attribute_row.id, p_lock);
            end if;
        end if;

        return l_values;
    end;

    function get_string_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2_list
    is
    begin
        return get_string_values(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_string_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return varchar2_list
    is
    begin
        return get_string_values(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;

    function get_date_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return date
    is
        l_value date;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    BEGIN
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_DATE, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);

                if (l_history_id is null) then
                    l_value := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;

                    l_value := get_date_value_for_hist(l_history_id);
                end if;
            else
                if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
                    begin
                        execute immediate get_fixed_attribute_statement(p_attribute_row, p_lock)
                        into l_value using p_object_id;
                    exception
                        when no_data_found then
                             l_value := null;
                    end;
                elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
                    l_value := get_date_value_utl(p_object_id, p_attribute_row.id, p_lock);
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_date_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date
    is
    begin
        return get_date_value(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_date_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date
    is
    begin
        return get_date_value(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);

    end;

    function get_date_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return date_list
    is
        l_values date_list;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_multiple_values(p_attribute_row, attribute_utl.VALUE_TYPE_DATE, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_values_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);
                if (l_history_id is null) then
                    l_values := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;
                        l_values := get_date_values_for_hist(l_history_id);
                end if;
            else
                l_values := get_date_values_utl(p_object_id, p_attribute_row.id, p_lock);
            end if;
        end if;

        return l_values;
    end;

    function get_date_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date_list
    is
    begin
        return get_date_values(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_date_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return date_list
    is
    begin
        return get_date_values(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);

    end;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return blob
    is
        l_value blob;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_BLOB, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);

                if (l_history_id is null) then
                    l_value := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;

                    l_value := get_blob_value_for_hist(l_history_id);
                end if;
            else
                if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
                    begin
                        execute immediate get_fixed_attribute_statement(p_attribute_row, p_lock)
                        into l_value using p_object_id;
                    exception
                        when no_data_found then
                             l_value := null;
                    end;
                elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
                    l_value := get_blob_value_utl(p_object_id, p_attribute_row.id, p_lock);
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob
    is
    begin
        return get_blob_value(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob
    is
    begin
        return get_blob_value(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return blob_list
    is
        l_values blob_list;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_multiple_values(p_attribute_row, attribute_utl.VALUE_TYPE_BLOB, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_values_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);
                if (l_history_id is null) then
                    l_values := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;
                        l_values := get_blob_values_for_hist(l_history_id);
                end if;
            else
                l_values := get_blob_values_utl(p_object_id, p_attribute_row.id, p_lock);
            end if;
        end if;

        return l_values;
    end;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob_list
    is
    begin
        return get_blob_values(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return blob_list
    is
    begin
        return get_blob_values(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return clob
    is
        l_value clob;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_CLOB, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);

                if (l_history_id is null) then
                    l_value := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;

                    l_value := get_clob_value_for_hist(l_history_id);
                end if;
            else
                if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
                    begin
                        execute immediate get_fixed_attribute_statement(p_attribute_row, p_lock)
                        into l_value using p_object_id;
                    exception
                        when no_data_found then
                             l_value := null;
                    end;
                elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
                    l_value := get_clob_value_utl(p_object_id, p_attribute_row.id, p_lock);
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob
    is
    begin
        return get_clob_value(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob
    is
    begin
        return get_clob_value(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_lock in boolean default false)
    return clob_list
    is
        l_values clob_list;
        l_statement varchar2(32767 byte);
        l_history_id integer;
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_for_multiple_values(p_attribute_row, attribute_utl.VALUE_TYPE_CLOB, l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_values_function || '(:object_id, :attribute_id, :p_value_date, :p_lock); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date, tools.boolean_to_int(p_lock);
        else
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE and p_value_date <> bankdate()) then
                l_history_id := get_history_id_for_date(p_object_id, p_attribute_row.id, p_value_date);
                if (l_history_id is null) then
                    l_values := null;
                else
                    if (p_lock) then
                        l_history_id := read_history(l_history_id, p_lock => true).id;
                    end if;
                        l_values := get_clob_values_for_hist(l_history_id);
                end if;
            else
                l_values := get_clob_values_utl(p_object_id, p_attribute_row.id, p_lock);
            end if;
        end if;

        return l_values;
    end;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob_list
    is
    begin
        return get_clob_values(p_object_id, read_attribute(p_attribute_id), p_value_date, p_lock);
    end;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default bankdate(),
        p_lock in boolean default false)
    return clob_list
    is
    begin
        return get_clob_values(p_object_id, read_attribute(p_attribute_code), p_value_date, p_lock);
    end;
/*
    procedure link_history_to_operation(
        p_history_id in integer,
        p_operation_id in integer)
    is
    begin
        insert into attribute_operation_history
        values (p_operation_id, p_history_id);
    end;
*/
    procedure set_attribute_history_comment(
        p_history_id in integer,
        p_comment in varchar2)
    is
    begin
        if (p_comment is not null) then
            insert into attribute_history_comment
            values (p_history_id, p_comment);
        end if;
    end;

    function create_history_item(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date,
        p_comment in varchar2)
    return integer
    is
        l_history_id integer;
    begin
        insert into attribute_history
        values (attribute_history_seq.nextval, p_object_id, p_attribute_row.id, p_value_date, user_id(), sysdate, 'N')
        returning id
        into l_history_id;

        set_attribute_history_comment(l_history_id, p_comment);
/*
        if (p_operation_id is not null) then
            link_history_to_operation(l_history_id, p_operation_id);
        end if;
*/
        return l_history_id;
    end;

    procedure create_number_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in number,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_value is not null) then
            insert into attribute_number_history
            values (l_attribute_history_id, p_value);
        end if;
    end;

    procedure create_number_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in number_list,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_values is not null) then
            forall i in indices of p_values
                insert into attribute_number_history
                values (l_attribute_history_id, p_values(i));
        end if;
    end;

    procedure create_string_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in varchar2,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_value is not null) then
            insert into attribute_string_history
            values (l_attribute_history_id, p_value);
        end if;
    end;

    procedure create_string_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in varchar2_list,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_values is not null) then
            forall i in indices of p_values
                insert into attribute_string_history
                values (l_attribute_history_id, p_values(i));
        end if;
    end;

    procedure create_date_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in date,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_value is not null) then
            insert into attribute_date_history
            values (l_attribute_history_id, p_value);
        end if;
    end;

    procedure create_date_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in date_list,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_values is not null) then
            forall i in indices of p_values
                insert into attribute_date_history
                values (l_attribute_history_id, p_values(i));
        end if;
    end;

    procedure create_blob_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in blob,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_value is not null) then
            insert into attribute_blob_history
            values (l_attribute_history_id, p_value);
        end if;
    end;

    procedure create_blob_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in blob_list,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_values is not null) then
            forall i in indices of p_values
                insert into attribute_blob_history
                values (l_attribute_history_id, p_values(i));
        end if;
    end;

    procedure create_clob_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in clob,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_value is not null) then
            insert into attribute_clob_history
            values (l_attribute_history_id, p_value);
        end if;
    end;

    procedure create_clob_history(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in clob_list,
        p_value_date in date,
        p_comment in varchar2)
    is
        l_attribute_history_id integer;
    begin
        l_attribute_history_id := create_history_item(p_object_id, p_attribute_row, p_value_date, p_comment);

        if (p_values is not null) then
            forall i in indices of p_values
                insert into attribute_clob_history
                values (l_attribute_history_id, p_values(i));
        end if;
    end;

    procedure set_number_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_attribute_type_code in varchar2,
        p_value in number)
    is
        parent_key_not_found exception;
        pragma exception_init(parent_key_not_found, -2291);
    begin
        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then

            execute immediate set_fixed_attribute_statement(p_attribute_row)
            using p_value, p_object_id;

            if (sql%rowcount = 0) then
                raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                                '} з ідентифікатором {' || p_object_id || '} не знайдений');
            end if;
        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_value is null) then
                delete attribute_number_value a
                where  a.object_id = p_object_id and
                       a.attribute_id = p_attribute_row.id;
            else
                update attribute_number_value a
                set    a.value = p_value
                where  a.object_id = p_object_id and
                       a.attribute_id = p_attribute_row.id;

                if (sql%rowcount = 0) then
                    insert into attribute_number_value
                    values (p_object_id, p_attribute_row.id, p_value);
                end if;
            end if;
        end if;
    end;

    procedure set_number_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in number_list)
    is
    begin
        delete attribute_number_value a
        where  a.object_id = p_object_id and
               a.attribute_id = p_attribute_row.id;

        if (p_values is not null and p_values is not empty) then
            forall i in indices of p_values
                insert into attribute_number_value
                values (p_object_id, p_attribute_row.id, p_values(i));
        end if;
    end;

    procedure set_string_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_attribute_type_code in varchar2,
        p_value in varchar2)
    is
    begin
        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then

            execute immediate set_fixed_attribute_statement(p_attribute_row)
            using p_value, p_object_id;

        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_value is null) then
                delete attribute_string_value oas
                where  oas.object_id = p_object_id and
                       oas.attribute_id = p_attribute_row.id;
            else
                update attribute_string_value a
                set    a.value = p_value
                where  a.object_id = p_object_id and
                       a.attribute_id = p_attribute_row.id;

                if (sql%rowcount = 0) then
                    insert into attribute_string_value
                    values (p_object_id, p_attribute_row.id, p_value);
                end if;
            end if;
        end if;
    end;

    procedure set_string_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in varchar2_list)
    is
    begin
        delete attribute_string_value a
        where  a.object_id = p_object_id and
               a.attribute_id = p_attribute_row.id;

        if (p_values is not null and p_values is not empty) then
            forall i in indices of p_values
                insert into attribute_string_value
                values (p_object_id, p_attribute_row.id, p_values(i));
        end if;
    end;

    procedure set_date_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_attribute_type_code in varchar2,
        p_value in date)
    is
    begin
        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then

            execute immediate set_fixed_attribute_statement(p_attribute_row)
            using p_value, p_object_id;

        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_value is null) then
                delete attribute_date_value oad
                where  oad.object_id = p_object_id and
                       oad.attribute_id = p_attribute_row.id;
            else
                update attribute_date_value a
                set    a.value = p_value
                where  a.object_id = p_object_id and
                       a.attribute_id = p_attribute_row.id;

                if (sql%rowcount = 0) then
                    insert into attribute_date_value
                    values (p_object_id, p_attribute_row.id, p_value);
                end if;
            end if;
        end if;
    end;

    procedure set_date_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in date_list)
    is
    begin
        delete attribute_date_value a
        where  a.object_id = p_object_id and
               a.attribute_id = p_attribute_row.id;

        if (p_values is not null and p_values is not empty) then
            forall i in indices of p_values
                insert into attribute_date_value
                values (p_object_id, p_attribute_row.id, p_values(i));
        end if;
    end;

    procedure set_blob_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_attribute_type_code in varchar2,
        p_value in blob)
    is
    begin
        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then

            execute immediate set_fixed_attribute_statement(p_attribute_row)
            using p_value, p_object_id;

        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_value is null) then
                delete attribute_blob_value oab
                where  oab.object_id = p_object_id and
                       oab.attribute_id = p_attribute_row.id;
            else
                update attribute_blob_value a
                set    a.value = p_value
                where  a.object_id = p_object_id and
                       a.attribute_id = p_attribute_row.id;

                if (sql%rowcount = 0) then
                    insert into attribute_blob_value
                    values (p_object_id, p_attribute_row.id, p_value);
                end if;
            end if;
        end if;
    end;

    procedure set_blob_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in blob_list)
    is
    begin
        delete attribute_blob_value a
        where  a.object_id = p_object_id and
               a.attribute_id = p_attribute_row.id;

        if (p_values is not null and p_values is not empty) then
            forall i in indices of p_values
                insert into attribute_blob_value
                values (p_object_id, p_attribute_row.id, p_values(i));
        end if;
    end;

    procedure set_clob_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_attribute_type_code in varchar2,
        p_value in clob)
    is
    begin
        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then

            execute immediate set_fixed_attribute_statement(p_attribute_row)
            using p_value, p_object_id;

        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_value is null) then
                delete attribute_clob_value oac
                where oac.object_id = p_object_id and
                      oac.attribute_id = p_attribute_row.id;
            else
                update attribute_clob_value a
                set    a.value = p_value
                where  a.object_id = p_object_id and
                       a.attribute_id = p_attribute_row.id;

                if (sql%rowcount = 0) then
                    insert into attribute_clob_value
                    values (p_object_id, p_attribute_row.id, p_value);
                end if;
            end if;
        end if;
    end;

    procedure set_clob_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in clob_list)
    is
    begin
        delete attribute_clob_value a
        where  a.object_id = p_object_id and
               a.attribute_id = p_attribute_row.id;

        if (p_values is not null and p_values is not empty) then
            forall i in indices of p_values
                insert into attribute_clob_value
                values (p_object_id, p_attribute_row.id, p_values(i));
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in number,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_historical_value number;
        l_history_row attribute_history%rowtype;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_single_value(p_attribute_row,
                                       number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST, attribute_utl.VALUE_TYPE_DEAL,
                                                   attribute_utl.VALUE_TYPE_ACCOUNT, attribute_utl.VALUE_TYPE_CUSTOMER),
                                       l_attribute_type_code);

        check_list_attribute(p_attribute_row, p_value);

        check_domain_attribute(p_attribute_row, p_value);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC)) then

            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                -- фіксація змін в історії
                if (p_valid_through is not null) then
                    -- якщо p_valid_through не пуста, це означає, що встановлюване значення має обмежений період дії,
                    -- в цьому разі, починаючи з дати, наступної за p_valid_through, продовжує діяти значення, що було до цього.
                    -- Отримаємо значення, що діяло на дату p_valid_through + 1, та зафіксуємо новий початок його дії
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);
                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_value := get_number_value_for_hist(l_history_row.id);
                        create_number_history(p_object_id, p_attribute_row, l_historical_value, p_valid_through + 1, p_comment);
                    end if;
                end if;

                -- оновимо історію за той відрізок часу, що знаходиться між p_valid_from та p_valid_through (межі відрізку включаються)
                -- p_valid_from <= value_date <= p_valid_through
                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_number_history(p_object_id, p_attribute_row, p_value, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                -- якщо в попередньому циклі не знайшлося значення з датою початку дії, що співпадає з p_valid_from,
                -- зафіксуємо зміну значення на дату p_valid_from
                if (not l_value_date_is_in_range) then
                    create_number_history(p_object_id, p_attribute_row, p_value, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_number_history(p_object_id, p_attribute_row, p_value, null, p_comment);
            end if;

            -- якщо період дії нового значення охоплює поточну банківську дату - оновлюємо поточне значення
            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_number_value_utl(p_object_id, p_attribute_row, l_attribute_type_code, p_value);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            -- для розрахункових атрибутів може лише викликатися процедура попередньої обробки з l_attribute_row.set_value_procedure
            -- (якщо вона вказана), додаткових дій не проводиться і зміна значення такого атрибуту не фіксується в історії
            null;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in number_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_historical_values number_list;
        l_history_row attribute_history%rowtype;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_multi_values(p_attribute_row,
                                       number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST, attribute_utl.VALUE_TYPE_DEAL,
                                                   attribute_utl.VALUE_TYPE_ACCOUNT, attribute_utl.VALUE_TYPE_CUSTOMER),
                                       l_attribute_type_code);

        check_list_attribute(p_attribute_row, p_values);

        check_domain_attribute(p_attribute_row, p_values);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then

            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);
                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_values := get_number_values_for_hist(l_history_row.id);
                        create_number_history(p_object_id, p_attribute_row, l_historical_values, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_number_history(p_object_id, p_attribute_row, p_values, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_number_history(p_object_id, p_attribute_row, p_values, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_number_history(p_object_id, p_attribute_row, p_values, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_number_value_utl(p_object_id, p_attribute_row, p_values);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_history_row attribute_history%rowtype;
        l_historical_value varchar2(4000 byte);
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        if (p_value is not null and p_attribute_row.regular_expression is not null) then
            if (not regexp_like(p_value, p_attribute_row.regular_expression)) then
                raise_application_error(-20000,
                                        'Значення {' || p_value ||
                                        '} атрибуту {' || p_attribute_row.attribute_name ||
                                        '} не відповідає формату : ' || p_attribute_row.regular_expression);
            end if;
        end if;

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_STRING, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC)) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_value := get_string_value_for_hist(l_history_row.id);
                        create_string_history(p_object_id, p_attribute_row, l_historical_value, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_string_history(p_object_id, p_attribute_row, p_value, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_string_history(p_object_id, p_attribute_row, p_value, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_string_history(p_object_id, p_attribute_row, p_value, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_string_value_utl(p_object_id, p_attribute_row, l_attribute_type_code, p_value);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in varchar2_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_historical_values varchar2_list;
        l_history_row attribute_history%rowtype;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
        l integer;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        if (p_values is not null and p_attribute_row.regular_expression is not null) then
            l := p_values.first;
            while (l is not null) loop
                if (not regexp_like(p_values(l), p_attribute_row.regular_expression)) then
                    raise_application_error(-20000,
                                            'Значення ' || p_values(l) ||
                                            ' атрибуту ' || p_attribute_row.attribute_name ||
                                            ' не відповідає формату : ' || p_attribute_row.regular_expression);
                end if;
            end loop;
        end if;

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_multi_values(p_attribute_row, attribute_utl.VALUE_TYPE_STRING, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_values := get_string_values_for_hist(l_history_row.id);
                        create_string_history(p_object_id, p_attribute_row, l_historical_values, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_string_history(p_object_id, p_attribute_row, p_values, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_string_history(p_object_id, p_attribute_row, p_values, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_string_history(p_object_id, p_attribute_row, p_values, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_string_value_utl(p_object_id, p_attribute_row, p_values);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_historical_value date;
        l_history_row attribute_history%rowtype;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_DATE, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC)) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_value := get_date_value_for_hist(l_history_row.id);
                        create_date_history(p_object_id, p_attribute_row, l_historical_value, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_date_history(p_object_id, p_attribute_row, p_value, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_date_history(p_object_id, p_attribute_row, p_value, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_date_history(p_object_id, p_attribute_row, p_value, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_date_value_utl(p_object_id, p_attribute_row, l_attribute_type_code, p_value);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in date_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_historical_values date_list;
        l_history_row attribute_history%rowtype;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_multi_values(p_attribute_row, attribute_utl.VALUE_TYPE_DATE, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_values := get_date_values_for_hist(l_history_row.id);
                        create_date_history(p_object_id, p_attribute_row, l_historical_values, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_date_history(p_object_id, p_attribute_row, p_values, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_date_history(p_object_id, p_attribute_row, p_values, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_date_history(p_object_id, p_attribute_row, p_values, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_date_value_utl(p_object_id, p_attribute_row, p_values);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in blob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_history_row attribute_history%rowtype;
        l_historical_value blob;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_BLOB, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id,  :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC)) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_value := get_blob_value_for_hist(l_history_row.id);
                        create_blob_history(p_object_id, p_attribute_row, l_historical_value, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_blob_history(p_object_id, p_attribute_row, p_value, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_blob_history(p_object_id, p_attribute_row, p_value, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                      create_blob_history(p_object_id, p_attribute_row, p_value, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_blob_value_utl(p_object_id, p_attribute_row, l_attribute_type_code, p_value);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in blob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_history_row attribute_history%rowtype;
        l_historical_values blob_list;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_multi_values(p_attribute_row, attribute_utl.VALUE_TYPE_BLOB, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_values := get_blob_values_for_hist(l_history_row.id);
                        create_blob_history(p_object_id, p_attribute_row, l_historical_values, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_blob_history(p_object_id, p_attribute_row, p_values, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_blob_history(p_object_id, p_attribute_row, p_values, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_blob_history(p_object_id, p_attribute_row, p_values, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_blob_value_utl(p_object_id, p_attribute_row, p_values);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in clob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_history_row attribute_history%rowtype;
        l_historical_value clob;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_single_value(p_attribute_row, attribute_utl.VALUE_TYPE_CLOB, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC)) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_value := get_clob_value_for_hist(l_history_row.id);
                        create_clob_history(p_object_id, p_attribute_row, l_historical_value, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_clob_history(p_object_id, p_attribute_row, p_value, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_clob_history(p_object_id, p_attribute_row, p_value, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_clob_history(p_object_id, p_attribute_row, p_value, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_clob_value_utl(p_object_id, p_attribute_row, l_attribute_type_code, p_value);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in clob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_history_row attribute_history%rowtype;
        l_historical_values clob_list;
        l_value_date_is_in_range boolean default false;
        l_attribute_type_code varchar(30 char);
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_attr_before_multi_values(p_attribute_row, attribute_utl.VALUE_TYPE_CLOB, l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        if (p_attribute_row.set_value_procedure is not null) then
            execute immediate 'begin ' ||
                               p_attribute_row.set_value_procedure ||
                               '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
            using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;
        end if;

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                if (p_valid_through is not null) then
                    l_history_row := get_history_row_for_date(p_object_id, p_attribute_row.id, p_valid_through + 1, true);

                    if (tools.compare_range_borders(l_history_row.value_date, p_valid_through + 1) < 0) then
                        l_historical_values := get_clob_values_for_hist(l_history_row.id);
                        create_clob_history(p_object_id, p_attribute_row, l_historical_values, p_valid_through + 1, p_comment);
                    end if;
                end if;

                for i in (select distinct t.value_date
                          from   attribute_history t
                          where  t.object_id = p_object_id and
                                 t.attribute_id = p_attribute_row.id and
                                 tools.compare_range_borders(p_valid_from, t.value_date) <= 0 and
                                 tools.compare_range_borders(t.value_date, p_valid_through) <= 0 and
                                 t.is_delete = 'N') loop

                    create_clob_history(p_object_id, p_attribute_row, p_values, i.value_date, p_comment);

                    if (tools.equals(p_valid_from, i.value_date)) then
                        l_value_date_is_in_range := true;
                    end if;
                end loop;

                if (not l_value_date_is_in_range) then
                    create_clob_history(p_object_id, p_attribute_row, p_values, p_valid_from, p_comment);
                end if;
            elsif (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                create_clob_history(p_object_id, p_attribute_row, p_values, null, p_comment);
            end if;

            if (tools.compare_range_borders(p_valid_from, bankdate()) <= 0 and tools.compare_range_borders(bankdate(), p_valid_through) <= 0) then
                set_clob_value_utl(p_object_id, p_attribute_row, p_values);
            end if;
        end if;
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in varchar2_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in varchar2_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_value,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_value,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_values,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_values,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_value,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_value,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in varchar2_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_values,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in varchar2_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_values,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_value,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_value,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_values,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_values,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_value,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_value,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_values,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_values,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_value,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_value,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_values,
                  p_value_date,
                  get_history_row_after_date(p_object_id, p_attribute_id, p_value_date).value_date,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_values,
                      p_value_date,
                      get_history_row_after_date(p_object_id, l_attribute_row.id, p_value_date).value_date,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in varchar2_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in varchar2_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, bankdate(), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, bankdate(), null, p_comment);
    end;

    procedure delete_history_record(
        p_history_id in integer,
        p_comment in varchar2)
    is
    begin
        update attribute_history oah
        set    oah.is_delete = 'Y'
        where  oah.id = p_history_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Рядок в історії змін атрибуту з ідентифікатором {' || p_history_id || '} не знайдений');
        end if;

        insert into attribute_history_deletion
        values (p_history_id, user_id(), sysdate, p_comment);
    end;

    procedure remove_history(
        p_history_id in integer,
        p_comment in varchar2)
    is
        l_history_row attribute_history%rowtype;
        l_attribute_row attribute_kind%rowtype;
        l_attribute_type_code varchar2(30 char);
        l_history_id_for_date integer;
        l_history_row_after_date attribute_history%rowtype;
        l_previous_history_id integer;
        l_number_value number;
        l_number_values number_list;
        l_string_value varchar2(4000 byte);
        l_string_values varchar2_list;
        l_date_value date;
        l_date_values date_list;
        l_blob_value blob;
        l_blob_values blob_list;
        l_clob_value clob;
        l_clob_values clob_list;
        l_comment varchar2(4000 byte) default regexp_replace(p_comment, '[^A-Za-zА-Яа-я]');
    begin
        l_history_row := read_history(p_history_id, true);

        if (l_history_row.is_delete = 'Y') then
            raise_application_error(-20000, 'Запис історії з ідентифікатором {' || l_history_row.id || '} вже видалений - повторне видалення не допускається');
        end if;

        if (l_comment is null) then
            raise_application_error(-20000, 'Причина видалення рядка історії з ідентифікатором {' || p_history_id || '} не вказана');
        end if;

        if (length(l_comment) < 20) then
            raise_application_error(-20000, 'Опис причини видалення рядка історії з ідетифікатором {' || p_history_id || '} має містити щонайменше 20 значимих символів');
        end if;

        if (lengthb(p_comment) > 4000) then
            raise_application_error(-20000, 'Опис причини видалення рядка історії з ідетифікатором {' || p_history_id || '} не може перевищувати довжину в 4000 байт');
        end if;

        l_attribute_row := read_attribute(l_history_row.attribute_id);

        if (l_attribute_row.state_id <> attribute_utl.ATTR_STATE_ACTIVE) then
            raise_application_error(-20000, 'Атрибут {' || l_attribute_row.attribute_name ||
                                            '} знаходиться в стані {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_STATE, l_attribute_row.state_id) ||
                                            '} - виконувати дії зі значеннями атрибуту не можливо');
        end if;

        l_attribute_type_code := object_utl.get_object_type_code(l_attribute_row.attribute_type_id);

        if (l_attribute_type_code in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC)) then

            if (l_attribute_row.del_value_procedure is not null) then
                execute immediate 'begin ' || l_attribute_row.del_value_procedure || '(:p_history_id); end;'
                using p_history_id;
            end if;

            l_history_id_for_date := get_history_id_for_date(l_history_row.object_id,
                                                             l_history_row.attribute_id,
                                                             l_history_row.value_date);

            l_history_row_after_date := get_history_row_after_date(l_history_row.object_id,
                                                                   l_history_row.attribute_id,
                                                                   l_history_row.value_date + 1);

            if (l_history_id_for_date = l_history_row.id and
                tools.compare_range_borders(l_history_row.value_date, bankdate()) <= 0 and
                tools.compare_range_borders(bankdate(), l_history_row_after_date.value_date) <= 0) then
                -- Співпадіння ідентифікаторів історії означає, що даний запис історії є останнім (тобто діючим) записом на свою дату.
                -- Поточна банківська дата знаходиться між датою, з якої починає діяти рядок історії та
                -- датою наступного значення (або наступне значення не існує - тобто поточне значення рядка історії діє без обмеження).
                -- Виконання усіх цих умов означає, що видаляється значення історії, що діє на даний момент - відповідно, при його видаленні
                -- необхідно відновити попереднє значення атрибуту (визначається за історією)
                l_previous_history_id := get_previous_history_id(l_history_row);

                case when l_attribute_row.value_type_id in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST,
                                                            attribute_utl.VALUE_TYPE_DEAL, attribute_utl.VALUE_TYPE_ACCOUNT,
                                                            attribute_utl.VALUE_TYPE_CUSTOMER) then
                     if (l_attribute_row.multy_value_flag = 'Y') then
                         l_number_values := get_number_values_for_hist(l_previous_history_id);
                         check_list_attribute(l_attribute_row, l_number_values);
                         check_domain_attribute(l_attribute_row, l_number_values);
                         set_number_value_utl(l_history_row.object_id, l_attribute_row, l_number_values);
                     else
                         l_number_value := get_number_value_for_hist(l_previous_history_id);
                         check_list_attribute(l_attribute_row, l_number_value);
                         check_domain_attribute(l_attribute_row, l_number_value);
                         set_number_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_number_value);
                     end if;
                when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_STRING then
                     if (l_attribute_row.multy_value_flag = 'Y') then
                         l_string_values := get_string_values_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_string_values);
                         set_string_value_utl(l_history_row.object_id, l_attribute_row, l_string_values);
                     else
                         l_string_value := get_string_value_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_string_value);
                         set_string_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_string_value);
                     end if;
                when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_DATE then
                     if (l_attribute_row.multy_value_flag = 'Y') then
                         l_date_values := get_date_values_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_date_values);
                         set_date_value_utl(l_history_row.object_id, l_attribute_row, l_date_values);
                     else
                         l_date_value := get_date_value_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_date_value);
                         set_date_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_date_value);
                     end if;
                when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_BLOB then
                     if (l_attribute_row.multy_value_flag = 'Y') then
                         l_blob_values := get_blob_values_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_blob_values);
                         set_blob_value_utl(l_history_row.object_id, l_attribute_row, l_blob_values);
                     else
                         l_blob_value := get_blob_value_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_blob_value);
                         set_blob_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_blob_value);
                     end if;
                when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_CLOB then
                     if (l_attribute_row.multy_value_flag = 'Y') then
                         l_clob_values := get_clob_values_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_clob_values);
                         set_clob_value_utl(l_history_row.object_id, l_attribute_row, l_clob_values);
                     else
                         l_clob_value := get_clob_value_for_hist(l_previous_history_id);
                         check_domain_attribute(l_attribute_row, l_clob_value);
                         set_clob_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_clob_value);
                     end if;
                else
                     raise_application_error(-20000, 'Неочікуваний тип значення атрибуту {' || l_attribute_row.value_type_id || '}');
                end case;
            end if;

            delete_history_record(p_history_id, p_comment);
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            raise_application_error(-20000, 'Розрахунковий атрибут {' || l_attribute_row.attribute_name ||
                                            '} не веде історію зміни значень, отже видалення історії також не допускається');
        end if;
    end;

    function map_value_type_to_value_table(
        p_value_type_id in integer)
    return varchar2
    is
    begin
        case when p_value_type_id in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST) then
                  return 'ATTRIBUTE_NUMBER_VALUE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_DEAL then
                  return 'ATTRIBUTE_DEAL_VALUE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_ACCOUNT then
                  return 'ATTRIBUTE_ACCOUNT_VALUE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_CUSTOMER then
                  return 'ATTRIBUTE_CUSTOMER_VALUE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_STRING then
                  return 'ATTRIBUTE_STRING_VALUE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_DATE then
                  return 'ATTRIBUTE_DATE_VALUE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_BLOB then
                  return 'ATTRIBUTE_BLOB_VALUE';
             when p_value_type_id = attribute_utl.VALUE_TYPE_CLOB then
                  return 'ATTRIBUTE_CLOB_VALUE';
        end case;
    end;

    function map_value_type_to_hist_table(
        p_value_type_id in integer)
    return varchar2
    is
    begin
        case when p_value_type_id in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST) then
                  return 'ATTRIBUTE_NUMBER_HISTORY';
             when p_value_type_id = attribute_utl.VALUE_TYPE_DEAL then
                  return 'ATTRIBUTE_DEAL_HISTORY';
             when p_value_type_id = attribute_utl.VALUE_TYPE_ACCOUNT then
                  return 'ATTRIBUTE_ACCOUNT_HISTORY';
             when p_value_type_id = attribute_utl.VALUE_TYPE_CUSTOMER then
                  return 'ATTRIBUTE_CUSTOMER_HISTORY';
             when p_value_type_id = attribute_utl.VALUE_TYPE_STRING then
                  return 'ATTRIBUTE_STRING_HISTORY';
             when p_value_type_id = attribute_utl.VALUE_TYPE_DATE then
                  return 'ATTRIBUTE_DATE_HISTORY';
             when p_value_type_id = attribute_utl.VALUE_TYPE_BLOB then
                  return 'ATTRIBUTE_BLOB_HISTORY';
             when p_value_type_id = attribute_utl.VALUE_TYPE_CLOB then
                  return 'ATTRIBUTE_CLOB_HISTORY';
        end case;
    end;

    function check_if_values_exists(
        p_attribute_row in attribute_kind%rowtype,
        p_attribute_type_code in varchar2,
        p_include_deleted_values in char)
    return char
    is
        l_values_exists_flag char(1 byte);
    begin
        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            return object_utl.check_if_any_objects_exists(p_attribute_row.object_type_id);
        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_include_deleted_values = 'Y') then
                select /*+FIRST_ROW*/ 'Y'
                into   l_values_exists_flag
                from   attribute_history h
                where  h.attribute_id = p_attribute_row.id and
                       rownum = 1;
            else
                execute immediate ' select /*+FIRST_ROW*/ ''Y''' ||
                                  ' from ' || map_value_type_to_value_table(p_attribute_row.value_type_id) ||
                                  ' where attribute_id = :p_attribute_id and rownum = 1'
                using out l_values_exists_flag, p_attribute_row.id;
            end if;
        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            return object_utl.check_if_any_objects_exists(p_attribute_row.object_type_id);
        end if;
    end;

    procedure on_set_attribute_value_type(
        p_attribute_id in integer,
        p_new_value_type_id in integer)
    is
        l_attribute_row attribute_kind%rowtype;
        l_object_type_storage_row object_type_storage%rowtype;
        l_table_owner varchar2(30 char);
        l_table_name varchar2(30 char);
        l_actual_field_data_type varchar2(30);
        l_attribute_type_code varchar2(30 char);
    begin
        if (p_new_value_type_id not in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_STRING, attribute_utl.VALUE_TYPE_DATE,
                                        attribute_utl.VALUE_TYPE_CLOB, attribute_utl.VALUE_TYPE_BLOB, attribute_utl.VALUE_TYPE_LIST,
                                        attribute_utl.VALUE_TYPE_DEAL, attribute_utl.VALUE_TYPE_ACCOUNT, attribute_utl.VALUE_TYPE_CUSTOMER)) then
            raise_application_error(-20000, 'Неочікуваний тип значення атрибуту {' || p_new_value_type_id || '}');
        end if;

        l_attribute_row := read_attribute(p_attribute_id);

        if (l_attribute_row.state_id <> attribute_utl.ATTR_STATE_UNDER_CONSTRUCTION) then
            raise_application_error(-20000, 'Для зміни налаштувань атрибуту, його необхідно перевести в режим редагування');
        end if;

        l_attribute_type_code := object_utl.get_object_type_code(l_attribute_row.attribute_type_id);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (l_attribute_row.value_table_name is null) then
                l_object_type_storage_row := object_utl.read_object_type_storage(l_attribute_row.object_type_id);
                l_table_owner := l_object_type_storage_row.table_owner;
                l_table_name := l_object_type_storage_row.table_name;
            else
                l_table_owner := l_attribute_row.value_table_owner;
                l_table_name := l_attribute_row.value_table_name;
            end if;

            -- TODO: set_deferred
            --
            l_actual_field_data_type := ddl_utl.get_column_data_type(l_table_name, l_attribute_row.value_column_name, l_table_owner);
            if (l_actual_field_data_type is null or map_value_type_to_oracle_type(p_new_value_type_id) <> l_actual_field_data_type) then
                raise_application_error(-20000, 'Тип значення атрибуту {' || list_utl.get_item_code(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_new_value_type_id) ||
                                                '} не відповідає типу поля, що зберігатиме значення {' || l_actual_field_data_type || '}');
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (check_if_values_exists(l_attribute_row, l_attribute_type_code, 'Y') = 'Y') then
                raise_application_error(-20000, 'З атрибутом {' || l_attribute_row.attribute_name ||
                                                '} вже розпочата робота - існують значення атрибуту або історія їх зміни. Змінити тип значення атрибуту неможливо');
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            -- шо б там не було - просто змінюємо тип значення атрибуту, оскільки для розрахункових атрибутів ми не можемо перевірити
            -- тип значення, що повертається функцією
            null;
        end if;
    end;

    procedure set_attribute_history_mode(
        p_attribute_id in integer,
        p_new_history_saving_mode_id in integer,
        p_limit in integer default 100)
    is
        l_attribute_row attribute_kind%rowtype;
        l_attribute_type_code varchar2(30 char);
        l_object_type_storage_row object_type_storage%rowtype;
        l_new_history_ids number_list;
        l_object_ids number_list;
        l_cursor sys_refcursor;
        l_limit pls_integer default p_limit;
        l_value_table_name varchar2(30 char);
        l_history_table_name varchar2(30 char);
        l_value_date date;
    begin
        -- TODO : додати вставку коментарів для видалених записів історії

        if (p_new_history_saving_mode_id is null or
            p_new_history_saving_mode_id not in (attribute_utl.HISTORY_MODE_NO_HISTORY, attribute_utl.HISTORY_MODE_VALUES_ONLY, attribute_utl.HISTORY_MODE_VALUES_BY_DATE)) then
            raise_application_error(-20000, 'Неочікуване значення режиму історизації {' || p_new_history_saving_mode_id || '}');
        end if;

        l_attribute_row := read_attribute(p_attribute_id);

        lock_attribute(p_attribute_id);

        if (l_attribute_row.state_id <> attribute_utl.ATTR_STATE_UNDER_CONSTRUCTION) then
            raise_application_error(-20000, 'Для зміни налаштувань атрибуту, його необхідно перевести в режим конструювання');
        end if;

        l_attribute_type_code := object_utl.get_object_type_code(l_attribute_row.attribute_type_id);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and p_new_history_saving_mode_id <> attribute_utl.HISTORY_MODE_NO_HISTORY) then
            raise_application_error(-20000, 'Розрахунковий атрибут не може зберігати історію');
        end if;

        if (not tools.equals(l_attribute_row.history_saving_mode_id, p_new_history_saving_mode_id)) then
            if (l_attribute_type_code in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC)) then
                l_value_table_name := map_value_type_to_value_table(l_attribute_row.value_type_id);
                l_history_table_name := map_value_type_to_hist_table(l_attribute_row.value_type_id);
                if (l_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_NO_HISTORY) then
                    if (p_new_history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                        -- скинути поточне значення в історію - дата початку дії значення = null
                        l_value_date := null;
                    elsif (p_new_history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                        -- скинути поточне значення в історію - дата початку дії значення = bankdate()
                        l_value_date := bankdate();
                    end if;

                    if (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
                        open l_cursor
                        for ' select distinct object_id' ||
                            ' from ' || l_value_table_name ||
                            ' where  attribute_id = :p_attribute_id'
                        using in l_attribute_row.id;

                        loop
                            fetch l_cursor
                            bulk collect into l_object_ids
                            limit l_limit;

                            forall i in indices of l_object_ids
                                   insert into attribute_history
                                   values (attribute_history_seq.nextval, l_object_ids(i), l_attribute_row.id, l_value_date, user_id(), sysdate, 'N')
                                   returning id bulk collect into l_new_history_ids;

                            forall i in indices of l_new_history_ids
                                   execute immediate ' insert into ' || l_history_table_name ||
                                                     ' select :p_history_id, value from ' || l_value_table_name ||
                                                     ' where  object_id = :p_object_id and ' ||
                                                             'attribute_id = :attribute_id'
                                   using l_new_history_ids(i), l_object_ids(i), l_attribute_row.id;

                            exit when l_object_ids.count < l_limit;
                        end loop;

                    elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
                        l_object_type_storage_row := object_utl.read_object_type_storage(l_attribute_row.object_type_id, p_raise_ndf => false);

                        if (l_object_type_storage_row.object_type_id is null) then
                            raise_application_error(-20000, 'Для зміни режиму історизації необхідно заповнити параметри збереження даних в налаштуваннях типу об''єктів {' ||
                                                            object_utl.get_object_type_name(l_attribute_row.object_type_id) || '}');
                        end if;

                        if (l_object_type_storage_row.object_type_column_name is null) then
                            open l_cursor
                            for ' select ' || l_object_type_storage_row.key_column_name ||
                                ' from ' || l_object_type_storage_row.table_name ||
                                case when l_object_type_storage_row.where_clause is null then null
                                     else ' where ' || l_object_type_storage_row.where_clause
                                end;
                        else
                            open l_cursor
                            for ' select ' || l_object_type_storage_row.key_column_name ||
                                ' from ' || l_object_type_storage_row.table_name ||
                                ' where ' || l_object_type_storage_row.object_type_column_name ||
                                             ' in (select column_value from table(:object_type_ids))' ||
                                             case when l_object_type_storage_row.where_clause is null then null
                                                  else ' and ' || l_object_type_storage_row.where_clause
                                             end
                            using object_utl.get_inheritance_tree(l_attribute_row.object_type_id);
                        end if;

                        loop
                            fetch l_cursor
                            bulk collect into l_object_ids
                            limit l_limit;

                            forall i in indices of l_object_ids
                                   insert into attribute_history
                                   values (attribute_history_seq.nextval, l_object_ids(i), l_attribute_row.id, l_value_date, user_id(), sysdate, 'N')
                                   returning id bulk collect into l_new_history_ids;

                            forall i in indices of l_new_history_ids
                                   execute immediate ' insert into ' || l_history_table_name ||
                                                     ' select :p_history_id, ' || l_attribute_row.value_column_name ||
                                                     ' from ' || l_object_type_storage_row.table_name ||
                                                     ' where ' || l_object_type_storage_row.key_column_name || ' = :p_object_id'
                                   using l_new_history_ids(i), l_object_ids(i);

                            exit when l_object_ids.count < l_limit;
                        end loop;
                    end if;
                elsif (l_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                    if (p_new_history_saving_mode_id = attribute_utl.HISTORY_MODE_NO_HISTORY) then
                        -- помітити всю історію як видалену - в коментарі вказати причину видалення:
                        -- 'Зміна режиму збереження історії: попереднє значення "Зберігати тільки значення", нове значення "Не зберігати історію"'
                        update attribute_history t
                        set    t.is_delete = 'Y'
                        where  t.attribute_id = l_attribute_row.id and
                               t.is_delete = 'N';
                    elsif (p_new_history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                        -- "відновити" дату початку дії значення з системної дати встановлення значення
                        declare
                            l_old_history_ids number_list;
                            l_old_history_objects number_list;
                            l_old_history_sys_dates date_list;
                            l_old_history_curators number_list;
                        begin
                            open l_cursor
                            for select id, object_id, sys_time, user_id
                                from   attribute_history
                                where  attribute_id = l_attribute_row.id and
                                       is_delete = 'N'
                                for update;

                            loop
                                fetch l_cursor
                                bulk collect into l_old_history_ids,
                                                  l_old_history_objects,
                                                  l_old_history_sys_dates,
                                                  l_old_history_curators
                                limit l_limit;

                                -- помітити всю історію як видалену - в коментарі вказати причину видалення:
                                -- 'Зміна режиму збереження історії: попереднє значення "Зберігати значення на дату", нове значення "Не зберігати історію"'
                                update attribute_history t
                                set    t.is_delete = 'Y'
                                where  t.id in (select column_value from table(l_old_history_ids));

                                -- скопіювати історію значень на дату від початку дії об'єкту до поточного банківського дня - при цьому, замінити дату значення на null
                                -- помітити всю стару історію як видалену - в коментарі вказати причину видалення:
                                -- 'Зміна режиму збереження історії: попереднє значення "Зберігати значення на дату", нове значення "Зберігати тільки значення"'
                                forall i in indices of l_old_history_ids
                                       insert into attribute_history
                                       values (attribute_history_seq.nextval,
                                               l_old_history_objects(i),
                                               l_attribute_row.id,
                                               trunc(l_old_history_sys_dates(i)),
                                               l_old_history_curators(i),
                                               l_old_history_sys_dates(i),
                                               'N')
                                       returning id bulk collect into l_new_history_ids;

                                forall i in indices of l_new_history_ids
                                       execute immediate ' insert into ' || l_history_table_name ||
                                                         ' select :new_history_id, value from ' || l_history_table_name ||
                                                         ' where  id = :p_new_history_id'
                                       using l_new_history_ids(i), l_old_history_ids(i);

                                exit when l_old_history_ids.count < l_limit;
                            end loop;
                        end;
                    end if;
                elsif (l_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
                    if (p_new_history_saving_mode_id = attribute_utl.HISTORY_MODE_NO_HISTORY) then
                        update attribute_history t
                        set    t.is_delete = 'Y'
                        where  t.attribute_id = l_attribute_row.id and
                               t.is_delete = 'N';
                    elsif (p_new_history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_ONLY) then
                        declare
                            l_old_history_ids number_list;
                            l_old_history_objects number_list;
                            l_old_history_sys_dates date_list;
                            l_old_history_curators number_list;
                        begin
                            open l_cursor
                            for select id, object_id, sys_time, user_id
                                from   attribute_history
                                where  attribute_id = l_attribute_row.id and
                                       is_delete = 'N'
                                for update;

                            loop
                                fetch l_cursor
                                bulk collect into l_old_history_ids,
                                                  l_old_history_objects,
                                                  l_old_history_sys_dates,
                                                  l_old_history_curators
                                limit l_limit;

                                -- помітити всю історію як видалену - в коментарі вказати причину видалення:
                                -- 'Зміна режиму збереження історії: попереднє значення "Зберігати значення на дату", нове значення "Не зберігати історію"'
                                update attribute_history t
                                set    t.is_delete = 'Y'
                                where  t.id in (select column_value from table(l_old_history_ids));

                                -- скопіювати історію значень на дату від початку дії об'єкту до поточного банківського дня - при цьому, замінити дату значення на null
                                -- помітити всю стару історію як видалену - в коментарі вказати причину видалення:
                                -- 'Зміна режиму збереження історії: попереднє значення "Зберігати значення на дату", нове значення "Зберігати тільки значення"'
                                forall i in indices of l_old_history_ids
                                       insert into attribute_history
                                       values (attribute_history_seq.nextval,
                                               l_old_history_objects(i),
                                               l_attribute_row.id,
                                               null,
                                               l_old_history_curators(i),
                                               l_old_history_sys_dates(i),
                                               'N')
                                       returning id bulk collect into l_new_history_ids;

                                forall i in indices of l_new_history_ids
                                       execute immediate ' insert into ' || l_history_table_name ||
                                                         ' select :new_history_id, value from ' || l_history_table_name ||
                                                         ' where  id = :p_new_history_id'
                                       using l_new_history_ids(i), l_old_history_ids(i);

                                exit when l_old_history_ids.count < l_limit;
                            end loop;
                        end;
                    end if;
                end if;
            end if;

            update attribute_kind t
            set    t.history_saving_mode_id = p_new_history_saving_mode_id
            where  t.id = p_attribute_id;
        end if;
    end;

    procedure on_set_attribute_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_object_type(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_value_type(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_value_table_owner(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_value_table_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_key_column_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_value_column_name(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_regular_expression(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_list_type(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_multy_value_flag(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
        l_attribute_type_code varchar2(30 char);
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        l_attribute_type_code := object_utl.get_object_type_code(l_attribute_row.attribute_type_id);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED and p_new_value = 'Y') then
            raise_application_error(-20000, 'Параметр об''єкту, що зберігається в таблиці не може зберігати одночасно декілька значень');
        end if;

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_history_saving_mode(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in integer,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_get_value_function(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_get_values_function(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_set_value_procedure(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure on_set_del_value_procedure(
        p_object_id in integer,
        p_attribute_id in integer,
        p_new_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_object_id);

        check_state_before_change(l_attribute_row);

        tools.hide_hint(p_attribute_id);
        tools.hide_hint(p_new_value);
        tools.hide_hint(p_valid_from);
        tools.hide_hint(p_valid_through);
    end;

    procedure put_under_construction(
        p_attribute_id in integer)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_id);

        if (l_attribute_row.state_id <> attribute_utl.ATTR_STATE_UNDER_CONSTRUCTION) then
            lock_attribute(p_attribute_id);

            set_value(p_attribute_id, attribute_utl.ATTR_CODE_STATE, attribute_utl.ATTR_STATE_UNDER_CONSTRUCTION);
        end if;
    end;

    procedure activate_attribute(
        p_attribute_id in integer)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_id);

        lock_attribute(p_attribute_id);

        if (l_attribute_row.state_id <> attribute_utl.ATTR_STATE_ACTIVE) then
            validate_attribute(l_attribute_row);

            set_value(p_attribute_id, attribute_utl.ATTR_CODE_STATE, attribute_utl.ATTR_STATE_ACTIVE);
        end if;
    end;

    procedure close_attribute(
        p_attribute_id in integer)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_id);

        lock_attribute(p_attribute_id);

        if (l_attribute_row.state_id <> attribute_utl.ATTR_STATE_CLOSED) then
            set_value(p_attribute_id, attribute_utl.ATTR_CODE_STATE, attribute_utl.ATTR_STATE_CLOSED);
        end if;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  ATTRIBUTE_UTL ***
grant EXECUTE                                                                on ATTRIBUTE_UTL   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ATTRIBUTE_UTL   to BARS_DM;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/attribute_utl.sql =========*** End *
 PROMPT ===================================================================================== 
 
