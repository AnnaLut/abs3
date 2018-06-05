prompt create table bars_intgr.imp_object
begin
    execute immediate q'[
create table bars_intgr.imp_object
(
object_name varchar2(32),
object_proc varchar2(255),
imp_order number,
active number(1),
imp_mode varchar2(5) default 'DELTA'
)
tablespace brssmld]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt add column imp_mode
begin
    execute immediate q'[alter table bars_intgr.imp_object add imp_mode varchar2(5) default 'DELTA']';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;    
end;
/

prompt create index xpk_imp_object
begin
    execute immediate 'create unique index bars_intgr.xpk_imp_object on bars_intgr.imp_object(object_name) tablespace brssmli';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;    
end;
/
prompt create PK
begin
    execute immediate 'alter table bars_intgr.imp_object add constraint XPK_IMP_OBJECT primary key (object_name) using index bars_intgr.xpk_imp_object';
exception
    when others then
        if sqlcode = -2260 then null; else raise; end if;
end;
/
comment on table bars_intgr.imp_object is 'Список объектов для выгрузки';
comment on column bars_intgr.imp_object.object_name is 'Код объекта';
comment on column bars_intgr.imp_object.object_proc is 'Процедура вызова';
comment on column bars_intgr.imp_object.imp_order is 'Порядок выгрузки';
comment on column bars_intgr.imp_object.active is 'Включен: 1/0';
comment on column bars_intgr.imp_object.imp_mode is 'Режим выгрузки: FULL / DELTA';