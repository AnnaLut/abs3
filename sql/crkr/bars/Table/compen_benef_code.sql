exec bpa.alter_policy_info('COMPEN_BENEF_CODE', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_BENEF_CODE', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_BENEF_CODE
(
  code  VARCHAR2(1) not null,
  descr VARCHAR2(100)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column COMPEN_BENEF_CODE.code
  is 'Код бенефіціара';
comment on column COMPEN_BENEF_CODE.descr
  is 'Опис ';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_BENEF_CODE
  add constraint PK_COMPEN_BENEF_CODE primary key (CODE)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on COMPEN_BENEF_CODE to BARS_ACCESS_USER;