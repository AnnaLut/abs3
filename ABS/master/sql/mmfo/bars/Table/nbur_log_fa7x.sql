-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 22.06.2018
-- ======================================================================================
-- create table NBUR_LOG_FA7X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_FA7X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FA7X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FA7X', 'FILIAL',  'M', NULL,  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FA7X', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_FA7X
( REPORT_DATE     date       constraint CC_NBURLOGFA7X_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGFA7X_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR) constraint CC_NBURLOGFA7X_EKP_NN        NOT NULL
, T020            VARCHAR2(1 CHAR) constraint CC_NBURLOGFA7X_T020_NN       NOT NULL
, R020            VARCHAR2(4 CHAR) constraint CC_NBURLOGFA7X_R020_NN       NOT NULL
, R011            VARCHAR2(1 CHAR)
, R013            VARCHAR2(1 CHAR)
, R030            VARCHAR2(3 CHAR) constraint CC_NBURLOGFA7X_R030_NN       NOT NULL
, K030            VARCHAR2(1 CHAR) constraint CC_NBURLOGFA7X_K030_NN       NOT NULL
, S181            VARCHAR2(1 CHAR) constraint CC_NBURLOGFA7X_S181_NN       NOT NULL
, S190            VARCHAR2(1 CHAR) constraint CC_NBURLOGFA7X_S190_NN       NOT NULL
, S240            VARCHAR2(1 CHAR) constraint CC_NBURLOGFA7X_S240_NN       NOT NULL
, T070            NUMBER(38)
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

  dbms_output.put_line( 'Table "NBUR_LOG_FA7X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FA7X" already exists.' );
end;
/
SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_FA7X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table NBUR_LOG_FA7X is 'A7X Структура активів та пасивів';

comment on column NBUR_LOG_FA7X.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_FA7X.KF is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_FA7X.VERSION_ID is 'Ід. версії файлу';
comment on column NBUR_LOG_FA7X.NBUC is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_FA7X.EKP is 'Код показника';
comment on column NBUR_LOG_FA7X.T020 is 'Елемент рахунку';
comment on column NBUR_LOG_FA7X.R020 is 'Номер рахунку';
comment on column NBUR_LOG_FA7X.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column NBUR_LOG_FA7X.R013 is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column NBUR_LOG_FA7X.R030 is 'Код валюти';
comment on column NBUR_LOG_FA7X.K030 is 'Код резидентності';
comment on column NBUR_LOG_FA7X.S181 is 'Код початкового строку погашення';
comment on column NBUR_LOG_FA7X.S190 is 'Код строку прострочення погашення боргу';
comment on column NBUR_LOG_FA7X.S240 is 'Код строку до погашення';
comment on column NBUR_LOG_FA7X.T070 is 'Сума';
comment on column NBUR_LOG_FA7X.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_FA7X.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_FA7X.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_FA7X.KV is 'Ід. валюти';
comment on column NBUR_LOG_FA7X.MATURITY_DATE is 'Дата Погашення';
comment on column NBUR_LOG_FA7X.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_FA7X.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_FA7X.ND is 'Ід. договору';
comment on column NBUR_LOG_FA7X.BRANCH is 'Код підрозділу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_FA7X to BARSUPL;
grant SELECT on NBUR_LOG_FA7X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_FA7X to BARSREADER_ROLE;
