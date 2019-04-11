create or replace package ddl_utl is

    DEFAULT_SCHEMA constant varchar2(30 char) := 'BARS';

    name_already_used exception;
    table_can_have_only_one_pk exception;
    unique_key_already_exists exception;
    constraint_name_already_used exception;
    table_or_view_doesnt_exist exception;
    materialized_view_doesnt_exist exception;
    sequence_doesnt_exist exception;
    primary_key_doesnt_exist exception;
    missing_or_invalid_index_name exception;
    missing_or_invalid_constr_name exception;
    column_already_exists exception;
    column_already_nullable exception;
    column_cant_be_set_nullable exception;
    column_already_not_nullable exception;
    cant_drop_nonexistent_pk exception;
    cant_drop_nonexistent_uk exception;

    pragma exception_init(name_already_used, -955);
    pragma exception_init(table_can_have_only_one_pk, -2260);
    pragma exception_init(unique_key_already_exists, -2261);
    pragma exception_init(constraint_name_already_used, -2275);
    pragma exception_init(table_or_view_doesnt_exist, -942);
    pragma exception_init(materialized_view_doesnt_exist, -12003);
    pragma exception_init(sequence_doesnt_exist, -2289);
    pragma exception_init(primary_key_doesnt_exist, -2441);
    pragma exception_init(missing_or_invalid_index_name, -953);
    pragma exception_init(missing_or_invalid_constr_name, -2250);
    pragma exception_init(column_already_exists, -1430);
    pragma exception_init(column_already_nullable, -2);
    pragma exception_init(column_cant_be_set_nullable, -1451);
    pragma exception_init(column_already_not_nullable, -1442);
    pragma exception_init(cant_drop_nonexistent_pk, -2441);
    pragma exception_init(cant_drop_nonexistent_uk, -2442);

    procedure execute_statement_autonomous(
        p_statement in varchar2);

    function read_table_metadata(
        p_table_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tables%rowtype;

    function read_column_metadata(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tab_columns%rowtype;

    procedure check_if_table_exists(
        p_table_name in varchar2,
        p_owner in varchar2 default null);

    function check_if_table_exists(
        p_table_name in varchar2,
        p_owner in varchar2 default null)
    return char;

    procedure check_if_column_exists(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null);

    function get_column_data_type(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null)
    return varchar2;

    function get_constraint_columns(
        p_constraint_name in varchar2,
        p_owner in varchar2 default null)
    return string_list;

    procedure create_table(
        p_table_statement in varchar2);

    procedure create_materialized_view(
        p_materialized_view_statement in varchar2);

    procedure create_sequence(
        p_sequence_statement in varchar2);

    procedure create_index(
        p_index_statement in varchar2);

    procedure create_primary_key(
        p_alter_table_statement in varchar2);

    procedure create_unique_key(
        p_alter_table_statement in varchar2);

    procedure add_column(
        p_alter_table_statement in varchar2);

    procedure add_constraint(
        p_alter_table_statement in varchar2);

    procedure drop_sequence(
        p_sequence_statement in varchar2);

    procedure drop_table(
        p_table_statement in varchar2);

    procedure drop_materialized_view(
        p_materialized_view_statement in varchar2);

    procedure drop_index(
        p_index_statement in varchar2);

    procedure drop_primary_key(
        p_drop_statement in varchar2);

    procedure drop_unique_key(
        p_drop_statement in varchar2);

    procedure drop_constraint(
        p_constraint_statement in varchar2);

    procedure set_column_null(
        p_modify_statement in varchar2);

    procedure set_column_not_null(
        p_modify_statement in varchar2);

    procedure refresh_mview_autonomous(
        list in varchar2,
        method in varchar2 default null,
        rollback_seg in varchar2 default null,
        push_deferred_rpc in boolean default true,
        refresh_after_errors in boolean default false,
        purge_option in binary_integer default 1,
        parallelism in binary_integer default 0,
        heap_size in binary_integer default 0,
        atomic_refresh in boolean default true,
        nested in boolean default false);
end;
/
create or replace package body ddl_utl as

    procedure execute_statement_autonomous(
        p_statement in varchar2)
    is
        pragma autonomous_transaction;
    begin
        execute immediate p_statement;
        commit;
    exception
        when others then
             rollback;
             bars_audit.error('ddl_utl.execute_statement_autonomous (exception) :' || chr(10) ||
                              'p_statement : ' || p_statement || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             raise;
    end;

    function read_table_metadata(
        p_table_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tables%rowtype
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
                raise_application_error(-20000, 'Òàáëèöÿ {' || l_owner || '.' || p_table_name || '} íå ³ñíóº');
             else return null;
             end if;
    end;

    function read_column_metadata(
        p_table_name in varchar2,
        p_column_name in varchar2,
        p_owner in varchar2 default null,
        p_raise_ndf in boolean default true)
    return all_tab_columns%rowtype
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
                raise_application_error(-20000, 'Ïîëå {' || p_column_name || '} â òàáëèö³ {' || l_owner || '.' || p_table_name || '} íå ³ñíóº');
             else return null;
             end if;
    end;

    function check_if_table_exists(
        p_table_name in varchar2,
        p_owner in varchar2 default null)
    return char
    is
    begin
        return case when read_table_metadata(p_table_name, p_owner, p_raise_ndf => false).table_name is null then 'N' else 'Y' end;
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

    function get_constraint_columns(
        p_constraint_name in varchar2,
        p_owner in varchar2 default null)
    return string_list
    is
        l_constraint_columns string_list;
        l_owner varchar2(30 char) := nvl(upper(p_owner), ddl_utl.DEFAULT_SCHEMA);
    begin
        select c.column_name
        bulk collect into l_constraint_columns
        from   all_cons_columns c
        where  c.constraint_name = p_constraint_name and
               c.owner = l_owner;

        return l_constraint_columns;
    end;

    procedure create_sequence(
        p_sequence_statement in varchar2)
    is
    begin
        execute immediate p_sequence_statement;
    exception
        when name_already_used then
             null;
    end;

    procedure create_table(
        p_table_statement in varchar2)
    is
    begin
        execute immediate p_table_statement;
    exception
        when name_already_used then
             null;
    end;

    procedure create_materialized_view(
        p_materialized_view_statement in varchar2)
    is
    begin
        execute immediate p_materialized_view_statement;
    exception
        when name_already_used then
             null;
    end;

    procedure create_index(
        p_index_statement in varchar2)
    is
    begin
        execute immediate p_index_statement;
    exception
        when name_already_used then
             null;
    end;

    procedure create_primary_key(
        p_alter_table_statement in varchar2)
    is
    begin
        execute immediate p_alter_table_statement;
    exception
        when name_already_used then
             null;
        when table_can_have_only_one_pk then
             null;
    end;

    procedure create_unique_key(
        p_alter_table_statement in varchar2)
    is
    begin
        execute immediate p_alter_table_statement;
    exception
        when name_already_used then
             null;
        when unique_key_already_exists then
             null;
    end;

    procedure add_column(
        p_alter_table_statement in varchar2)
    is
    begin
        execute immediate p_alter_table_statement;
    exception
        when column_already_exists then
             null;
    end;

    procedure add_constraint(
        p_alter_table_statement in varchar2)
    is
    begin
        execute immediate p_alter_table_statement;
    exception
        when constraint_name_already_used then
             null;
    end;

    procedure drop_sequence(
        p_sequence_statement in varchar2)
    is
    begin
        execute immediate p_sequence_statement;
    exception
        when sequence_doesnt_exist then
             null;
    end;

    procedure drop_table(
        p_table_statement in varchar2)
    is
    begin
        execute immediate p_table_statement;
    exception
        when table_or_view_doesnt_exist then
             null;
    end;

    procedure drop_materialized_view(
        p_materialized_view_statement in varchar2)
    is
    begin
        execute immediate p_materialized_view_statement;
    exception
        when materialized_view_doesnt_exist then
             null;
    end;

    procedure drop_primary_key(
        p_drop_statement in varchar2)
    is
    begin
        execute immediate p_drop_statement;
    exception
        when cant_drop_nonexistent_pk then
             null;
    end;

    procedure drop_unique_key(
        p_drop_statement in varchar2)
    is
    begin
        execute immediate p_drop_statement;
    exception
        when cant_drop_nonexistent_uk then
             null;
    end;

    procedure drop_index(
        p_index_statement in varchar2)
    is
    begin
        execute immediate p_index_statement;
    exception
        when missing_or_invalid_index_name then
             null;
    end;

    procedure drop_constraint(
        p_constraint_statement in varchar2)
    is
    begin
        execute immediate p_constraint_statement;
    exception
        when missing_or_invalid_constr_name then
             null;
    end;

    procedure drop_primary_key(
        p_key_statement in varchar2)
    is
    begin
        execute immediate p_key_statement;
    exception
        when primary_key_doesnt_exist then
             null;
    end;

    procedure set_column_null(
        p_modify_statement in varchar2)
    is
    begin
        execute immediate p_modify_statement;
    exception
        when column_already_nullable then
             null;
        when column_cant_be_set_nullable then
             null;
    end;

    procedure set_column_not_null(
        p_modify_statement in varchar2)
    is
    begin
        execute immediate p_modify_statement;
    exception
        when column_already_not_nullable then
             null;
    end;

    procedure refresh_mview_autonomous(
        list in varchar2,
        method in varchar2 default null,
        rollback_seg in varchar2 default null,
        push_deferred_rpc in boolean default true,
        refresh_after_errors in boolean default false,
        purge_option in binary_integer default 1,
        parallelism in binary_integer default 0,
        heap_size in binary_integer default 0,
        atomic_refresh in boolean default true,
        nested in boolean default false)
    is
        pragma autonomous_transaction;
    begin
        dbms_mview.refresh(list => list,
                           method => method,
                           rollback_seg => rollback_seg,
                           push_deferred_rpc => push_deferred_rpc,
                           refresh_after_errors => refresh_after_errors,
                           purge_option => purge_option,
                           parallelism => parallelism,
                           heap_size => heap_size,
                           atomic_refresh => atomic_refresh,
                           nested => nested);
    end;
end;
/
