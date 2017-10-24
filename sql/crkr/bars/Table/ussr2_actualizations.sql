exec bpa.alter_policy_info('USSR2_ACTUALIZATIONS', 'filial', null, null, null, null);
exec bpa.alter_policy_info('USSR2_ACTUALIZATIONS', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table USSR2_ACTUALIZATIONS
(
  id         NUMBER not null,
  staff_id   NUMBER,
  crt_date   DATE default sysdate,
  branch     VARCHAR2(30),
  state_id   VARCHAR2(100),
  state_date DATE default sysdate,
  act_type   VARCHAR2(100) default ''NORMAL''
)
tablespace BRSBIGD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 4M
    next 4M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table USSR2_ACTUALIZATIONS
  is 'Сеанси актуалізіції данних вкладників';
-- Add comments to the columns 
comment on column USSR2_ACTUALIZATIONS.id
  is 'Ідентифікатор';
comment on column USSR2_ACTUALIZATIONS.staff_id
  is 'Користувач, що створив';
comment on column USSR2_ACTUALIZATIONS.crt_date
  is 'Дата створення';
comment on column USSR2_ACTUALIZATIONS.branch
  is 'Відділення де було створенно';
comment on column USSR2_ACTUALIZATIONS.state_id
  is 'Статус';
comment on column USSR2_ACTUALIZATIONS.state_date
  is 'Дата статусу';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint PK_USSR2ACTS primary key (ID)
  using index 
  tablespace BRSBIGI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 4M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint FK_ACTS_SID_ACTSTS_ID foreign key (STATE_ID)
  references USSR2_ACT_STATES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint FK_ACTS_TYPE foreign key (ACT_TYPE)
  references USSR2_ACTS_TYPES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint CC_USSR2ACTS_BRANCH_NN
  check ("BRANCH" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint CC_USSR2ACTS_CRTDATE_NN
  check ("CRT_DATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint CC_USSR2ACTS_STAFFID_NN
  check ("STAFF_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint CC_USSR2ACTS_STATEDATE_NN
  check ("STATE_DATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACTUALIZATIONS
  add constraint CC_USSR2ACTS_STATEID_NN
  check ("STATE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on USSR2_ACTUALIZATIONS to PUBLIC;
