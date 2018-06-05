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

comment on column bars_intgr.deposits2.branch is 'Відділення';
comment on column bars_intgr.deposits2.kf is 'РУ';
comment on column bars_intgr.deposits2.rnk is 'РНК';
comment on column bars_intgr.deposits2.nd is '№ договору';
comment on column bars_intgr.deposits2.dat_begin is 'Договір від';
comment on column bars_intgr.deposits2.dat_end is 'Дата закінчення договору';
comment on column bars_intgr.deposits2.nls is 'Номер рахунку';
comment on column bars_intgr.deposits2.vidd_name is 'Вид вкладу';
comment on column bars_intgr.deposits2.term is 'Строк вкладу';
comment on column bars_intgr.deposits2.sdog is 'Сума вкладу';
comment on column bars_intgr.deposits2.massa is 'Маса вкладу';
comment on column bars_intgr.deposits2.kv is 'Валюта вкладу';
comment on column bars_intgr.deposits2.intrate is 'Відсоткова ставка';
comment on column bars_intgr.deposits2.sdog_begin is 'Початкова сума вкладу';
comment on column bars_intgr.deposits2.last_add_date is 'Дата останього поповнення';
comment on column bars_intgr.deposits2.last_add_suma is 'Сума останього поповнення';
comment on column bars_intgr.deposits2.ostc is 'Поточний залишок';
comment on column bars_intgr.deposits2.suma_proc is 'Поточна сума нарахованих проц.';
comment on column bars_intgr.deposits2.suma_proc_plan is 'Сума відсотків на планову дату виплати';
comment on column bars_intgr.deposits2.deposit_id is 'id депозиту';
comment on column bars_intgr.deposits2.dpt_status is 'Статус деп.договору';
comment on column bars_intgr.deposits2.suma_proc_payoff is 'Сума виплачених відсотків';
comment on column bars_intgr.deposits2.date_proc_payoff is 'Дата виплати відсотків';
comment on column bars_intgr.deposits2.date_dep_payoff is 'Дата виплати депозиту';
comment on column bars_intgr.deposits2.datz is 'Дата заключення вкладу';
comment on column bars_intgr.deposits2.dazs is 'Дата закриття рахунку';
comment on column bars_intgr.deposits2.blkd is 'Код блокування рахунку по дебету';
comment on column bars_intgr.deposits2.blkk is 'Код блокування рахунку по кредиту';
comment on column bars_intgr.deposits2.cnt_dubl is 'кількість пролонгацій';
comment on column bars_intgr.deposits2.archdoc_id is 'Ідентифікатор депозитного договору в ЕАД';
comment on column bars_intgr.deposits2.ncash is 'Форма депозита (нал/безнал)';
comment on column bars_intgr.deposits2.name_d is 'Получатель депозита';
comment on column bars_intgr.deposits2.okpo_d is 'Код получателя депозита';
comment on column bars_intgr.deposits2.NLS_D is 'Номер счета получателя депозита';
comment on column bars_intgr.deposits2.MFO_D is 'МФО счета получателя депозита';
comment on column bars_intgr.deposits2.NAME_P is 'Получатель процентов';
comment on column bars_intgr.deposits2.OKPO_P is 'Код получателя  процентов';
comment on column bars_intgr.deposits2.NLSB is 'Номер счета получателя  процентов';
comment on column bars_intgr.deposits2.MFOB is 'МФО счета получателя  процентов';
comment on column bars_intgr.deposits2.NLSP is 'Номер счета процентов';
comment on column bars_intgr.deposits2.ROSP_M is 'Вклад в пользу малолетнего лица';
comment on column bars_intgr.deposits2.MAL is 'Вклад на имя малолетнего лица';
comment on column bars_intgr.deposits2.BEN is 'Вклад на бенефициара';
comment on column bars_intgr.deposits2.vidd is 'код вид вкладу';
comment on column bars_intgr.deposits2.WB is 'Открыт в онлайне';

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
