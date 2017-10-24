exec bpa.alter_policy_info('COMPEN_REGISTRY_TYPES', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_REGISTRY_TYPES', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_REGISTRY_TYPES
(
  type_id   NUMBER not null,
  reg_code  VARCHAR2(10),
  type_name VARCHAR2(64)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_REGISTRY_TYPES
  is '“ипи реЇстр≥в на виплату';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_REGISTRY_TYPES
  add constraint PK_COMPEN_REGISTRY_TYPE primary key (TYPE_ID)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

