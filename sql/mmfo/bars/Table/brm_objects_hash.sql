prompt brm_objects_hash
begin 
    bpa.alter_policy_info('BRM_OBJECTS_HASH', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('BRM_OBJECTS_HASH', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate '
create table brm_objects_hash
(
install_id number,
object_id number,
object_owner varchar2(30),
object_type varchar2(20),
object_name varchar2(30),
object_ts varchar2(100),
bars_hash varchar2(32)
)
tablespace BRSMDLD';
exception
    when others then
        if sqlcode=-955 then null; else raise; end if;
end;
/
begin
    execute immediate 'create unique index XPK_BRM_OBJ_HASH on BRM_OBJECTS_HASH(install_id, object_id) tablespace BRSMDLI';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table BRM_OBJECTS_HASH is 'Лог по каждому объекту на момент записи в основной brm_install_log';
comment on column BRM_OBJECTS_HASH.install_id is 'Ид в основной таблице';

grant select on brm_objects_hash to bars_access_defrole;
grant select on brm_objects_hash to barsreader_role;