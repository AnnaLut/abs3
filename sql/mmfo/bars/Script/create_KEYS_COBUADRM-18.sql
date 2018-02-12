prompt ... 


begin
    execute immediate 'create index BARS.I_ADRSETTLEMENTS_NAME on BARS.ADR_SETTLEMENTS (SETTLEMENT_NAME)
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index BARS.I_ADRSETTLEMENTS_UNAME on BARS.ADR_SETTLEMENTS (UPPER(SETTLEMENT_NAME))
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index BARS.I_ADRSETTLEMENTS_UNAMERU on BARS.ADR_SETTLEMENTS (UPPER(SETTLEMENT_NAME_RU))
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


alter table BARS.ADR_SETTLEMENTS
  add constraint FK_SETTLEMENTS_AREAS foreign key (AREA_ID)
  references BARS.ADR_AREAS (AREA_ID);
alter table BARS.ADR_SETTLEMENTS
  add constraint FK_SETTLEMENTS_PHONECODES foreign key (PHONE_CODE_ID)
  references BARS.ADR_PHONE_CODES (PHONE_CODE_ID);
alter table BARS.ADR_SETTLEMENTS
  add constraint FK_SETTLEMENTS_REGIONS foreign key (REGION_ID)
  references BARS.ADR_REGIONS (REGION_ID);
alter table BARS.ADR_SETTLEMENTS
  add constraint FK_SETTLEMENTS_SETTLEMENTTYPES foreign key (SETTLEMENT_TYPE_ID)
  references BARS.ADR_SETTLEMENT_TYPES (SETTLEMENT_TP_ID);



begin
    execute immediate 'create index BARS.I_ADRSTREETS_SETTLEMENTID on BARS.ADR_STREETS (SETTLEMENT_ID)
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index BARS.I_ADRSTREETS_UNAME on BARS.ADR_STREETS (UPPER(STREET_NAME))
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index BARS.I_ADRSTREETS_UNAMERU on BARS.ADR_STREETS (UPPER(STREET_NAME_RU))
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

-- Create/Recreate primary, unique and foreign key constraints 
alter table BARS.ADR_STREETS
  add constraint PK_STREETS primary key (STREET_ID)
  using index 
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
alter table BARS.ADR_STREETS
  add constraint FK_STREETS_SETTLEMENTS foreign key (SETTLEMENT_ID)
  references BARS.ADR_SETTLEMENTS (SETTLEMENT_ID);
alter table BARS.ADR_STREETS
  add constraint FK_STREETS_STREETTYPES foreign key (STREET_TYPE)
  references BARS.ADR_STREET_TYPES (STR_TP_ID);


begin
    execute immediate 'create index BARS.I_ADRHOUSES_STREETID on BARS.ADR_HOUSES (STREET_ID)
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

-- Create/Recreate primary, unique and foreign key constraints 
alter table BARS.ADR_HOUSES
  add constraint PK_HOUSENUMS primary key (HOUSE_ID)
  using index 
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
alter table BARS.ADR_HOUSES
  add constraint FK_HOUSENUMS_CITYDISTRICTS foreign key (DISTRICT_ID)
  references BARS.ADR_CITY_DISTRICTS (DISTRICT_ID);
alter table BARS.ADR_HOUSES
  add constraint FK_HOUSENUMS_STREETS foreign key (STREET_ID)
  references BARS.ADR_STREETS (STREET_ID);


prompt ... 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_AREACENTERF
  check (AREA_CENTER_F   IN ( 0, 1 ))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_AREACENTERF_NN
  check ("AREA_CENTER_F" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_EFFDT_NN
  check ("EFF_DT" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_ID_NN
  check ("SETTLEMENT_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_NAME_NN
  check ("SETTLEMENT_NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_POSTCODEMAX_NN
  check ("POSTAL_CODE_MAX" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_POSTCODEMIN_NN
  check ("POSTAL_CODE_MIN" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_REGIONCENTERF
  check (REGION_CENTER_F IN ( 0, 1 ))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_REGNCENTERF_NN
  check ("REGION_CENTER_F" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_SETTLEMENTPID
  check (SETTLEMENT_PID < SETTLEMENT_ID)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_SPIUSETLID_NN
  check ("SPIU_CITY_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_TYPEID_NN
  check ("SETTLEMENT_TYPE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

prompt ... 


begin
    execute immediate 'alter table ADR_STREETS
  add constraint CC_STREETS_EFFDT_NN
  check ("EFF_DT" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_STREETS
  add constraint CC_STREETS_SETTLEMENTID_NN
  check ("SETTLEMENT_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_STREETS
  add constraint CC_STREETS_STREETID_NN
  check ("STREET_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_STREETS
  add constraint CC_STREETS_STREETNAME_NN
  check ("STREET_NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table SETTLEMENTS_MATCH
  add constraint FK_SETTLEMENTSMATCH_AREA foreign key (AREA)
  references ADR_AREAS (AREA_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table SETTLEMENTS_MATCH
  add constraint FK_SETTLEMENTSMATCH_SETTLEMID foreign key (SETTLEMENTS_ID)
  references ADR_SETTLEMENTS (SETTLEMENT_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table STREETS_MATCH
  add constraint FK_STREETSMATCH_AREA foreign key (AREA)
  references ADR_AREAS (AREA_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table STREETS_MATCH
  add constraint FK_STREETSMATCH_SETTLEMENTS foreign key (SETTLEMENTS)
  references ADR_SETTLEMENTS (SETTLEMENT_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


