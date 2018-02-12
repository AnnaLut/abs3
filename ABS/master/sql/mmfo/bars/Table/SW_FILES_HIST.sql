prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'SW_FILES_HIST', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_FILES_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table SW_FILES_HIST
(
  id         NUMBER,
  systemcode VARCHAR2(10) not null,
  operdate   DATE not null,
  state      NUMBER(2),
  data       CLOB,
  chg_date   DATE
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
comment on table SW_FILES_HIST
  is 'Список файлов импорта систем (история)';
-- Add comments to the columns 
comment on column SW_FILES_HIST.systemcode
  is 'код системы';
comment on column SW_FILES_HIST.operdate
  is 'дата импорта';
comment on column SW_FILES_HIST.state
  is 'состояние файла';
comment on column SW_FILES_HIST.data
  is 'файл';

  