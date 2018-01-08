prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'CALL_TAB_NAME', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'CALL_TAB_NAME', 'FILIAL', null, null, null, null );
end;
/
prompt ... 


-- Create table
begin
    execute immediate 'create table CALL_TAB_NAME
(
  name VARCHAR2(30) not null
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
comment on table CALL_TAB_NAME
  is 'Список таблиц для вызова';
-- Add comments to the columns 
comment on column CALL_TAB_NAME.name
  is 'Имя таблицы';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CALL_TAB_NAME
  add constraint PK_CALLTABNAME primary key (NAME)
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

