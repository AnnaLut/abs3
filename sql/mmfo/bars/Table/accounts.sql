-- ======================================================================================
-- Module : CAC
-- Author : unknown genius
-- Date   : 29.08.2017
-- ======================================================================================
-- create table ACCOUNTS
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table ACCOUNTS
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'ACCOUNTS', 'CENTER', null, null, null, null );
  bpa.alter_policy_info( 'ACCOUNTS', 'FILIAL',  'M',  'M',  'M',  'M' );
  bpa.alter_policy_info( 'ACCOUNTS', 'WHOLE' , null,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table ACCOUNTS
( ACC          NUMBER(38)   constraint CC_ACCOUNTS_ACC_NN    NOT NULL
, KF           VARCHAR2(6)  default SYS_CONTEXT(''BARS_CONTEXT'',''USER_MFO'')
                            constraint CC_ACCOUNTS_KF_NN     NOT NULL
, NLS          VARCHAR2(15) constraint CC_ACCOUNTS_NLS_NN    NOT NULL
, KV           NUMBER(3)    constraint CC_ACCOUNTS_KV_NN     NOT NULL
, BRANCH       VARCHAR2(30) default SYS_CONTEXT(''BARS_CONTEXT'',''USER_BRANCH'')
                            constraint CC_ACCOUNTS_BRANCH_NN NOT NULL
, TOBO         VARCHAR2(30) default SYS_CONTEXT(''BARS_CONTEXT'',''USER_BRANCH'')
                            constraint CC_ACCOUNTS_TOBO_NN   NOT NULL
, NLSALT       VARCHAR2(15)
, NBS          CHAR(4)
, OB22         CHAR(2)
, NBS2         CHAR(4)
, DAOS         DATE         default TRUNC(SYSDATE)
                            constraint CC_ACCOUNTS_DAOS_NN   NOT NULL
, MDATE        DATE
, DAZS         DATE
, ISP          NUMBER(38)   constraint CC_ACCOUNTS_ISP_NN    NOT NULL
, NMS          VARCHAR2(70) constraint CC_ACCOUNTS_NMS_NN    NOT NULL
, LIM          NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_LIM_NN    NOT NULL
, OSTB         NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_OSTB_NN   NOT NULL
, OSTC         NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_OSTC_NN   NOT NULL
, OSTF         NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_OSTF_NN   NOT NULL
, OSTQ         NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_OSTQ_NN   NOT NULL
, DOS          NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_DOS_NN    NOT NULL
, KOS          NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_KOS_NN    NOT NULL
, DOSQ         NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_DOSQ_NN   NOT NULL
, KOSQ         NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_KOSQ_NN   NOT NULL
, PAP          NUMBER(1)    constraint CC_ACCOUNTS_PAP_NN    NOT NULL
, TIP          CHAR(3)      default ''ODB''
                            constraint CC_ACCOUNTS_TIP_NN    NOT NULL
, VID          NUMBER(2)    constraint CC_ACCOUNTS_VID_NN    NOT NULL
, TRCN         NUMBER(24)   default 0
                            constraint CC_ACCOUNTS_TRCN_NN   NOT NULL
, SEC          RAW(64)
, ACCC         NUMBER(38)
, BLKD         NUMBER(3)    default 0
                            constraint CC_ACCOUNTS_BLKD_NN   NOT NULL
, BLKK         NUMBER(3)    default 0
                            constraint CC_ACCOUNTS_BLKK_NN   NOT NULL
, POS          NUMBER(38)   constraint CC_ACCOUNTS_POS_NN    NOT NULL
, SECI         NUMBER(38)
, SECO         NUMBER(38)
, GRP          NUMBER(38)
, OSTX         NUMBER(24)
, RNK          NUMBER(38)   constraint CC_ACCOUNTS_RNK_NN  NOT NULL
, NOTIFIER_REF NUMBER(38)
, DAPP         DATE
, DAPPQ        DATE
, BDATE        DATE
, OPT          INTEGER
, SEND_SMS     VARCHAR2(1)
, DAT_ALT      DATE
, constraint PK_ACCOUNTS primary key (ACC) using index tablespace BRSBIGI
, constraint UK_ACCOUNTS unique ( KF, ACC) using index tablespace BRSBIGI local compress 1
, constraint FK_ACCOUNT_ACCOUNT foreign key ( ACCC ) references ACCOUNTS ( ACC )
, constraint CC_ACCOUNTS_BRANCH check ( BRANCH like ''/''||KF||''/%'')
, constraint CC_ACCOUNTS_TOBO   check ( BRANCH = TOBO ) deferrable
, constraint CC_ACCOUNTS_DAZS   check ( OSTC = nvl2(DAZS,0,OSTC) )
) TABLESPACE BRSBIGD 
  PARTITION BY LIST (KF)
  ( PARTITION P_01_300465  VALUES (''300465'')
  , PARTITION P_02_324805  VALUES (''324805'')
  , PARTITION P_03_302076  VALUES (''302076'')
  , PARTITION P_04_303398  VALUES (''303398'')
  , PARTITION P_05_305482  VALUES (''305482'')
  , PARTITION P_06_335106  VALUES (''335106'')
  , PARTITION P_07_311647  VALUES (''311647'')
  , PARTITION P_08_312356  VALUES (''312356'')
  , PARTITION P_09_313957  VALUES (''313957'')
  , PARTITION P_10_336503  VALUES (''336503'')
  , PARTITION P_11_322669  VALUES (''322669'')
  , PARTITION P_12_323475  VALUES (''323475'')
  , PARTITION P_13_304665  VALUES (''304665'')
  , PARTITION P_14_325796  VALUES (''325796'')
  , PARTITION P_15_326461  VALUES (''326461'')
  , PARTITION P_16_328845  VALUES (''328845'')
  , PARTITION P_17_331467  VALUES (''331467'')
  , PARTITION P_18_333368  VALUES (''333368'')
  , PARTITION P_19_337568  VALUES (''337568'')
  , PARTITION P_20_338545  VALUES (''338545'')
  , PARTITION P_21_351823  VALUES (''351823'')
  , PARTITION P_22_352457  VALUES (''352457'')
  , PARTITION P_23_315784  VALUES (''315784'')
  , PARTITION P_24_354507  VALUES (''354507'')
  , PARTITION P_25_356334  VALUES (''356334'')
  , PARTITION P_26_353553  VALUES (''353553'')
  )';
  
  dbms_output.put_line( 'Table "ACCOUNTS" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "ACCOUNTS" already exists.' );
end;
/

SET FEEDBACK ON


begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.accounts  ADD  (DAT_ALT date ) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.ACCOUNTS.DAT_ALT IS 'Дата заміни NLS->NLSALT';


prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'ACCOUNTS' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  ACCOUNTS              IS 'Счета банка';

COMMENT ON COLUMN ACCOUNTS.ACC          IS 'Внутренний номер счета';
COMMENT ON COLUMN ACCOUNTS.KF           IS 'Код филиала';
COMMENT ON COLUMN ACCOUNTS.NLS          IS 'Номер лицевого счета (внешний)';
COMMENT ON COLUMN ACCOUNTS.KV           IS 'Код валюты';
COMMENT ON COLUMN ACCOUNTS.BRANCH       IS 'Код безбалансового отделения';
COMMENT ON COLUMN ACCOUNTS.NLSALT       IS 'Альтернативный номер счета';
COMMENT ON COLUMN ACCOUNTS.NBS          IS 'Номер балансового счета';
COMMENT ON COLUMN ACCOUNTS.NBS2         IS 'Номер альтернат. балансового счета';
COMMENT ON COLUMN ACCOUNTS.DAOS         IS 'Дата открытия счета';
COMMENT ON COLUMN ACCOUNTS.DAPP         IS 'Дата последнего движения';
COMMENT ON COLUMN ACCOUNTS.ISP          IS 'Код исполнителя';
COMMENT ON COLUMN ACCOUNTS.NMS          IS 'Наименование счета';
COMMENT ON COLUMN ACCOUNTS.LIM          IS 'Лимит';
COMMENT ON COLUMN ACCOUNTS.OSTB         IS 'Остаток плановый';
COMMENT ON COLUMN ACCOUNTS.OSTC         IS 'Остаток фактический';
COMMENT ON COLUMN ACCOUNTS.OSTF         IS 'Остаток будущий';
COMMENT ON COLUMN ACCOUNTS.OSTQ         IS 'Эквивалент OSTF в нац. валюте';
COMMENT ON COLUMN ACCOUNTS.DOS          IS 'Обороты дебет';
COMMENT ON COLUMN ACCOUNTS.KOS          IS 'Обороты кредит';
COMMENT ON COLUMN ACCOUNTS.DOSQ         IS 'Дебетовые обороты за текущий день';
COMMENT ON COLUMN ACCOUNTS.KOSQ         IS 'Кредитовые обороты за текущий день';
COMMENT ON COLUMN ACCOUNTS.PAP          IS 'Признак Атива-Пассива';
COMMENT ON COLUMN ACCOUNTS.TIP          IS 'Тип счета';
COMMENT ON COLUMN ACCOUNTS.VID          IS 'Код вида счета';
COMMENT ON COLUMN ACCOUNTS.TRCN         IS 'Счетчик транзакций по данному счету';
COMMENT ON COLUMN ACCOUNTS.MDATE        IS 'Дата погашения счета';
COMMENT ON COLUMN ACCOUNTS.DAZS         IS 'Дата закрытия счета';
COMMENT ON COLUMN ACCOUNTS.SEC          IS 'Код доступа (obsolete)';
COMMENT ON COLUMN ACCOUNTS.ACCC         IS 'Внутренний номер счета';
COMMENT ON COLUMN ACCOUNTS.BLKD         IS 'Код блокировки дебет';
COMMENT ON COLUMN ACCOUNTS.BLKK         IS 'Код блокировки кредит';
COMMENT ON COLUMN ACCOUNTS.POS          IS 'Признак главного счета';
COMMENT ON COLUMN ACCOUNTS.SECI         IS 'Код доступа исполнителя';
COMMENT ON COLUMN ACCOUNTS.SECO         IS 'Код доступа остальных';
COMMENT ON COLUMN ACCOUNTS.GRP          IS 'Код группы счета';
COMMENT ON COLUMN ACCOUNTS.OSTX         IS 'Максимальный остаток на счете(верхний лимит)';
COMMENT ON COLUMN ACCOUNTS.RNK          IS 'Регистрационный номер клиента';
COMMENT ON COLUMN ACCOUNTS.NOTIFIER_REF IS 'способ уведомления клиента об изменении факт остатка';
COMMENT ON COLUMN ACCOUNTS.BDATE        IS 'Дата';
COMMENT ON COLUMN ACCOUNTS.OPT          IS '1 - Признак пакетной оплаты';
COMMENT ON COLUMN ACCOUNTS.OB22         IS 'Аналiтика рах. Розширення БР.';
COMMENT ON COLUMN ACCOUNTS.DAPPQ        IS 'Дата расчета эквивалента';
COMMENT ON COLUMN ACCOUNTS.SEND_SMS     IS '';

prompt -- ======================================================
prompt -- Constraints ( foreign keys )
prompt -- ======================================================

PROMPT *** Create  constraint FK_ACCOUNTS_BANKS ***
begin
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_BANKS FOREIGN KEY (KF)
	  REFERENCES BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_BRANCH ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_CUSTOMER ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_NOTIFIERS ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_NOTIFIERS FOREIGN KEY (NOTIFIER_REF)
	  REFERENCES NOTIFIERS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_PAP ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_PAP FOREIGN KEY (PAP)
	  REFERENCES PAP (PAP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_POS ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_POS FOREIGN KEY (POS)
	  REFERENCES POS (POS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_PS ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_PS FOREIGN KEY (NBS)
	  REFERENCES PS (NBS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_RANG ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_RANG FOREIGN KEY (BLKD)
	  REFERENCES RANG (RANG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_RANG2 ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_RANG2 FOREIGN KEY (BLKK)
	  REFERENCES RANG (RANG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_STAFF ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_STAFF FOREIGN KEY (ISP)
	  REFERENCES STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_TABVAL ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TABVAL FOREIGN KEY (KV)
	  REFERENCES TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_TIPS ***
begin   
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TIPS FOREIGN KEY (TIP)
	  REFERENCES TIPS (TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_ACCOUNTS_VIDS ***
begin
 execute immediate 'ALTER TABLE ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_VIDS FOREIGN KEY (VID)
	  REFERENCES VIDS (VID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

PROMPT *** Create  index IDX_ACCOUNTS_KF_TIP ***
begin
  execute immediate 'create index IDX_ACCOUNTS_TIP_KF on ACCOUNTS ( TIP, KF )
  tablespace BRSBIGI
  LOCAL
  COMPRESS 1';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/


PROMPT *** Create  index XAK_ACCOUNTS_BRANCH ***
begin   
 execute immediate 'create index IDX_ACCOUNTS_BRANCH ON ACCOUNTS (BRANCH) tablespace BRSBIGI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index XAK_ACCOUNTS_ACCC ***
begin   
 execute immediate 'create index XAK_ACCOUNTS_ACCC ON ACCOUNTS (ACCC) tablespace BRSBIGI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index IDX_ACCOUNTS_KF_NBS_OB22 ***
begin   
 execute immediate 'create index IDX_ACCOUNTS_NBS_OB22_KF on ACCOUNTS ( NBS, OB22 )
  tablespace BRSBIGI
  LOCAL
  COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index XAK_ACCOUNTS_RNK ***
begin   
 execute immediate 'create index IDX_ACCOUNTS_RNK ON ACCOUNTS (RNK) tablespace BRSBIGI LOCAL';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index UK_ACCOUNTS_KF_NLS_KV ***
begin   
 execute immediate 'create unique index UK_ACCOUNTS_KF_NLS_KV ON ACCOUNTS ( NLS, KV ) tablespace BRSBIGI LOCAL';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index IDX_ACCOUNTS_KF_NLSALT_KV ***
begin   
 execute immediate 'create index IDX_ACCOUNTS_KF_NLSALT_KV ON ACCOUNTS ( KV, NLSALT ) tablespace BRSBIGI LOCAL COMPRESS 1';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index XAK_ACCOUNTS_NMS ***
begin 
 execute immediate 'create index IDX_ACCOUNTS_NMS on ACCOUNTS (UPPER(NMS)) tablespace BRSBIGI LOCAL';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index XAK_ACCOUNTS_FTIP ***
begin   
 execute immediate 'create index XAK_ACCOUNTS_FTIP ON ACCOUNTS (CASE  WHEN (TIP=''N00'' OR TIP=''L00'' OR TIP=''L01'' OR TIP=''T00'' OR TIP=''T0D'' OR TIP=''TNB'' OR TIP=''TND'' OR TIP=''L99'' OR TIP=''N99'' OR TIP=''TUR'' OR TIP=''TUD'' OR TIP=''902'' OR TIP=''90D'') THEN TIP ELSE NULL END )
  TABLESPACE BRSBIGI
  LOCAL';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT,UPDATE,INSERT                                            on ACCOUNTS to ABS_ADMIN;
grant SELECT,UPDATE                                                   on ACCOUNTS to BARS009;
grant SELECT                                                          on ACCOUNTS to BARS010;
grant SELECT                                                          on ACCOUNTS to BARS015;
grant REFERENCES,SELECT                                               on ACCOUNTS to BARSAQ with grant option;
grant REFERENCES,SELECT                                               on ACCOUNTS to BARSAQ_ADM with grant option;
grant SELECT                                                          on ACCOUNTS to BARSDWH_ACCESS_USER;
grant SELECT                                                          on ACCOUNTS to BARSUPL;
grant SELECT,UPDATE,INSERT                                            on ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on ACCOUNTS to BARS_DM;
grant SELECT,UPDATE                                                   on ACCOUNTS to CUST001;
grant SELECT,UPDATE                                                   on ACCOUNTS to DEP_SKRN;
grant SELECT                                                          on ACCOUNTS to DM;
grant SELECT,UPDATE                                                   on ACCOUNTS to DPT;
grant SELECT                                                          on ACCOUNTS to DPT_ADMIN;
grant SELECT                                                          on ACCOUNTS to DPT_ROLE;
grant SELECT,UPDATE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES on ACCOUNTS to FINMON;
grant SELECT,UPDATE                                                   on ACCOUNTS to FINMON01;
grant SELECT,UPDATE                                                   on ACCOUNTS to FOREX;
grant SELECT                                                          on ACCOUNTS to IBSADM_ROLE;
grant SELECT                                                          on ACCOUNTS to INSPECTOR;
grant SELECT                                                          on ACCOUNTS to KLBX;
grant SELECT,UPDATE,INSERT                                            on ACCOUNTS to NALOG;
grant SELECT,UPDATE                                                   on ACCOUNTS to OBPC;
grant SELECT                                                          on ACCOUNTS to PFU with grant option;
grant SELECT                                                          on ACCOUNTS to PYOD001;
grant SELECT,UPDATE,INSERT                                            on ACCOUNTS to RCC_DEAL;
grant SELECT                                                          on ACCOUNTS to REF0000;
grant SELECT                                                          on ACCOUNTS to REFSYNC_USR;
grant SELECT                                                          on ACCOUNTS to RPBN001;
grant SELECT                                                          on ACCOUNTS to RPBN002;
grant SELECT,UPDATE                                                   on ACCOUNTS to SALGL;
grant SELECT,UPDATE                                                   on ACCOUNTS to SETLIM01;
grant SELECT                                                          on ACCOUNTS to START1;
grant SELECT                                                          on ACCOUNTS to SWTOSS;
grant UPDATE                                                          on ACCOUNTS to TECH001;
grant SELECT                                                          on ACCOUNTS to TECH005;
grant SELECT                                                          on ACCOUNTS to TOSS;
grant SELECT                                                          on ACCOUNTS to WR_ACRINT;
grant SELECT,UPDATE,INSERT                                            on ACCOUNTS to WR_ALL_RIGHTS;
grant SELECT,UPDATE                                                   on ACCOUNTS to WR_CUSTLIST;
grant SELECT,UPDATE                                                   on ACCOUNTS to WR_DEPOSIT_U;
grant SELECT                                                          on ACCOUNTS to WR_DOCHAND;
grant SELECT                                                          on ACCOUNTS to WR_DOCVIEW;
grant SELECT                                                          on ACCOUNTS to WR_DOC_INPUT;
grant SELECT                                                          on ACCOUNTS to WR_KP;
grant SELECT                                                          on ACCOUNTS to WR_VIEWACC;

prompt -- ======================================================
prompt -- Synonyms
prompt -- ======================================================

create or replace public synonym ACCOUNT1   for ACCOUNTS;
create or replace public synonym ACCOUNT2   for ACCOUNTS;
create or replace public synonym ACCOUNT4   for ACCOUNTS;
create or replace public synonym ACCOUNTS_F for ACCOUNTS;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
