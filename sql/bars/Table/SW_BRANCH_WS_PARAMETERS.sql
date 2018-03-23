prompt ... 


begin 
  BPA.ALTER_POLICY_INFO( 'SW_BRANCH_WS_PARAMETERS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_BRANCH_WS_PARAMETERS', 'FILIAL', null, null, null, null );
end;
/


prompt ... 


-- Create table
begin
    execute immediate 'create table SW_BRANCH_WS_PARAMETERS
(
  kf          VARCHAR2(6) not null,
  branch_name VARCHAR2(300 CHAR),
  url         VARCHAR2(300 CHAR) not null,
  login       VARCHAR2(30 CHAR),
  password    VARCHAR2(60)
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


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_BRANCH_WS_PARAMETERS
  add constraint PK_SW_BRANCHWSPARAMETERS primary key (KF)
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

