begin 
  bpa.alter_policy_info('CORP2_CUST_REL_USERS_MAP', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_CUST_REL_USERS_MAP', 'FILIAL',  null,  null, null, null);
end;

/
-- Create table
begin
    execute immediate 'create table CORP2_CUST_REL_USERS_MAP
(
  cust_id       NUMBER not null,
  rel_cust_id   NUMBER not null,
  sign_number   NUMBER(10) default 0 not null,
  user_id       VARCHAR2(128),
  is_approved   NUMBER,
  approved_type VARCHAR2(100),
  SEQUENTIAL_VISA VARCHAR2(1)

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
comment on table CORP2_CUST_REL_USERS_MAP
  is 'Связка клиент-пользоватль Corp2';
-- Add comments to the columns 
comment on column CORP2_CUST_REL_USERS_MAP.cust_id
  is 'ID клиента';
comment on column CORP2_CUST_REL_USERS_MAP.rel_cust_id
  is 'ID пользователя';
comment on column CORP2_CUST_REL_USERS_MAP.sign_number
  is 'Номер визы';
comment on column CORP2_CUST_REL_USERS_MAP.user_id
  is 'ID пользователя CORP2';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_CUST_REL_USERS_MAP
  add constraint FK_REL_CUSTOMER foreign key (REL_CUST_ID)
  references CORP2_REL_CUSTOMERS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_CUST_REL_USERS_MAP
  add constraint FK_CUSTOMER foreign key (CUST_ID)
  references CUSTOMER (RNK)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CORP2_CUST_REL_USERS_MAP
                       add constraint UK_rel_customer_um unique (CUST_ID, REL_CUST_ID)';
 exception when others then 
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on CORP2_CUST_REL_USERS_MAP to BARS_ACCESS_DEFROLE;
