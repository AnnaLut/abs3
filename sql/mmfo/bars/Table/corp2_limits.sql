begin 
  bpa.alter_policy_info('CORP2_LIMITS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_LIMITS', 'FILIAL',  null,  null, null, null);
end;
/


-- Create table
begin
    execute immediate 'create table CORP2_LIMITS
(
  limit_id          VARCHAR2(12),
  description       VARCHAR2(512),
  doc_sum           NUMBER(38,2),
  doc_created_count NUMBER(5),
  doc_sent_count    NUMBER(5)
)
rowdependencies';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_LIMITS
  is 'Типи лімітів version 1.0';
-- Add comments to the columns 
comment on column CORP2_LIMITS.limit_id
  is 'Ідентифікатор типа ліміта';
comment on column CORP2_LIMITS.description
  is 'Опис';
comment on column CORP2_LIMITS.doc_sum
  is 'Сума документів введених за день';
comment on column CORP2_LIMITS.doc_created_count
  is 'Кількість документів введених за день';
comment on column CORP2_LIMITS.doc_sent_count
  is 'Кількість документів відправлених в банк за день';
-- Create/Recreate check constraints 


begin
    execute immediate 'alter table CORP2_LIMITS
  add constraint PK_CUSTLIMITS primary key  (LIMIT_ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -1430 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CORP2_LIMITS
  add constraint CC_CUSTLIMITS_CCOUNT_NN
  check ("DOC_CREATED_COUNT" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_LIMITS
  add constraint CC_CUSTLIMITS_DESC_NN
  check ("DESCRIPTION" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_LIMITS
  add constraint CC_CUSTLIMITS_LIMITID_NN
  check ("LIMIT_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_LIMITS
  add constraint CC_CUSTLIMITS_SCOUNT_NN
  check ("DOC_SENT_COUNT" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_LIMITS
  add constraint CC_CUSTLIMITS_SUM_NN
  check ("DOC_SUM" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

grant select on CORP2_LIMITS to BARS_ACCESS_DEFROLE;