prompt ... 


begin
    execute immediate 'create table BARS_DM.CREDITS_DYN
(
  id                      NUMBER(15) not null,
  per_id                  NUMBER,
  nd                      NUMBER(38),
  rnk                     NUMBER(15),
  kf                      VARCHAR2(12),
  cc_id                   VARCHAR2(50),
  sdate                   DATE,
  branch                  VARCHAR2(30),
  vidd                    INTEGER,
  next_pay                DATE,
  probl_rozgl             VARCHAR2(30),
  probl_date              DATE,
  probl                   VARCHAR2(10),
  cred_change             VARCHAR2(30),
  cred_datechange         DATE,
  borg                    NUMBER(15,2),
  borg_tilo               NUMBER(15,2),
  borg_proc               NUMBER(15,2),
  prosr1                  DATE,
  prosr2                  DATE,
  prosrcnt                INTEGER,
  borg_prosr              NUMBER(15,2),
  borg_tilo_prosr         NUMBER(15,2),
  borg_proc_prosr         NUMBER(15,2),
  penja                   NUMBER(15,2),
  shtraf                  NUMBER(15,2),
  pay_tilo                NUMBER(15,2),
  pay_proc                NUMBER(15,2),
  cat_ryzyk               VARCHAR2(30),
  cred_to_prosr           DATE,
  borg_to_pbal            DATE,
  vart_majna              NUMBER(15,2),
  pog_finish              DATE,
  prosr_fact_cnt          NUMBER(4),
  next_pay_all            NUMBER(15,2),
  next_pay_tilo           NUMBER(15,2),
  next_pay_proc           NUMBER(15,2),
  sos                     INTEGER,
  last_pay_date           DATE,
  last_pay_suma           NUMBER(15,2),
  prosrcnt_proc           INTEGER,
  tilo_prosr_uah          NUMBER(15,2),
  proc_prosr_uah          NUMBER(15,2),
  borg_tilo_uah           NUMBER(15,2),
  borg_proc_uah           NUMBER(15,2),
  pay_vdvs                NUMBER(15,2),
  amount_commission       NUMBER(15,2),
  amount_prosr_commission NUMBER(15,2),
  es000                   VARCHAR2(24),
  es003                   VARCHAR2(24),
  vidd_custtype           NUMBER(1)
)
tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add/modify columns 
begin
  execute immediate 'alter table bars_dm.credits_dyn add ES000 varchar2(24)';
exception 
  when others then
    if sqlcode = -1430 then null;
    end if;
end;
/
begin
  execute immediate 'alter table bars_dm.credits_dyn add ES003 varchar2(24)';
exception 
  when others then
    if sqlcode = -1430 then null;
    end if;
end;
/
begin
  execute immediate 'alter table BARS_DM.CREDITS_DYN add vidd_custtype NUMBER(1)';
exception 
  when others then
    if sqlcode = -1430 then null;
    end if;
end;
/


-- Add comments to the columns 
comment on table BARS_DM.CREDITS_DYN is 'Кредити, динамічні дані';
comment on column BARS_DM.CREDITS_DYN.id is 'Ідентифікатор запису';
comment on column BARS_DM.CREDITS_DYN.per_id is 'Ідентифікатор періоду';
comment on column BARS_DM.CREDITS_DYN.nd is 'Ідентифікатор КД';
comment on column BARS_DM.CREDITS_DYN.rnk is 'РНК';
comment on column BARS_DM.CREDITS_DYN.kf is 'МФО РУ';
comment on column BARS_DM.CREDITS_DYN.cc_id is '№ договору';
comment on column BARS_DM.CREDITS_DYN.sdate is 'Дата укладання договору';
comment on column BARS_DM.CREDITS_DYN.branch is 'Бранч';
comment on column BARS_DM.CREDITS_DYN.vidd is 'Тип договору';
comment on column BARS_DM.CREDITS_DYN.next_pay is 'Дата здійснення наступного платежу';
comment on column BARS_DM.CREDITS_DYN.probl_rozgl is 'На стадії розгляду питання про визнання проблемним ';
comment on column BARS_DM.CREDITS_DYN.probl_date is 'Дата визнання кредиту проблемним';
comment on column BARS_DM.CREDITS_DYN.probl is 'Визнання кредиту проблемним';
comment on column BARS_DM.CREDITS_DYN.cred_change is 'Зміна умов кредитування ';
comment on column BARS_DM.CREDITS_DYN.cred_datechange is 'Дата здійснення зміни умов кредитування';
comment on column BARS_DM.CREDITS_DYN.borg is 'Сума заборгованості за кредитом у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.borg_tilo is 'Сума заборгованості за тілом кредиту у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.borg_proc is 'Сума заборгованості за відсотками у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.prosr1 is 'Дата виникнення першої прострочки за кредитом';
comment on column BARS_DM.CREDITS_DYN.prosr2 is 'Дата виникнення другої прострочки за кредитом';
comment on column BARS_DM.CREDITS_DYN.prosrcnt is 'Кількість прострочених платежів';
comment on column BARS_DM.CREDITS_DYN.borg_prosr is 'Сума простроченої заборгованості за кредитом у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.borg_tilo_prosr is 'Сума простроченої заборгованості за тілом у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.borg_proc_prosr is 'Сума простроченої заборгованості за процентами у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.penja is 'Сума пені у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.shtraf is 'Сума нарахованих штрафів у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.pay_tilo is 'Сума повернутих коштів по кредиту в поточному році, грн';
comment on column BARS_DM.CREDITS_DYN.pay_proc is 'Сума повернутих процентів за кредитом в поточному році, грн';
comment on column BARS_DM.CREDITS_DYN.cat_ryzyk is 'Категорія ризику кредитної операції';
comment on column BARS_DM.CREDITS_DYN.cred_to_prosr is 'Дата віднесення кредиту на рахунок простроченої заборгованості';
comment on column BARS_DM.CREDITS_DYN.borg_to_pbal is 'Дата перенесення заборгованості на позабалансові рахунки';
comment on column BARS_DM.CREDITS_DYN.vart_majna is 'Вартість прийнятого майна на баланс, грн ';
comment on column BARS_DM.CREDITS_DYN.pog_finish is 'Чинна дата погашення кредиту згідно з останніми змінами';
comment on column BARS_DM.CREDITS_DYN.prosr_fact_cnt is 'Кількість фактів виходу на просрочку';
comment on column BARS_DM.CREDITS_DYN.next_pay_all is 'Сума наступного платежу, всього';
comment on column BARS_DM.CREDITS_DYN.next_pay_tilo is 'Сума наступного платежу, тіло';
comment on column BARS_DM.CREDITS_DYN.next_pay_proc is 'Сума наступного платежу, відсотки';
comment on column BARS_DM.CREDITS_DYN.sos is 'Стан договору';
comment on column BARS_DM.CREDITS_DYN.last_pay_date is 'Дата останього платежу';
comment on column BARS_DM.CREDITS_DYN.last_pay_suma is 'Сума останього платежу';
comment on column BARS_DM.CREDITS_DYN.prosrcnt_proc is 'Кількість прострочених непогашених платежів по відсотках';
comment on column BARS_DM.CREDITS_DYN.tilo_prosr_uah is 'Сума простроченої заборгованості за тілом у гривні';
comment on column BARS_DM.CREDITS_DYN.proc_prosr_uah is 'Сума простроченої заборгованості за відсотками у гривні';
comment on column BARS_DM.CREDITS_DYN.borg_tilo_uah is 'Сума заборгованості за тілом у гривні';
comment on column BARS_DM.CREDITS_DYN.borg_proc_uah is 'Сума заборгованості за відсотками у гривні';
comment on column BARS_DM.CREDITS_DYN.pay_vdvs is 'Всього перераховано коштів від ВДВС, грн.';
comment on column BARS_DM.CREDITS_DYN.amount_commission is 'Сума комісії за КД у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.amount_prosr_commission is 'Сума простроченої комісії за КД у валюті кредиту';
comment on column BARS_DM.CREDITS_DYN.vidd_custtype is 'Тип клиента по виду договора: 3 - физическое лицо, 2 - юридическое лицо, 1 - банк';

begin
    execute immediate 'create index BARS_DM.I_CREDDYN_PERID on BARS_DM.CREDITS_DYN (PER_ID) tablespace BRSDYNI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_DYN
  add constraint PK_CREDITS_DYN primary key (ID)
  using index tablespace BRSDYNI';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_DYN
  add constraint FK_CREDDYN_PERID_PERIOD_ID foreign key (PER_ID)
  references BARS_DM.PERIODS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_DYN
  add constraint CC_CREDDYN_BRANCH_NN
  check ("BRANCH" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_DYN
  add constraint CC_CREDDYN_KF_NN
  check ("KF" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_DYN
  add constraint CC_CREDDYN_ND_NN
  check ("ND" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_DYN
  add constraint CC_CREDDYN_PERID_NN
  check ("PER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_DYN
  add constraint CC_CREDDYN_RNK_NN
  check ("RNK" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

grant select on BARS_DM.CREDITS_DYN to BARS;
grant select on BARS_DM.CREDITS_DYN to BARSUPL;
grant select on BARS_DM.CREDITS_DYN to BARS_SUP;
