begin
    execute immediate 'create table BARSTRANS.TRANSPORT_UNIT_TYPE
(
  id                  NUMBER(5) not null,
  transport_type_code VARCHAR2(30 CHAR),
  transport_type_name VARCHAR2(300 CHAR),
  direction           NUMBER(1),
  processing_block    VARCHAR2(4000),
  compressed          NUMBER(1),
  base64              NUMBER(1),
  checksum            NUMBER(1),
  information_request NUMBER(1)
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'ALTER TABLE BARSTRANS.TRANSPORT_UNIT_TYPE add(checksum NUMBER(1)
                                                                    ,information_request NUMBER(1))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/  

comment on column BARSTRANS.TRANSPORT_UNIT_TYPE.direction
  is '1 - OneWay, 2 - TwoWay';
comment on column BARSTRANS.TRANSPORT_UNIT_TYPE.compressed
  is '1 - Yes, 2 - No';
comment on column BARSTRANS.TRANSPORT_UNIT_TYPE.base64
  is '1 - Yes, 2 - No';
comment on column BARSTRANS.TRANSPORT_UNIT_TYPE.checksum
  is '1 - YES (Now, MD5 only), 2 - No';
comment on column BARSTRANS.TRANSPORT_UNIT_TYPE.information_request
  is '1 - Yes, 2 - No';

begin
    execute immediate 'alter table BARSTRANS.TRANSPORT_UNIT_TYPE
  add constraint PK_TRANSPORT_UNIT_TYPE primary key (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

grant select on BARSTRANS.TRANSPORT_UNIT_TYPE to BARS_ACCESS_DEFROLE;