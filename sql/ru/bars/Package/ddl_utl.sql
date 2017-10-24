
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ddl_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DDL_UTL is
    DEFAULT_SCHEMA constant varchar2(30 char) := 'BARS';

    function read_table_metadata(
        p_table_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tables%rowtype
    result_cache;

    function read_column_metadata(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tab_columns%rowtype
    result_cache;

    procedure check_if_table_exists(
        p_table_name in varchar2,
        p_owner in varchar2 default null);

    procedure check_if_column_exists(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null);

    function get_column_data_type(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null)
    return varchar2;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.DDL_UTL as

    function read_table_metadata(
        p_table_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tables%rowtype
    result_cache
    is
        l_table_row all_tables%rowtype;
        l_owner varchar2(30 char) default nvl(upper(p_owner), ddl_utl.DEFAULT_SCHEMA);
    begin
        select *
        into   l_table_row
        from   all_tables t
        where  t.owner = l_owner and
               t.table_name = upper(p_table_name);

        return l_table_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Таблиця {' || l_owner || '.' || p_table_name || '} не існує');
             else return null;
             end if;
    end;

    function read_column_metadata(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tab_columns%rowtype
    result_cache
    is
        l_column_row all_tab_columns%rowtype;
        l_owner varchar2(30 char) default nvl(upper(p_owner), ddl_utl.DEFAULT_SCHEMA);
    begin
        select *
        into   l_column_row
        from   all_tab_columns t
        where  t.owner = l_owner and
               t.table_name = upper(p_table_name) and
               t.column_name = upper(p_column_name);

        return l_column_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Поле {' || p_column_name || '} в таблиці {' || l_owner || '.' || p_table_name || '} не існує');
             else return null;
             end if;
    end;

    procedure check_if_table_exists(
        p_table_name in varchar2,
        p_owner in varchar2 default null)
    is
    begin
        tools.hide_hint(read_table_metadata(p_table_name, p_owner).table_name);
    end;

    procedure check_if_column_exists(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null)
    is
    begin
        tools.hide_hint(read_column_metadata(p_table_name, p_column_name, p_owner).column_name);
    end;

    function get_column_data_type(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null)
    return varchar2
    is
    begin
        return read_column_metadata(p_table_name, p_column_name, p_owner, p_raise_ndf => false).data_type;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ddl_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 