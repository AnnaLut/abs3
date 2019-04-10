begin
    bars_policy_adm.alter_policy_info('OBJECT_STATE', 'WHOLE', null, null, null, null);
    bars_policy_adm.alter_policy_info('OBJECT_STATE', 'FILIAL', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
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
