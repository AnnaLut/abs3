exec bpa.alter_policy_info('COMPEN_PAYMENTS_REGISTRY', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('COMPEN_PAYMENTS_REGISTRY', 'whole',  null,  'E', 'E', 'E');

-- Create table
begin
    execute immediate 'create table COMPEN_PAYMENTS_REGISTRY
(
  reg_id     NUMBER not null,
  rnk        NUMBER,
  amount     NUMBER,
  state_id   NUMBER,
  type_id    NUMBER,
  regdate    DATE default sysdate,
  changedate DATE,
  msg        VARCHAR2(4000 CHAR),
  ref_oper   NUMBER,
  sign       RAW(128),
  mfo        VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  branch     VARCHAR2(30) default sys_context(''bars_context'',''user_branch''),
  mfo_client VARCHAR2(6),
  nls        VARCHAR2(15),
  kv         NUMBER(6)
)
tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PAYMENTS_REGISTRY
  is 'Реєстр платежів на виплату клієнту';
-- Add comments to the columns 
comment on column COMPEN_PAYMENTS_REGISTRY.reg_id
  is 'Ідентифікатор виплати';
comment on column COMPEN_PAYMENTS_REGISTRY.rnk
  is 'Ідентифікатор клієнту';
comment on column COMPEN_PAYMENTS_REGISTRY.amount
  is 'Сума виплати';
comment on column COMPEN_PAYMENTS_REGISTRY.state_id
  is 'Статус виплати';
comment on column COMPEN_PAYMENTS_REGISTRY.type_id
  is 'Тип виплати';
comment on column COMPEN_PAYMENTS_REGISTRY.regdate
  is 'Дата реєстрації виплати';
comment on column COMPEN_PAYMENTS_REGISTRY.changedate
  is 'Дата зміни ';
comment on column COMPEN_PAYMENTS_REGISTRY.msg
  is 'Інформація';
comment on column COMPEN_PAYMENTS_REGISTRY.ref_oper
  is 'Внутрішній номер операціїї (АБС)';
comment on column COMPEN_PAYMENTS_REGISTRY.sign
  is 'ЕЦП';


comment on column COMPEN_PAYMENTS_REGISTRY.branch
  is 'Відділення в якому виплата була створена';
comment on column COMPEN_PAYMENTS_REGISTRY.mfo_client
  is 'МФО Розрахункового рахунку клієнта';
comment on column COMPEN_PAYMENTS_REGISTRY.nls
  is 'Рахунок клієнта';
comment on column COMPEN_PAYMENTS_REGISTRY.kv
  is 'Код валюти';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint COMPEN_PAYMENTS_REG_ID primary key (REG_ID)
  using index 
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint COMPEN_PAYMENTS_REG_STATE foreign key (STATE_ID)
  references COMPEN_REGISTRY_STATES (STATE_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint COMPEN_PAYMENTS_REG_TYPE foreign key (TYPE_ID)
  references COMPEN_REGISTRY_TYPES (TYPE_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint СС_COMPEN_REG_AMOUNT_NN
  check ("AMOUNT" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint СС_COMPEN_REG_BRANCH_NN
  check ("BRANCH" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 











begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint СС_COMPEN_REG_REGDATE_NN
  check ("REGDATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint СС_COMPEN_REG_RNK_NN
  check ("RNK" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint СС_COMPEN_REG_STATE_NN
  check ("STATE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint СС_COMPEN_REG_TYPE_NN
  check ("TYPE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


-- Add/modify columns 
begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY rename column mfo to BRANCH_ACT';
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY modify branch_act VARCHAR2(30)';
    execute immediate 'update compen_payments_registry r
    			set r.branch_act = (select branch from customer where rnk = r.rnk)';    

 exception when others then 
    if sqlcode = -957 then null; else raise; 
    end if; 
end;
/ 


-- Add comments to the columns 
comment on column COMPEN_PAYMENTS_REGISTRY.branch_act  is 'Бранч в якому заведений клієнт';
-- Create/Recreate check constraints 

begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY drop constraint СС_COMPEN_REG_MFO_NN';
 exception when others then 
    if sqlcode = -2443 then null; else raise; 
    end if; 
end;
/ 



begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY
  add constraint СС_COMPEN_REG_BRANCH_ACT_NN
  check ("BRANCH_ACT" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


-- Add/modify columns 
begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY add user_id number default sys_context(''bars_global'', ''user_id'')';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY add dbcode VARCHAR2(32)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY add date_val_reg DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY add okpo VARCHAR2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'create index IDX_COMPEN_PAYM_REG_RNK_TYPE on COMPEN_PAYMENTS_REGISTRY (RNK, TYPE_ID)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PAYM_REG_TYPE_STATE on COMPEN_PAYMENTS_REGISTRY (TYPE_ID, STATE_ID)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


comment on column COMPEN_PAYMENTS_REGISTRY.dbcode
  is 'ДбКод померлого заповнюється при виплатах на поховання';
comment on column COMPEN_PAYMENTS_REGISTRY.date_val_reg
  is 'Дата тіпа валютування. Планова дата виплати';
comment on column COMPEN_PAYMENTS_REGISTRY.okpo
  is 'Якщо представник, то має бути ЄДРПОУ, у іншому випадку ІПН клієнта';
comment on column COMPEN_PAYMENTS_REGISTRY.user_id
  is 'Ідентифікатор користувача створивший запис реєстру';

-- Add/modify columns 
begin
    execute immediate 'alter table COMPEN_PAYMENTS_REGISTRY add user_id_send number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PAYMENTS_REGISTRY.user_id_send
  is 'Користувач відправник в АБС';
