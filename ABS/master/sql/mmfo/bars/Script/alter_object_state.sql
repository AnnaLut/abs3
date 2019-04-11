declare
    l_id_column_exists integer default 0;
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    begin
        select 1
        into   l_id_column_exists
        from   user_tab_columns t
        where  t.table_name = 'OBJECT_STATE' and
               t.column_name = 'ID';
    exception
        when no_data_found then
             null;
    end;

    if (l_id_column_exists = 0) then
        begin
            execute immediate
            'create table tmp_object_state
             (
                    id number(38) not null,
                    object_type_id number(38) not null,
                    state_code varchar2(300 char) not null,
                    state_name varchar2(4000 byte) not null,
                    is_active char(1 byte) not null
             )
             tablespace brsmdld';
        exception
            when name_already_used then
                 null;
        end;

        lock table object_state in exclusive mode;

        execute immediate
        'insert into tmp_object_state select state_id, object_type_id, state_code, state_name, ''Y'' from object_state';

        execute immediate 'drop table object_state';

        execute immediate 'alter table tmp_object_state rename to object_state';
    end if;
end;
/

begin
    ddl_utl.create_primary_key('alter table object_state add constraint pk_object_state primary key (id) using index tablespace brsmdli');
end;
/

begin
    ddl_utl.create_unique_key('alter table object_state add constraint uk_object_state unique (object_type_id, state_code) using index tablespace brsmdli');
end;
/

comment on table object_state is 'Перелік допустимих станів, в яких можуть перебувати об''єкти АБС';
comment on column object_state.id is 'Ідентифікатор стану об''єкту - первинний ключ';
comment on column object_state.object_type_id is 'Типу об''єкту, для якого може застосовуватися даний статус';
comment on column object_state.state_code is 'Код стану об''єкта - унікальний в рамках типу об''єктів';
comment on column object_state.state_name is 'Назва стану об''єкта';
comment on column object_state.is_active is 'Ознака активності стану об''єкта (Y/N)';
