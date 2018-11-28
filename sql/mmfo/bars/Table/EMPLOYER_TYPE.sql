prompt ... 

begin
  BPA.ALTER_POLICY_INFO( 'EMPLOYER_TYPE', 'WHOLE' , NULL, NULL, NULL, NULL );
BPA.ALTER_POLICY_INFO( 'EMPLOYER_TYPE', 'FILIAL', null, null, null, null );
end;

/


-- Create table
begin
    execute immediate 'create table EMPLOYER_TYPE
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
comment on table EMPLOYER_TYPE
  is 'Тип роботодавця';
-- Add comments to the columns 
comment on column EMPLOYER_TYPE.id
  is 'Код типу роботодавця';
comment on column EMPLOYER_TYPE.name
  is 'Найменування типу роботодавця';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table EMPLOYER_TYPE
  add constraint PK_EMPLOYER_TYPE primary key (ID)
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
    execute immediate 'alter table EMPLOYER_TYPE
  add constraint CC_EMPLOYER_TYPE_ID_NN
  check ("ID" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table EMPLOYER_TYPE
  add constraint CC_EMPLOYER_TYPE_NAME_NN
  check ("NAME" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on EMPLOYER_TYPE to BARSREADER_ROLE;
grant select on EMPLOYER_TYPE to BARSUPL;
grant select on EMPLOYER_TYPE to BARS_ACCESS_DEFROLE;
grant select on EMPLOYER_TYPE to BARS_DM;
grant select on EMPLOYER_TYPE to CUST001;
grant select on EMPLOYER_TYPE to DPT_ROLE;
grant select on EMPLOYER_TYPE to RCC_DEAL;
grant select on EMPLOYER_TYPE to UPLD;
grant select, insert, update, delete on EMPLOYER_TYPE to WR_ALL_RIGHTS;
grant select on EMPLOYER_TYPE to WR_CUSTREG;
