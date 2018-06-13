-- ======================================================================================
-- Module : DPT
-- Author : BAA
-- Date   : 10.05.2018
-- ======================================================================================
-- create table DPT_DEPOSIT_CLOS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table DPT_DEPOSIT_CLOS
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPT_DEPOSIT_CLOS', 'CENTER', null, 'E', 'E', 'E' );
  BPA.ALTER_POLICY_INFO( 'DPT_DEPOSIT_CLOS', 'FILIAL',  'M', 'M', 'M', 'M' );
  BPA.ALTER_POLICY_INFO( 'DPT_DEPOSIT_CLOS', 'WHOLE',  null, 'E', 'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table DPT_DEPOSIT_CLOS
( IDUPD            NUMBER(38)   constraint CC_DPTDEPOSITCLOS_IDUPD_NN     NOT NULL
, BDATE            DATE
, ACTION_ID        NUMBER(1)    constraint CC_DPTDEPOSITCLOS_ACTIONID_NN  NOT NULL
, ACTIION_AUTHOR   NUMBER(38)   constraint CC_DPTDEPOSITCLOS_ACTUSER_NN   NOT NULL
, WHEN             DATE
, KF               VARCHAR2(6)  default SYS_CONTEXT('BARS_CONTEXT','USER_MFO')
                                constraint CC_DPTDEPOSITCLOS_KF_NN        NOT NULL
, DEPOSIT_ID       NUMBER(38)   CONSTRAINT CC_DPTDEPOSITCLOS_DEPOSITID_NN NOT NULL
, VIDD             NUMBER(38)   CONSTRAINT CC_DPTDEPOSITCLOS_VIDD_NN      NOT NULL
, ACC              NUMBER(38)   CONSTRAINT CC_DPTDEPOSITCLOS_ACC_NN       NOT NULL
, KV               NUMBER(3)    CONSTRAINT CC_DPTDEPOSITCLOS_KV_NN        NOT NULL
, RNK              NUMBER(38)   CONSTRAINT CC_DPTDEPOSITCLOS_RNK_NN       NOT NULL
, LIMIT            NUMBER(24)
, FREQ             NUMBER(3)
, DATZ             DATE         CONSTRAINT CC_DPTDEPOSITCLOS_DATZ_NN      NOT NULL
, DAT_BEGIN        DATE         CONSTRAINT CC_DPTDEPOSITCLOS_DATBEGIN_NN  NOT NULL
, DAT_END          DATE
, ND               VARCHAR2(35)
, BRANCH           VARCHAR2(30) default sys_context('bars_context','user_branch')
                                constraint CC_DPTDEPOSITCLOS_BRANCH_NN    NOT NULL
, COMMENTS         VARCHAR2(128)
, MFO_P            VARCHAR2(12)
, NLS_P            VARCHAR2(15)
, NAME_P           VARCHAR2(128)
, OKPO_P           VARCHAR2(15)
, DEPOSIT_COD      VARCHAR2(4)
, DPT_D            NUMBER(38)
, ACC_D            NUMBER(38)
, MFO_D            VARCHAR2(12)
, NLS_D            VARCHAR2(15)
, NMS_D            VARCHAR2(38)
, OKPO_D           VARCHAR2(14)
, REF_DPS          NUMBER(38)
, DAT_END_ALT      DATE
, STOP_ID          NUMBER(38)   CONSTRAINT CC_DPTDEPOSITCLOS_STOPID_NN NOT NULL 
, CNT_DUBL         NUMBER(10)
, CNT_EXT_INT      NUMBER(10)
, DAT_EXT_INT      DATE
, USERID           NUMBER(38)   CONSTRAINT CC_DPTDEPOSITCLOS_USERID_NN NOT NULL
, ARCHDOC_ID       NUMBER(38)
, FORBID_EXTENSION NUMBER(1)
, WB               CHAR(1)      default 'N'
, constraint PK_DPTDEPOSITCLOS              PRIMARY KEY (IDUPD) using index tablespace BRSBIGI
, constraint FK_DPTDEPOSITCLOS_DPTDPTALL    FOREIGN KEY (DEPOSIT_ID)     REFERENCES DPT_DEPOSIT_ALL (DEPOSIT_ID)
, constraint FK_DPTDEPOSITCLOS_DPTDPTALL2   FOREIGN KEY (DPT_D)          REFERENCES DPT_DEPOSIT_ALL (DEPOSIT_ID)
, constraint FK_DPTDEPOSITCLOS_ACCOUNTS     FOREIGN KEY (ACC)            REFERENCES ACCOUNTS (ACC)
, constraint FK_DPTDEPOSITCLOS_ACCOUNTS2    FOREIGN KEY (ACC_D)          REFERENCES ACCOUNTS (ACC)
, constraint FK_DPTDEPOSITCLOS_CUSTOMER     FOREIGN KEY (RNK)            REFERENCES CUSTOMER (RNK)
, constraint FK_DPTDEPOSITCLOS_KF           FOREIGN KEY (KF)             REFERENCES BANKS$BASE (MFO)
, constraint FK_DPTDEPOSITCLOS_BANKS        FOREIGN KEY (MFO_P)          REFERENCES BANKS$BASE (MFO)
, constraint FK_DPTDEPOSITCLOS_BANKS2       FOREIGN KEY (MFO_D)          REFERENCES BANKS$BASE (MFO)
, constraint FK_DPTDEPOSITCLOS_BRANCH       FOREIGN KEY (BRANCH)         REFERENCES BRANCH (BRANCH) DEFERRABLE
, constraint FK_DPTDEPOSITCLOS_DPTDEPACTION FOREIGN KEY (ACTION_ID)      REFERENCES DPT_DEPOSIT_ACTION (ID)
, constraint FK_DPTDEPOSITCLOS_DPTSTOP      FOREIGN KEY (STOP_ID)        REFERENCES DPT_STOP (ID)
, constraint FK_DPTDEPOSITCLOS_STAFF        FOREIGN KEY (ACTIION_AUTHOR) REFERENCES STAFF$BASE (ID)
, constraint FK_DPTDEPOSITCLOS_STAFF2       FOREIGN KEY (USERID)         REFERENCES STAFF$BASE (ID)
, constraint FK_DPTDEPOSITCLOS_TABVAL       FOREIGN KEY (KV)             REFERENCES TABVAL$GLOBAL (KV)
, constraint FK_DPTDEPOSITCLOS_DPTVIDD      FOREIGN KEY (VIDD)           REFERENCES DPT_VIDD (VIDD)
, constraint FK_DPTDEPOSITCLOS_FREQ         FOREIGN KEY (FREQ)           REFERENCES FREQ (FREQ)
) tablespace BRSBIGD
COMPRESS FOR OLTP
STORAGE( INITIAL 256K NEXT 256K )
PARTITION BY RANGE ("WHEN") INTERVAL( NUMTOYMINTERVAL(3,'MONTH') )
SUBPARTITION BY LIST (KF)
SUBPARTITION TEMPLATE
( SUBPARTITION SP_300465 VALUES ('300465')
, SUBPARTITION SP_302076 VALUES ('302076')
, SUBPARTITION SP_303398 VALUES ('303398')
, SUBPARTITION SP_304665 VALUES ('304665')
, SUBPARTITION SP_305482 VALUES ('305482')
, SUBPARTITION SP_311647 VALUES ('311647')
, SUBPARTITION SP_312356 VALUES ('312356')
, SUBPARTITION SP_313957 VALUES ('313957')
, SUBPARTITION SP_315784 VALUES ('315784')
, SUBPARTITION SP_322669 VALUES ('322669')
, SUBPARTITION SP_323475 VALUES ('323475')
, SUBPARTITION SP_324805 VALUES ('324805')
, SUBPARTITION SP_325796 VALUES ('325796')
, SUBPARTITION SP_326461 VALUES ('326461')
, SUBPARTITION SP_328845 VALUES ('328845')
, SUBPARTITION SP_331467 VALUES ('331467')
, SUBPARTITION SP_333368 VALUES ('333368')
, SUBPARTITION SP_335106 VALUES ('335106')
, SUBPARTITION SP_336503 VALUES ('336503')
, SUBPARTITION SP_337568 VALUES ('337568')
, SUBPARTITION SP_338545 VALUES ('338545')
, SUBPARTITION SP_351823 VALUES ('351823')
, SUBPARTITION SP_352457 VALUES ('352457')
, SUBPARTITION SP_353553 VALUES ('353553')
, SUBPARTITION SP_354507 VALUES ('354507')
, SUBPARTITION SP_356334 VALUES ('356334')
)
( PARTITION DEPCLS_Y2009    VALUES LESS THAN (TO_DATE(' 2010-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2010    VALUES LESS THAN (TO_DATE(' 2011-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2011    VALUES LESS THAN (TO_DATE(' 2012-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2012    VALUES LESS THAN (TO_DATE(' 2013-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2013    VALUES LESS THAN (TO_DATE(' 2014-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2014    VALUES LESS THAN (TO_DATE(' 2015-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q1 VALUES LESS THAN (TO_DATE(' 2015-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q2 VALUES LESS THAN (TO_DATE(' 2015-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q3 VALUES LESS THAN (TO_DATE(' 2015-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q4 VALUES LESS THAN (TO_DATE(' 2016-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q1 VALUES LESS THAN (TO_DATE(' 2016-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q2 VALUES LESS THAN (TO_DATE(' 2016-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q3 VALUES LESS THAN (TO_DATE(' 2016-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q4 VALUES LESS THAN (TO_DATE(' 2017-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q1 VALUES LESS THAN (TO_DATE(' 2017-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q2 VALUES LESS THAN (TO_DATE(' 2017-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q3 VALUES LESS THAN (TO_DATE(' 2017-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q4 VALUES LESS THAN (TO_DATE(' 2018-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
)]';

  dbms_output.put_line( 'Table created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "DPT_DEPOSIT" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

PROMPT *** Create index IDX_DPTDEPOSITCLOS_ACTNID ***

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DPTDEPOSITCLOS_ACTNID on DPT_DEPOSIT_CLOS ( ACTION_ID, DEPOSIT_ID, KF ) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

PROMPT *** Create  index UK_DPTDEPOSITCLOS ***

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate 'create unique index UK_DPTDEPOSITCLOS on DPT_DEPOSIT_CLOS (DECODE(ACTION_ID,0,DEPOSIT_ID,1,DEPOSIT_ID,2,DEPOSIT_ID,5,DEPOSIT_ID,NULL), DECODE(ACTION_ID,0,1,1,2,2,2,5,5,NULL)) tablespace BRSBIGI';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

PROMPT *** Create  index UK_DPTDEPOSITCLOS_REFDPS ***

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate 'create unique index UK_DPTDEPOSITCLOS_REFDPS on DPT_DEPOSIT_CLOS (REF_DPS) tablespace BRSBIGI';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

PROMPT *** Create index IDX_DPTDEPOSITCLOS_BDATE ***

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DPTDEPOSITCLOS_BDATE on DPT_DEPOSIT_CLOS ( BDATE, KF, DEPOSIT_ID, IDUPD ) tablespace BRSBIGI compress 2';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

PROMPT *** Create  index IDX_DPTDEPOSITCLOS_DPTID ***

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DPTDEPOSITCLOS_DPTID on DPT_DEPOSIT_CLOS (DEPOSIT_ID) tablespace BRSBIGI';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

PROMPT *** Create  index IDX_DPTDEPOSITCLOS_ACC ***

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DPTDEPOSITCLOS_ACC on DPT_DEPOSIT_CLOS (ACC) tablespace BRSBIGI';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

PROMPT *** Create  index IDX_DPTDEPOSITCLOS_RNK ***

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DPTDEPOSITCLOS_RNK on DPT_DEPOSIT_CLOS (RNK) tablespace BRSBIGI';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'DPT_DEPOSIT_CLOS' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  DPT_DEPOSIT_CLOS                IS 'Архів депозитів ФО';

comment on column DPT_DEPOSIT_CLOS.KF             IS 'Код фiлiалу (МФО)';
comment on column DPT_DEPOSIT_CLOS.DEPOSIT_ID     IS 'Идентификатор депозитного договора';
comment on column DPT_DEPOSIT_CLOS.VIDD           IS 'Идентификатор вида деп. договора';
comment on column DPT_DEPOSIT_CLOS.ACC            IS 'Идентификатор основного счета';
comment on column DPT_DEPOSIT_CLOS.KV             IS 'Код валюты';
comment on column DPT_DEPOSIT_CLOS.RNK            IS 'Идентификатор клиента';
comment on column DPT_DEPOSIT_CLOS.DAT_BEGIN      IS 'Дата начала договора';
comment on column DPT_DEPOSIT_CLOS.DAT_END        IS 'Дата завершения договора';
comment on column DPT_DEPOSIT_CLOS.COMMENTS       IS 'Комментарий';
comment on column DPT_DEPOSIT_CLOS.MFO_P          IS 'Код МФО банка получателя';
comment on column DPT_DEPOSIT_CLOS.NLS_P          IS 'Номер счета получателя';
comment on column DPT_DEPOSIT_CLOS.LIMIT          IS 'Лимит';
comment on column DPT_DEPOSIT_CLOS.DEPOSIT_COD    IS 'Код вида договора';
comment on column DPT_DEPOSIT_CLOS.NAME_P         IS 'Наименование получателя';
comment on column DPT_DEPOSIT_CLOS.DATZ           IS 'Дата заключения договора';
comment on column DPT_DEPOSIT_CLOS.OKPO_P         IS 'Код ОКПО получателя';
comment on column DPT_DEPOSIT_CLOS.FREQ           IS 'Периодичность выплаты %%';
comment on column DPT_DEPOSIT_CLOS.ND             IS '№ депозитного договора (альтернативный)';
comment on column DPT_DEPOSIT_CLOS.BRANCH         IS 'Код подразделения';
comment on column DPT_DEPOSIT_CLOS.DPT_D          IS '№ техн.вклада';
comment on column DPT_DEPOSIT_CLOS.ACC_D          IS 'Внутр.номер техн.счета';
comment on column DPT_DEPOSIT_CLOS.MFO_D          IS 'МФО техн.счета';
comment on column DPT_DEPOSIT_CLOS.NLS_D          IS 'Техн.счет';
comment on column DPT_DEPOSIT_CLOS.NMS_D          IS 'Наименование техн.счета';
comment on column DPT_DEPOSIT_CLOS.OKPO_D         IS 'Идент.код техн.счета';
comment on column DPT_DEPOSIT_CLOS.REF_DPS        IS 'Референс документа по взысканию штрафа';
comment on column DPT_DEPOSIT_CLOS.DAT_END_ALT    IS 'План.дата закрытия техн.счета';
comment on column DPT_DEPOSIT_CLOS.STOP_ID        IS 'Код штрафа за досрочное расторжение';
comment on column DPT_DEPOSIT_CLOS.USERID         IS 'Пользователь-инициатор открытия вклада';
comment on column DPT_DEPOSIT_CLOS.ARCHDOC_ID     IS 'Ідентифікатор депозитного договору в ЕАД';
comment on column DPT_DEPOSIT_CLOS.IDUPD          IS 'Идентификатор записи';
comment on column DPT_DEPOSIT_CLOS.ACTION_ID      IS 'Код изменения';
comment on column DPT_DEPOSIT_CLOS.ACTIION_AUTHOR IS 'Код польз, совершившего изменения';
comment on column DPT_DEPOSIT_CLOS.WHEN           IS 'Дата/время изменения';
comment on column DPT_DEPOSIT_CLOS.BDATE          IS 'Банковская дата';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT                         on DPT_DEPOSIT_CLOS to BARSREADER_ROLE;
grant SELECT                         on DPT_DEPOSIT_CLOS to BARSUPL;
GRANT SELECT, INSERT, UPDATE, DELETE on DPT_DEPOSIT_CLOS TO BARS_ACCESS_DEFROLE;
grant SELECT                         on DPT_DEPOSIT_CLOS to BARS_DM;
grant SELECT                         on DPT_DEPOSIT_CLOS TO UPLD;
