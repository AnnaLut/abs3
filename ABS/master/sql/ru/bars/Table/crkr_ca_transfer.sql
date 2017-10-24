exec bpa.alter_policy_info('CRKR_CA_TRANSFER', 'filial', null, null, null, null);
exec bpa.alter_policy_info('CRKR_CA_TRANSFER', 'whole',  null,  null, null, null);

begin
    execute immediate 'create table CRKR_CA_TRANSFER
(
  reg_id   NUMBER,
  ref_id   NUMBER,
  reg_date DATE default sysdate
)
tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CRKR_CA_TRANSFER
  add constraint PK_CRKR_CA_TRANSFER primary key (reg_id)
  using index 
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CRKR_CA_TRANSFER
  is 'Переданий реєстр з ЦРКР для виплат';
-- Add comments to the columns 
comment on column CRKR_CA_TRANSFER.reg_id
  is 'ІД реєстру в ЦРКР';
comment on column CRKR_CA_TRANSFER.ref_id
  is 'ІД документу';
comment on column CRKR_CA_TRANSFER.reg_date
  is 'Дата створення запису';


-- Grant/Revoke object privileges 
grant select, insert on CRKR_CA_TRANSFER to BARS_ACCESS_DEFROLE;

