prompt ... 

exec bpa.alter_policy_info('SW_SYSTEM', 'FILIAL',  null,  null, null, null);
exec bpa.alter_policy_info('SW_SYSTEM', 'WHOLE',  null,  null, null, null);
/

prompt ... 


prompt ... 


-- Create table
begin
    execute immediate 'create table SW_SYSTEM
(
  systemcode VARCHAR2(10) not null,
  systemname VARCHAR2(30),
  vebservise VARCHAR2(30),
  close_date DATE,
  kod_nbu    VARCHAR2(5)
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
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table SW_SYSTEM
  is 'Список системм ШК и SW';
-- Add comments to the columns 
comment on column SW_SYSTEM.systemcode
  is 'код системмы';
comment on column SW_SYSTEM.systemname
  is 'имя системы';
comment on column SW_SYSTEM.vebservise
  is 'имя вебсервиса';
comment on column SW_SYSTEM.close_date
  is 'дата окончания использования системмы';
comment on column SW_SYSTEM.kod_nbu
  is 'Код НБУ';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_SYSTEM
  add constraint PK_SW_SYSTEM primary key (SYSTEMCODE)
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
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

