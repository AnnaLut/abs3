
prompt ... 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''E_DEAL$BASE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''E_DEAL$BASE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''E_DEAL$BASE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/



begin
    execute immediate 'create table E_DEAL$BASE
(
  nd      INTEGER,
  rnk     INTEGER,
  sos     INTEGER default 10,
  cc_id   VARCHAR2(20),
  sdate   DATE,
  wdate   DATE,
  user_id INTEGER,
  sa      NUMBER,
  kf      VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  acc26   INTEGER,
  acc36   INTEGER,
  accd    INTEGER,
  accp    INTEGER,
  ndi     NUMBER(38)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

/ 
-- Add comments to the columns 
comment on column E_DEAL$BASE.nd
  is 'Реф. договора';
comment on column E_DEAL$BASE.rnk
  is 'Рег № клиента';
comment on column E_DEAL$BASE.sos
  is 'Состояние дог';
comment on column E_DEAL$BASE.cc_id
  is 'Ид. договора';
comment on column E_DEAL$BASE.sdate
  is 'Дата дог.';
comment on column E_DEAL$BASE.wdate
  is 'Дата пред.расч.';
comment on column E_DEAL$BASE.user_id
  is 'Код инспектора по дог';
comment on column E_DEAL$BASE.sa
  is 'Расч.сумма абонплаты';
comment on column E_DEAL$BASE.ndi
  is 'Унікальній реф дог по рах асс36';

-- Create/Rebegin
begin
    execute immediate 'create index IE_DEAL$BASE_ACC26 on E_DEAL$BASE (ACC26)
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
    execute immediate 'create index IE_DEAL$BASE_ACC36 on E_DEAL$BASE (ACC36)
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
    execute immediate 'alter table E_DEAL$BASE
  add constraint XPK_E_DEAL primary key (ND)
  using index 
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint UK_EDEAL$BASE unique (KF, ND)
  using index 
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode in( -1430,-2261) then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint FK2_EDEAL_ACCOUNTS foreign key (KF, ACC36)
  references ACCOUNTS (KF, ACC)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint FK3_EDEAL_ACCOUNTS foreign key (KF, ACCD)
  references ACCOUNTS (KF, ACC)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint FKP_EDEAL_ACCOUNTS foreign key (KF, ACCP)
  references ACCOUNTS (KF, ACC)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint FK_EDEAL_ACCOUNTS foreign key (KF, ACC26)
  references ACCOUNTS (KF, ACC)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint FK_EDEAL_CUSTOMER foreign key (RNK)
  references CUSTOMER (RNK)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint FK_EDEAL_KF foreign key (KF)
  references BANKS$BASE (MFO)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint FK_EDEAL_STAFF foreign key (USER_ID)
  references STAFF$BASE (ID)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint CC_EDEAL_ACC26_NN
  check ("ACC26" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint CC_EDEAL_KF_NN
  check ("KF" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint CC_EDEAL_SOS_NN
  check ("SOS" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint NK_E_DEAL_ND
  check ("ND" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table E_DEAL$BASE
  add constraint NK_E_DEAL_RNK
  check ("RNK" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on E_DEAL$BASE to BARSREADER_ROLE;
grant select on E_DEAL$BASE to BARSUPL;
grant select, insert, update, delete on E_DEAL$BASE to BARS_ACCESS_DEFROLE;
grant select on E_DEAL$BASE to BARS_DM;
grant select, insert, update, delete on E_DEAL$BASE to ELT;
grant select on E_DEAL$BASE to START1;
grant select on E_DEAL$BASE to UPLD;
grant select, insert, update, delete on E_DEAL$BASE to WR_ALL_RIGHTS;


PROMPT *** ALTER_POLICIES to E_DEAL$BASE ***
 exec bpa.alter_policies('E_DEAL$BASE');
