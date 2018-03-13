prompt create table bars_intgr.imp_object_mfo
begin
    execute immediate q'[
create table bars_intgr.imp_object_mfo
(
object_name varchar2(32),
KF varchar2(6),
changenumber number
)
tablespace brssmld]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt create xpk index
begin
    execute immediate 'create unique index bars_intgr.xpk_imp_object_mfo on bars_intgr.imp_object_mfo(kf, object_name)';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;    
end;
/
prompt create FK
begin
    execute immediate 'alter table imp_object_mfo add constraint R_IMP_OBJECT foreign key(object_name) references bars_intgr.imp_object(object_name) enable validate';
exception
    when others then
        if sqlcode = -2275 then null; else raise; end if;
end;
/
comment on table bars_intgr.imp_object_mfo is 'Нумерация дельт по объектам выгрузки в разрезе филиалов';
comment on column bars_intgr.imp_object_mfo.object_name is 'Код объекта';
comment on column bars_intgr.imp_object_mfo.kf is 'Код филиала';
comment on column bars_intgr.imp_object_mfo.changenumber is 'Номер переданной дельты';