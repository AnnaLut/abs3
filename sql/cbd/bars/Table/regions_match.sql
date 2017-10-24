prompt ... 
exec bpa.alter_policy_info('REGIONS_MATCH', 'WHOLE',  null,  null, null, null);
exec bpa.alter_policy_info('REGIONS_MATCH', 'FILIAL',  null,  null, null, null);

begin
    execute immediate 'drop table BARS.REGIONS_MATCH';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


-- Create table
begin
    execute immediate 'create table REGIONS_MATCH
(
  domain    VARCHAR2(30) not null,
  region_id NUMBER(10) not null,
  kf        VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
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
comment on table REGIONS_MATCH
  is '������� ������������ ��������';
-- Add comments to the columns 
comment on column REGIONS_MATCH.domain
  is '������ �������� ';
comment on column REGIONS_MATCH.region_id
  is '����� ��������';
comment on column REGIONS_MATCH.kf
  is '��� �������';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table REGIONS_MATCH
  add constraint UK_DOMAINMATCH unique (DOMAIN, KF)
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
    execute immediate 'alter table REGIONS_MATCH
  add constraint FK_DOMAINMATCH_REGION_ID foreign key (REGION_ID)
  references ADR_REGIONS (REGION_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 



