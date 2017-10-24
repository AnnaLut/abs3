exec bpa.alter_policy_info('COMPEN_OPER', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('COMPEN_OPER', 'whole',  null,  'E', 'E', 'E');


-- Create table
begin
    execute immediate 'create table COMPEN_OPER
(
  oper_id      NUMBER not null,
  oper_type    NUMBER,
  compen_id    NUMBER,
  compen_bound NUMBER,
  rnk          NUMBER,
  amount       NUMBER,
  regdate      DATE default sysdate,
  changedate   DATE,
  state        NUMBER,
  msg          VARCHAR2(4000 CHAR),
  branch       VARCHAR2(30) default sys_context(''bars_context'',''user_branch''),
  mfo          VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  reg_id       NUMBER,
  ref_id       NUMBER,
  user_id      NUMBER
)
tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_OPER
  is 'Операції над вкладами';
-- Add comments to the columns 
comment on column COMPEN_OPER.oper_id
  is 'Ідлентифікатор операції';
comment on column COMPEN_OPER.oper_type
  is 'Тип операції';
comment on column COMPEN_OPER.compen_id
  is 'Ідентифікатор вкладу';
comment on column COMPEN_OPER.compen_bound
  is 'Пов''язаний ідентифікатор вкладу';
comment on column COMPEN_OPER.rnk
  is 'Ідентифікатор клієнта';
comment on column COMPEN_OPER.amount
  is 'Сума операції';
comment on column COMPEN_OPER.regdate
  is 'Дата реєстрації операції';
comment on column COMPEN_OPER.changedate
  is 'Дата модифікації операції';
comment on column COMPEN_OPER.state
  is 'Статус операції';
comment on column COMPEN_OPER.msg
  is 'Інформація';
comment on column COMPEN_OPER.branch
  is 'Відділення в якому операція була створена';
comment on column COMPEN_OPER.mfo
  is 'МФО в якому операція була створена';
comment on column COMPEN_OPER.reg_id
  is 'Ідентифікатор реєстру на виплату в який входить сума операції';
comment on column COMPEN_OPER.ref_id
  is 'Ідентифікатор операції В АБС';
comment on column COMPEN_OPER.user_id
  is 'Ідентифікатор користувача створивший операцію';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_OPER
  add constraint PK_COMPEN_OPER_ID primary key (OPER_ID)
  using index 
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint FK_COMPEN_OPER_BOUND_ID foreign key (COMPEN_BOUND)
  references COMPEN_PORTFOLIO (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint FK_COMPEN_OPER_COMPEN_ID foreign key (COMPEN_ID)
  references COMPEN_PORTFOLIO (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint FK_COMPEN_OPER_REG_ID foreign key (REG_ID)
  references COMPEN_PAYMENTS_REGISTRY (REG_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint FK_COMPEN_OPER_RNK foreign key (RNK)
  references COMPEN_CLIENTS (RNK)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint FK_COMPEN_OPER_STATE foreign key (STATE)
  references COMPEN_OPER_STATES (STATE_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint FK_COMPEN_OPER_TYPE foreign key (OPER_TYPE)
  references COMPEN_OPER_TYPES (TYPE_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table COMPEN_OPER
  add constraint СС_COMPEN_OPER_BRANCH_NN
  check ("BRANCH" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint СС_COMPEN_OPER_COMPEN_ID_NN
  check ("COMPEN_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint СС_COMPEN_OPER_MFO_NN
  check ("MFO" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint СС_COMPEN_OPER_REGDATE_NN
  check ("REGDATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


--=======================-
--видалення констрейну який не потрібен і був створений з кириличними СС замість латинських CC
begin
    execute immediate 'alter table COMPEN_OPER
  drop constraint СС_COMPEN_OPER_RNK_NN';
 exception when others then 
    if sqlcode = -2443 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'alter table COMPEN_OPER
  drop constraint CC_COMPEN_OPER_RNK_NN';
 exception when others then 
    if sqlcode = -2443 then null; else raise; 
    end if; 
end;
/ 
--=======================-


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint СС_COMPEN_OPER_STATE_NN
  check ("STATE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint СС_COMPEN_OPER_TYPE_NN
  check ("OPER_TYPE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_OPER add visa_user_id NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER add visa_date DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER add changeuser_id NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_OPER add oper_ost NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

alter table COMPEN_OPER modify user_id default sys_context('bars_global', 'user_id');

begin
    execute immediate 'create index IDX_COMP_OPER_COMP_ID_STATE on COMPEN_OPER (COMPEN_ID, STATE)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMP_OPER_RNK on COMPEN_OPER (RNK)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


comment on column COMPEN_OPER.visa_user_id
  is 'Ідентифікатор користувача завізувавший операцію';
comment on column COMPEN_OPER.visa_date
  is 'Дата візування';
comment on column COMPEN_OPER.changeuser_id
  is 'Користувач останньої зміни';
comment on column COMPEN_OPER.oper_ost
  is 'Залишок  після операції';

begin
    execute immediate 'alter table COMPEN_OPER add benef_idb INTEGER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_OPER.benef_idb
  is 'Код беніфіціара прив''язаного до вкладу';


begin
    execute immediate 'alter table COMPEN_OPER
  add constraint FK_COMPEN_OPER_BENEF foreign key (COMPEN_ID, BENEF_IDB)
  references compen_benef (ID_COMPEN, IDB)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Grant/Revoke object privileges 
grant select on COMPEN_OPER to BARS_ACCESS_DEFROLE;
