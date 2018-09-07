begin 
  bpa.alter_policy_info('CORP2_REL_CUSTOMERS_ADDRESS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_REL_CUSTOMERS_ADDRESS', 'FILIAL',  null,  null, null, null);
end;

/
-- Create table
begin
    execute immediate 'create table CORP2_REL_CUSTOMERS_ADDRESS
(
  rel_cust_id  NUMBER not null,
  region_id    NUMBER,
  city         VARCHAR2(200),
  street       VARCHAR2(500),
  house_number VARCHAR2(100),
  addition     VARCHAR2(4000)
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
comment on table CORP2_REL_CUSTOMERS_ADDRESS
  is 'Aa?ane iiaycaieo in?a eio?ei iaaaii ainooi ai CorpLight';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_REL_CUSTOMERS_ADDRESS
  add constraint FK_REL_CUSTOMER_ADDR foreign key (REL_CUST_ID)
  references CORP2_REL_CUSTOMERS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on CORP2_REL_CUSTOMERS_ADDRESS to BARS_ACCESS_DEFROLE;
