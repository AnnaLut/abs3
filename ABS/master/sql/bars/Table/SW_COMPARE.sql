prompt ... 

exec bpa.alter_policy_info('SW_COMPARE', 'FILIAL', 'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('SW_COMPARE', 'WHOLE',  null, null, null, null );
/


prompt ... 


-- Create table
begin
    execute immediate 'create table SW_COMPARE
(
  id              NUMBER(38) not null,
  ddate_oper      DATE,
  kod_nbu         VARCHAR2(5),
  ref             NUMBER(38),
  userid_ref      NUMBER(38),
  is_resolve      NUMBER(1) not null,
  cause_err       NUMBER(38),
  comments        VARCHAR2(100),
  prn_file_own    NUMBER,
  prn_file_import NUMBER,
  userid          NUMBER(38) default sys_context(''bars_global'',''user_id'') not null,
  ddate           DATE not null,
  branch          VARCHAR2(30) default sys_context(''bars_context'',''user_branch'') not null,
  kf              VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'') not null
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
comment on table SW_COMPARE
  is 'Таблица квитовок';
-- Add comments to the columns 
comment on column SW_COMPARE.ddate_oper
  is 'дата перации';
comment on column SW_COMPARE.kod_nbu
  is 'код НБУ';
comment on column SW_COMPARE.is_resolve
  is 'признак решения расхождения (0-зеленый, 1 - желтый, 4,5 - синий)';
comment on column SW_COMPARE.cause_err
  is 'причина расхождения';
comment on column SW_COMPARE.prn_file_own
  is 'файл импорта ру';
comment on column SW_COMPARE.prn_file_import
  is 'файл импорта внешней системы';
comment on column SW_COMPARE.userid
  is 'пользователь квитовки';
comment on column SW_COMPARE.ddate
  is 'дата квитовки';

-- Create/Rebegin
begin
    execute immediate 'create index I_SWCOMPAR_DDATEOPER on SW_COMPARE (DDATE_OPER)
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_SWCOMPAR_EPRNFILEIMPORT on SW_COMPARE (PRN_FILE_IMPORT, IS_RESOLVE)
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_SWCOMPAR_EPRNFILEOWN on SW_COMPARE (PRN_FILE_OWN, IS_RESOLVE)
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_SWCOMPAR_TRDDATEOPER on SW_COMPARE (TRUNC(DDATE_OPER))
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_COMPARE
  add constraint PK_SWCOMPARE primary key (ID)
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




exec bpa.alter_policies('SW_COMPARE');