prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'SW_OPERATION', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_OPERATION', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table SW_OPERATION
(
  id   NUMBER not null,
  code VARCHAR2(20) not null,
  name VARCHAR2(50) not null
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
comment on table SW_OPERATION
  is 'Операции';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_OPERATION
  add constraint PK_SWOPERATION primary key (ID)
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
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

