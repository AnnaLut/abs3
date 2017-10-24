prompt ... 


begin
    execute immediate 'create table BARS_DM.CREDITS_STAT
(
  id              NUMBER(15) not null,
  per_id          NUMBER,
  nd              NUMBER(38),
  rnk             NUMBER(15),
  kf              VARCHAR2(12),
  branch          VARCHAR2(30),
  okpo            VARCHAR2(14),
  cc_id           VARCHAR2(50),
  sdate           DATE,
  wdate           DATE,
  wdate_fact      DATE,
  vidd            INTEGER,
  prod            VARCHAR2(100),
  prod_clas       VARCHAR2(100),
  pawn            VARCHAR2(100),
  sdog            NUMBER(24,2),
  term            INTEGER,
  kv              INTEGER,
  pog_plan        NUMBER(15,2),
  pog_fact        NUMBER(15,2),
  borg_sy         NUMBER(15,2),
  borgproc_sy     NUMBER(15,2),
  bpk_nls         VARCHAR2(15),
  intrate         NUMBER,
  ptn_name        VARCHAR2(255),
  ptn_okpo        VARCHAR2(14),
  ptn_mother_name VARCHAR2(255),
  open_date_bal22 DATE,
  es000           VARCHAR2(24),
  es003           VARCHAR2(24),
  vidd_custtype   NUMBER(1)
) tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add/modify columns 
begin
  execute immediate 'alter table bars_dm.credits_stat add ES000 varchar2(24)';
exception 
  when others then
    if sqlcode = -1430 then null;
    end if;
end;
/
begin
  execute immediate 'alter table bars_dm.credits_stat add ES003 varchar2(24)';
exception 
  when others then
    if sqlcode = -1430 then null;
    end if;
end;
/
begin
  execute immediate 'alter table BARS_DM.CREDITS_STAT add vidd_custtype NUMBER(1)';
exception 
  when others then
    if sqlcode = -1430 then null;
    end if;
end;
/

-- Add comments to the columns 
comment on table BARS_DM.CREDITS_STAT is '�������, ������� ���';
comment on column BARS_DM.CREDITS_STAT.id is '������������� ������';
comment on column BARS_DM.CREDITS_STAT.per_id is '������������� ������';
comment on column BARS_DM.CREDITS_STAT.nd is '������������� ��';
comment on column BARS_DM.CREDITS_STAT.rnk is '���';
comment on column BARS_DM.CREDITS_STAT.kf is '��� ��';
comment on column BARS_DM.CREDITS_STAT.branch is '�����';
comment on column BARS_DM.CREDITS_STAT.okpo is '���';
comment on column BARS_DM.CREDITS_STAT.cc_id is '� ��������';
comment on column BARS_DM.CREDITS_STAT.sdate is '���� ��������� ��������';
comment on column BARS_DM.CREDITS_STAT.wdate is '���� ��������� �������� (��������)';
comment on column BARS_DM.CREDITS_STAT.vidd is '��� ��������';
comment on column BARS_DM.CREDITS_STAT.prod is '��� ���������� ��������';
comment on column BARS_DM.CREDITS_STAT.prod_clas is '������������ ���������� ��������';
comment on column BARS_DM.CREDITS_STAT.pawn is '��� �������/��������������';
comment on column BARS_DM.CREDITS_STAT.sdog is '���� ������� (�������� ���� ��������)';
comment on column BARS_DM.CREDITS_STAT.term is '����� ������� (� ������)';
comment on column BARS_DM.CREDITS_STAT.kv is '������ �������';
comment on column BARS_DM.CREDITS_STAT.pog_plan is '������� ���� ��������� �� ������� �����';
comment on column BARS_DM.CREDITS_STAT.pog_fact is '�������� ���� ��������� �� ������� �����';
comment on column BARS_DM.CREDITS_STAT.borg_sy is '���� ������� ������������� �� ������� ����, ���';
comment on column BARS_DM.CREDITS_STAT.borgproc_sy is '���� ������� ������������� �� ��������� �� ������� ����, ���.';
comment on column BARS_DM.CREDITS_STAT.bpk_nls is '���.2625 ��� �� �� ���';
comment on column BARS_DM.CREDITS_STAT.intrate is '����� ��������� ������';
comment on column BARS_DM.CREDITS_STAT.ptn_name is '������������ ��������';
comment on column BARS_DM.CREDITS_STAT.ptn_okpo is '��� ������ ��������';
comment on column BARS_DM.CREDITS_STAT.ptn_mother_name is '������������ ����������� ������';
comment on column BARS_DM.CREDITS_STAT.open_date_bal22 is '���� �������� ������� 2202/03 ��� 2232/33';
comment on column BARS_DM.CREDITS_STAT.vidd_custtype is '��� ������� �� ���� ��������: 3 - ���������� ����, 2 - ����������� ����, 1 - ����';

begin
    execute immediate 'create index BARS_DM.I_CREDITS_STAT_PERID on BARS_DM.CREDITS_STAT (PER_ID) tablespace BRSDYNI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_STAT
  add constraint PK_CREDITS_STAT primary key (ID)
  using index tablespace BRSDYNI';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_STAT
  add constraint FK_CREDITS_PERID_PERIOD_ID foreign key (PER_ID)
  references BARS_DM.PERIODS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_STAT
  add constraint CC_CREDITS_BRANCH_NN
  check ("BRANCH" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_STAT
  add constraint CC_CREDITS_KF_NN
  check ("KF" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_STAT
  add constraint CC_CREDITS_ND_NN
  check ("ND" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_STAT
  add constraint CC_CREDITS_PERID_NN
  check ("PER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table BARS_DM.CREDITS_STAT
  add constraint CC_CREDITS_RNK_NN
  check ("RNK" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

grant select on BARS_DM.CREDITS_STAT to BARS;
grant select on BARS_DM.CREDITS_STAT to BARSUPL;
grant select on BARS_DM.CREDITS_STAT to BARS_SUP;
