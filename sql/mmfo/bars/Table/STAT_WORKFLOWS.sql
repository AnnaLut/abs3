BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAT_WORKFLOWS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAT_WORKFLOWS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table STAT_WORKFLOWS
(
  id            NUMBER(5) not null,
  name          VARCHAR2(64),
  close_date    DATE,
  close_user_id NUMBER(38)
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
comment on table STAT_WORKFLOWS
  is 'Технологічні лінії';
-- Add comments to the columns 
comment on column STAT_WORKFLOWS.id
  is ' ID workflow ';
comment on column STAT_WORKFLOWS.name
  is ' Найменування workflow ';
comment on column STAT_WORKFLOWS.close_date
  is ' Дата закриття workflow ';
comment on column STAT_WORKFLOWS.close_user_id
  is ' Користувач, який закрив workflow ';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table STAT_WORKFLOWS
  add constraint PK_EAWORKFLOWS primary key (ID)
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


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table STAT_WORKFLOWS
  add constraint CC_STATWORKFLOWS_WFNAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

