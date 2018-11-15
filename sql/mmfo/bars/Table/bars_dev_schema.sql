prompt table bars_dev_schema
begin
    bpa.alter_policy_info('BARS_DEV_SCHEMA', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('BARS_DEV_SCHEMA', 'FILIAL', null, 'E', 'E', 'E');
end;
/
begin
    execute immediate '
create table bars_dev_schema
(
schemaname varchar2(64),
description varchar2(256),
constraint XPK_BARS_DEV_SCHEMA primary key (schemaname) using index tablespace brssmli
)
tablespace brssmld';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

begin
    bpa.alter_policies('BARS_DEV_SCHEMA');   
end;
/
comment on table bars_dev_schema is 'Схемы БД, используемые для разработки';
comment on column bars_dev_schema.schemaname is 'Название схемы';
comment on column bars_dev_schema.description is 'Назначение';