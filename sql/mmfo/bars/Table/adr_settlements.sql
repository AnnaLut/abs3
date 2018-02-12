begin
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENTS', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENTS', 'FILIAL', null, null, null, null );
end;
/


prompt ... 

-- Create table
create table BARS.ADR_SETTLEMENTS
(
  settlement_id      NUMBER(10),
  settlement_name    VARCHAR2(50),
  settlement_name_ru VARCHAR2(50),
  settlement_type_id NUMBER(3),
  postal_code_min    VARCHAR2(5),
  postal_code_max    VARCHAR2(5),
  phone_code_id      NUMBER(10),
  region_center_f    NUMBER(1) default 0,
  area_center_f      NUMBER(1) default 0,
  region_id          NUMBER(10),
  area_id            NUMBER(10),
  koatuu             VARCHAR2(15),
  terrstatus         VARCHAR2(50),
  eff_dt             DATE,
  end_dt             DATE,
  settlement_pid     NUMBER(10),
  spiu_city_id       NUMBER(10),
  spiu_suburb_id     NUMBER(10)
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Add comments to the table 
comment on table BARS.ADR_SETTLEMENTS
  is 'Довідник населених пунктів';
-- Add comments to the columns 
comment on column BARS.ADR_SETTLEMENTS.settlement_id
  is 'Ідентифікатор населеного пункту (equal to "SPIU.SUMMARYSETTLEMENTS.SUMMARYSETTLEMENTID"';
comment on column BARS.ADR_SETTLEMENTS.settlement_name
  is 'Назва населеного пункту';
comment on column BARS.ADR_SETTLEMENTS.settlement_name_ru
  is 'Назва населеного пункту';
comment on column BARS.ADR_SETTLEMENTS.settlement_type_id
  is 'Ідентифікатор типу населеного пункту';
comment on column BARS.ADR_SETTLEMENTS.postal_code_min
  is 'Мінімальний індекс для населеного пункту';
comment on column BARS.ADR_SETTLEMENTS.postal_code_max
  is 'Максимальний індекс для населеного пункту';
comment on column BARS.ADR_SETTLEMENTS.region_center_f
  is 'Чи є населений пункт обласним центром';
comment on column BARS.ADR_SETTLEMENTS.area_center_f
  is 'Чи є населений пункт районним центром';
comment on column BARS.ADR_SETTLEMENTS.region_id
  is 'Ід. області (для міст обласного підпорядкування)';
comment on column BARS.ADR_SETTLEMENTS.area_id
  is 'Ід. району';
comment on column BARS.ADR_SETTLEMENTS.koatuu
  is 'Код населеного пункту згідно класифікатора об`єктів адміністративно-територіального устрою України (КОАТУУ)';
comment on column BARS.ADR_SETTLEMENTS.terrstatus
  is 'Спеціальний статус території (Зона АТО, Тимчасово окупована територія - Крим)';
comment on column BARS.ADR_SETTLEMENTS.eff_dt
  is 'The date from which an instance of the entity is valid.';
comment on column BARS.ADR_SETTLEMENTS.end_dt
  is 'The date after which an instance of the entity is no longer valid.';
comment on column BARS.ADR_SETTLEMENTS.settlement_pid
  is 'Previous Ідентифікатор населеного пункту';

-- Create/Rebegin


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

-- Create/Recreate primary, unique and foreign key constraints 
alter table BARS.ADR_SETTLEMENTS
  add constraint PK_SETTLEMENTS primary key (SETTLEMENT_ID)
  using index 
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
  );
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
-- Create/Recreate check constraints 
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_AREACENTERF
  check (AREA_CENTER_F   IN ( 0, 1 ));
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_AREACENTERF_NN
  check ("AREA_CENTER_F" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_EFFDT_NN
  check ("EFF_DT" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_ID_NN
  check ("SETTLEMENT_ID" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_NAME_NN
  check ("SETTLEMENT_NAME" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_POSTCODEMAX_NN
  check ("POSTAL_CODE_MAX" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_POSTCODEMIN_NN
  check ("POSTAL_CODE_MIN" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_REGIONCENTERF
  check (REGION_CENTER_F IN ( 0, 1 ));
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_REGNCENTERF_NN
  check ("REGION_CENTER_F" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_SETTLEMENTPID
  check (SETTLEMENT_PID < SETTLEMENT_ID);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_SPIUSETLID_NN
  check ("SPIU_CITY_ID" IS NOT NULL);
alter table BARS.ADR_SETTLEMENTS
  add constraint CC_SETTLEMENTS_TYPEID_NN
  check ("SETTLEMENT_TYPE_ID" IS NOT NULL);
-- Grant/Revoke object privileges 
grant select on BARS.ADR_SETTLEMENTS to BARSUPL;
grant select on BARS.ADR_SETTLEMENTS to FINMON01;
grant select on BARS.ADR_SETTLEMENTS to START1;
grant select on BARS.ADR_SETTLEMENTS to UPLD;

