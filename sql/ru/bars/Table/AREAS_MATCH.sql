prompt ... 
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AREAS_MATCH'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''AREAS_MATCH'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/
begin
    execute immediate 'drop table BARS.AREAS_MATCH';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


-- Create table
begin
    execute immediate 'create table AREAS_MATCH
(
  region  VARCHAR2(30) not null,
  area_id NUMBER(10) not null,
  kf      VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  domain  NUMBER(10)
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
comment on table AREAS_MATCH
  is 'Таблица соответствия раенов';
-- Add comments to the columns 
comment on column AREAS_MATCH.region
  is 'Старое значение ';
comment on column AREAS_MATCH.area_id
  is 'Новое значение';
comment on column AREAS_MATCH.kf
  is 'Код филиала';
comment on column AREAS_MATCH.domain
  is 'Область';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table AREAS_MATCH
  add constraint UK_AREASMATCH unique (REGION, KF)
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
    execute immediate 'alter table AREAS_MATCH
  add constraint FK_AREASMATCH_DOMAIN foreign key (DOMAIN)
  references ADR_REGIONS (REGION_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

 exec bpa.alter_policies('AREAS_MATCH');