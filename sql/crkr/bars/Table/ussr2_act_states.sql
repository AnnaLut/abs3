exec bpa.alter_policy_info('USSR2_ACT_STATES', 'filial', null, null, null, null);
exec bpa.alter_policy_info('USSR2_ACT_STATES', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table USSR2_ACT_STATES
(
  id   VARCHAR2(100) not null,
  name VARCHAR2(300),
  ord  NUMBER
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table USSR2_ACT_STATES
  is 'Статуси авторизації';
-- Add comments to the columns 
comment on column USSR2_ACT_STATES.id
  is 'Ідентифікатор';
comment on column USSR2_ACT_STATES.name
  is 'Найменування';
comment on column USSR2_ACT_STATES.ord
  is 'Порядок';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table USSR2_ACT_STATES
  add constraint PK_USSR2ACTSTATES primary key (ID)
  using index 
  tablespace BRSSMLI';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table USSR2_ACT_STATES
  add constraint CC_ACTSTATES_NAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on USSR2_ACT_STATES to PUBLIC;
