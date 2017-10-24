exec bpa.alter_policy_info('COMPEN_PARAM_TYPES', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_PARAM_TYPES', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_PARAM_TYPES
(
  id          NUMBER(1) not null,
  discription VARCHAR2(64)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PARAM_TYPES
  is 'Типи параметрів для модуля ЦРКР';
-- Add comments to the columns 
comment on column COMPEN_PARAM_TYPES.id
  is 'Ідентифікатор типу';
comment on column COMPEN_PARAM_TYPES.discription
  is 'Опис типу';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PARAM_TYPES
  add constraint PK_COMPENPARAMTYPES primary key (ID)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_PARAM_TYPES to BARS_ACCESS_DEFROLE;
