begin
    execute immediate 'create table BARSTRANS.TRANSPORT_TRACKING
(
  id               NUMBER(38) not null,
  unit_id          varchar2(32) not null,
  state_id         NUMBER(5) not null,
  sys_time         DATE,
  tracking_comment VARCHAR2(4000),
  stack_trace      CLOB,
  kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARSTRANS.TRANSPORT_TRACKING
  add constraint PK_TRANSPORT_TRACKING primary key (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/  
grant select on BARSTRANS.TRANSPORT_TRACKING to BARS_ACCESS_DEFROLE;