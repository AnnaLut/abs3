exec bpa.alter_policy_info('CRKR_CA_TRANSFER_STATE', 'filial', null, null, null, null);
exec bpa.alter_policy_info('CRKR_CA_TRANSFER_STATE', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table CRKR_CA_TRANSFER_STATE
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
comment on table CRKR_CA_TRANSFER_STATE
  is 'Опис статусів по переданій інформації';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CRKR_CA_TRANSFER_STATE
  add constraint PK_CRKR_CA_TRANSFER_STATE primary key (STATE_ID)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on CRKR_CA_TRANSFER_STATE to BARS_ACCESS_DEFROLE;
