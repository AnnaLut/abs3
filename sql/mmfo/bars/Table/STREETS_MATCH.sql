
prompt ... 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STREETS_MATCH'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STREETS_MATCH'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/


begin
    execute immediate 'drop table BARS.STREETS_MATCH';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


-- Create table
begin
    execute immediate 'create table STREETS_MATCH
(
  region      NUMBER(10),
  settlements NUMBER(10) not null,
  kf          VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  street      VARCHAR2(100),
  street_id   NUMBER(10),
  area        NUMBER(10)
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
comment on table STREETS_MATCH
  is 'Таблица соответствия улиц';
-- Add comments to the columns 
comment on column STREETS_MATCH.region
  is 'Область';
comment on column STREETS_MATCH.settlements
  is 'Город';
comment on column STREETS_MATCH.kf
  is 'Код филиала';
comment on column STREETS_MATCH.street
  is 'Старое значение ';
comment on column STREETS_MATCH.street_id
  is 'Новое значение';
comment on column STREETS_MATCH.area
  is 'Раен';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STREETS_MATCH
  add constraint UK_STREETSMATCH unique (STREET, KF)
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
  add constraint FK_STREETSMATCH_REGION foreign key (REGION)
  references ADR_REGIONS (REGION_ID)';
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

 exec bpa.alter_policies('STREETS_MATCH');