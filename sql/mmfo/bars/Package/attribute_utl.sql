 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/attribute_utl.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ATTRIBUTE_UTL is

    -- Author  : Artem Yurchenko
    -- Date    : 2015-04-20
    -- Purpose : Пакет для роботи з атрибутами об'єктів АБС

    OBJECT_TYPE_ATTRIBUTE          constant varchar2(30 char) := 'ATTRIBUTE';
    ATTR_TYPE_FIXED                constant varchar2(30 char) := 'FIXED_ATTRIBUTE';
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

    ATTR_CODE_NAME                 constant varchar2(30 char) := 'ATTR_NAME';
    ATTR_CODE_OBJECT_TYPE          constant varchar2(30 char) := 'ATTR_OBJECT_TYPE';
    ATTR_CODE_VALUE_TYPE           constant varchar2(30 char) := 'ATTR_VALUE_TYPE';
    ATTR_CODE_VALUE_TABLE_OWNER    constant varchar2(30 char) := 'ATTR_VALUE_TABLE_OWNER';
    ATTR_CODE_VALUE_TABLE_NAME     constant varchar2(30 char) := 'ATTR_VALUE_TABLE_NAME';
    ATTR_CODE_KEY_COLUMN_NAME      constant varchar2(30 char) := 'ATTR_KEY_COLUMN_NAME';
    ATTR_CODE_VALUE_COLUMN_NAME    constant varchar2(30 char) := 'ATTR_VALUE_COLUMN_NAME';
    ATTR_CODE_REGULAR_EXPRESSION   constant varchar2(30 char) := 'ATTR_REGULAR_EXPRESSION';
    ATTR_CODE_LIST_TYPE            constant varchar2(30 char) := 'ATTR_LIST_TYPE';
    ATTR_CODE_SMALL_VALUE_FLAG     constant varchar2(30 char) := 'ATTR_SMALL_VALUE_FLAG';
    ATTR_CODE_VALUE_BY_DATE_FLAG   constant varchar2(30 char) := 'ATTR_VALUE_BY_DATE_FLAG';
    ATTR_CODE_MULTI_VALUES_FLAG    constant varchar2(30 char) := 'ATTR_MULTI_VALUES_FLAG';
    ATTR_CODE_SAVE_HISTORY_FLAG    constant varchar2(30 char) := 'ATTR_SAVE_HISTORY_FLAG';
    ATTR_CODE_GET_VALUE_FUNCTION   constant varchar2(30 char) := 'ATTR_GET_VALUE_FUNCTION';
    ATTR_CODE_SET_VALUE_PROCEDURES constant varchar2(30 char) := 'ATTR_SET_VALUE_PROCEDURES';
    ATTR_CODE_STATE                constant varchar2(30 char) := 'ATTR_STATE';

    ATTR_CODE_REGEXP_MISMATCH_EXPL constant varchar2(30 char) := 'ATTR_REGEXP_MISMATCH_EXPL';

    HISTORY_STATE_PLANED           constant char(1 byte) := 'P';
    HISTORY_STATE_ACTIVE           constant char(1 byte) := 'A';
    HISTORY_STATE_DELETED          constant char(1 byte) := 'D';
/*
    procedure add_attribute_partition(
        p_attribute_id in integer);

    procedure add_date_attribute_partition(
        p_attribute_id in integer);
*/
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
        p_multi_values_flag        in char default 'N',
        p_save_history_flag        in char default 'N',
        p_set_value_procedures     in string_list default null)
    return integer;

    function create_dynamic_attribute(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_small_value_flag         in char default 'N',
        p_value_by_date_flag       in char default 'N',
        p_multi_values_flag        in char default 'N',
        p_save_history_flag        in char default 'N',
        p_set_value_procedures     in string_list default null)
    return integer;

    function create_calculated_attribute(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_small_value_flag         in char default 'N',
        p_value_by_date_flag       in char default 'N',
        p_multi_values_flag        in char default 'N',
        p_get_value_function       in varchar2 default null,
        p_set_value_procedures     in string_list default null)
    return integer;

    function read_attribute(
        p_attribute_id in integer,
        p_raise_ndf in boolean default true)
    return attribute_kind%rowtype;

    function read_attribute(
        p_attribute_code in varchar2,
        p_raise_ndf in boolean default true)
    return attribute_kind%rowtype;

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
        p_value_date in date default trunc(sysdate))
    return number;

    function get_number_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return number;

    function get_number_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return number_list;

    function get_number_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return number_list;

    function get_string_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return varchar2;

    function get_string_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return varchar2;

    function get_string_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return string_list;

    function get_string_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return string_list;

    function get_date_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return date;

    function get_date_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return date;

    function get_date_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return date_list;

    function get_date_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return date_list;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return blob;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return blob;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return blob_list;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return blob_list;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return clob;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return clob;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return clob_list;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
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
        p_values in string_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
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
        p_values in string_list,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
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
        p_values in string_list,
        p_comment in varchar2 default null);

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
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

    -- порівнює значення (p_value) з поточним значенням атрибуту
    -- повертає:
    --     1 - p_value > поточного значення
    --     0 - p_value = поточному значенню
    --    -1 - p_value < поточного значення
    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;


    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in string_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype;

    function check_if_value_exists(
        p_object_id in integer,
        p_attribute_id in integer,
        p_include_deleted_values in char default 'N')
    return char;

    function check_if_value_exists(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_include_deleted_values in char default 'N')
    return char;
/*
    procedure remove_history(
        p_history_id in integer,
        p_comment in varchar2);
*/
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
        p_value_type_id in integer,
        p_multi_values_flag in char)
    return string_list
    is
    begin
        if (p_multi_values_flag = 'N') then
            case when p_value_type_id in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST) then
                      return string_list('NUMBER');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_STRING then
                      return string_list('VARCHAR2', 'VARCHAR', 'CHAR');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_DATE then
                      return string_list('DATE');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_BLOB then
                      return string_list('BLOB');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_CLOB then
                      return string_list('CLOB');
            end case;
        else
            case when p_value_type_id in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST) then
                      return string_list('NUMBER_LIST');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_STRING then
                      return string_list('STRING_LIST');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_DATE then
                      return string_list('DATE_LIST');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_BLOB then
                      return string_list('BLOB_LIST');
                 when p_value_type_id = attribute_utl.VALUE_TYPE_CLOB then
                      return string_list('CLOB_LIST');
            end case;
        end if;
    end;

    procedure check_attribute_uniqueness(p_attribute_code in varchar2)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(upper(p_attribute_code), p_raise_ndf => false);

        if (l_attribute_row.id is not null) then
            raise_application_error(-20000, 'Атрибут з кодом {' || upper(p_attribute_code) || '} вже існує');
        end if;
    end;

    procedure check_attribute_value_storage(
        p_attribute_name in varchar2,
        p_object_type_id in integer,
        p_value_type_id in integer,
        p_value_table_owner in varchar2,
        p_value_table_name in varchar2,
        p_key_column_name in varchar2,
        p_value_column_name in varchar2,
        p_multi_values_flag in char)
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

        if (ddl_utl.get_column_data_type(p_value_table_name, p_value_column_name, p_value_table_owner) not member of map_value_type_to_oracle_type(p_value_type_id, p_multi_values_flag)) then
            raise_application_error(-20000, 'Тип значень параметру {' || list_utl.get_item_name(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_value_type_id) ||
                                            '} не відповідає типу поля {' || tools.words_to_string(map_value_type_to_oracle_type(p_value_type_id, p_multi_values_flag), ', ') || '}');
        end if;
    end;

    procedure check_attribute(
        p_attribute_type_code in varchar2,
        p_attribute_name in varchar2,
        p_value_type_id in integer,
        p_regular_expression in varchar2,
        p_list_type_code in varchar2,
        p_multi_values_flag in char,
        p_save_history_flag in char)
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
            raise_application_error(-20000, 'Тип значень атрибуту {' || p_attribute_name || '} не вказаний');
        end if;

        if (p_save_history_flag is null or p_save_history_flag not in ('Y', 'N')) then
            raise_application_error(-20000, 'Неочікуване значення флагу збереження історії {' || p_save_history_flag || '}');
        end if;

        if (p_multi_values_flag is null or p_multi_values_flag not in ('Y', 'N')) then
            raise_application_error(-20000, 'Неочікуване значення флагу множинних значень атрибуту {' || p_multi_values_flag || '}');
        end if;

        if (p_value_type_id not in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_STRING, attribute_utl.VALUE_TYPE_DATE,
                                    attribute_utl.VALUE_TYPE_CLOB, attribute_utl.VALUE_TYPE_BLOB, attribute_utl.VALUE_TYPE_LIST)) then
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
                raise_application_error(-20000, 'Тип списку {' || l_list_type_row.list_name || '} закрито - його використання заборонено');
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
        p_multi_values_flag in char,
        p_save_history_flag in char)
    is
    begin
        check_attribute_uniqueness(p_attribute_code);

        check_attribute(attribute_utl.ATTR_TYPE_FIXED,
                        p_attribute_name,
                        p_value_type_id,
                        p_regular_expression,
                        p_list_type_code,
                        p_multi_values_flag,
                        p_save_history_flag);

        check_attribute_value_storage(p_attribute_name,
                                      p_object_type_id,
                                      p_value_type_id,
                                      p_value_table_owner,
                                      p_value_table_name,
                                      p_key_column_name,
                                      p_value_column_name,
                                      p_multi_values_flag);
    end;

    procedure check_new_dynamic_attribute(
        p_attribute_code in varchar2,
        p_attribute_name in varchar2,
        p_value_type_id in integer,
        p_regular_expression in varchar2,
        p_list_type_code in varchar2,
        p_value_by_date_flag in char,
        p_multi_values_flag in char,
        p_save_history_flag in char)
    is
    begin
        check_attribute_uniqueness(p_attribute_code);

        check_attribute(attribute_utl.ATTR_TYPE_DYNAMIC,
                        p_attribute_name,
                        p_value_type_id,
                        p_regular_expression,
                        p_list_type_code,
                        p_multi_values_flag,
                        p_save_history_flag);

        if (p_value_by_date_flag is null or p_value_by_date_flag not in ('Y', 'N')) then
            raise_application_error(-20000, 'Неочікуване значення флагу збереження значень атрибуту на дату {' || p_value_by_date_flag || '}');
        end if;
    end;

    procedure check_new_calculated_attribute(
        p_attribute_code in varchar2,
        p_attribute_name in varchar2,
        p_value_type_id in integer,
        p_regular_expression in varchar2,
        p_list_type_code in varchar2,
        p_value_by_date_flag in char,
        p_multi_values_flag in char,
        p_get_value_function in varchar2)
    is
    begin
        check_attribute_uniqueness(p_attribute_code);

        check_attribute(attribute_utl.ATTR_TYPE_DYNAMIC,
                        p_attribute_name,
                        p_value_type_id,
                        p_regular_expression,
                        p_list_type_code,
                        p_multi_values_flag,
                        'N');

        if (p_value_by_date_flag is null or p_value_by_date_flag not in ('Y', 'N')) then
            raise_application_error(-20000, 'Неочікуване значення флагу збереження значень атрибуту на дату {' || p_value_by_date_flag || '}');
        end if;

        if (p_get_value_function is null) then
            raise_application_error(-20000, 'Функція отримання значень для розрахункового атрибуту не вказана');
        end if;
    end;

    function get_regexp_mismatch_expl(
        p_attribute_id in integer)
    return varchar2
    is
    begin
        return get_string_value(p_attribute_id, attribute_utl.ATTR_CODE_REGEXP_MISMATCH_EXPL);
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
                        p_attribute_row.multi_values_flag,
                        p_attribute_row.save_history_flag);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then

            check_attribute_value_storage(p_attribute_row.attribute_name,
                                          p_attribute_row.object_type_id,
                                          p_attribute_row.value_type_id,
                                          p_attribute_row.value_table_owner,
                                          p_attribute_row.value_table_name,
                                          p_attribute_row.key_column_name,
                                          p_attribute_row.value_column_name,
                                          p_attribute_row.multi_values_flag);

        elsif (l_attribute_type_code in (attribute_utl.ATTR_TYPE_DYNAMIC)) then

            if (p_attribute_row.value_by_date_flag is null or p_attribute_row.value_by_date_flag not in ('Y', 'N')) then
                raise_application_error(-20000, 'Неочікуване значення флагу збереження значень атрибуту на дату {' || p_attribute_row.value_by_date_flag || '}');
            end if;

        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then

            if (p_attribute_row.value_by_date_flag is null or p_attribute_row.value_by_date_flag not in ('Y', 'N')) then
                raise_application_error(-20000, 'Неочікуване значення флагу збереження значень атрибуту на дату {' || p_attribute_row.value_by_date_flag || '}');
            end if;
            if (p_attribute_row.get_value_function is null) then
                raise_application_error(-20000, 'Функція отримання значень для розрахункового атрибуту не вказана');
            end if;

        end if;
    end;
/*
    procedure add_attribute_partition(
        p_attribute_id in integer)
    is
        pragma autonomous_transaction;
        l_statement varchar2(32767 byte);
    begin
        l_statement := 'alter table attribute_value add partition attribute_value_' || to_char(p_attribute_id, 'FM00000') || ' values (' || p_attribute_id || ')';
        execute immediate l_statement;
    end;

    procedure add_date_attribute_partition(
        p_attribute_id in integer)
    is
        pragma autonomous_transaction;
        l_statement varchar2(32767 byte);
    begin
        l_statement := 'alter table attribute_value_by_date add partition attribute_value_by_date_' || to_char(p_attribute_id, 'FM00000') || ' values (' || p_attribute_id || ')';
        execute immediate l_statement;
    end;
*/
    function create_attribute(
        p_attribute_type_code      in varchar2,
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_id           in integer,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2,
        p_list_type_code           in varchar2,
        p_value_by_date_flag       in char,
        p_small_value_flag         in char,
        p_multi_values_flag        in char,
        p_save_history_flag        in char,
        p_set_value_procedures     in string_list)
    return integer
    is
        l_attribute_id integer;
    begin
        insert into attribute_kind(id, attribute_type_id, attribute_code, state_id)
        values (s_attribute_kind.nextval,
                object_utl.get_object_type_id(p_attribute_type_code),
                upper(p_attribute_code),
                attribute_utl.ATTR_STATE_UNDER_CONSTRUCTION)
        returning id into l_attribute_id;

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_NAME, p_attribute_name);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_OBJECT_TYPE, p_object_type_id);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_TYPE, p_value_type_id);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_REGULAR_EXPRESSION, p_regular_expression);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_LIST_TYPE, list_utl.get_list_id(p_list_type_code));
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_SMALL_VALUE_FLAG, p_small_value_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_BY_DATE_FLAG, p_value_by_date_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_MULTI_VALUES_FLAG, p_multi_values_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_SAVE_HISTORY_FLAG, p_save_history_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_SET_VALUE_PROCEDURES, p_set_value_procedures);

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
        p_multi_values_flag        in char default 'N',
        p_save_history_flag        in char default 'N',
        p_set_value_procedures     in string_list default null)
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
                            p_multi_values_flag,
                            p_save_history_flag);

        l_attribute_id := create_attribute(attribute_utl.ATTR_TYPE_FIXED,
                                           p_attribute_code,
                                           p_attribute_name,
                                           l_object_type_row.id,
                                           p_value_type_id,
                                           p_regular_expression,
                                           p_list_type_code,
                                           'N',
                                           'N',
                                           p_multi_values_flag,
                                           p_save_history_flag,
                                           p_set_value_procedures);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_TABLE_OWNER, p_value_table_owner);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_TABLE_NAME, p_value_table_name);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_KEY_COLUMN_NAME, p_key_column_name);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_VALUE_COLUMN_NAME, p_value_column_name);

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
        p_small_value_flag         in char default 'N',
        p_value_by_date_flag       in char default 'N',
        p_multi_values_flag        in char default 'N',
        p_save_history_flag        in char default 'N',
        p_set_value_procedures     in string_list default null)
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
                                    p_value_by_date_flag,
                                    p_multi_values_flag,
                                    p_save_history_flag);

        l_attribute_id := create_attribute(attribute_utl.ATTR_TYPE_DYNAMIC,
                                           p_attribute_code,
                                           p_attribute_name,
                                           l_object_type_row.id,
                                           p_value_type_id,
                                           p_regular_expression,
                                           p_list_type_code,
                                           p_value_by_date_flag,
                                           p_small_value_flag,
                                           p_multi_values_flag,
                                           p_save_history_flag,
                                           p_set_value_procedures);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_SMALL_VALUE_FLAG, p_small_value_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_MULTI_VALUES_FLAG, p_multi_values_flag);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_STATE, attribute_utl.ATTR_STATE_ACTIVE);
/*
        if (p_value_by_date_flag = 'Y') then
            add_date_attribute_partition(l_attribute_id);
        else
            add_attribute_partition(l_attribute_id);
        end if;
*/
        return l_attribute_id;
    end;

    function create_calculated_attribute(
        p_attribute_code           in varchar2,
        p_attribute_name           in varchar2,
        p_object_type_code         in varchar2,
        p_value_type_id            in integer,
        p_regular_expression       in varchar2 default null,
        p_list_type_code           in varchar2 default null,
        p_small_value_flag         in char default 'N',
        p_value_by_date_flag       in char default 'N',
        p_multi_values_flag        in char default 'N',
        p_get_value_function       in varchar2 default null,
        p_set_value_procedures     in string_list default null)
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
                                       p_value_by_date_flag,
                                       p_multi_values_flag,
                                       p_get_value_function);

        l_attribute_id := create_attribute(attribute_utl.ATTR_TYPE_CALCULATED,
                                           p_attribute_code,
                                           p_attribute_name,
                                           l_object_type_row.id,
                                           p_value_type_id,
                                           p_regular_expression,
                                           p_list_type_code,
                                           p_value_by_date_flag,
                                           p_small_value_flag,
                                           p_multi_values_flag,
                                           'N',
                                           p_set_value_procedures);

        set_value(l_attribute_id, attribute_utl.ATTR_CODE_SMALL_VALUE_FLAG, p_small_value_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_MULTI_VALUES_FLAG, p_multi_values_flag);
        set_value(l_attribute_id, attribute_utl.ATTR_CODE_GET_VALUE_FUNCTION, p_get_value_function);

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
        where  oak.attribute_code = upper(p_attribute_code)
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
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        select *
        into   l_attribute_row
        from   attribute_kind oak
        where  oak.attribute_code = upper(p_attribute_code);

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

    function read_attribute_domain(
        p_attribute_id in integer,
        p_raise_ndf in boolean default true)
    return attribute_domain%rowtype
    is
        l_attribute_domain_row attribute_domain%rowtype;
    begin
        select *
        into   l_attribute_domain_row
        from   attribute_domain d
        where  d.attribute_id = p_attribute_id;

        return l_attribute_domain_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Налаштування для отримання набору допустимих значень атрибуту з ідентифікатором {' ||
                                                 p_attribute_id || '} не знайдено');
             else return null;
             end if;
    end;

    function lock_attr_current_date(
        p_attribute_id in integer)
    return attribute_current_date%rowtype
    is
        l_attribute_current_date_row attribute_current_date%rowtype;
    begin
        select *
        into   l_attribute_current_date_row
        from   attribute_current_date t
        where  t.attribute_kind_id = p_attribute_id
        for update wait 900;

        return l_attribute_current_date_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_attribute_current_date(
        p_attribute_id in integer)
    return date
    is
        l_attribute_current_date date;
    begin
        select current_value_date
        into   l_attribute_current_date
        from   attribute_current_date t
        where  t.attribute_kind_id = p_attribute_id;

        return l_attribute_current_date;
    exception
        when no_data_found then
             return null;
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
        p_attribute_row in attribute_kind%rowtype)
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
               ' where ' || l_key_column_name || ' = :object_id';
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

    procedure check_for_value(
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

        if (p_attribute_type_code not in (attribute_utl.ATTR_TYPE_FIXED, attribute_utl.ATTR_TYPE_DYNAMIC, attribute_utl.ATTR_TYPE_CALCULATED)) then
            raise_application_error(-20000, 'Неочікуваний тип {' || p_attribute_row.attribute_type_id || '} атрибуту {' || p_attribute_row.attribute_name || '}');
        end if;
    end;

    procedure check_for_single_value(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code in varchar2)
    is
    begin
        check_for_value(p_attribute_row, p_valid_value_types, p_attribute_type_code);

        if (p_attribute_row.multi_values_flag = 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name || '} передбачає збереження множини значень - ' ||
                                            'для отримання результату, необхідно використовувати функцію, що повертає колекцію значень, а не одне значення');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and p_attribute_row.get_value_function is null) then
            raise_application_error(-20000, 'Функція отримання значення розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;
    end;

    procedure check_for_multi_values(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code in varchar2)
    is
    begin
        check_for_value(p_attribute_row, p_valid_value_types, p_attribute_type_code);

        if (p_attribute_row.multi_values_flag <> 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name || '} не передбачає збереження множинних значень');
        end if;

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and p_attribute_row.get_value_function is null) then
            raise_application_error(-20000, 'Функція отримання списку значень розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;
    end;

    procedure check_before_single_value(
        p_attribute_row in attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code in varchar2)
    is
    begin
        check_for_value(p_attribute_row, p_valid_value_types, p_attribute_type_code);

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and (p_attribute_row.set_value_procedures is null or p_attribute_row.set_value_procedures is empty)) then
            raise_application_error(-20000, 'Процедура встановлення значення розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;

        if (p_attribute_row.multi_values_flag = 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name || '} передбачає збереження одночасно декількох значень - ' ||
                                            'для встановлення його значення повинна використовуватись інша процедура');
        end if;
    end;

    procedure check_before_multi_values(
        p_attribute_row attribute_kind%rowtype,
        p_valid_value_types in number_list,
        p_attribute_type_code varchar2)
    is
    begin
        check_for_value(p_attribute_row, p_valid_value_types, p_attribute_type_code);

        if (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED and (p_attribute_row.set_value_procedures is null or p_attribute_row.set_value_procedures is empty)) then
            raise_application_error(-20000, 'Процедура встановлення значення розрахункового атрибуту {' || p_attribute_row.attribute_name || '} не вказана');
        end if;

        if (p_attribute_row.multi_values_flag <> 'Y') then
            raise_application_error(-20000, 'Атрибут {' || p_attribute_row.attribute_name ||
                                            '} не передбачає збереження одночасно декількох значень - ' ||
                                            'для встановлення його значення повинна використовуватись інша процедура');
        end if;
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
        p_values in string_list)
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
        if (tools.compare_range_borders(p_valid_from, p_valid_through) > 0) then
            raise_application_error(-20000, 'Дата початку дії значення {' || nvl(to_char(p_valid_from, 'dd.mm.yyyy'), 'не обмежено') ||
                                            '} атрибуту {' || p_attribute_row.attribute_name ||
                                            '} не може перевищувати дату завершення його дії {' ||
                                            nvl(to_char(p_valid_through, 'dd.mm.yyyy'), 'не обмежено') || '}');
        end if;
    end;

    procedure check_regular_expression(
        p_attribute_row in attribute_kind%rowtype,
        p_value in varchar2)
    is
        l_regular_expr_mismatch_expl varchar2(4000 byte);
    begin
        if (p_value is not null) then
            if (p_attribute_row.regular_expression is not null and not regexp_like(p_value, p_attribute_row.regular_expression)) then

                l_regular_expr_mismatch_expl := get_regexp_mismatch_expl(p_attribute_row.id);

                raise_application_error(-20000,
                                        'Значення {' || p_value ||
                                        '} атрибуту {' || p_attribute_row.attribute_name ||
                                        '} не відповідає формату (' || p_attribute_row.regular_expression || ')' ||
                                        case when l_regular_expr_mismatch_expl is null then null
                                             else ': ' || l_regular_expr_mismatch_expl
                                        end);
            end if;
        end if;
    end;

    procedure check_regular_expression(
        p_attribute_row in attribute_kind%rowtype,
        p_values in string_list)
    is
        l_regular_expr_mismatch_expl varchar2(4000 byte);
        l integer;
    begin
        if (p_values is not null and p_values is not empty) then
            if (p_attribute_row.regular_expression is not null) then

                l := p_values.first;
                while (l is not null) loop

                    if (p_values(l) is not null and not regexp_like(p_values(l), p_attribute_row.regular_expression)) then

                        l_regular_expr_mismatch_expl := get_regexp_mismatch_expl(p_attribute_row.id);

                        raise_application_error(-20000,
                                                'Значення ' || p_values(l) ||
                                                ' атрибуту ' || p_attribute_row.attribute_name ||
                                                ' не відповідає формату (' || p_attribute_row.regular_expression || ')' ||
                                                case when l_regular_expr_mismatch_expl is null then null
                                                     else ': ' || l_regular_expr_mismatch_expl
                                                end);
                    end if;
                end loop;
            end if;
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
                 raise_application_error(-20000, 'Запис в історії значень атрибуту з ідентифікатором {' || p_id || '} не знайдений');
             else return null;
             end if;
    end;
/*
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
*/
    function get_previous_history_id(
        p_history_row attribute_history%rowtype)
    return integer
    is
        l_history_id integer;
    begin
        select min(h.id) keep (dense_rank last order by h.id)
        into   l_history_id
        from   attribute_history h
        where  h.object_id = p_history_row.object_id and
               h.attribute_id = p_history_row.attribute_id and
               h.id < p_history_row.id and
               h.state_code = attribute_utl.HISTORY_STATE_ACTIVE;

         return l_history_id;
    end;
/*
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
        else
            return null;
        end if;
    end;

    function get_history_row_after_date(
        p_object_id in integer,
        p_attribute_id in integer,
        p_anchor_date in date)
    return attribute_history%rowtype
    is
        l_history_id integer;
    begin
        l_history_id := get_history_id_after_date(p_object_id, p_attribute_id, p_anchor_date);

        if (l_history_id is not null) then
            return read_history(l_history_id);
        else
            return null;
        end if;
    end;
*/
    function get_previous_history_row(
        p_history_row attribute_history%rowtype)
    return attribute_history%rowtype
    is
        l_history_id integer;
    begin
        l_history_id := get_previous_history_id(p_history_row);

        if (l_history_id is not null) then
            return read_history(l_history_id);
        else
            return null;
        end if;
    end;

    function get_attr_value(
        p_object_id in integer,
        p_attribute_id in integer)
    return attribute_value%rowtype
    is
        l_attribute_value_row attribute_value%rowtype;
    begin
        select *
        into   l_attribute_value_row
        from   attribute_value t
        where  t.object_id = p_object_id and
               t.attribute_id = p_attribute_id;

        return l_attribute_value_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_attr_small_value(
        p_object_id in integer,
        p_attribute_id in integer)
    return attribute_small_value%rowtype
    is
        l_attribute_value_row attribute_small_value%rowtype;
    begin
        select *
        into   l_attribute_value_row
        from   attribute_small_value t
        where  t.object_id = p_object_id and
               t.attribute_id = p_attribute_id;

        return l_attribute_value_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_attr_value_for_date(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date)
    return attribute_value_by_date%rowtype
    is
        l_attribute_value_row attribute_value_by_date%rowtype;
    begin
        select *
        into   l_attribute_value_row
        from   attribute_value_by_date t
        where  t.rowid = (select min(d.rowid) keep (dense_rank last order by d.value_date nulls first)
                          from   attribute_value_by_date d
                          where  d.object_id = p_object_id and
                                 d.attribute_id = p_attribute_id and
                                 tools.compare_range_borders(d.value_date, p_value_date) <= 0);

        return l_attribute_value_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_attr_value_after_date(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date)
    return attribute_value_by_date%rowtype
    is
        l_attribute_value_row attribute_value_by_date%rowtype;
    begin
        select *
        into   l_attribute_value_row
        from   attribute_value_by_date t
        where  t.rowid = (select min(d.rowid) keep (dense_rank first order by d.value_date nulls first)
                          from   attribute_value_by_date d
                          where  d.object_id = p_object_id and
                                 d.attribute_id = p_attribute_id and
                                 tools.compare_range_borders(d.value_date, p_value_date) > 0);

        return l_attribute_value_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_number_values_utl(
        p_nested_table_id in integer)
    return number_list
    is
        l_number_values number_list;
    begin
        select t.number_values
        bulk collect into l_number_values
        from   attribute_values t
        where  t.nested_table_id = p_nested_table_id;

        return l_number_values;
    end;

    function get_string_values_utl(
        p_nested_table_id in integer)
    return string_list
    is
        l_string_values string_list;
    begin
        select t.string_values
        bulk collect into l_string_values
        from   attribute_values t
        where  t.nested_table_id = p_nested_table_id;

        return l_string_values;
    end;

    function get_date_values_utl(
        p_nested_table_id in integer)
    return date_list
    is
        l_date_values date_list;
    begin
        select t.date_values
        bulk collect into l_date_values
        from   attribute_values t
        where  t.nested_table_id = p_nested_table_id;

        return l_date_values;
    end;

    function get_blob_values_utl(
        p_nested_table_id in integer)
    return blob_list
    is
        l_blob_values blob_list;
    begin
        select t.blob_values
        bulk collect into l_blob_values
        from   attribute_values t
        where  t.nested_table_id = p_nested_table_id;

        return l_blob_values;
    end;

    function get_clob_values_utl(
        p_nested_table_id in integer)
    return clob_list
    is
        l_clob_values clob_list;
    begin
        select t.clob_values
        bulk collect into l_clob_values
        from   attribute_values t
        where  t.nested_table_id = p_nested_table_id;

        return l_clob_values;
    end;

    function get_number_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return number
    is
        l_value number;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar2(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_value using p_object_id;
                exception
                    when no_data_found then
                         l_value := null;
                end;
            else
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).number_value;
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).number_value;
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_value := get_attr_small_value(p_object_id, p_attribute_row.id).number_value;
                else
                    l_value := get_attr_value(p_object_id, p_attribute_row.id).number_value;
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_number_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date)
    return number
    is
    begin
        return get_number_value(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_number_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date)
    return number
    is
    begin
        return get_number_value(p_object_id, read_attribute(p_attribute_code), p_value_date);
    end;

    function get_number_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return number_list
    is
        l_values number_list;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_multi_values(p_attribute_row,
                               number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST),
                               l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_values using p_object_id;
                exception
                    when no_data_found then
                         l_values := null;
                end;
            else
                l_values := get_number_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_values := get_number_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_values := get_number_values_utl(get_attr_small_value(p_object_id, p_attribute_row.id).nested_table_id);
                else
                    l_values := get_number_values_utl(get_attr_value(p_object_id, p_attribute_row.id).nested_table_id);
                end if;
            end if;
        end if;

        return l_values;
    end;

    function get_number_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return number_list
    is
    begin
        return get_number_values(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_number_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return number_list
    is
    begin
        return get_number_values(p_object_id, read_attribute(p_attribute_code), p_value_date);
    end;

    function get_string_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return varchar2
    is
        l_value varchar2(4000 byte);
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_STRING), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_value using p_object_id;
                exception
                    when no_data_found then
                         l_value := null;
                end;
            else
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).string_value;
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).string_value;
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_value := get_attr_small_value(p_object_id, p_attribute_row.id).string_value;
                else
                    l_value := get_attr_value(p_object_id, p_attribute_row.id).string_value;
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_string_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return varchar2
    is
    begin
        return get_string_value(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_string_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return varchar2
    is
    begin
        return get_string_value(p_object_id, read_attribute(p_attribute_code), p_value_date);
    end;

    function get_string_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return string_list
    is
        l_values string_list;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_STRING), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_values using p_object_id;
                exception
                    when no_data_found then
                         l_values := null;
                end;
            else
                l_values := get_string_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_values := get_string_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_values := get_string_values_utl(get_attr_small_value(p_object_id, p_attribute_row.id).nested_table_id);
                else
                    l_values := get_string_values_utl(get_attr_value(p_object_id, p_attribute_row.id).nested_table_id);
                end if;
            end if;
        end if;

        return l_values;
    end;

    function get_string_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return string_list
    is
    begin
        return get_string_values(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_string_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return string_list
    is
    begin
        return get_string_values(p_object_id, read_attribute(p_attribute_code), p_value_date);
    end;

    function get_date_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return date
    is
        l_value date;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    BEGIN
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_DATE), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_value using p_object_id;
                exception
                    when no_data_found then
                         l_value := null;
                end;
            else
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).date_value;
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).date_value;
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_value := get_attr_small_value(p_object_id, p_attribute_row.id).date_value;
                else
                    l_value := get_attr_value(p_object_id, p_attribute_row.id).date_value;
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_date_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return date
    is
    begin
        return get_date_value(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_date_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return date
    is
    begin
        return get_date_value(p_object_id, read_attribute(p_attribute_code), p_value_date);

    end;

    function get_date_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return date_list
    is
        l_values date_list;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_DATE), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_values using p_object_id;
                exception
                    when no_data_found then
                         l_values := null;
                end;
            else
                l_values := get_date_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_values := get_date_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_values := get_date_values_utl(get_attr_small_value(p_object_id, p_attribute_row.id).nested_table_id);
                else
                    l_values := get_date_values_utl(get_attr_value(p_object_id, p_attribute_row.id).nested_table_id);
                end if;
            end if;
        end if;

        return l_values;
    end;

    function get_date_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return date_list
    is
    begin
        return get_date_values(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_date_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return date_list
    is
    begin
        return get_date_values(p_object_id, read_attribute(p_attribute_code), p_value_date);

    end;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return blob
    is
        l_value blob;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_BLOB), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_value using p_object_id;
                exception
                    when no_data_found then
                         l_value := null;
                end;
            else
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).blob_value;
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).blob_value;
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_value := get_attr_small_value(p_object_id, p_attribute_row.id).blob_value;
                else
                    l_value := get_attr_value(p_object_id, p_attribute_row.id).blob_value;
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return blob
    is
    begin
        return get_blob_value(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_blob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return blob
    is
    begin
        return get_blob_value(p_object_id, read_attribute(p_attribute_code), p_value_date);
    end;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return blob_list
    is
        l_values blob_list;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_BLOB), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_values using p_object_id;
                exception
                    when no_data_found then
                         l_values := null;
                end;
            else
                l_values := get_blob_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_values := get_blob_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_values := get_blob_values_utl(get_attr_small_value(p_object_id, p_attribute_row.id).nested_table_id);
                else
                    l_values := get_blob_values_utl(get_attr_value(p_object_id, p_attribute_row.id).nested_table_id);
                end if;
            end if;
        end if;

        return l_values;
    end;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return blob_list
    is
    begin
        return get_blob_values(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_blob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return blob_list
    is
    begin
        return get_blob_values(p_object_id, read_attribute(p_attribute_code), p_value_date);
    end;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return clob
    is
        l_value clob;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_CLOB), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_value, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_value using p_object_id;
                exception
                    when no_data_found then
                         l_value := null;
                end;
            else
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).clob_value;
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_value := get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).clob_value;
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_value := get_attr_small_value(p_object_id, p_attribute_row.id).clob_value;
                else
                    l_value := get_attr_value(p_object_id, p_attribute_row.id).clob_value;
                end if;
            end if;
        end if;

        return l_value;
    end;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return clob
    is
    begin
        return get_clob_value(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_clob_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return clob
    is
    begin
        return get_clob_value(p_object_id, read_attribute(p_attribute_code), p_value_date);
    end;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value_date in date)
    return clob_list
    is
        l_values clob_list;
        l_statement varchar2(32767 byte);
        l_attribute_type_code varchar(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_for_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_CLOB), l_attribute_type_code);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            l_statement := 'begin :result := ' || p_attribute_row.get_value_function || '(:object_id, :attribute_id, :p_value_date); end;';

            execute immediate l_statement
            using out l_values, p_object_id, p_attribute_row.id, p_value_date;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'N' or get_attribute_current_date(p_attribute_row.id) = trunc(p_value_date)) then
                begin
                    execute immediate get_fixed_attribute_statement(p_attribute_row)
                    into l_values using p_object_id;
                exception
                    when no_data_found then
                         l_values := null;
                end;
            else
                l_values := get_clob_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                l_values := get_clob_values_utl(get_attr_value_for_date(p_object_id, p_attribute_row.id, p_value_date).nested_table_id);
            else
                if (p_attribute_row.small_value_flag = 'Y') then
                    l_values := get_clob_values_utl(get_attr_small_value(p_object_id, p_attribute_row.id).nested_table_id);
                else
                    l_values := get_clob_values_utl(get_attr_value(p_object_id, p_attribute_row.id).nested_table_id);
                end if;
            end if;
        end if;

        return l_values;
    end;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value_date in date default trunc(sysdate))
    return clob_list
    is
    begin
        return get_clob_values(p_object_id, read_attribute(p_attribute_id), p_value_date);
    end;

    function get_clob_values(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value_date in date default trunc(sysdate))
    return clob_list
    is
    begin
        return get_clob_values(p_object_id, read_attribute(p_attribute_code), p_value_date);
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
    procedure track_attribute_history(
        p_history_id in integer,
        p_state_code in char,
        p_comment in varchar2)
    is
    begin
        tools.hide_hint(p_history_id);
        tools.hide_hint(p_state_code);
        tools.hide_hint(p_comment);
/*
        insert into attribute_history_tracking
        values (s_attribute_history_tracking.nextval, p_history_id, p_state_code, bars_login.current_user_id(), sysdate, p_comment);
*/
    end;

    procedure create_history_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_number_value in number default null,
        p_string_value in varchar2 default null,
        p_date_value in date default null,
        p_blob_value in blob default null,
        p_clob_value in clob default null,
        p_nested_table_id in integer default null,
        p_state_code in char default attribute_utl.HISTORY_STATE_ACTIVE,
        p_comment in varchar2 default null)
    is
        l_history_id integer;
    begin
        insert into attribute_history
        values (s_attribute_history.nextval,
                p_attribute_id,
                p_object_id,
                p_valid_from,
                p_valid_through,
                p_number_value,
                p_string_value,
                p_date_value,
                p_blob_value,
                p_clob_value,
                p_nested_table_id,
                p_state_code,
                user_id(),
                sysdate,
                p_comment)
        returning id
        into l_history_id;

        -- track_attribute_history(l_history_id, p_state_code, p_comment);
/*
        if (p_operation_id is not null) then
            link_history_to_operation(l_history_id, p_operation_id);
        end if;
*/
    end create_history_utl;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in number)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in varchar2)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in date)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in blob)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in clob)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in number_list)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in string_list)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in date_list)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in blob_list)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure set_fixed_attribute_value(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_value in clob_list)
    is
    begin
        execute immediate set_fixed_attribute_statement(p_attribute_row)
        using p_value, p_object_id;

        if (sql%rowcount = 0) then
            raise_application_error(-20000, 'Об''єкт типу {' || object_utl.get_object_type_name(p_attribute_row.object_type_id) ||
                                            '} з ідентифікатором {' || p_object_id || '} не знайдений');
        end if;
    end;

    procedure clear_attribute_values_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_small_value_flag in char)
    is
    begin
        if (p_small_value_flag = 'Y') then
            delete attribute_small_value a
            where  a.object_id = p_object_id and
                   a.attribute_id = p_attribute_id;
        else
            delete attribute_value a
            where  a.object_id = p_object_id and
                   a.attribute_id = p_attribute_id;
        end if;
    end;

    procedure set_attribute_value_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_small_value_flag in char,
        p_number_value in number default null,
        p_string_value in varchar2 default null,
        p_date_value in date default null,
        p_blob_value in blob default null,
        p_clob_value in clob default null,
        p_nested_table_id in integer default null)
    is
        l_value_is_empty boolean;
    begin
        l_value_is_empty := (p_number_value    is null) and
                            (p_string_value    is null) and
                            (p_date_value      is null) and
                            (p_blob_value      is null) and
                            (p_clob_value      is null) and
                            (p_nested_table_id is null);

        if (l_value_is_empty) then
            clear_attribute_values_utl(p_object_id, p_attribute_id, p_small_value_flag);
        else
            if (p_small_value_flag = 'Y') then
                update attribute_small_value a
                set    a.number_value       = p_number_value,
                       a.string_value       = p_string_value,
                       a.date_value         = p_date_value,
                       a.blob_value         = p_blob_value,
                       a.clob_value         = p_clob_value,
                       a.nested_table_id    = p_nested_table_id
                where  a.object_id          = p_object_id and
                       a.attribute_id       = p_attribute_id;

                if (sql%rowcount = 0) then
                    insert into attribute_small_value
                    values (p_attribute_id,
                            p_object_id,
                            p_number_value,
                            p_string_value,
                            p_date_value,
                            p_blob_value,
                            p_clob_value,
                            p_nested_table_id);
                end if;
            else
                update attribute_value a
                set    a.number_value       = p_number_value,
                       a.string_value       = p_string_value,
                       a.date_value         = p_date_value,
                       a.blob_value         = p_blob_value,
                       a.clob_value         = p_clob_value,
                       a.nested_table_id    = p_nested_table_id
                where  a.object_id          = p_object_id and
                       a.attribute_id       = p_attribute_id;

                if (sql%rowcount = 0) then
                    insert into attribute_value
                    values (p_attribute_id,
                            p_object_id,
                            p_number_value,
                            p_string_value,
                            p_date_value,
                            p_blob_value,
                            p_clob_value,
                            p_nested_table_id);
                end if;
            end if;
        end if;
    end;

    function create_nested_table_item(
        p_values in number_list)
    return integer
    is
        l_nested_table_id integer;
    begin
        if (p_values is null or p_values is empty) then
            return null;
        end if;

        l_nested_table_id := s_attribute_values.nextval;

        insert into attribute_values(nested_table_id, number_values)
        select l_nested_table_id, column_value
        from   table(p_values);

        return l_nested_table_id;
    end;

    function create_nested_table_item(
        p_values in string_list)
    return integer
    is
        l_nested_table_id integer;
    begin
        if (p_values is null or p_values is empty) then
            return null;
        end if;

        l_nested_table_id := s_attribute_values.nextval;

        insert into attribute_values(nested_table_id, string_values)
        select l_nested_table_id, column_value
        from   table(p_values);

        return l_nested_table_id;
    end;

    function create_nested_table_item(
        p_values in date_list)
    return integer
    is
        l_nested_table_id integer;
    begin
        if (p_values is null or p_values is empty) then
            return null;
        end if;

        l_nested_table_id := s_attribute_values.nextval;

        insert into attribute_values(nested_table_id, date_values)
        select l_nested_table_id, column_value
        from   table(p_values);

        return l_nested_table_id;
    end;

    function create_nested_table_item(
        p_values in blob_list)
    return integer
    is
        l_nested_table_id integer;
    begin
        if (p_values is null or p_values is empty) then
            return null;
        end if;

        l_nested_table_id := s_attribute_values.nextval;

        insert into attribute_values(nested_table_id, blob_values)
        select l_nested_table_id, column_value
        from   table(p_values);

        return l_nested_table_id;
    end;

    function create_nested_table_item(
        p_values in clob_list)
    return integer
    is
        l_nested_table_id integer;
    begin
        if (p_values is null or p_values is empty) then
            return null;
        end if;

        l_nested_table_id := s_attribute_values.nextval;

        insert into attribute_values(nested_table_id, clob_values)
        select l_nested_table_id, column_value
        from   table(p_values);

        return l_nested_table_id;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_value in number)
    is
        type t_date_value is record ( value_date date, value number );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_date_values t_date_values;
        l_date_values_aa t_date_values_aa;
        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed date_list := date_list();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;
        l_item_after_valid_thr_date t_date_value;

        l_prev_value number;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.number_value
        bulk collect into l_date_values
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        -- визначаємо елементи, що потрапляють в період дії нового значення
        -- такі значення додаємо до масиву значень, що видаляються з історії оскільки нове значення перекриває собою періоди їх дії.
        -- якщо дата завершення дії нового значення вказана (тобто нове значення діє не до "плюс нескінченності"), визначаємо значення,
        -- що діяло на цей момент і це значення продовжить діяти з дати наступної за датою завершення дії нового значення (p_valid_through + 1)
        l := l_date_values.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_date_values(l).value_date) <= 0 and
                    tools.compare_range_borders(l_date_values(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values(l).value_date;

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_date_values(l).value_date)) then
                    l_item_after_valid_thr_date := l_date_values(l);
                end if;
            else
                l_date_values_aa(tools.date_to_number(l_date_values(l).value_date, p_replace_null_with_this_value => -1)) := l_date_values(l);
            end if;

            l := l_date_values.next(l);
        end loop;

        -- підготуємо записи з датами початку і завершення дії нового значення атрибуту та помістимо їх до масиву елементів,
        -- що підлягають вставці
        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.value := p_value;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_date_values_aa(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            l_valid_through_item.value_date := p_valid_through + 1;
            l_valid_through_item.value := l_item_after_valid_thr_date.value;

            -- якщо на дату, наступну за датою завершення дії нового значення, вже існує наступний запис із власним значенням,
            -- це значення продовжує діяти. Інакше додаємо запис зі значенням, що буде діяти після дати завершення нового значення
            if (not l_date_values_aa.exists(l_numeric_date)) then
                l_date_values_aa(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        -- нормалізація значень в періодах - позбуваємося подвійних періодів з однаковим значенням і різними датами початку дії
        -- цього значення - об'єднуємо періоди за значенням
        d := l_date_values_aa.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_date_values_aa(d).value) = 0) then
                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values_aa(d).value_date;
                -- якщо періоди, що зливаються в один, зачіпають дату початку або дату завершення дії значення = їх, окрім видалення
                -- з загального масиву елементів (l_date_values_aa), також необхідно прибрати з масиву елементів для вставки
                -- (якщо вони були внесені туди в попередній частині процедури)
                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_date_values_aa(d).value;
            d := l_date_values_aa.next(d);
        end loop;

        -- видаляємо записи за дати, що перекриваються новим періодом дії значення
        if (l_items_to_be_removed is not empty) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i) or
                           (t.value_date is null and l_items_to_be_removed(i) is null));
        end if;

        -- вставляємо записи на дату початку дії значення, та на дату наступну після завершення періоду дії (якщо такий вказаний)
        if (l_items_to_be_inserted_aa.count() > 0) then

            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, number_value)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).value);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_values in number_list,
        p_nested_table_id in integer)
    is
        type t_date_value is record ( value_date date, nested_table_id integer, value number_list );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_original_data t_date_values;
        l_working_set t_date_values_aa;

        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed date_list := date_list();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;

        l_item_after_valid_thr_date t_date_value;

        l_prev_value number_list;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        -- повторюємо для масиву чисел той самий процес, що й для скалярного значення типу number
        -- з особливостями перетворень між anydata та number_list
        select t.value_date, t.nested_table_id,
               (select cast(collect(number_values) as number_list)
                from   attribute_values v
                where  v.nested_table_id = t.nested_table_id)
        bulk collect into l_original_data
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_original_data.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_original_data(l).value_date) <= 0 and
                    tools.compare_range_borders(l_original_data(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_original_data(l).value_date;

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_original_data(l).value_date)) then
                    l_item_after_valid_thr_date := l_original_data(l);
                end if;
            else
                l_numeric_date := tools.date_to_number(l_original_data(l).value_date, p_replace_null_with_this_value => -1);
                l_working_set(l_numeric_date) := l_original_data(l);
            end if;

            l := l_original_data.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.nested_table_id := p_nested_table_id;
        l_valid_from_item.value := p_values;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_working_set(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            if (not l_working_set.exists(l_numeric_date)) then
                l_valid_through_item.value_date := p_valid_through + 1;
                l_valid_through_item.nested_table_id := l_item_after_valid_thr_date.nested_table_id;
                l_valid_through_item.value := l_item_after_valid_thr_date.value;

                l_working_set(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_working_set.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_working_set(d).value) = 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_working_set(d).value_date;

                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_working_set(d).value;
            d := l_working_set.next(d);
        end loop;

        if (l_items_to_be_removed is not empty) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i) or
                           (t.value_date is null and l_items_to_be_removed(i) is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then
            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, nested_table_id)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).nested_table_id);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_value in varchar2)
    is
        type t_date_value is record ( value_date date, value varchar2(4000 byte) );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_date_values t_date_values;
        l_date_values_aa t_date_values_aa;

        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed date_list := date_list();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;
        l_item_after_valid_thr_date t_date_value;

        l_prev_value varchar2(4000 byte);
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.string_value
        bulk collect into l_date_values
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_date_values.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_date_values(l).value_date) <= 0 and
                    tools.compare_range_borders(l_date_values(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values(l).value_date;

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_date_values(l).value_date)) then
                    l_item_after_valid_thr_date := l_date_values(l);
                end if;
            else
                l_date_values_aa(tools.date_to_number(l_date_values(l).value_date, p_replace_null_with_this_value => -1)) := l_date_values(l);
            end if;

            l := l_date_values.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.value := p_value;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_date_values_aa(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            l_valid_through_item.value_date := p_valid_through + 1;
            l_valid_through_item.value := l_item_after_valid_thr_date.value;

            if (not l_date_values_aa.exists(l_numeric_date)) then
                l_date_values_aa(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_date_values_aa.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_date_values_aa(d).value) = 0) then
                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values_aa(d).value_date;

                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_date_values_aa(d).value;
            d := l_date_values_aa.next(d);
        end loop;

        if (l_items_to_be_removed is not empty) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i) or
                           (t.value_date is null and l_items_to_be_removed(i) is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then

            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, string_value)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).value);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_values in string_list,
        p_nested_table_id in integer)
    is
        type t_date_value is record ( value_date date, nested_table_id integer, value string_list );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_original_data t_date_values;
        l_working_set t_date_values_aa;

        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed date_list := date_list();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;

        l_item_after_valid_thr_date t_date_value;

        l_prev_value string_list;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.nested_table_id,
               (select cast(collect(string_values) as string_list)
                from   attribute_values v
                where  v.nested_table_id = t.nested_table_id)
        bulk collect into l_original_data
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_original_data.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_original_data(l).value_date) <= 0 and
                    tools.compare_range_borders(l_original_data(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_original_data(l).value_date;

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_original_data(l).value_date)) then
                    l_item_after_valid_thr_date := l_original_data(l);
                end if;
            else
                l_numeric_date := tools.date_to_number(l_original_data(l).value_date, p_replace_null_with_this_value => -1);
                l_working_set(l_numeric_date) := l_original_data(l);
            end if;

            l := l_original_data.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.nested_table_id := p_nested_table_id;
        l_valid_from_item.value := p_values;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_working_set(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            if (not l_working_set.exists(l_numeric_date)) then
                l_valid_through_item.value_date := p_valid_through + 1;
                l_valid_through_item.nested_table_id := l_item_after_valid_thr_date.nested_table_id;
                l_valid_through_item.value := l_item_after_valid_thr_date.value;

                l_working_set(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_working_set.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_working_set(d).value) = 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_working_set(d).value_date;

                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_working_set(d).value;
            d := l_working_set.next(d);
        end loop;

        if (l_items_to_be_removed is not empty) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i) or
                           (t.value_date is null and l_items_to_be_removed(i) is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then
            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, nested_table_id)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).nested_table_id);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_value in date)
    is
        type t_date_value is record ( value_date date, value date );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_date_values t_date_values;
        l_date_values_aa t_date_values_aa;
        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed t_date_values := t_date_values();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;
        l_item_after_valid_thr_date t_date_value;

        l_prev_value date;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.date_value
        bulk collect into l_date_values
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_date_values.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_date_values(l).value_date) <= 0 and
                    tools.compare_range_borders(l_date_values(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values(l);

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_date_values(l).value_date)) then
                    l_item_after_valid_thr_date := l_date_values(l);
                end if;
            else
                l_date_values_aa(tools.date_to_number(l_date_values(l).value_date, p_replace_null_with_this_value => -1)) := l_date_values(l);
            end if;

            l := l_date_values.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.value := p_value;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_date_values_aa(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            l_valid_through_item.value_date := p_valid_through + 1;
            l_valid_through_item.value := l_item_after_valid_thr_date.value;

            if (not l_date_values_aa.exists(l_numeric_date)) then
                l_date_values_aa(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_date_values_aa.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_date_values_aa(d).value) = 0) then
                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values_aa(d);
                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_date_values_aa(d).value;
            d := l_date_values_aa.next(d);
        end loop;

        if (l_items_to_be_removed.count() > 0) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i).value_date or
                           (t.value_date is null and l_items_to_be_removed(i).value_date is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then

            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, date_value)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).value);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_values in date_list,
        p_nested_table_id in integer)
    is
        type t_date_value is record ( value_date date, nested_table_id integer, value date_list );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_original_data t_date_values;
        l_working_set t_date_values_aa;

        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed date_list := date_list();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;

        l_item_after_valid_thr_date t_date_value;

        l_prev_value date_list;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.nested_table_id,
               (select cast(collect(date_values) as date_list)
                from   attribute_values v
                where  v.nested_table_id = t.nested_table_id)
        bulk collect into l_original_data
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_original_data.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_original_data(l).value_date) <= 0 and
                    tools.compare_range_borders(l_original_data(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_original_data(l).value_date;

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_original_data(l).value_date)) then
                    l_item_after_valid_thr_date := l_original_data(l);
                end if;
            else
                l_numeric_date := tools.date_to_number(l_original_data(l).value_date, p_replace_null_with_this_value => -1);
                l_working_set(l_numeric_date) := l_original_data(l);
            end if;

            l := l_original_data.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.nested_table_id := p_nested_table_id;
        l_valid_from_item.value := p_values;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_working_set(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            if (not l_working_set.exists(l_numeric_date)) then
                l_valid_through_item.value_date := p_valid_through + 1;
                l_valid_through_item.nested_table_id := l_item_after_valid_thr_date.nested_table_id;
                l_valid_through_item.value := l_item_after_valid_thr_date.value;

                l_working_set(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_working_set.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_working_set(d).value) = 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_working_set(d).value_date;

                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_working_set(d).value;
            d := l_working_set.next(d);
        end loop;

        if (l_items_to_be_removed is not empty) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i) or
                           (t.value_date is null and l_items_to_be_removed(i) is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then
            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, nested_table_id)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).nested_table_id);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_value in blob)
    is
        type t_date_value is record ( value_date date, value blob );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_date_values t_date_values;
        l_date_values_aa t_date_values_aa;
        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed t_date_values := t_date_values();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;
        l_item_after_valid_thr_date t_date_value;

        l_prev_value blob;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.blob_value
        bulk collect into l_date_values
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_date_values.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_date_values(l).value_date) <= 0 and
                    tools.compare_range_borders(l_date_values(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values(l);

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_date_values(l).value_date)) then
                    l_item_after_valid_thr_date := l_date_values(l);
                end if;
            else
                l_date_values_aa(tools.date_to_number(l_date_values(l).value_date, p_replace_null_with_this_value => -1)) := l_date_values(l);
            end if;

            l := l_date_values.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.value := p_value;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_date_values_aa(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            l_valid_through_item.value_date := p_valid_through + 1;
            l_valid_through_item.value := l_item_after_valid_thr_date.value;

            if (not l_date_values_aa.exists(l_numeric_date)) then
                l_date_values_aa(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_date_values_aa.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_date_values_aa(d).value) = 0) then
                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values_aa(d);
                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_date_values_aa(d).value;
            d := l_date_values_aa.next(d);
        end loop;

        if (l_items_to_be_removed.count() > 0) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i).value_date or
                           (t.value_date is null and l_items_to_be_removed(i).value_date is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then

            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, blob_value)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).value);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_values in blob_list,
        p_nested_table_id in integer)
    is
        type t_date_value is record ( value_date date, nested_table_id integer, value blob_list );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_original_data t_date_values;
        l_working_set t_date_values_aa;

        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed date_list := date_list();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;

        l_item_after_valid_thr_date t_date_value;

        l_prev_value blob_list;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.nested_table_id,
               (select cast(collect(blob_values) as blob_list)
                from   attribute_values v
                where  v.nested_table_id = t.nested_table_id)
        bulk collect into l_original_data
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_original_data.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_original_data(l).value_date) <= 0 and
                    tools.compare_range_borders(l_original_data(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_original_data(l).value_date;

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_original_data(l).value_date)) then
                    l_item_after_valid_thr_date := l_original_data(l);
                end if;
            else
                l_numeric_date := tools.date_to_number(l_original_data(l).value_date, p_replace_null_with_this_value => -1);
                l_working_set(l_numeric_date) := l_original_data(l);
            end if;

            l := l_original_data.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.nested_table_id := p_nested_table_id;
        l_valid_from_item.value := p_values;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_working_set(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            if (not l_working_set.exists(l_numeric_date)) then
                l_valid_through_item.value_date := p_valid_through + 1;
                l_valid_through_item.nested_table_id := l_item_after_valid_thr_date.nested_table_id;
                l_valid_through_item.value := l_item_after_valid_thr_date.value;

                l_working_set(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_working_set.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_working_set(d).value) = 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_working_set(d).value_date;

                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_working_set(d).value;
            d := l_working_set.next(d);
        end loop;

        if (l_items_to_be_removed is not empty) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i) or
                           (t.value_date is null and l_items_to_be_removed(i) is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then
            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, nested_table_id)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).nested_table_id);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_value in clob)
    is
        type t_date_value is record ( value_date date, value clob );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_date_values t_date_values;
        l_date_values_aa t_date_values_aa;
        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed t_date_values := t_date_values();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;
        l_item_after_valid_thr_date t_date_value;

        l_prev_value clob;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.clob_value
        bulk collect into l_date_values
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_date_values.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_date_values(l).value_date) <= 0 and
                    tools.compare_range_borders(l_date_values(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values(l);

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_date_values(l).value_date)) then
                    l_item_after_valid_thr_date := l_date_values(l);
                end if;
            else
                l_date_values_aa(tools.date_to_number(l_date_values(l).value_date, p_replace_null_with_this_value => -1)) := l_date_values(l);
            end if;

            l := l_date_values.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.value := p_value;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_date_values_aa(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            l_valid_through_item.value_date := p_valid_through + 1;
            l_valid_through_item.value := l_item_after_valid_thr_date.value;

            if (not l_date_values_aa.exists(l_numeric_date)) then
                l_date_values_aa(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_date_values_aa.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_date_values_aa(d).value) = 0) then
                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_date_values_aa(d);
                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_date_values_aa(d).value;
            d := l_date_values_aa.next(d);
        end loop;

        if (l_items_to_be_removed.count() > 0) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i).value_date or
                           (t.value_date is null and l_items_to_be_removed(i).value_date is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then

            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, clob_value)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).value);
        end if;
    end;

    procedure set_value_for_date_utl(
        p_object_id in integer,
        p_attribute_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_values in clob_list,
        p_nested_table_id in integer)
    is
        type t_date_value is record ( value_date date, nested_table_id integer, value clob_list );
        type t_date_values is table of t_date_value;
        type t_date_values_aa is table of t_date_value index by pls_integer;

        l_original_data t_date_values;
        l_working_set t_date_values_aa;

        l_items_to_be_inserted_aa t_date_values_aa;
        l_items_to_be_inserted t_date_values;
        l_items_to_be_removed date_list := date_list();

        l_valid_from_item t_date_value;
        l_valid_through_item t_date_value;

        l_item_after_valid_thr_date t_date_value;

        l_prev_value clob_list;
        l_numeric_date integer;
        l pls_integer;
        d pls_integer;
    begin
        select t.value_date, t.nested_table_id,
               (select cast(collect(clob_values) as clob_list)
                from   attribute_values v
                where  v.nested_table_id = t.nested_table_id)
        bulk collect into l_original_data
        from   attribute_value_by_date t
        where  t.attribute_id = p_attribute_id and
               t.object_id = p_object_id
        for update wait 60;

        l := l_original_data.first;
        while (l is not null) loop
            if (tools.compare_range_borders(p_valid_from, l_original_data(l).value_date) <= 0 and
                    tools.compare_range_borders(l_original_data(l).value_date, p_valid_through) <= 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_original_data(l).value_date;

                if (p_valid_through is not null and
                    (l_item_after_valid_thr_date.value_date is null or
                     l_item_after_valid_thr_date.value_date <= l_original_data(l).value_date)) then
                    l_item_after_valid_thr_date := l_original_data(l);
                end if;
            else
                l_numeric_date := tools.date_to_number(l_original_data(l).value_date, p_replace_null_with_this_value => -1);
                l_working_set(l_numeric_date) := l_original_data(l);
            end if;

            l := l_original_data.next(l);
        end loop;

        l_valid_from_item.value_date := p_valid_from;
        l_valid_from_item.nested_table_id := p_nested_table_id;
        l_valid_from_item.value := p_values;

        l_numeric_date := tools.date_to_number(p_valid_from, p_replace_null_with_this_value => -1);
        l_working_set(l_numeric_date) := l_valid_from_item;
        l_items_to_be_inserted_aa(l_numeric_date) := l_valid_from_item;

        if (p_valid_through is not null) then
            l_numeric_date := tools.date_to_number(p_valid_through + 1, p_replace_null_with_this_value => -1);

            if (not l_working_set.exists(l_numeric_date)) then
                l_valid_through_item.value_date := p_valid_through + 1;
                l_valid_through_item.nested_table_id := l_item_after_valid_thr_date.nested_table_id;
                l_valid_through_item.value := l_item_after_valid_thr_date.value;

                l_working_set(l_numeric_date) := l_valid_through_item;
                if (not l_items_to_be_inserted_aa.exists(l_numeric_date)) then
                    l_items_to_be_inserted_aa(l_numeric_date) := l_valid_through_item;
                end if;
            end if;
        end if;

        d := l_working_set.first;
        while (d is not null) loop
            if (tools.compare(l_prev_value, l_working_set(d).value) = 0) then

                l_items_to_be_removed.extend(1);
                l_items_to_be_removed(l_items_to_be_removed.last) := l_working_set(d).value_date;

                if (l_items_to_be_inserted_aa.exists(d)) then
                    l_items_to_be_inserted_aa.delete(d);
                end if;
            end if;
            l_prev_value := l_working_set(d).value;
            d := l_working_set.next(d);
        end loop;

        if (l_items_to_be_removed is not empty) then
            forall i in indices of l_items_to_be_removed
                delete attribute_value_by_date t
                where  t.attribute_id = p_attribute_id and
                       t.object_id = p_object_id and
                       (t.value_date = l_items_to_be_removed(i) or
                           (t.value_date is null and l_items_to_be_removed(i) is null));
        end if;

        if (l_items_to_be_inserted_aa.count() > 0) then
            l_items_to_be_inserted := t_date_values();
            l_items_to_be_inserted.extend(l_items_to_be_inserted_aa.count());

            l_numeric_date := l_items_to_be_inserted_aa.first;
            for i in 1..l_items_to_be_inserted_aa.count() loop
                l_items_to_be_inserted(i) := l_items_to_be_inserted_aa(l_numeric_date);
                l_numeric_date := l_items_to_be_inserted_aa.next(l_numeric_date);
            end loop;

            forall i in indices of l_items_to_be_inserted
                insert into attribute_value_by_date(attribute_id, object_id, value_date, nested_table_id)
                values (p_attribute_id, p_object_id, l_items_to_be_inserted(i).value_date, l_items_to_be_inserted(i).nested_table_id);
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_value in number,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_values in number_list,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_value in varchar2,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_values in string_list,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_value in date,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_values in date_list,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_value in blob,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_values in blob_list,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_value in clob,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_value, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
        end if;
    end;

    procedure call_set_value_handler(
        p_attribute_row in attribute_kind%rowtype,
        p_object_id in integer,
        p_values in clob_list,
        p_valid_from in date,
        p_valid_through in date)
    is
        l integer;
    begin
        if (p_attribute_row.set_value_procedures is not null and p_attribute_row.set_value_procedures is not empty) then
            l := p_attribute_row.set_value_procedures.first;
            while (l is not null) loop
                execute immediate 'begin ' ||
                                   p_attribute_row.set_value_procedures(l) ||
                                   '(:p_object_id, :p_attribute_id, :p_new_value, :p_valid_from, :p_valid_through); end;'
                using p_object_id, p_attribute_row.id, p_values, p_valid_from, p_valid_through;

                l := p_attribute_row.set_value_procedures.next(l);
            end loop;
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
        l_attribute_type_code varchar(30 char);
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_single_value(p_attribute_row,
                                  number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST),
                                  l_attribute_type_code);

        check_list_attribute(p_attribute_row, p_value);

        check_domain_attribute(p_attribute_row, p_value);

        call_set_value_handler(p_attribute_row, p_object_id, p_value, p_valid_from, p_valid_through);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_number_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_number_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);
            else
                set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_number_value => p_value);
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
        l_attribute_type_code varchar(30 char);
        l_nested_table_id integer;
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_multi_values(p_attribute_row,
                                  number_list(attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST),
                                  l_attribute_type_code);

        check_list_attribute(p_attribute_row, p_values);

        check_domain_attribute(p_attribute_row, p_values);

        call_set_value_handler(p_attribute_row, p_object_id, p_values, p_valid_from, p_valid_through);

        l_nested_table_id := create_nested_table_item(p_values);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);
            else
                if (p_values is null or p_values is empty) then
                    clear_attribute_values_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag);
                else
                    set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_nested_table_id => l_nested_table_id);
                end if;
            end if;
        end if;

        if (p_attribute_row.save_history_flag = 'Y') then
          create_history_utl(p_object_id,
                             p_attribute_row.id,
                             p_valid_from,
                             p_valid_through,
                             p_nested_table_id => l_nested_table_id,
                             p_comment => p_comment);
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
        l_attribute_type_code varchar(30 char);
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        check_regular_expression(p_attribute_row, p_value);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_STRING), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        call_set_value_handler(p_attribute_row, p_object_id, p_value, p_valid_from, p_valid_through);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_string_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_string_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);
            else
                set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_string_value => p_value);
            end if;
        end if;
    end;

    procedure set_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_values in string_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
        l_attribute_type_code varchar(30 char);
        l_nested_table_id integer;
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        check_regular_expression(p_attribute_row, p_values);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_STRING), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        call_set_value_handler(p_attribute_row, p_object_id, p_values, p_valid_from, p_valid_through);

        l_nested_table_id := create_nested_table_item(p_values);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);
            else
                if (p_values is null or p_values is empty) then
                    clear_attribute_values_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag);
                else
                    set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_nested_table_id => l_nested_table_id);
                end if;
            end if;
        end if;

        if (p_attribute_row.save_history_flag = 'Y') then
          create_history_utl(p_object_id,
                             p_attribute_row.id,
                             p_valid_from,
                             p_valid_through,
                             p_nested_table_id => l_nested_table_id,
                             p_comment => p_comment);
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
        l_attribute_type_code varchar(30 char);
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_DATE), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        call_set_value_handler(p_attribute_row, p_object_id, p_value, p_valid_from, p_valid_through);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_date_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_date_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);
            else
                set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_date_value => p_value);
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
        l_attribute_type_code varchar(30 char);
        l_nested_table_id integer;
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_DATE), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        call_set_value_handler(p_attribute_row, p_object_id, p_values, p_valid_from, p_valid_through);

        l_nested_table_id := create_nested_table_item(p_values);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);
            else
                if (p_values is null or p_values is empty) then
                    clear_attribute_values_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag);
                else
                    set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_nested_table_id => l_nested_table_id);
                end if;
            end if;
        end if;

        if (p_attribute_row.save_history_flag = 'Y') then
          create_history_utl(p_object_id,
                             p_attribute_row.id,
                             p_valid_from,
                             p_valid_through,
                             p_nested_table_id => l_nested_table_id,
                             p_comment => p_comment);
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
        l_attribute_type_code varchar(30 char);
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_BLOB), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        call_set_value_handler(p_attribute_row, p_object_id, p_value, p_valid_from, p_valid_through);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_blob_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_blob_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);
            else
                set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_blob_value => p_value);
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
        l_attribute_type_code varchar(30 char);
        l_nested_table_id integer;
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_BLOB), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        call_set_value_handler(p_attribute_row, p_object_id, p_values, p_valid_from, p_valid_through);

        l_nested_table_id := create_nested_table_item(p_values);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);
            else
                if (p_values is null or p_values is empty) then
                    clear_attribute_values_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag);
                else
                    set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_nested_table_id => l_nested_table_id);
                end if;
            end if;
        end if;

        if (p_attribute_row.save_history_flag = 'Y') then
          create_history_utl(p_object_id,
                             p_attribute_row.id,
                             p_valid_from,
                             p_valid_through,
                             p_nested_table_id => l_nested_table_id,
                             p_comment => p_comment);
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
        l_attribute_type_code varchar(30 char);
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_single_value(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_CLOB), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_value);

        call_set_value_handler(p_attribute_row, p_object_id, p_value, p_valid_from, p_valid_through);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_clob_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_value);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.save_history_flag = 'Y') then
              create_history_utl(p_object_id,
                                 p_attribute_row.id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_clob_value => p_value,
                                 p_comment => p_comment);
            end if;

            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_value);
            else
                set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_clob_value => p_value);
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
        l_attribute_type_code varchar(30 char);
        l_nested_table_id integer;
        l_attribute_current_date date;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        check_before_multi_values(p_attribute_row, number_list(attribute_utl.VALUE_TYPE_CLOB), l_attribute_type_code);

        check_domain_attribute(p_attribute_row, p_values);

        call_set_value_handler(p_attribute_row, p_object_id, p_values, p_valid_from, p_valid_through);

        l_nested_table_id := create_nested_table_item(p_values);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            if (p_attribute_row.value_by_date_flag = 'Y') then

                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);

                l_attribute_current_date := get_attribute_current_date(p_attribute_row.id);
                if (tools.compare_range_borders(trunc(p_valid_from), l_attribute_current_date) <= 0 and
                    tools.compare_range_borders(l_attribute_current_date, trunc(p_valid_through)) <= 0) then

                    set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
                end if;
            else
                set_fixed_attribute_value(p_object_id, p_attribute_row, p_values);
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (p_attribute_row.value_by_date_flag = 'Y') then
                set_value_for_date_utl(p_object_id, p_attribute_row.id, p_valid_from, p_valid_through, p_values, l_nested_table_id);
            else
                if (p_values is null or p_values is empty) then
                    clear_attribute_values_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag);
                else
                    set_attribute_value_utl(p_object_id, p_attribute_row.id, p_attribute_row.small_value_flag, p_nested_table_id => l_nested_table_id);
                end if;
            end if;
        end if;

        if (p_attribute_row.save_history_flag = 'Y') then
          create_history_utl(p_object_id,
                             p_attribute_row.id,
                             p_valid_from,
                             p_valid_through,
                             p_nested_table_id => l_nested_table_id,
                             p_comment => p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in string_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2)
    is
    begin
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_value, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_id), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
        set_value_utl(p_object_id, read_attribute(p_attribute_code), p_values, trunc(p_valid_from), trunc(p_valid_through), p_comment);
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in string_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id,
                  p_attribute_id,
                  p_values,
                  p_value_date,
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
                  p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
        l_attribute_row attribute_kind%rowtype;
    begin
        l_attribute_row := read_attribute(p_attribute_code);

        set_value_utl(p_object_id,
                      l_attribute_row,
                      p_values,
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
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
                  get_attr_value_after_date(p_object_id, p_attribute_id, p_value_date).value_date - 1,
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
                      trunc(p_value_date),
                      get_attr_value_after_date(p_object_id, get_attribute_id(p_attribute_code), trunc(p_value_date)).value_date - 1,
                      p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in string_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_value, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_id, p_values, trunc(sysdate), null, p_comment);
    end;

    procedure set_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_comment in varchar2 default null)
    is
    begin
        set_value(p_object_id, p_attribute_code, p_values, trunc(sysdate), null, p_comment);
    end;
/*
    procedure put_plan_value_utl(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_valid_from in date,
        p_valid_through in date,
        p_number_value in number,
        p_number_values in number_list,
        p_string_value in varchar2,
        p_string_values in string_list,
        p_date_value in date,
        p_date_values in date_list,
        p_blob_value in blob,
        p_blob_values in blob_list,
        p_clob_value in clob,
        p_clob_values in clob_list,
        p_comment in varchar2)
    is
        l_attribute_type_code varchar(30 char);
        l_all_value_types number_list;
    begin
        check_validity_period(p_attribute_row, p_valid_from, p_valid_through);

        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        l_all_value_types := number_list(attribute_utl.VALUE_TYPE_NUMBER,
                                         attribute_utl.VALUE_TYPE_STRING,
                                         attribute_utl.VALUE_TYPE_DATE,
                                         attribute_utl.VALUE_TYPE_BLOB,
                                         attribute_utl.VALUE_TYPE_CLOB,
                                         attribute_utl.VALUE_TYPE_LIST);

        if (p_attribute_row.multi_values_flag = 'Y') then
            check_before_multi_values(p_attribute_row, l_all_value_types, l_attribute_type_code);

            if (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_NUMBER) then
                check_domain_attribute(p_attribute_row, p_number_values);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_STRING) then
                check_domain_attribute(p_attribute_row, p_string_values);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_DATE) then
                check_domain_attribute(p_attribute_row, p_date_values);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_BLOB) then
                check_domain_attribute(p_attribute_row, p_blob_values);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_CLOB) then
                check_domain_attribute(p_attribute_row, p_clob_values);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_LIST) then
                check_list_attribute(p_attribute_row, p_number_values);
                check_domain_attribute(p_attribute_row, p_number_values);
            end if;
        else
            check_before_single_value(p_attribute_row, l_all_value_types, l_attribute_type_code);

            if (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_NUMBER) then
                check_domain_attribute(p_attribute_row, p_number_value);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_STRING) then
                check_domain_attribute(p_attribute_row, p_string_value);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_DATE) then
                check_domain_attribute(p_attribute_row, p_date_value);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_BLOB) then
                check_domain_attribute(p_attribute_row, p_blob_value);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_CLOB) then
                check_domain_attribute(p_attribute_row, p_clob_value);
            elsif (p_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_LIST) then
                check_list_attribute(p_attribute_row, p_number_value);
                check_domain_attribute(p_attribute_row, p_number_value);
            end if;
        end if;
\*
        if (p_attribute_row.history_saving_mode_id = attribute_utl.HISTORY_MODE_VALUES_BY_DATE) then
            insert into attribute_planned_value
            values (s_attribute_history.nextval,
                    p_attribute_row.id,
                    p_object_id,
                    p_valid_from,
                    p_valid_through,
                    p_number_value,
                    p_number_values,
                    p_string_value,
                    p_string_values,
                    p_date_value,
                    p_date_values,
                    p_blob_value,
                    p_blob_values,
                    p_clob_value,
                    p_clob_values,
                    sysdate,
                    bars_login.current_user_id(),
                    p_comment);
        else
            update attribute_planned_value t
            set    t.;
        end if;*\
    end;
*/
    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in number,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value number(32, 12);
    begin
        l_current_value := get_number_value(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in number,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value number(32, 12);
    begin
        l_current_value := get_number_value(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in number_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values number_list;
    begin
        l_current_values := get_number_values(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in number_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values number_list;
    begin
        l_current_values := get_number_values(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in varchar2,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value varchar2(4000 byte);
    begin
        l_current_value := get_string_value(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in varchar2,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value varchar2(4000 byte);
    begin
        l_current_value := get_string_value(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in string_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values string_list;
    begin
        l_current_values := get_string_values(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in string_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values string_list;
    begin
        l_current_values := get_string_values(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in date,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value date;
    begin
        l_current_value := get_date_value(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in date,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value date;
    begin
        l_current_value := get_date_value(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in date_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values date_list;
    begin
        l_current_values := get_date_values(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in date_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values date_list;
    begin
        l_current_values := get_date_values(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in blob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value blob;
    begin
        l_current_value := get_blob_value(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in blob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value blob;
    begin
        l_current_value := get_blob_value(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in blob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values blob_list;
    begin
        l_current_values := get_blob_values(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in blob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values blob_list;
    begin
        l_current_values := get_blob_values(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_value in clob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value clob;
    begin
        l_current_value := get_clob_value(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_value in clob,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_value clob;
    begin
        l_current_value := get_clob_value(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_value, l_current_value, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_id in integer,
        p_values in clob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values clob_list;
    begin
        l_current_values := get_clob_values(p_object_id, p_attribute_id, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;

    function compare_value(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_values in clob_list,
        p_value_date in date default trunc(sysdate),
        p_nulls_first in char default 'N')
    return signtype
    is
        l_current_values clob_list;
    begin
        l_current_values := get_clob_values(p_object_id, p_attribute_code, p_value_date);

        return tools.compare(p_values, l_current_values, p_nulls_first);
    end;
/*
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
        values (p_history_id, bars_login.current_user_id(), sysdate, p_comment);
    end;
*//*
    procedure remove_history(
        p_history_id in integer,
        p_comment in varchar2)
    is
        l_history_row attribute_history%rowtype;
        l_attribute_row attribute_kind%rowtype;
        l_attribute_type_code varchar2(30 char);
        l_history_id_for_date integer;
        l_history_row_after_date attribute_history%rowtype;
        l_previous_history_row attribute_history%rowtype;
        l_number_value number;
        l_number_values number_list;
        l_string_value varchar2(4000 byte);
        l_string_values string_list;
        l_date_value date;
        l_date_values date_list;
        l_blob_value blob;
        l_blob_values blob_list;
        l_clob_value clob;
        l_clob_values clob_list;
        l_comment varchar2(4000 byte) default regexp_replace(p_comment, '[^A-Za-zА-Яа-я]');
        l integer;
    begin
        l_history_row := read_history(p_history_id, p_lock => true);

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

            if (l_attribute_row.del_value_procedures is not null and l_attribute_row.del_value_procedures is not empty) then
                l := l_attribute_row.set_value_procedures.first;
                while (l is not null) loop
                    execute immediate 'begin ' || l_attribute_row.del_value_procedures(l) || '(:p_history_id); end;'
                    using p_history_id;

                    l := l_attribute_row.set_value_procedures.next(l);
                end loop;
            end if;

            l_history_id_for_date := get_history_id_for_date(l_history_row.object_id,
                                                             l_history_row.attribute_id,
                                                             l_history_row.value_date);

            l_history_row_after_date := null; -- get_history_row_after_date(l_history_row.object_id,
                                              --                      l_history_row.attribute_id,
                                              --                      l_history_row.value_date + 1);

            if (l_history_id_for_date = l_history_row.id and
                tools.compare_range_borders(l_history_row.value_date, trunc(sysdate)) <= 0 and
                tools.compare_range_borders(trunc(sysdate), l_history_row_after_date.value_date) <= 0) then
                -- Співпадіння ідентифікаторів історії означає, що даний запис історії є останнім (тобто діючим) записом на свою дату.
                -- Поточна банківська дата знаходиться між датою, з якої починає діяти рядок історії та
                -- датою наступного значення (або наступне значення не існує - тобто поточне значення рядка історії діє без обмеження).
                -- Виконання усіх цих умов означає, що видаляється значення історії, що діє на даний момент - відповідно, при його видаленні
                -- необхідно відновити попереднє значення атрибуту (визначається за історією)
                l_previous_history_row := get_previous_history_row(l_history_row);

                case when l_attribute_row.value_type_id in (attribute_utl.VALUE_TYPE_NUMBER, attribute_utl.VALUE_TYPE_LIST) then
                          if (l_attribute_row.multi_values_flag = 'Y') then
                              l_number_values := l_previous_history_row.number_values;
                              check_list_attribute(l_attribute_row, l_number_values);
                              check_domain_attribute(l_attribute_row, l_number_values);
                              set_number_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_number_values);
                          else
                              l_number_value := l_previous_history_row.number_value;
                              check_list_attribute(l_attribute_row, l_number_value);
                              check_domain_attribute(l_attribute_row, l_number_value);
                              set_number_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_number_value);
                          end if;
                     when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_STRING then
                          if (l_attribute_row.multi_values_flag = 'Y') then
                              l_string_values := l_previous_history_row.string_values;
                              check_domain_attribute(l_attribute_row, l_string_values);
                              set_string_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_string_values);
                          else
                              l_string_value := l_previous_history_row.string_value;
                              check_domain_attribute(l_attribute_row, l_string_value);
                              set_string_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_string_value);
                          end if;
                     when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_DATE then
                          if (l_attribute_row.multi_values_flag = 'Y') then
                              l_date_values := l_previous_history_row.date_values;
                              check_domain_attribute(l_attribute_row, l_date_values);
                              set_date_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_date_values);
                          else
                              l_date_value := l_previous_history_row.date_value;
                              check_domain_attribute(l_attribute_row, l_date_value);
                              set_date_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_date_value);
                          end if;
                     when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_BLOB then
                          if (l_attribute_row.multi_values_flag = 'Y') then
                              l_blob_values := l_previous_history_row.blob_values;
                              check_domain_attribute(l_attribute_row, l_blob_values);
                              set_blob_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_blob_values);
                          else
                              l_blob_value := l_previous_history_row.blob_value;
                              check_domain_attribute(l_attribute_row, l_blob_value);
                              set_blob_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_blob_value);
                          end if;
                     when l_attribute_row.value_type_id = attribute_utl.VALUE_TYPE_CLOB then
                          if (l_attribute_row.multi_values_flag = 'Y') then
                              l_clob_values := l_previous_history_row.clob_values;
                              check_domain_attribute(l_attribute_row, l_clob_values);
                              set_clob_value_utl(l_history_row.object_id, l_attribute_row, l_attribute_type_code, l_clob_values);
                          else
                              l_clob_value := l_previous_history_row.clob_value;
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
*/
    function check_if_data_exists(
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
            begin
                if (p_include_deleted_values = 'Y') then
                    select /*+FIRST_ROW*/ 'Y'
                    into   l_values_exists_flag
                    from   attribute_history h
                    where  h.attribute_id = p_attribute_row.id and
                           rownum = 1;
                else
                    select /*+FIRST_ROW*/ 'Y'
                    into   l_values_exists_flag
                    from   attribute_value v
                    where  v.attribute_id = p_attribute_row.id and
                           rownum = 1;
                end if;
            exception
                when no_data_found then
                     l_values_exists_flag := 'N';
            end;

            return l_values_exists_flag;
        elsif (p_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            return object_utl.check_if_any_objects_exists(p_attribute_row.object_type_id);
        end if;
    end;

    function check_if_value_exists(
        p_object_id in integer,
        p_attribute_row in attribute_kind%rowtype,
        p_include_deleted_values in char default 'N')
    return char
    is
        l_value_exists_flag char(1 byte);
        l_attribute_type_code varchar2(30 char);
    begin
        l_attribute_type_code := object_utl.get_object_type_code(p_attribute_row.attribute_type_id);

        if (l_attribute_type_code = attribute_utl.ATTR_TYPE_FIXED) then
            return object_utl.check_if_any_objects_exists(p_attribute_row.object_type_id);
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            begin
                if (p_include_deleted_values = 'Y') then
                    select /*+FIRST_ROW*/ 'Y'
                    into   l_value_exists_flag
                    from   attribute_history h
                    where  h.object_id = p_object_id and
                           h.attribute_id = p_attribute_row.id and
                           rownum = 1;
                else
                    select 'Y'
                    into   l_value_exists_flag
                    from   attribute_value v
                    where  v.attribute_id = p_attribute_row.id and
                           v.object_id = p_object_id;
                end if;
            exception
                when no_data_found then
                     l_value_exists_flag := 'N';
            end;

            return l_value_exists_flag;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            return object_utl.check_if_any_objects_exists(p_attribute_row.object_type_id);
        end if;
    end;

    function check_if_value_exists(
        p_object_id in integer,
        p_attribute_id in integer,
        p_include_deleted_values in char default 'N')
    return char
    is
    begin
         return check_if_value_exists(p_object_id,
                                      read_attribute(p_attribute_id),
                                      p_include_deleted_values);
    end;

    function check_if_value_exists(
        p_object_id in integer,
        p_attribute_code in varchar2,
        p_include_deleted_values in char default 'N')
    return char
    is
    begin
         return check_if_value_exists(p_object_id,
                                      read_attribute(p_attribute_code),
                                      p_include_deleted_values);
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
                                        attribute_utl.VALUE_TYPE_CLOB, attribute_utl.VALUE_TYPE_BLOB, attribute_utl.VALUE_TYPE_LIST)) then
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
            if (l_actual_field_data_type is null or l_actual_field_data_type not member of map_value_type_to_oracle_type(p_new_value_type_id, l_attribute_row.multi_values_flag)) then
                raise_application_error(-20000, 'Тип значення атрибуту {' || list_utl.get_item_code(attribute_utl.LT_ATTRIBUTE_VALUE_TYPE, p_new_value_type_id) ||
                                                '} не відповідає типу поля, що зберігатиме значення {' || l_actual_field_data_type || '}');
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_DYNAMIC) then
            if (check_if_data_exists(l_attribute_row, l_attribute_type_code, 'Y') = 'Y') then
                raise_application_error(-20000, 'З атрибутом {' || l_attribute_row.attribute_name ||
                                                '} вже розпочата робота - існують значення атрибуту або історія їх зміни. Змінити тип значення атрибуту неможливо');
            end if;
        elsif (l_attribute_type_code = attribute_utl.ATTR_TYPE_CALCULATED) then
            -- шо б там не було - просто змінюємо тип значення атрибуту, оскільки для розрахункових атрибутів ми не можемо перевірити
            -- тип значення, що повертається функцією
            null;
        end if;
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
/*
    procedure set_current_values(
        p_attribute_id in integer)
    is
        pragma autonomous_transaction;
        l_attribute_row attribute_kind%rowtype;
        l_attribute_current_date_row attribute_current_date%rowtype;
        l_objects number_list;
        l_statement varchar2(32767 byte);
        l_object_type_storage_row object_type_storage%rowtype;
        l_table_name
    begin
        l_attribute_row := lock_attribute(p_attribute_id);
        l_attribute_current_date_row := lock_attr_current_date(p_attribute_id);

        l_objects := object_utl.lock_objects(l_attribute_row.object_type_id);

        l_object_type_storage_row := object_utl.read_object_type_storage(l_attribute_row.object_type_id);

        l_statement := ' update ' || case when l_object_type_storage_row.table_owner is null then null
                                          else l_object_type_storage_row.table_owner || '.' ||
                                     end ||
                                     l_object_type_storage_row.table_name ||
                       ' set ' || l_attribute_row.value_column_name
        commit;
    end;

    procedure set_current_values
    is
    begin
        for i in (select k.id
                  from   attribute_kind k
                  join   object_type o on o.id = k.attribute_type_id
                  where  o.type_code = attribute_utl.ATTR_TYPE_FIXED and
                         k.value_by_date_flag = 'Y' and
                         exists (select 1
                                 from   attribute_current_date d
                                 where  d.attribute_id = k.id and
                                        d.current_value_date <> trunc(sysdate))) loop
            set_current_values(i.id);
        end loop;
    end;
*/
end;
/
 show err;
 
PROMPT *** Create  grants  ATTRIBUTE_UTL ***
grant EXECUTE                                                                on ATTRIBUTE_UTL   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/attribute_utl.sql =========*** End *
 PROMPT ===================================================================================== 
 
