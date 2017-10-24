exec bpa.alter_policy_info('compen_portfolio_status', 'filial', null, null, null, null);
exec bpa.alter_policy_info('compen_portfolio_status', 'whole',  null,  null, null, null);


-- Create table
begin
    execute immediate 'create table COMPEN_PORTFOLIO_STATUS
(
  status_id   NUMBER not null,
  status_name VARCHAR2(64 CHAR),
  description VARCHAR2(255 CHAR)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PORTFOLIO_STATUS
  is 'Довідник статусів компенсаційних рахунків';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PORTFOLIO_STATUS
  add constraint PK_STATUS_ID primary key (STATUS_ID)
  using index 
  tablespace BRSSMLD
';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table COMPEN_PORTFOLIO_STATUS
  add constraint CC_COMPEN_PORTFOLIO_STATUS_NN
  check ("STATUS_NAME" is not null)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

