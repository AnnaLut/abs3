-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 27.06.2018
-- ======================================================================================
-- create table NBUR_LOG_FD5X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_FD5X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FD5X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FD5X', 'FILIAL',  'M', NULL,  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FD5X', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_FD5X
( REPORT_DATE     date       constraint CC_NBURLOGFD5X_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGFD5X_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR) constraint CC_NBURLOGFD5X_EKP_NN        NOT NULL
, KU              VARCHAR2(2 CHAR) constraint CC_NBURLOGFD5X_KU_NN         NOT NULL
, T020            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_T020_NN       NOT NULL
, R020            VARCHAR2(4 CHAR) constraint CC_NBURLOGFD5X_R020_NN       NOT NULL
, R011            VARCHAR2(1 CHAR)
, R013            VARCHAR2(1 CHAR)
, R030            VARCHAR2(3 CHAR) constraint CC_NBURLOGFD5X_R030_NN       NOT NULL
, K040            VARCHAR2(3 CHAR) constraint CC_NBURLOGFD5X_K040_NN       NOT NULL
, K072            VARCHAR2(2 CHAR) constraint CC_NBURLOGFD5X_K072_NN       NOT NULL
, K111            VARCHAR2(2 CHAR)
, K140            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_K140_NN       NOT NULL
, F074            VARCHAR2(3 CHAR) constraint CC_NBURLOGFD5X_F074_NN       NOT NULL
, S032            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_S032_NN       NOT NULL
, S080            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_S080_NN       NOT NULL
, S183            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_S183_NN       NOT NULL
, S190            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_S190_NN       NOT NULL
, S241            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_S241_NN       NOT NULL
, S260            VARCHAR2(2 CHAR) constraint CC_NBURLOGFD5X_S260_NN       NOT NULL
, F048            VARCHAR2(1 CHAR) constraint CC_NBURLOGFD5X_F048_NN       NOT NULL
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

  dbms_output.put_line( 'Table "NBUR_LOG_FD5X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FD5X" already exists.' );
end;
/
SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_FD5X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table NBUR_LOG_FD5X is 'D5X Додаткові дані для розрахунку економічних нормативів';

comment on column NBUR_LOG_FD5X.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_FD5X.KF is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_FD5X.VERSION_ID is 'Ід. версії файлу';
comment on column NBUR_LOG_FD5X.NBUC is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_FD5X.EKP is 'Код показника';
comment on column NBUR_LOG_FD5X.KU is 'Код території';
comment on column NBUR_LOG_FD5X.T020 is 'Елемент рахунку';
comment on column NBUR_LOG_FD5X.R020 is 'Номер рахунку';
comment on column NBUR_LOG_FD5X.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column NBUR_LOG_FD5X.R013 is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column NBUR_LOG_FD5X.R030 is 'Код валюти';
comment on column NBUR_LOG_FD5X.K040 is 'Код країни';
comment on column NBUR_LOG_FD5X.K072 is 'Код сектору економіки';
comment on column NBUR_LOG_FD5X.K111 is 'Код роздiлу виду економiчної дiяльностi';
comment on column NBUR_LOG_FD5X.K140 is 'Код розміру суб’єкта господарювання';
comment on column NBUR_LOG_FD5X.F074 is 'Код щодо належності контрагента/пов’язаної з банком особи до групи юридичних осіб під спільним контролем або до групи по';
comment on column NBUR_LOG_FD5X.S032 is 'Узагальнений код виду забезпечення кредиту';
comment on column NBUR_LOG_FD5X.S080 is 'Код класу боржника/контрагента';
comment on column NBUR_LOG_FD5X.S183 is 'Узагальнений код початкових строків погашення';
comment on column NBUR_LOG_FD5X.S190 is 'Код строку прострочення погашення боргу';
comment on column NBUR_LOG_FD5X.S241 is 'Узагальнений код строків до погашення';
comment on column NBUR_LOG_FD5X.S260 is 'Код індивідуального споживання за цілями';
comment on column NBUR_LOG_FD5X.F048 is 'Код типу процентної ставки';
comment on column NBUR_LOG_FD5X.T070 is 'Сума';
comment on column NBUR_LOG_FD5X.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_FD5X.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_FD5X.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_FD5X.KV is 'Ід. валюти';
comment on column NBUR_LOG_FD5X.MATURITY_DATE is 'Дата Погашення';
comment on column NBUR_LOG_FD5X.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_FD5X.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_FD5X.ND is 'Ід. договору';
comment on column NBUR_LOG_FD5X.BRANCH is 'Код підрозділу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_FD5X to BARSUPL;
grant SELECT on NBUR_LOG_FD5X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_FD5X to BARSREADER_ROLE;
