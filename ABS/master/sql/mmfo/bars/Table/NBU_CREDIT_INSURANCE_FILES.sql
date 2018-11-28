BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU_CREDIT_INSURANCE_FILES'', ''WHOLE'' , null, null, null, null);
               bpa.alter_policy_info(''NBU_CREDIT_INSURANCE_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               null;
           end; 
          '; 
END; 
/

prompt ... 


prompt ... 


-- Create table
begin
    execute immediate 'create table NBU_CREDIT_INSURANCE_FILES
(
  id      NUMBER(38) not null,
  name    VARCHAR2(100) not null,
  ddate   DATE not null,
  idupd   NUMBER(38) not null,
  chgdate DATE not null,
  kf      VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  state   NUMBER(1) default 0
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table NBU_CREDIT_INSURANCE_FILES
  is 'Завантажені файли';
-- Add comments to the columns 
comment on column NBU_CREDIT_INSURANCE_FILES.name
  is 'Ім''я файлу';
comment on column NBU_CREDIT_INSURANCE_FILES.ddate
  is 'Дата файлу';
comment on column NBU_CREDIT_INSURANCE_FILES.idupd
  is 'Користувач';
comment on column NBU_CREDIT_INSURANCE_FILES.chgdate
  is 'Системна дата';
comment on column NBU_CREDIT_INSURANCE_FILES.kf
  is 'РУ';
comment on column NBU_CREDIT_INSURANCE_FILES.state
  is 'статус 0-Завантажено, 1 - Оброблено, 2 - Завантажено з помилками';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table NBU_CREDIT_INSURANCE_FILES
  add constraint PK_NBUCREDITINSURANCEFILES primary key (ID)
  using index 
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 



exec bpa.alter_policies('NBU_CREDIT_INSURANCE_FILES');