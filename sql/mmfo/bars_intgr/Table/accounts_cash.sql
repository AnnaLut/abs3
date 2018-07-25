prompt create table bars_intgr.accounts_cash

begin
    execute immediate q'[
create table bars_intgr.accounts_cash
(
CHANGENUMBER NUMBER,
KF           VARCHAR2(6),
ACC          NUMBER,
RNK          NUMBER(15),
nls          VARCHAR2(15),
kv           NUMBER(3),
branch       VARCHAR(30),
NMS          VARCHAR2(70),
ob22         VARCHAR2(2),
nmk          varchar2(70),
okpo         varchar2(14)
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
comment on table bars_intgr.accounts_cash is 'Касові рахунки';
comment on column bars_intgr.accounts_cash.branch is 'Відділення';
comment on column bars_intgr.accounts_cash.kf is 'РУ';
comment on column bars_intgr.accounts_cash.acc is 'Унікальний номер рахунку';
comment on column bars_intgr.accounts_cash.rnk is 'РНК';
comment on column bars_intgr.accounts_cash.nls is 'Номер рахунку';
comment on column bars_intgr.accounts_cash.kv is 'Валюта';
comment on column bars_intgr.accounts_cash.ob22 is 'Аналітика рахунку';
comment on column bars_intgr.accounts_cash.nms is 'Назва рахунку';
comment on column bars_intgr.accounts_cash.okpo is 'ОКПО власника рахунку';
comment on column bars_intgr.accounts_cash.nmk is 'Назва контрагента (власника рахунку)';


prompt create unique index XPK_ACCOUNTS_CASH

begin
    execute immediate 'create unique index XPK_ACCOUNTS_CASH on bars_intgr.ACCOUNTS_CASH(KF, ACC) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create index I_ACCOUNTS_CASH_CHANGENUMBER

begin
    execute immediate 'create index I_ACCOUNTS_CASH_CHANGENUMBER on bars_intgr.ACCOUNTS_CASH(KF, CHANGENUMBER) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create error log
begin
    dbms_errlog.create_error_log(dml_table_name => 'ACCOUNTS_CASH', err_log_table_space => 'BRSDMIMP');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
