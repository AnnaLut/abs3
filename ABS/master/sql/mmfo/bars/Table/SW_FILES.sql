prompt ... 

exec bpa.alter_policy_info('SW_FILES', 'FILIAL',  null,  null, null, null);
exec bpa.alter_policy_info('SW_FILES', 'WHOLE',  null,  null, null, null);
/

prompt ... 


prompt ... 


-- Create table
begin
    execute immediate 'create table SW_FILES
(
  id         NUMBER not null,
  systemcode VARCHAR2(10),
  operdate   DATE,
  state      NUMBER(2),
  data       CLOB
  
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
comment on table SW_FILES
  is 'Список файлов импорта систем';
-- Add comments to the columns 
comment on column SW_FILES.systemcode
  is 'код системы';
comment on column SW_FILES.operdate
  is 'дата импорта';
comment on column SW_FILES.state
  is 'состояние файла';
comment on column SW_FILES.data
  is 'файл';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_FILES
  add constraint PK_SW_FILES primary key (ID)
  using index 
  tablespace BRSDYNI
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


begin
    execute immediate 'alter table SW_FILES
  add constraint UK_SW_FILES_SYSTEMCODEOPERDATE unique (SYSTEMCODE, OPERDATE)
  using index 
  tablespace BRSDYNI
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
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table SW_FILES
  add constraint FK_SW_FILES_SYSTEMCODE foreign key (SYSTEMCODE)
  references SW_SYSTEM (SYSTEMCODE)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

