exec bpa.alter_policy_info('COMPEN_OPER_STATES', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_OPER_STATES', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_OPER_STATES
(
  state_id   NUMBER not null,
  state_name VARCHAR2(64)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_OPER_STATES
  is 'Опис статусів операцій';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_OPER_STATES
  add constraint PK_COMPEN_OPER_STATE_ID primary key (STATE_ID)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on COMPEN_OPER_STATES to BARS_ACCESS_DEFROLE;
