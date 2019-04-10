exec bars.bpa.alter_policy_info( 'ZVT_DIVISION', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZVT_DIVISION', 'FILIAL', null, null, null, null );
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table BARS.ZVT_DIVISION
(
  division_id INTEGER not null,
  name        VARCHAR2(80)
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
execute immediate q'[alter table BARS.ZVT_DIVISION
  add constraint XPK_ZVT_DIVISION primary key (DIVISION_ID)
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
  dbms_output.put_line( 'Table "ZVT_DIVISION" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "ZVT_DIVISION" already exists.' );
end;
/

commit;

grant select, insert, update, delete on BARS.ZVT_DIVISION to BARS_ACCESS_DEFROLE;
grant select on BARS.ZVT_DIVISION to WR_REFREAD;

