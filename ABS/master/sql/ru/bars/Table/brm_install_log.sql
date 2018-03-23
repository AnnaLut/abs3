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
            rec_message varchar2(250),
            bars_hash varchar2(32),
            dbname       VARCHAR2(24),
            mfo          VARCHAR2(6),
            glbname      VARCHAR2(64),
            username     VARCHAR2(64),
            machine_name VARCHAR2(64),
            machine_ip   VARCHAR2(24)
        ) tablespace brsdynd';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt add bars_hash column
begin
    execute immediate 'alter table brm_install_log add bars_hash varchar2(32)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
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
begin
    execute immediate 'alter table bars.brm_install_log add dbname varchar2(24)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;    
end;
/
begin
    execute immediate 'alter table bars.brm_install_log add mfo varchar2(6)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;    
end;
/
begin
    execute immediate 'alter table bars.brm_install_log add glbname varchar2(64)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;    
end;
/
begin
    execute immediate 'alter table bars.brm_install_log add username varchar2(64)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;    
end;
/
begin
    execute immediate 'alter table bars.brm_install_log add machine_name varchar2(64)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;    
end;
/
begin
    execute immediate 'alter table bars.brm_install_log add machine_ip varchar2(24)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;    
end;
/