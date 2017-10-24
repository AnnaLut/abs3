prompt ... 
exec bpa.alter_policy_info('SETTLEMENTS_MATCH', 'WHOLE',  null,  null, null, null);
exec bpa.alter_policy_info('SETTLEMENTS_MATCH', 'FILIAL',  null,  null, null, null);

begin
    execute immediate 'drop table BARS.SETTLEMENTS_MATCH';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

-- Create table
begin
    execute immediate 'create table SETTLEMENTS_MATCH
(
  locality       VARCHAR2(30) not null,
  settlements_id NUMBER(10) not null,
  kf             VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  region         NUMBER(10),
  area           NUMBER(10)
)
tablespace BRSDYND
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
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table SETTLEMENTS_MATCH
  is '������� ������������ �������';
-- Add comments to the columns 
comment on column SETTLEMENTS_MATCH.locality
  is '������ �������� ';
comment on column SETTLEMENTS_MATCH.settlements_id
  is '����� ��������';
comment on column SETTLEMENTS_MATCH.kf
  is '��� �������';
comment on column SETTLEMENTS_MATCH.region
  is '�������';
comment on column SETTLEMENTS_MATCH.area
  is '����';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SETTLEMENTS_MATCH
  add constraint UK_SETTLEMENTSMATCH unique (REGION, AREA, LOCALITY, KF)
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
    if sqlcode = -2261 then null; else raise; 
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
  add constraint FK_SETTLEMENTSMATCH_REGION foreign key (REGION)
  references ADR_REGIONS (REGION_ID)';
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



