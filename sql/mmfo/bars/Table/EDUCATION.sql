prompt ... 

begin
  BPA.ALTER_POLICY_INFO( 'EDUCATION', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'EDUCATION', 'FILIAL', null, null, null, null );
end;
/

-- Create table
begin
    execute immediate 'create table EDUCATION
(
  id   NUMBER(2),
  name VARCHAR2(50)
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table EDUCATION
  is 'Образование';
-- Add comments to the columns 
comment on column EDUCATION.id
  is 'Код освіти';
comment on column EDUCATION.name
  is 'Найменування освіти';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table EDUCATION
  add constraint PK_EDUCATION primary key (ID)
  using index 
  tablespace BRSSMLI
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


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table EDUCATION
  add constraint CC_EDUCATION_ID_NN
  check ("ID" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table EDUCATION
  add constraint CC_EDUCATION_NAME_NN
  check ("NAME" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on EDUCATION to BARSREADER_ROLE;
grant select on EDUCATION to BARSUPL;
grant select on EDUCATION to BARS_ACCESS_DEFROLE;
grant select on EDUCATION to BARS_DM;
grant select on EDUCATION to CUST001;
grant select on EDUCATION to DPT_ROLE;
grant select on EDUCATION to RCC_DEAL;
grant select on EDUCATION to UPLD;
grant select, insert, update, delete on EDUCATION to WR_ALL_RIGHTS;
grant select on EDUCATION to WR_CUSTREG;
