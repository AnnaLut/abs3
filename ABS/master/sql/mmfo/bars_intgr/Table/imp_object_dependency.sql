prompt create table bars_intgr.imp_object_dependency
begin
    execute immediate q'[
create table bars_intgr.imp_object_dependency
(
KF varchar2(6),
OBJECT_NAME varchar2(32),
TABLE_NAME varchar2(32),
KEY_COLUMN varchar2(32),
SQL_PREDICATE varchar2(250),
IDUPD number
)
tablespace brssmld
]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt create index XPK_IMP_OBJECT_DEPENDENCY
begin
    execute immediate 'create unique index XPK_IMP_OBJECT_DEPENDENCY on imp_object_dependency (KF, OBJECT_NAME, TABLE_NAME) tablespace brssmli';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt create constraint XPK_IMP_OBJECT_DEPENDENCY
begin
	execute immediate 'alter table bars_intgr.imp_object_dependency add constraint XPK_IMP_OBJECT_DEPENDENCY primary key(KF, OBJECT_NAME, TABLE_NAME) using index bars_intgr.XPK_IMP_OBJECT_DEPENDENCY';
exception
	when others then
		if sqlcode = -2260 then null; else raise; end if;
end;
/
comment on table bars_intgr.imp_object_dependency is 'Список таблиц-зависимостей (update-таблицы bars)';
comment on column bars_intgr.imp_object_dependency.kf is 'Код филиала';
comment on column bars_intgr.imp_object_dependency.object_name is 'Код объекта';
comment on column bars_intgr.imp_object_dependency.table_name is 'Имя таблицы bars';
comment on column bars_intgr.imp_object_dependency.key_column is 'Ключевое поле объекта';
comment on column bars_intgr.imp_object_dependency.sql_predicate is 'Дополнительный предикат для выборки по update-таблице';
comment on column bars_intgr.imp_object_dependency.idupd is 'Последний выгруженный idupd';
