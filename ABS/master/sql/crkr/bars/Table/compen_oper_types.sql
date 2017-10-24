exec bpa.alter_policy_info('COMPEN_OPER_TYPES', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_OPER_TYPES', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_OPER_TYPES
(
  type_id   NUMBER not null,
  oper_code VARCHAR2(30),
  text      VARCHAR2(254)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_OPER_TYPES
  is 'Типи операцій';
-- Add comments to the columns 
comment on column COMPEN_OPER_TYPES.type_id
  is 'Ідентифікатор типу операції';
comment on column COMPEN_OPER_TYPES.oper_code
  is 'Код типу операції';
comment on column COMPEN_OPER_TYPES.text
  is 'Назва операції';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_OPER_TYPES
  add constraint PK_COMPEN_TYPE_ID primary key (TYPE_ID)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on COMPEN_OPER_TYPES to BARS_ACCESS_DEFROLE;
