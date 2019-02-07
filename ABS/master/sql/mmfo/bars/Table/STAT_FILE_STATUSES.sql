BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_FILE_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_FILE_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_FILE_STATUSES
(
  id   NUMBER not null,
  name VARCHAR2(64)
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
comment on table STAT_FILE_STATUSES
  is '������ ������� ����� ';
-- Add comments to the columns 
comment on column STAT_FILE_STATUSES.id
  is ' ID ������� ';
comment on column STAT_FILE_STATUSES.name
  is ' ������������ ������� ';

-- Create/Rebegin
begin
    execute immediate 'create unique index PK_STATFILESTATUSES on STAT_FILE_STATUSES (ID)
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_FILE_STATUSES
  add constraint PK_STATFILESTATUSES_ID primary key (ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_FILE_STATUSES
  add constraint CC_FILESTATUS_STATUSNAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

