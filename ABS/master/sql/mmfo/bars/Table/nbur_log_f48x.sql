-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 26.06.2018
-- ======================================================================================
-- create table NBUR_LOG_F48X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F48X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F48X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F48X', 'FILIAL',  'M', NULL,  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F48X', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F48X
( REPORT_DATE     date       constraint CC_NBURLOGF48X_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF48X_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR) constraint CC_NBURLOGF48X_EKP_NN        NOT NULL
, Q003            VARCHAR2(20 CHAR) constraint CC_NBURLOGF48X_Q003_NN       NOT NULL
, Q001            VARCHAR2(135 CHAR) constraint CC_NBURLOGF48X_R020_NN       NOT NULL
, Q002            VARCHAR2(135 CHAR)
, Q008            VARCHAR2(135 CHAR)
, Q029            VARCHAR2(10 CHAR)
, K020            VARCHAR2(10 CHAR)
, K021            VARCHAR2(3 CHAR)
, K040            VARCHAR2(3 CHAR)
, K110            VARCHAR2(5 CHAR)
, T070            NUMBER(38)
, T080            NUMBER(38)
, T090_1          NUMBER(5,2) constraint CC_NBURLOGF48X_T0901_VAL CHECK (T090_1 BETWEEN 0 AND 100)
, T090_2          NUMBER(38)
, T090_3          NUMBER(38)
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, MATURITY_DATE   DATE
, CUST_ID         NUMBER(38)     
, REF             NUMBER(38)
, ND              NUMBER(38)
, BRANCH          VARCHAR2(30)     
) tablespace BRSBIGD
COMPRESS BASIC
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED   0
PCTFREE   0
PARTITION BY RANGE (REPORT_DATE) INTERVAL( NUMTODSINTERVAL(1,'DAY') )
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
, SUBPARTITION SP_356334 VALUES ('356334') )
( PARTITION P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2018','DD/MM/YYYY') ) )]';

  dbms_output.put_line( 'Table "NBUR_LOG_F48X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F48X" already exists.' );
end;
/
SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F48X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table NBUR_LOG_F48X is '48X Двадцять найбільших учасників банку';

comment on column NBUR_LOG_F48X.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F48X.KF is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_F48X.VERSION_ID is 'Ід. версії файлу';
comment on column NBUR_LOG_F48X.NBUC is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_F48X.EKP is 'Код показника';
comment on column NBUR_LOG_F48X.Q003 is 'Умовний порядковий номер учасника банку';
comment on column NBUR_LOG_F48X.Q001 is 'Повне найменування юридичної особи або прізвище, ім’я, по батькові фізичної особи учасника банку';
comment on column NBUR_LOG_F48X.Q002 is 'Адреса юридичної особи або адреса постійного місця проживання фізичної особи';
comment on column NBUR_LOG_F48X.Q008 is 'Платіжні реквізити юридичної особи або паспортні дані фізичної особи';
comment on column NBUR_LOG_F48X.Q029 is 'Код учасника банку нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини';
comment on column NBUR_LOG_F48X.K020 is 'Код учаснику банку';
comment on column NBUR_LOG_F48X.K021 is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column NBUR_LOG_F48X.K040 is 'Код країни учасника банку';
comment on column NBUR_LOG_F48X.K110 is 'Код виду економічної діяльності учасника банку';
comment on column NBUR_LOG_F48X.T070 is 'Вартість акцій (паїв)';
comment on column NBUR_LOG_F48X.T080 is 'Кількість акцій (паїв)';
comment on column NBUR_LOG_F48X.T090_1 is 'Відсоток прямої участі у статутному капіталі';
comment on column NBUR_LOG_F48X.T090_2 is 'Відсоток опосередкованої участі у статутному капіталі';
comment on column NBUR_LOG_F48X.T090_3 is 'Відсоток загальної участі у статутному капіталі';
comment on column NBUR_LOG_F48X.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_F48X.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_F48X.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_F48X.KV is 'Ід. валюти';
comment on column NBUR_LOG_F48X.MATURITY_DATE is 'Дата Погашення';
comment on column NBUR_LOG_F48X.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_F48X.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_F48X.ND is 'Ід. договору';
comment on column NBUR_LOG_F48X.BRANCH is 'Код підрозділу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F48X to BARSUPL;
grant SELECT on NBUR_LOG_F48X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F48X to BARSREADER_ROLE;
