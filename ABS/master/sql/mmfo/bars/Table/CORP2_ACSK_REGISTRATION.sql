begin 
  bpa.alter_policy_info('CORP2_ACSK_REGISTRATION', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_ACSK_REGISTRATION', 'FILIAL',  null,  null, null, null);
end;

/
-- Create table
begin
    execute immediate 'create table CORP2_ACSK_REGISTRATION
(
  registration_id   NUMBER not null,
  rel_cust_id       NUMBER,
  acsk_user_id      VARCHAR2(128),
  registration_date DATE default sysdate not null
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_ACSK_REGISTRATION
  is 'Ca?a?no?iaai? a AONE ee??ioa';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_ACSK_REGISTRATION
  add constraint PK_CORP2_ACSK_REG_REG_ID primary key (REGISTRATION_ID)
  using index 
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_ACSK_REGISTRATION
  add constraint FK_REL_CUST_REG foreign key (REL_CUST_ID)
  references CORP2_REL_CUSTOMERS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table CORP2_ACSK_REGISTRATION
  add constraint CC_CORP2_ACSK_REG_REL_CUST_ID
  check ("REL_CUST_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on CORP2_ACSK_REGISTRATION to BARS_ACCESS_DEFROLE;
