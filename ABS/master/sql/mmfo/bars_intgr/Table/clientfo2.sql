prompt create table bars_intgr.clientfo2

begin
    execute immediate q'[
create table bars_intgr.clientfo2
(
CHANGENUMBER NUMBER,
LAST_NAME VARCHAR2(50),
FIRST_NAME VARCHAR2(50),
MIDDLE_NAME VARCHAR2(60),
BDAY DATE,
GR VARCHAR2(30),
PASSP NUMBER(22, 0),
SER VARCHAR2(10),
NUMDOC VARCHAR2(20),
PDATE DATE,
ORGAN VARCHAR2(70),
PASSP_EXPIRE_TO DATE,
PASSP_TO_BANK DATE,
KF  VARCHAR2(6),
RNK NUMBER(22, 0),
OKPO VARCHAR2(14),
CUST_STATUS VARCHAR2(20),
CUST_ACTIVE NUMBER(22, 0),
TELM VARCHAR2(20),
TELW VARCHAR2(20),
TELD VARCHAR2(20),
TELADD VARCHAR2(20),
EMAIL VARCHAR2(100),
ADR_POST_COUNTRY VARCHAR2(55),
ADR_POST_DOMAIN VARCHAR2(30),
ADR_POST_REGION VARCHAR2(30),
ADR_POST_LOC VARCHAR2(30),
ADR_POST_ADR VARCHAR2(100),
ADR_POST_ZIP VARCHAR2(20),
ADR_FACT_COUNTRY VARCHAR2(55),
ADR_FACT_DOMAIN VARCHAR2(30),
ADR_FACT_REGION VARCHAR2(30),
ADR_FACT_LOC VARCHAR2(30),
ADR_FACT_ADR VARCHAR2(100),
ADR_FACT_ZIP VARCHAR2(20),
ADR_WORK_COUNTRY VARCHAR2(55),
ADR_WORK_DOMAIN VARCHAR2(30),
ADR_WORK_REGION VARCHAR2(30),
ADR_WORK_LOC VARCHAR2(30),
ADR_WORK_ADR VARCHAR2(55),
ADR_WORK_ZIP VARCHAR2(20),
BRANCH VARCHAR2(30),
NEGATIV_STATUS VARCHAR2(10),
REESTR_MOB_BANK VARCHAR2(10),
REESTR_INET_BANK VARCHAR2(10),
REESTR_SMS_BANK VARCHAR2(10),
MONTH_INCOME NUMBER(22, 2),
SUBJECT_ROLE VARCHAR2(10),
REZIDENT VARCHAR2(10),
MERRIED VARCHAR2(500),
EMP_STATUS VARCHAR2(10),
SUBJECT_CLASS VARCHAR2(10),
INSIDER VARCHAR2(10),
SEX CHAR(1),
VIPK NUMBER(22, 0),
VIP_FIO_MANAGER VARCHAR2(250),
VIP_PHONE_MANAGER VARCHAR2(30),
DATE_ON DATE,
DATE_OFF DATE,
EDDR_ID VARCHAR2(20),
IDCARD_VALID_DATE DATE,
IDDPL VARCHAR2(500),
BPLACE VARCHAR2(70),
SUBSD VARCHAR2(500),
SUBSN VARCHAR2(500),
ELT_N VARCHAR2(500),
ELT_D VARCHAR2(500),
GCIF VARCHAR2(30),
NOMPDV VARCHAR2(9),
NOM_DOG VARCHAR2(10),
SW_RN VARCHAR2(500),
Y_ELT VARCHAR2(500),
ADM VARCHAR2(70),
FADR VARCHAR2(500),
ADR_ALT VARCHAR2(70),
BUSSS VARCHAR2(500),
PC_MF VARCHAR2(500),
PC_Z4 VARCHAR2(500),
PC_Z3 VARCHAR2(500),
PC_Z5 VARCHAR2(500),
PC_Z2 VARCHAR2(500),
PC_Z1 VARCHAR2(500),
AGENT VARCHAR2(500),
PC_SS VARCHAR2(500),
STMT VARCHAR2(500),
VIDKL VARCHAR2(500),
VED CHAR(5),
TIPA VARCHAR2(500),
PHKLI VARCHAR2(500),
AF1_9 VARCHAR2(500),
IDDPD VARCHAR2(500),
DAIDI VARCHAR2(500),
DATVR VARCHAR2(500),
DATZ VARCHAR2(500),
DATE_PHOTO DATE,
IDDPR VARCHAR2(500),
ISE CHAR(5),
OBSLU VARCHAR2(500),
CRSRC VARCHAR2(500),
DJOTH VARCHAR2(500),
DJAVI VARCHAR2(500),
DJ_TC VARCHAR2(500),
DJOWF VARCHAR2(500),
DJCFI VARCHAR2(500),
DJ_LN VARCHAR2(500),
DJ_FH VARCHAR2(500),
DJ_CP VARCHAR2(500),
CHORN VARCHAR2(500),
CRISK_KL VARCHAR2(1),
BC NUMBER(22, 0),
SPMRK VARCHAR2(500),
K013 VARCHAR2(500),
KODID VARCHAR2(500),
COUNTRY NUMBER(22, 0),
MS_FS VARCHAR2(500),
MS_VD VARCHAR2(500),
MS_GR VARCHAR2(500),
LIM_KASS NUMBER(22, 0),
LIM NUMBER(22, 0),
LICO VARCHAR2(500),
UADR VARCHAR2(500),
MOB01 VARCHAR2(500),
MOB02 VARCHAR2(500),
MOB03 VARCHAR2(500),
SUBS VARCHAR2(500),
K050 CHAR(3),
DEATH VARCHAR2(500),
NO_PHONE NUMBER(22, 0),
NSMCV VARCHAR2(500),
NSMCC VARCHAR2(500),
NSMCT VARCHAR2(500),
NOTES VARCHAR2(140),
SAMZ VARCHAR2(500),
OREP VARCHAR2(500),
OVIFS VARCHAR2(500),
AF6 VARCHAR2(500),
FSKRK VARCHAR2(500),
FSOMD VARCHAR2(500),
FSVED VARCHAR2(500),
FSZPD VARCHAR2(500),
FSPOR VARCHAR2(500),
FSRKZ VARCHAR2(500),
FSZOP VARCHAR2(500),
FSKPK VARCHAR2(500),
FSKPR VARCHAR2(500),
FSDIB VARCHAR2(500),
FSCP VARCHAR2(500),
FSVLZ VARCHAR2(500),
FSVLA VARCHAR2(500),
FSVLN VARCHAR2(500),
FSVLO VARCHAR2(500),
FSSST VARCHAR2(500),
FSSOD VARCHAR2(500),
FSVSN VARCHAR2(500),
DOV_P VARCHAR2(500),
DOV_A VARCHAR2(500),
DOV_F VARCHAR2(500),
NMKV VARCHAR2(70),
SN_GC VARCHAR2(500),
NMKK VARCHAR2(38),
PRINSIDER NUMBER(22, 0),
NOTESEC VARCHAR2(256),
MB CHAR(1),
PUBLP VARCHAR2(500),
WORKB VARCHAR2(500),
C_REG NUMBER(22, 0),
C_DST NUMBER(22, 0),
RGADM VARCHAR2(30),
RGTAX VARCHAR2(30),
DATEA DATE,
DATET DATE,
RNKP NUMBER(22, 0),
CIGPO VARCHAR2(500),
COUNTRY_NAME VARCHAR2(70),
TARIF VARCHAR2(500),
AINAB VARCHAR2(500),
TGR NUMBER(22, 0),
CUSTTYPE NUMBER(22, 0),
RIZIK VARCHAR2(500),
SNSDR VARCHAR2(500),
IDPIB VARCHAR2(500),
FS CHAR(2),
SED CHAR(4),
DJER VARCHAR2(500),
CODCAGENT NUMBER(22, 0),
SUTD VARCHAR2(500),
RVDBC VARCHAR2(500),
RVIBA VARCHAR2(500),
RVIDT VARCHAR2(500),
RV_XA VARCHAR2(500),
RVIBR VARCHAR2(500),
RVIBB VARCHAR2(500),
RVRNK VARCHAR2(500),
RVPH1 VARCHAR2(500),
RVPH2 VARCHAR2(500),
RVPH3 VARCHAR2(500),
SAB VARCHAR2(6),
VIP_ACCOUNT_MANAGER VARCHAR2(500)
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

comment on column bars_intgr.clientfo2.LAST_NAME is q'[Прізвище]';
comment on column bars_intgr.clientfo2.FIRST_NAME is q'[Імя]';
comment on column bars_intgr.clientfo2.MIDDLE_NAME is q'[По-батькові]';
comment on column bars_intgr.clientfo2.BDAY is q'[Дата народження]';
comment on column bars_intgr.clientfo2.GR is q'[Громадянство]';
comment on column bars_intgr.clientfo2.PASSP is q'[Тип документу]';
comment on column bars_intgr.clientfo2.SER is q'[Серія]';
comment on column bars_intgr.clientfo2.NUMDOC is q'[Номер документу]';
comment on column bars_intgr.clientfo2.PDATE is q'[Дата видачі]';
comment on column bars_intgr.clientfo2.ORGAN is q'[Орган видачі]';
comment on column bars_intgr.clientfo2.PASSP_EXPIRE_TO is q'[Документ дійсний до]';
comment on column bars_intgr.clientfo2.PASSP_TO_BANK is 'Дата пред''явлення документу банку';
comment on column bars_intgr.clientfo2.KF is q'[МФО]';
comment on column bars_intgr.clientfo2.RNK is q'[РНК]';
comment on column bars_intgr.clientfo2.OKPO is q'[ІНН]';
comment on column bars_intgr.clientfo2.CUST_STATUS is q'[Статус клієнта в БАРС]';
comment on column bars_intgr.clientfo2.CUST_ACTIVE is q'[РНК активного клієнта]';
comment on column bars_intgr.clientfo2.TELM is q'[Мобільний телефон]';
comment on column bars_intgr.clientfo2.TELW is q'[Робочий телефон]';
comment on column bars_intgr.clientfo2.TELD is q'[Контактний телефон]';
comment on column bars_intgr.clientfo2.TELADD is q'[Додаткові телефони]';
comment on column bars_intgr.clientfo2.EMAIL is q'[Електронна пошта]';
comment on column bars_intgr.clientfo2.ADR_POST_COUNTRY is q'[Країна]';
comment on column bars_intgr.clientfo2.ADR_POST_DOMAIN is q'[Область]';
comment on column bars_intgr.clientfo2.ADR_POST_REGION is q'[Район]';
comment on column bars_intgr.clientfo2.ADR_POST_LOC is q'[Населений пункт]';
comment on column bars_intgr.clientfo2.ADR_POST_ADR is q'[Вулиця, будинок, квартира]';
comment on column bars_intgr.clientfo2.ADR_POST_ZIP is q'[Поштовий індекс]';
comment on column bars_intgr.clientfo2.ADR_FACT_COUNTRY is q'[Країна]';
comment on column bars_intgr.clientfo2.ADR_FACT_DOMAIN is q'[Область]';
comment on column bars_intgr.clientfo2.ADR_FACT_REGION is q'[Район]';
comment on column bars_intgr.clientfo2.ADR_FACT_LOC is q'[Населений пункт]';
comment on column bars_intgr.clientfo2.ADR_FACT_ADR is q'[Вулиця, будинок, квартира]';
comment on column bars_intgr.clientfo2.ADR_FACT_ZIP is q'[Поштовий індекс]';
comment on column bars_intgr.clientfo2.ADR_WORK_COUNTRY is q'[Країна]';
comment on column bars_intgr.clientfo2.ADR_WORK_DOMAIN is q'[Область]';
comment on column bars_intgr.clientfo2.ADR_WORK_REGION is q'[Район]';
comment on column bars_intgr.clientfo2.ADR_WORK_LOC is q'[Населений пункт]';
comment on column bars_intgr.clientfo2.ADR_WORK_ADR is q'[Вулиця, будинок, квартира]';
comment on column bars_intgr.clientfo2.ADR_WORK_ZIP is q'[Поштовий індекс]';
comment on column bars_intgr.clientfo2.BRANCH is q'[Відділення]';
comment on column bars_intgr.clientfo2.NEGATIV_STATUS is q'[Негативний статус]';
comment on column bars_intgr.clientfo2.REESTR_MOB_BANK is q'[Реєстрація в мобільному банкінгу]';
comment on column bars_intgr.clientfo2.REESTR_INET_BANK is q'[Реєстрація в інтернет-банкінгу]';
comment on column bars_intgr.clientfo2.REESTR_SMS_BANK is q'[Реєстрація в СМС-банкінгу]';
comment on column bars_intgr.clientfo2.MONTH_INCOME is q'[Сумарний місячний дохід]';
comment on column bars_intgr.clientfo2.SUBJECT_ROLE is 'Опис ролі суб''єкта';
comment on column bars_intgr.clientfo2.REZIDENT is q'[Резидент]';
comment on column bars_intgr.clientfo2.MERRIED is q'[Сімейний стан]';
comment on column bars_intgr.clientfo2.EMP_STATUS is q'[Статус зайнятості особи]';
comment on column bars_intgr.clientfo2.SUBJECT_CLASS is 'Класифікація суб''єкта';
comment on column bars_intgr.clientfo2.INSIDER is q'[Ознака приналежності до інсайдерів]';
comment on column bars_intgr.clientfo2.SEX is q'[Стать]';
comment on column bars_intgr.clientfo2.VIPK is q'[Значення параметру ВІП]';
comment on column bars_intgr.clientfo2.VIP_FIO_MANAGER is q'[ПІБ працівника по ВІП]';
comment on column bars_intgr.clientfo2.VIP_PHONE_MANAGER is q'[Телефон працівника по ВІП]';
comment on column bars_intgr.clientfo2.DATE_ON is q'[Дата відкриття клієнта]';
comment on column bars_intgr.clientfo2.DATE_OFF is q'[Дата закриття РНК клієнта]';
comment on column bars_intgr.clientfo2.EDDR_ID is q'[Номер запису в ЄДДР]';
comment on column bars_intgr.clientfo2.IDCARD_VALID_DATE is q'[Дійсний до (паспорт ID-картка)]';
comment on column bars_intgr.clientfo2.IDDPL is q'[Дата планової ідентифікації]';
comment on column bars_intgr.clientfo2.BPLACE is q'[Місце народження]';
comment on column bars_intgr.clientfo2.SUBSD is q'[Дата субсидії]';
comment on column bars_intgr.clientfo2.SUBSN is q'[Номер субсидії]';
comment on column bars_intgr.clientfo2.ELT_N is q'[ELT. Номер договору клієнт-банк]';
comment on column bars_intgr.clientfo2.ELT_D is q'[ELT. Дата договору клієнт-банк]';
comment on column bars_intgr.clientfo2.GCIF is q'[GCIF]';
comment on column bars_intgr.clientfo2.NOMPDV is q'[Номер в реєстрі НДС]';
comment on column bars_intgr.clientfo2.NOM_DOG is q'[Номер договору на супровід]';
comment on column bars_intgr.clientfo2.SW_RN is q'[Назва клієнта російською]';
comment on column bars_intgr.clientfo2.Y_ELT is q'[Автостягнення тарифу абонплати]';
comment on column bars_intgr.clientfo2.ADM is q'[Адмін. орган реєстрації]';
comment on column bars_intgr.clientfo2.FADR is q'[Адреса тимчасового перебування]';
comment on column bars_intgr.clientfo2.ADR_ALT is q'[Альтернативна адреса]';
comment on column bars_intgr.clientfo2.BUSSS is q'[Бізнес-сектор]';
comment on column bars_intgr.clientfo2.PC_MF is q'[БПК. Дівоче прізвище матері]';
comment on column bars_intgr.clientfo2.PC_Z4 is q'[БПК. Загранпаспорт. Діє до]';
comment on column bars_intgr.clientfo2.PC_Z3 is q'[БПК. Загранпаспорт. Ким виданий]';
comment on column bars_intgr.clientfo2.PC_Z5 is q'[БПК. Загранпаспорт. Коли виданий]';
comment on column bars_intgr.clientfo2.PC_Z2 is q'[БПК. Загранпаспорт. Номер]';
comment on column bars_intgr.clientfo2.PC_Z1 is q'[БПК. Загранпаспорт. Серія]';
comment on column bars_intgr.clientfo2.AGENT is q'[БПК. Код ЄГРПОУ підприємства де працює]';
comment on column bars_intgr.clientfo2.PC_SS is q'[БПК. Сімейний стан]';
comment on column bars_intgr.clientfo2.STMT is q'[Від виписки]';
comment on column bars_intgr.clientfo2.VIDKL is q'[Від клієнта]';
comment on column bars_intgr.clientfo2.VED is q'[Вид економічної діяльності]';
comment on column bars_intgr.clientfo2.TIPA is q'[Вид незалежної проф діяльності]';
comment on column bars_intgr.clientfo2.PHKLI is q'[Види послуг, якими користується клієнт]';
comment on column bars_intgr.clientfo2.AF1_9 is q'[Дані про реєстрацію як ФОП]';
comment on column bars_intgr.clientfo2.IDDPD is q'[Дата внесення в анкету останніх змін]';
comment on column bars_intgr.clientfo2.DAIDI is q'[Дата виконання та заходи поглиб. перевірки клієнта]';
comment on column bars_intgr.clientfo2.DATVR is q'[Дата відкриття першого рахунку]';
comment on column bars_intgr.clientfo2.DATZ is q'[ Дата первинного заповнення анкети]';
comment on column bars_intgr.clientfo2.DATE_PHOTO is q'[Дата останньої фотографії]';
comment on column bars_intgr.clientfo2.IDDPR is q'[Дата проведеної ідентиф.]';
comment on column bars_intgr.clientfo2.ISE is q'[Інституційний сектор економіки]';
comment on column bars_intgr.clientfo2.OBSLU is q'[Історія обслуговування клієнта]';
comment on column bars_intgr.clientfo2.CRSRC is q'[Джерело створення(DPT-деп.модуль, CCK-кред.мод.)]';
comment on column bars_intgr.clientfo2.DJOTH is q'[Джерела. Інше]';
comment on column bars_intgr.clientfo2.DJAVI is q'[Джерела. Щомісячний дохід]';
comment on column bars_intgr.clientfo2.DJ_TC is q'[Джерела. Право на вимогу]';
comment on column bars_intgr.clientfo2.DJOWF is q'[Джерела. Власні кошти]';
comment on column bars_intgr.clientfo2.DJCFI is q'[Джерела. Срочні контракти та ін.]';
comment on column bars_intgr.clientfo2.DJ_LN is q'[Джерела. Позика]';
comment on column bars_intgr.clientfo2.DJ_FH is q'[Джерела. Фінансова допомога]';
comment on column bars_intgr.clientfo2.DJ_CP is q'[Джерела. ЦП]';
comment on column bars_intgr.clientfo2.CHORN is q'[Чорнобильці]';
comment on column bars_intgr.clientfo2.CRISK_KL is q'[Клас позичальника]';
comment on column bars_intgr.clientfo2.BC is q'[Клієнт банку]';
comment on column bars_intgr.clientfo2.SPMRK is q'[Код "особливі відмітки" нстнд.]';
comment on column bars_intgr.clientfo2.K013 is q'[Код виду клієнта]';
comment on column bars_intgr.clientfo2.KODID is q'[Код ідентифік. клієнта]';
comment on column bars_intgr.clientfo2.COUNTRY is q'[Код країни]';
comment on column bars_intgr.clientfo2.MS_FS is q'[Орг.-правова форма]';
comment on column bars_intgr.clientfo2.MS_VD is q'[Галузь виду діяльності]';
comment on column bars_intgr.clientfo2.MS_GR is q'[Належність до групи]';
comment on column bars_intgr.clientfo2.LIM_KASS is q'[Ліміт каси]';
comment on column bars_intgr.clientfo2.LIM is q'[Ліміт на активні операц.]';
comment on column bars_intgr.clientfo2.LICO is q'[Ліцензії на вик. певних опер.]';
comment on column bars_intgr.clientfo2.UADR is q'[Місцезнаходж. юр. справи]';
comment on column bars_intgr.clientfo2.MOB01 is q'[Мобільний 1]';
comment on column bars_intgr.clientfo2.MOB02 is q'[Мобільний 2]';
comment on column bars_intgr.clientfo2.MOB03 is q'[Мобільний 3]';
comment on column bars_intgr.clientfo2.SUBS is q'[Наявність субсидії]';
comment on column bars_intgr.clientfo2.K050 is q'[Податковий код К050]';
comment on column bars_intgr.clientfo2.DEATH is q'[Смерть клієнта]';
comment on column bars_intgr.clientfo2.NO_PHONE is q'[Відсутність мобільного]';
comment on column bars_intgr.clientfo2.NSMCV is q'[Вид клієнта(кл/співр/деп/пенс)]';
comment on column bars_intgr.clientfo2.NSMCC is q'[Код клієнта в карт. системі]';
comment on column bars_intgr.clientfo2.NSMCT is q'[Тип клієнта.А-власник карти, 2-торг.]';
comment on column bars_intgr.clientfo2.NOTES is q'[Особливі примітки]';
comment on column bars_intgr.clientfo2.SAMZ is q'[Самозайнятість]';
comment on column bars_intgr.clientfo2.OREP is q'[Репутація клієнта]';
comment on column bars_intgr.clientfo2.OVIFS is q'[Відповідність операцій відомій інф.]';
comment on column bars_intgr.clientfo2.AF6 is q'[Відповідн. операцій суті і напряму діяльн.]';
comment on column bars_intgr.clientfo2.FSKRK is q'[Наяв.кред.заб.перед.інш.банками та ФО]';
comment on column bars_intgr.clientfo2.FSOMD is 'Міс. совок. дохід сім''ї';
comment on column bars_intgr.clientfo2.FSVED is q'[Зовнішньоєкономічна діяльність]';
comment on column bars_intgr.clientfo2.FSZPD is q'[Ведення підпр. діяльності(ФО)]';
comment on column bars_intgr.clientfo2.FSPOR is q'[Прибуток за ост. фінанс. рік]';
comment on column bars_intgr.clientfo2.FSRKZ is q'[розм. поточн.кред.заборгов.по зобов.]';
comment on column bars_intgr.clientfo2.FSZOP is q'[Збитки за останній фінрік]';
comment on column bars_intgr.clientfo2.FSKPK is q'[К-сть постійних контрагентів]';
comment on column bars_intgr.clientfo2.FSKPR is q'[К-сть штатних працівників]';
comment on column bars_intgr.clientfo2.FSDIB is q'[Наявність депозитів в інш. банках]';
comment on column bars_intgr.clientfo2.FSCP is q'[Власність - цінні папери]';
comment on column bars_intgr.clientfo2.FSVLZ is q'[Власність - земельна ділянка]';
comment on column bars_intgr.clientfo2.FSVLA is q'[Власність - авто]';
comment on column bars_intgr.clientfo2.FSVLN is q'[Власність - нерухомість]';
comment on column bars_intgr.clientfo2.FSVLO is q'[Власність - обладнання]';
comment on column bars_intgr.clientfo2.FSSST is q'[Соціальний статус(ФО)]';
comment on column bars_intgr.clientfo2.FSSOD is q'[Сума основного доходу]';
comment on column bars_intgr.clientfo2.FSVSN is q'[Оцінка фін стану - підсумок]';
comment on column bars_intgr.clientfo2.DOV_P is q'[Паспортні дані довір. особи]';
comment on column bars_intgr.clientfo2.DOV_A is q'[Адреса довір. особи]';
comment on column bars_intgr.clientfo2.DOV_F is q'[Довірена особа]';
comment on column bars_intgr.clientfo2.NMKV is 'Повне ім''я(міжн)';
comment on column bars_intgr.clientfo2.SN_GC is 'Повне ім''я(род. відм.)';
comment on column bars_intgr.clientfo2.NMKK is 'Повне ім''я(скороч.)';
comment on column bars_intgr.clientfo2.PRINSIDER is q'[Наявність анкети інсайдера]';
comment on column bars_intgr.clientfo2.NOTESEC is q'[Примітки для СБ]';
comment on column bars_intgr.clientfo2.MB is q'[Належність до малого бізнесу]';
comment on column bars_intgr.clientfo2.PUBLP is q'[Належність до публ. діячів]';
comment on column bars_intgr.clientfo2.WORKB is q'[Належність до співр. банку]';
comment on column bars_intgr.clientfo2.C_REG is q'[Районна ПІ]';
comment on column bars_intgr.clientfo2.C_DST is q'[Областна ПІ]';
comment on column bars_intgr.clientfo2.RGADM is q'[Рег. номер в адміністрації]';
comment on column bars_intgr.clientfo2.RGTAX is q'[Рег. номер ПІ]';
comment on column bars_intgr.clientfo2.DATEA is q'[Дата реєстр. в адмін.]';
comment on column bars_intgr.clientfo2.DATET is q'[Дата реєстр. в ПІ]';
comment on column bars_intgr.clientfo2.RNKP is q'[Регістр. номер холдингу]';
comment on column bars_intgr.clientfo2.CIGPO is q'[Статус зайнятості]';
comment on column bars_intgr.clientfo2.COUNTRY_NAME is q'[Назва країни]';
comment on column bars_intgr.clientfo2.TARIF is q'[Страховий тариф(ФО)]';
comment on column bars_intgr.clientfo2.AINAB is q'[Рахунки в інших банках]';
comment on column bars_intgr.clientfo2.TGR is q'[Тип державного реєстру]';
comment on column bars_intgr.clientfo2.CUSTTYPE is q'[Тип клієнта]';
comment on column bars_intgr.clientfo2.RIZIK is q'[Рівень ризику]';
comment on column bars_intgr.clientfo2.SNSDR is q'[Облікова серія, ном. свід. держ. реєстр.]';
comment on column bars_intgr.clientfo2.IDPIB is q'[ПІБ співр., відпов. за ідент. та дослідж.]';
comment on column bars_intgr.clientfo2.FS is q'[Форма власності]';
comment on column bars_intgr.clientfo2.SED is q'[Форма господарювання(К051)]';
comment on column bars_intgr.clientfo2.DJER is q'[Характеристика джерел надх. доходу]';
comment on column bars_intgr.clientfo2.CODCAGENT is q'[Характеристика клієнта(К010)]';
comment on column bars_intgr.clientfo2.SUTD is q'[Характеристика суті діяльності]';
comment on column bars_intgr.clientfo2.RVDBC is q'[ЦРВ. DBCode]';
comment on column bars_intgr.clientfo2.RVIBA is q'[ЦРВ. Адреса відд. видачі картки]';
comment on column bars_intgr.clientfo2.RVIDT is q'[ЦРВ. Дата видачі картки]';
comment on column bars_intgr.clientfo2.RV_XA is 'ЦРВ. Ім''я файла ХА';
comment on column bars_intgr.clientfo2.RVIBR is q'[ЦРВ. Відділення видачі картки]';
comment on column bars_intgr.clientfo2.RVIBB is q'[ЦРВ. Відділення видачі картки(АБС)]';
comment on column bars_intgr.clientfo2.RVRNK is q'[ЦРВ. РНК в ЦРВ]';
comment on column bars_intgr.clientfo2.RVPH1 is q'[ЦРВ. Телефон-1]';
comment on column bars_intgr.clientfo2.RVPH2 is q'[ЦРВ. Телефон-2]';
comment on column bars_intgr.clientfo2.RVPH3 is q'[ЦРВ. Телефон-3]';
comment on column bars_intgr.clientfo2.SAB is q'[Електронний код клієнта]';
comment on column bars_intgr.clientfo2.VIP_ACCOUNT_MANAGER is q'[Аккаунт vip-менеджера в AD]';

prompt create unique index XPK_CLIENFO2

begin
    execute immediate 'create unique index XPK_CLIENFO2 on bars_intgr.clientfo2(KF, RNK) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create index I_CLIENFO2_CHANGENUMBER

begin
    execute immediate 'create index I_CLIENFO2_CHANGENUMBER on bars_intgr.clientfo2(KF, CHANGENUMBER) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt create error log
begin
    dbms_errlog.create_error_log(dml_table_name => 'CLIENTFO2', err_log_table_space => 'BRSDMIMP');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
