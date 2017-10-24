prompt create table brm_install_log
begin
  bpa.alter_policy_info('BRM_INSTALL_LOG', 'WHOLE', null, null, null, null);
  bpa.alter_policy_info('BRM_INSTALL_LOG', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate '
        create table brm_install_log
        (
            rec_id number,
            rec_date date default sysdate,
            inst_type varchar2(10),
            inst_name varchar2(50),
            rec_message varchar2(250)
        ) tablespace brsdynd';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
begin
    execute immediate 'create unique index XPK_BRM_INSTALL_LOG on BRM_INSTALL_LOG(rec_id) tablespace BRSDYNI';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
begin
    execute immediate 'alter table brm_install_log add constraint XPK_BRM_INSTALL_LOG primary key(rec_id) using index XPK_BRM_INSTALL_LOG';
exception
    when others then
        if sqlcode = -2260 then null; else raise; end if;
end;
/