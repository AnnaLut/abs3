begin
  BPA.ALTER_POLICY_INFO( 'ADR_AREAS', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_AREAS', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_AREAS
(
  area_id      NUMBER(10),
  spiu_area_id NUMBER(10),
  area_name    VARCHAR2(50),
  area_name_ru VARCHAR2(50),
  region_id    NUMBER(10),
  koatuu       VARCHAR2(5)
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
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table ADR_AREAS
  is 'Довідник районів';
-- Add comments to the columns 
comment on column ADR_AREAS.area_id
  is 'Ідентифікатор району';
comment on column ADR_AREAS.area_name
  is 'Назва району';
comment on column ADR_AREAS.area_name_ru
  is 'Назва району';
comment on column ADR_AREAS.region_id
  is 'Ідентифікатор області';
/

begin
-- Create/Rebegin
    execute immediate 'create index IDX_ADRAREAS_AREANAME on ADR_AREAS (NLSSORT(AREA_NAME,''nls_sort=''''BINARY_CI''''''))
  tablespace BRSDYNI
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
    execute immediate 'create index I_ADRAREAS_UAREANAME on ADR_AREAS (UPPER(AREA_NAME))
  tablespace BRSDYNI
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
    execute immediate 'create index I_ADRAREAS_UAREANAMERU on ADR_AREAS (UPPER(AREA_NAME_RU))
  tablespace BRSDYNI
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
begin
    execute immediate 'alter table ADR_AREAS
  add constraint PK_AREAS primary key (AREA_ID)
  using index 
  tablespace BRSDYNI
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
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_AREAS
  add constraint FK_AREAS_REGIONS foreign key (REGION_ID)
  references ADR_REGIONS (REGION_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table ADR_AREAS
  add constraint CC_AREAS_ID_NN
  check ("AREA_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_AREAS
  add constraint CC_AREAS_NAME_NN
  check ("AREA_NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_AREAS
  add constraint CC_AREAS_REGIONID_NN
  check ("REGION_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table ADR_AREAS
  add constraint CC_AREAS_SPIUID_NN
  check ("SPIU_AREA_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on ADR_AREAS to BARSUPL;
grant select on ADR_AREAS to START1;
grant select on ADR_AREAS to UPLD;
