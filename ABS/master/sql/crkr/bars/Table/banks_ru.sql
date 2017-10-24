exec bpa.alter_policy_info('BANKS_RU', 'filial', null, null, null, null);
exec bpa.alter_policy_info('BANKS_RU', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table BANKS_RU
(
  ru   INTEGER,
  mfo  VARCHAR2(12) not null,
  name VARCHAR2(38),
  rnk  NUMBER,
  okpo VARCHAR2(8)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table BANKS_RU
  add constraint XPK_BANKS_RU primary key (MFO)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on BANKS_RU to BARS_ACCESS_DEFROLE;
grant select, insert, update, delete on BANKS_RU to START1;
