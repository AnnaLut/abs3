BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_OPERATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_OPERATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

-- Create table
begin
    execute immediate 'create table SAGO_OPERATION
(
  id   VARCHAR2(10) not null,
  name VARCHAR2(200)
)
tablespace BRSSMLD
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
comment on table SAGO_OPERATION
  is 'Список операций САГО';
-- Add comments to the columns 
comment on column SAGO_OPERATION.id
  is 'Код операції САГО';
comment on column SAGO_OPERATION.name
  is 'Назва операції';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SAGO_OPERATION
  add constraint PK_SAGO_OPERATION primary key (ID)
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

