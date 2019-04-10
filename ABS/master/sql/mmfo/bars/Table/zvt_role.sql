exec bars.bpa.alter_policy_info( 'ZVT_ROLE', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZVT_ROLE', 'FILIAL', null, null, null, null );
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table BARS.ZVT_ROLE
(
  role_id       INTEGER not null,
  role_code     VARCHAR2(225),
  department_id INTEGER,
  division_id   INTEGER,
  team_id       INTEGER,
  sector_id     INTEGER
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )]';
execute immediate q'[
alter table BARS.ZVT_ROLE
  add constraint XPK_ZVTROLE primary key (ROLE_ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )]';
execute immediate q'[
alter table BARS.ZVT_ROLE
  add constraint FK_ZVTROLE_DEPARTMENT_ID foreign key (DEPARTMENT_ID)
  references BARS.ZVT_DEPARTMENT (DEPARTMENT_ID)]';
execute immediate q'[
alter table BARS.ZVT_ROLE
  add constraint FK_ZVTROLE_ROLE_ID foreign key (ROLE_ID)
  references BARS.STAFF_ROLE (ID)]';
execute immediate q'[
alter table BARS.ZVT_ROLE
  add constraint FK_ZVTROLE_SECTOR_ID foreign key (SECTOR_ID)
  references BARS.ZVT_SECTOR (SECTOR_ID)]';
execute immediate q'[
alter table BARS.ZVT_ROLE
  add constraint FK_ZVTROLE_TEAM_ID foreign key (TEAM_ID)
  references BARS.ZVT_TEAM (TEAM_ID)]';
  dbms_output.put_line( 'Table "ZVT_ROLE" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "ZVT_ROLE" already exists.' );
end;
/

commit;

grant select, insert, update, delete on BARS.ZVT_ROLE to BARS_ACCESS_DEFROLE;
grant select on BARS.ZVT_ROLE to WR_REFREAD;

