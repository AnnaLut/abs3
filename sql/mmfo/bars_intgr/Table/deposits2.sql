prompt create table bars_intgr.deposits2
begin
    execute immediate q'[
create table bars_intgr.deposits2
(
CHANGENUMBER NUMBER, 
KF VARCHAR2(6), 
branch CHAR(30),
rnk NUMBER(15),
nd VARCHAR2(35),
dat_begin DATE,
dat_end DATE,
nls VARCHAR2(15),
vidd_name VARCHAR2(50),
term NUMBER(4, 2),
sdog NUMBER(15, 2),
massa NUMBER(8, 2),
kv NUMBER(3),
intrate NUMBER(5, 2),
sdog_begin NUMBER(15, 2),
last_add_date DATE,
last_add_suma NUMBER(15, 2),
ostc NUMBER(15, 2),
suma_proc NUMBER(15, 2),
suma_proc_plan NUMBER(15, 2),
deposit_id NUMBER(15),
dpt_status NUMBER(1),
suma_proc_payoff NUMBER(15, 2),
date_proc_payoff DATE,
date_dep_payoff DATE,
datz DATE,
dazs DATE,
blkd NUMBER(3),
blkk NUMBER(3),
cnt_dubl NUMBER(3),
archdoc_id NUMBER(15),
ncash VARCHAR2(128),
name_d VARCHAR2(128),
okpo_d VARCHAR2(14),
NLS_D VARCHAR2(15),
MFO_D VARCHAR2(12),
NAME_P VARCHAR2(128),
OKPO_P VARCHAR2(14),
NLSB VARCHAR2(15),
MFOB VARCHAR2(12),
NLSP VARCHAR2(15),
ROSP_M NUMBER(1),
MAL NUMBER(1),
BEN NUMBER(1),
vidd NUMBER(5),
WB VARCHAR2(1),
OB22 VARCHAR2(2), 
NMS VARCHAR2(70)
)
tablespace BRSDMIMP
PARTITION by list (KF)
 (  
 PARTITION KF_300465 VALUES ('300465'),
 PARTITION KF_302076 VALUES ('302076'),
 PARTITION KF_303398 VALUES ('303398'),
 PARTITION KF_304665 VALUES ('304665'),
 PARTITION KF_305482 VALUES ('305482'),
 PARTITION KF_311647 VALUES ('311647'),
 PARTITION KF_312356 VALUES ('312356'),
 PARTITION KF_313957 VALUES ('313957'),
 PARTITION KF_315784 VALUES ('315784'),
 PARTITION KF_322669 VALUES ('322669'),
 PARTITION KF_323475 VALUES ('323475'),
 PARTITION KF_324805 VALUES ('324805'),
 PARTITION KF_325796 VALUES ('325796'),
 PARTITION KF_326461 VALUES ('326461'),
 PARTITION KF_328845 VALUES ('328845'),
 PARTITION KF_331467 VALUES ('331467'),
 PARTITION KF_333368 VALUES ('333368'),
 PARTITION KF_335106 VALUES ('335106'),
 PARTITION KF_336503 VALUES ('336503'),
 PARTITION KF_337568 VALUES ('337568'),
 PARTITION KF_338545 VALUES ('338545'),
 PARTITION KF_351823 VALUES ('351823'),
 PARTITION KF_352457 VALUES ('352457'),
 PARTITION KF_353553 VALUES ('353553'),
 PARTITION KF_354507 VALUES ('354507'),
 PARTITION KF_356334 VALUES ('356334')
 )]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

comment on column bars_intgr.deposits2.branch is '³�������';
comment on column bars_intgr.deposits2.kf is '��';
comment on column bars_intgr.deposits2.rnk is '���';
comment on column bars_intgr.deposits2.nd is '� ��������';
comment on column bars_intgr.deposits2.dat_begin is '������ ��';
comment on column bars_intgr.deposits2.dat_end is '���� ��������� ��������';
comment on column bars_intgr.deposits2.nls is '����� �������';
comment on column bars_intgr.deposits2.vidd_name is '��� ������';
comment on column bars_intgr.deposits2.term is '����� ������';
comment on column bars_intgr.deposits2.sdog is '���� ������';
comment on column bars_intgr.deposits2.massa is '���� ������';
comment on column bars_intgr.deposits2.kv is '������ ������';
comment on column bars_intgr.deposits2.intrate is '³�������� ������';
comment on column bars_intgr.deposits2.sdog_begin is '��������� ���� ������';
comment on column bars_intgr.deposits2.last_add_date is '���� ��������� ����������';
comment on column bars_intgr.deposits2.last_add_suma is '���� ��������� ����������';
comment on column bars_intgr.deposits2.ostc is '�������� �������';
comment on column bars_intgr.deposits2.suma_proc is '������� ���� ����������� ����.';
comment on column bars_intgr.deposits2.suma_proc_plan is '���� ������� �� ������� ���� �������';
comment on column bars_intgr.deposits2.deposit_id is 'id ��������';
comment on column bars_intgr.deposits2.dpt_status is '������ ���.��������';
comment on column bars_intgr.deposits2.suma_proc_payoff is '���� ���������� �������';
comment on column bars_intgr.deposits2.date_proc_payoff is '���� ������� �������';
comment on column bars_intgr.deposits2.date_dep_payoff is '���� ������� ��������';
comment on column bars_intgr.deposits2.datz is '���� ���������� ������';
comment on column bars_intgr.deposits2.dazs is '���� �������� �������';
comment on column bars_intgr.deposits2.blkd is '��� ���������� ������� �� ������';
comment on column bars_intgr.deposits2.blkk is '��� ���������� ������� �� �������';
comment on column bars_intgr.deposits2.cnt_dubl is '������� �����������';
comment on column bars_intgr.deposits2.archdoc_id is '������������� ����������� �������� � ���';
comment on column bars_intgr.deposits2.ncash is '����� �������� (���/������)';
comment on column bars_intgr.deposits2.name_d is '���������� ��������';
comment on column bars_intgr.deposits2.okpo_d is '��� ���������� ��������';
comment on column bars_intgr.deposits2.NLS_D is '����� ����� ���������� ��������';
comment on column bars_intgr.deposits2.MFO_D is '��� ����� ���������� ��������';
comment on column bars_intgr.deposits2.NAME_P is '���������� ���������';
comment on column bars_intgr.deposits2.OKPO_P is '��� ����������  ���������';
comment on column bars_intgr.deposits2.NLSB is '����� ����� ����������  ���������';
comment on column bars_intgr.deposits2.MFOB is '��� ����� ����������  ���������';
comment on column bars_intgr.deposits2.NLSP is '����� ����� ���������';
comment on column bars_intgr.deposits2.ROSP_M is '����� � ������ ����������� ����';
comment on column bars_intgr.deposits2.MAL is '����� �� ��� ����������� ����';
comment on column bars_intgr.deposits2.BEN is '����� �� �����������';
comment on column bars_intgr.deposits2.vidd is '��� ��� ������';
comment on column bars_intgr.deposits2.WB is '������ � �������';

prompt create unique index xpk_deposits2

begin
    execute immediate 'create unique index xpk_deposits2 on bars_intgr.deposits2(KF, deposit_id) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create index I_accounts_CHANGENUMBER

begin
    execute immediate 'create index I_DEPOSITS2_CHANGENUMBER on bars_intgr.DEPOSITS2(KF, CHANGENUMBER) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create error log
begin
    dbms_errlog.create_error_log(dml_table_name => 'DEPOSITS2', err_log_table_space => 'BRSDMIMP');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
