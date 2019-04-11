declare
    l_state_column_exists_flag integer := 0;
begin
    begin
        select 1
        into   l_state_column_exists_flag
        from   user_tab_columns t
        where  t.table_name = 'DEAL' and
               t.column_name = 'STATE_ID';
    exception
        when no_data_found then
             null;
    end;

    if (l_state_column_exists_flag = 1) then
        execute immediate
        'insert into object
         select id, deal_type_id, state_id
         from   deal d
         minus
         select o.* from object o';

        commit;

        execute immediate 'alter table deal drop column state_id';
        execute immediate 'alter index pk_deal rebuild';

        dbms_stats.gather_table_stats('BARS', 'OBJECT');
        dbms_stats.gather_table_stats('BARS', 'DEAL');
        dbms_stats.gather_index_stats('BARS', 'PK_OBJECT');

    end if;
end;
/

