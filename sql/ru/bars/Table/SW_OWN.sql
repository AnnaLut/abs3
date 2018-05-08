prompt ... 

exec bpa.alter_policy_info('SW_OWN', 'FILIAL', 'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('SW_OWN', 'WHOLE',  null, null, null, null );

/


prompt ... 


-- Create table
begin
    execute immediate 'create table SW_OWN
(
  kf          VARCHAR2(6),
  ref         NUMBER(38) not null,
  tt          CHAR(3),
  tt_name     VARCHAR2(70),
  oper_branch VARCHAR2(30),
  pdat        DATE not null,
  fdat        DATE not null,
  mtsc        VARCHAR2(220),
  dk          NUMBER(1) not null,
  s           NUMBER(24,2),
  nls         VARCHAR2(15),
  kv          VARCHAR2(3),
  kod_nbu     VARCHAR2(5),
  name        VARCHAR2(25),
  acc_branch  VARCHAR2(30),
  ob22        CHAR(2),
  compare_id  NUMBER(38) default 0 not null,
  prn_file    NUMBER,
  nazn        VARCHAR2(160),
  sk          NUMBER(24,2)
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
comment on table SW_OWN
  is 'Таблица операций по "Single Window"';
-- Add comments to the columns 
comment on column SW_OWN.kf
  is 'МФО';
comment on column SW_OWN.ref
  is 'реф';
comment on column SW_OWN.tt
  is 'код операции';
comment on column SW_OWN.tt_name
  is 'название операции';
comment on column SW_OWN.oper_branch
  is 'бранч операции';
comment on column SW_OWN.mtsc
  is 'код транзакции';
comment on column SW_OWN.dk
  is 'признак Дт/Кт';
comment on column SW_OWN.s
  is 'сумма';
comment on column SW_OWN.nls
  is 'счет';
comment on column SW_OWN.kv
  is 'валюта';
comment on column SW_OWN.kod_nbu
  is 'код НБУ';
comment on column SW_OWN.name
  is 'имя НБУ';
comment on column SW_OWN.acc_branch
  is 'бранч счета';
comment on column SW_OWN.compare_id
  is 'идентификатор квитовки';
comment on column SW_OWN.prn_file
  is 'фал синхронизации';
comment on column SW_OWN.nazn
  is 'назначение платежа';
comment on column SW_OWN.sk
  is 'сумма комиссии';


begin
    execute immediate 'create index I_SW_OWN_COMPAREID on SW_OWN (COMPARE_ID)
  nologging  local';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_SW_OWN_FDAT on SW_OWN (FDAT)
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
    execute immediate 'create index I_SW_OWN_KF on SW_OWN (KF)
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
    execute immediate 'create index I_SW_OWN_MTSC on SW_OWN (MTSC)
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
    execute immediate 'create index I_SW_OWN_TRFDAT on SW_OWN (TRUNC(FDAT))
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
    execute immediate 'alter table SW_OWN
  add constraint PK_SW_OWN primary key (REF, DK)
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
    execute immediate 'alter table SW_OWN
  add constraint FK_SWOWN_PRNFILE foreign key (PRN_FILE)
  references SW_CA_FILES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 



-- Grant/Revoke object privileges 
grant select, insert, update on SW_OWN to BARS_ACCESS_DEFROLE;


exec bpa.alter_policies('SW_OWN');

