begin
    execute immediate 'create table BARSTRANS.TRANSPORT_UNIT
(
  id               varchar2(32) not null,
  unit_type_id     NUMBER(5) not null,
  external_file_id VARCHAR2(300 CHAR),
  receiver_url     VARCHAR2(4000),
  request_data     BLOB not null,
  response_data    BLOB,
  state_id         NUMBER(5) not null,
  failures_count   NUMBER(5) not null,
  kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/  
begin
    execute immediate 'ALTER TABLE BARSTRANS.TRANSPORT_UNIT add(kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/ 

begin
    execute immediate 'create index I_TRANSPORT_UNIT_EXTFID on BARSTRANS.TRANSPORT_UNIT (UNIT_TYPE_ID, EXTERNAL_FILE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARSTRANS.TRANSPORT_UNIT
  add constraint PK_TRANSPOR_UNIT primary key (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARSTRANS.TRANSPORT_UNIT
  add constraint FK_TRANSPORT_U_REF_TRANSPORT_U foreign key (UNIT_TYPE_ID)
  references TRANSPORT_UNIT_TYPE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

grant select on BARSTRANS.TRANSPORT_UNIT to BARS;
grant select on BARSTRANS.TRANSPORT_UNIT to BARS_ACCESS_DEFROLE;