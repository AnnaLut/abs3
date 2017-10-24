exec bpa.alter_policy_info('COMPEN_OB22', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_OB22', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_OB22
(
  ob22 CHAR(2) not null,
  text VARCHAR2(200)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_OB22
  is 'Компенсаційні вклади, ОБ22';
-- Add comments to the columns 
comment on column COMPEN_OB22.ob22
  is 'ОБ22';
comment on column COMPEN_OB22.text
  is 'Розшифровка';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_OB22
  add constraint PK_COMPEN_OB22 primary key (OB22)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on COMPEN_OB22 to BARS_ACCESS_USER;
grant select, insert, update, delete on COMPEN_OB22 to START1;
grant select, insert, update, delete on COMPEN_OB22 to WR_ALL_RIGHTS;
