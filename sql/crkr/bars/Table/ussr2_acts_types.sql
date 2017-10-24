exec bpa.alter_policy_info('USSR2_ACTS_TYPES', 'filial', null, null, null, null);
exec bpa.alter_policy_info('USSR2_ACTS_TYPES', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table USSR2_ACTS_TYPES
(
  id   VARCHAR2(100) not null,
  name VARCHAR2(300)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table USSR2_ACTS_TYPES
  is 'Типи актуалізації';
-- Add comments to the columns 
comment on column USSR2_ACTS_TYPES.id
  is 'Тип';
comment on column USSR2_ACTS_TYPES.name
  is 'Найменування';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table USSR2_ACTS_TYPES
  add constraint PK_USSR2ACTSTYPES primary key (ID)
  using index 
  tablespace BRSSMLI';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table USSR2_ACTS_TYPES
  add constraint CC_ACTSTYPES_NAME_NN
  check ("NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on USSR2_ACTS_TYPES to PUBLIC;
