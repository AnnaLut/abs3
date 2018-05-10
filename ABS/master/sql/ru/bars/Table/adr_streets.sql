-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_STREETS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create Table ADR_STREETS
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'ADR_STREETS', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_STREETS', 'FILIAL', null, null, null, null );
end;
/

prompt ... 

-- Create table
create table BARS.ADR_STREETS
(
  street_id      NUMBER(10),
  street_name    VARCHAR2(50),
  street_name_ru VARCHAR2(50),
  street_type    NUMBER(3),
  settlement_id  NUMBER(10),
  eff_dt         DATE,
  end_dt         DATE
)
tablespace BRSMDLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Add comments to the table 
comment on table BARS.ADR_STREETS
  is 'Довідник вулиць';
-- Add comments to the columns 
comment on column BARS.ADR_STREETS.street_id
  is 'Ідентифікатор вулиці';
comment on column BARS.ADR_STREETS.street_name
  is 'Назва вулиці';
comment on column BARS.ADR_STREETS.street_name_ru
  is 'Назва вулиці (RUS)';
comment on column BARS.ADR_STREETS.street_type
  is 'Ідентифікатор типу вулиці';
comment on column BARS.ADR_STREETS.settlement_id
  is 'Ідентифікатор населеного пункту';

-- Create/Rebegin
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
-- Create/Recreate check constraints 
alter table BARS.ADR_STREETS
  add constraint CC_STREETS_EFFDT_NN
  check ("EFF_DT" IS NOT NULL);
alter table BARS.ADR_STREETS
  add constraint CC_STREETS_SETTLEMENTID_NN
  check ("SETTLEMENT_ID" IS NOT NULL);
alter table BARS.ADR_STREETS
  add constraint CC_STREETS_STREETID_NN
  check ("STREET_ID" IS NOT NULL);
alter table BARS.ADR_STREETS
  add constraint CC_STREETS_STREETNAME_NN
  check ("STREET_NAME" IS NOT NULL);
-- Grant/Revoke object privileges 
grant select on BARS.ADR_STREETS to BARSUPL;
grant select on BARS.ADR_STREETS to FINMON01;
grant select on BARS.ADR_STREETS to START1;
grant select on BARS.ADR_STREETS to UPLD;


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on Table  BARS.ADR_STREETS is 'Довідник вулиць';

COMMENT ON COLUMN BARS.ADR_STREETS.STREET_ID      IS 'Ідентифікатор вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_NAME    IS 'Назва вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_NAME_RU IS 'Назва вулиці (RUS)';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_TYPE    IS 'Ідентифікатор типу вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.SETTLEMENT_ID  IS 'Ідентифікатор населеного пункту';
COMMENT ON COLUMN BARS.ADR_STREETS.EFF_DT         IS 'The date from which an instance of the entity is valid.';
COMMENT ON COLUMN BARS.ADR_STREETS.END_DT         IS 'The date after which an instance of the entity is no longer valid.';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.ADR_STREETS TO START1, BARSUPL, UPLD;
