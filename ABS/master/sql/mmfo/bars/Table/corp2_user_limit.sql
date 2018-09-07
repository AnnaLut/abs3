begin 
  bpa.alter_policy_info('CORP2_USER_LIMIT', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_USER_LIMIT', 'FILIAL',  null,  null, null, null);
end;
/


begin
    execute immediate 'create table CORP2_USER_LIMIT
(
  limit_id          VARCHAR2(12),
  user_id           INTEGER default sys_context(''core_global_ctx'',''user_id''),
  login_type        INTEGER default 0,
  doc_sum           NUMBER(38,2),
  doc_created_count NUMBER(5),
  doc_sent_count    NUMBER(5),
  doc_date_lim      DATE
)
tablespace BRSMDLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )
rowdependencies';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

comment on table CORP2_USER_LIMIT
  is 'Типи лімітів version 1.0';
-- Add comments to the columns 
comment on column CORP2_USER_LIMIT.limit_id
  is 'Ідентифікатор типа ліміта';
comment on column CORP2_USER_LIMIT.user_id
  is 'Ідентифікатор користувача';
comment on column CORP2_USER_LIMIT.doc_sum
  is 'Сума документів введених за день';
comment on column CORP2_USER_LIMIT.doc_created_count
  is 'Кількість документів введених за день';
comment on column CORP2_USER_LIMIT.doc_sent_count
  is 'Кількість документів відправлених в банк за день';
-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_USER_LIMIT
  add constraint PK_CUSTLIMITTEMPL primary key (USER_ID, LOGIN_TYPE)
  using index 
  tablespace BRSMDLD
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_USER_LIMIT
  add constraint FK_CUSTLIMITTEMPL_COREUSERS foreign key (USER_ID)
  references CORP2_REL_CUSTOMERS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_USER_LIMIT
                       add constraint FK_CUSTLIMITTEMPL_LIMITID foreign key (LIMIT_ID)
                       references CORP2_LIMITS (LIMIT_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table CORP2_USER_LIMIT
  add constraint CC_CUSTLIMITTEMPL_LIMITID_NN
  check ("LIMIT_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_USER_LIMIT
  add constraint CC_CUSTLIMITTEMPL_LOGIN_NN
  check ("LOGIN_TYPE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_USER_LIMIT
  add constraint CC_CUSTLIMITTEMPL_USERID_NN
  check ("USER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter on CORP2_USER_LIMIT to BARS_ACCESS_DEFROLE;
