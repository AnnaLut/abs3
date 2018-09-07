begin 
  bpa.alter_policy_info('CORP2_USER_VISA_STAMPS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_USER_VISA_STAMPS', 'FILIAL',  null,  null, null, null);
end;

/

-- Create table
begin
    execute immediate 'create table CORP2_USER_VISA_STAMPS
(
  user_id NUMBER not null,
  visa_id     NUMBER not null,
  visa_date   DATE,
  key_id      VARCHAR2(200),
  signature   CLOB
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_USER_VISA_STAMPS
  is 'Підписи профіля користувача до Corp2';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_USER_VISA_STAMPS
  add constraint FK_REL_CUSTOMER_STAMP foreign key (USER_ID)
  references CORP2_REL_CUSTOMERS (ID)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on CORP2_USER_VISA_STAMPS to BARS_ACCESS_DEFROLE;
