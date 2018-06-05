prompt create table bars_intgr.accounts
begin
    execute immediate q'[
create table bars_intgr.accounts
(
CHANGENUMBER NUMBER,
kf           VARCHAR2(6),
acc          NUMBER,
rnk          NUMBER(15),
branch       VARCHAR(30),
nls          VARCHAR2(15),
vidd         VARCHAR2(10),
daos         DATE,
kv           NUMBER(3),
intrate      NUMBER(5, 2),
massa        NUMBER(6, 2),
count_zl     NUMBER(3),
ostc         NUMBER(15, 2),
ob_mon       NUMBER(15, 2),
last_add_date DATE,
last_add_suma NUMBER(15, 2),
dazs         DATE,
blkd         NUMBER(3),
blkk         NUMBER(3),
acc_status   NUMBER(1),
ob22         VARCHAR2(2),
NMS          VARCHAR2(70)
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

comment on column bars_intgr.accounts.branch is 'Відділення';
comment on column bars_intgr.accounts.kf is 'РУ';
comment on column bars_intgr.accounts.acc is 'Унікальний номер рахунку';
comment on column bars_intgr.accounts.rnk is 'РНК';
comment on column bars_intgr.accounts.nls is 'Номер рахунку';
comment on column bars_intgr.accounts.vidd is 'Вид вкладу';
comment on column bars_intgr.accounts.daos is 'Дата відкриття рахунку';
comment on column bars_intgr.accounts.kv is 'Валюта';
comment on column bars_intgr.accounts.intrate is 'Відсоткова ставка';
comment on column bars_intgr.accounts.massa is 'Вага злитку';
comment on column bars_intgr.accounts.count_zl is 'Кількість злитків';
comment on column bars_intgr.accounts.ostc is 'Поточний залишок';
comment on column bars_intgr.accounts.ob_mon is 'Обороти по рахунку за місяць';
comment on column bars_intgr.accounts.last_add_date is 'Дата останнього поповнення';
comment on column bars_intgr.accounts.last_add_suma is 'Сума останього поповнення';
comment on column bars_intgr.accounts.dazs is 'Дата закриття рахунку';
comment on column bars_intgr.accounts.blkd is 'Код блокування рахунку по дебету';
comment on column bars_intgr.accounts.blkk is 'Код блокування рахунку по кредиту';
comment on column bars_intgr.accounts.acc_status is 'Статус рахунку (1-відкритий, 0-закритий)';
comment on column bars_intgr.accounts.ob22 is 'Аналітика рахунку';
comment on column bars_intgr.accounts.nms is 'Назва рахунку';


prompt create unique index XPK_accounts

begin
    execute immediate 'create unique index XPK_ACCOUNTS on bars_intgr.ACCOUNTS(KF, ACC) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create index I_accounts_CHANGENUMBER

begin
    execute immediate 'create index I_ACCOUNTS_CHANGENUMBER on bars_intgr.ACCOUNTS(KF, CHANGENUMBER) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create error log
begin
    dbms_errlog.create_error_log(dml_table_name => 'ACCOUNTS', err_log_table_space => 'BRSDMIMP');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
