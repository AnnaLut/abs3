prompt ... 

exec bpa.alter_policy_info('SW_IMPORT', 'FILIAL', 'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('SW_IMPORT', 'WHOLE',  null, null, null, null );
/

prompt ... 


prompt ... 


-- Create table
begin
    execute immediate 'create table SW_IMPORT
(
  systemcode     VARCHAR2(10) not null,
  operdate       DATE not null,
  transactionid  VARCHAR2(30) not null,
  barspointcode  VARCHAR2(30) not null,
  amount         NUMBER(24,2) not null,
  currency       VARCHAR2(3) not null,
  operation      NUMBER(3) not null,
  kf             VARCHAR2(6) not null,
  compare_id     NUMBER(38) default 0 not null,
  prn_file       NUMBER,
  totalcomission NUMBER(24,2),
  bankcomission  NUMBER(24,2),
  trn            VARCHAR2(30)
)
partition by list (compare_id)
(
  partition COMPARE_NO values (0)
    tablespace BRSDYND
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 64K
      minextents 1
      maxextents unlimited
    ),
  partition COMPARE_YES values (DEFAULT)
    tablespace BRSDYND
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 64K
      minextents 1
      maxextents unlimited
    )
 )
 ENABLE ROW MOVEMENT';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table SW_IMPORT
  is 'ƒанные с разных систем';
-- Add comments to the columns 
comment on column SW_IMPORT.systemcode
  is 'код системы';
comment on column SW_IMPORT.operdate
  is 'дата';
comment on column SW_IMPORT.transactionid
  is 'ид транзакции';
comment on column SW_IMPORT.barspointcode
  is 'бранч';
comment on column SW_IMPORT.amount
  is 'сумма';
comment on column SW_IMPORT.currency
  is 'валюта';
comment on column SW_IMPORT.operation
  is 'код операции';
comment on column SW_IMPORT.totalcomission
  is 'обща€ комисси€';
comment on column SW_IMPORT.bankcomission
  is 'банковска€ комисси€';
comment on column SW_IMPORT.trn
  is 'контрольний номер переказу';

begin
    execute immediate 'create index I_SW_IMPORT_COMPAREID on SW_IMPORT (COMPARE_ID)
  nologging  local';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_SW_IMPORT_OPERDATE on SW_IMPORT (OPERDATE)
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
    execute immediate 'create index I_SW_IMPORT_PRNFILE on SW_IMPORT (PRN_FILE)
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
    execute immediate 'create index I_SW_IMPORT_TROPERDATE on SW_IMPORT (TRUNC(OPERDATE))
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
    execute immediate 'alter table SW_IMPORT
  add constraint PK_SW_IMPORT primary key (SYSTEMCODE, TRANSACTIONID, OPERATION)
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
    execute immediate 'alter table SW_IMPORT
  add constraint FK_SWIMPORT_PRNFILE foreign key (PRN_FILE)
  references SW_FILES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


exec bpa.alter_policies('SW_IMPORT');