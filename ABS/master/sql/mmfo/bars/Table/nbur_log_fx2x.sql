-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 20/09/2018
-- ======================================================================================
-- create table NBUR_LOG_FX2X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_FX2X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FX2X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FX2X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_FX2X';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_FX2X
( REPORT_DATE     date       constraint CC_NBURLOGFX2X_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGFX2X_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, KU              number(3)
, F099            varchar2(2 CHAR)
, Q003_4          varchar2(4 CHAR)      
, T070            number(24)
, ACC_ID          number(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         number(38)
, ND              number(38)
, LINK_GROUP      NUMBER(38)
, LINK_CODE       VARCHAR2(3 BYTE)
, COMM            VARCHAR2(200 BYTE)
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

  dbms_output.put_line( 'Table "NBUR_LOG_FX2X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FX2X" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_LOG_FX2X add ACC_ID number(38)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_FX2X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_FX2X             is 'X2X (КОНСОЛІДОВАНИЙ 42X) Данi щодо максимального ризику на одного контрагента';

comment on column NBUR_LOG_FX2X.REPORT_DATE is 'Звітна дата';
comment on column NBUR_LOG_FX2X.KF          is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_FX2X.VERSION_ID  is 'Ідентифікатор версії';
comment on column NBUR_LOG_FX2X.EKP         is 'Код показника';
comment on column NBUR_LOG_FX2X.KU          is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_FX2X.F099        is 'Код даних для розрахунку економічних нормативів';        
comment on column NBUR_LOG_FX2X.Q003_4      is 'Умовний порядковий номер контрагента';        
comment on column NBUR_LOG_FX2X.T070        is 'Cума';        
comment on column NBUR_LOG_FX2X.ACC_ID      is 'Iдентифiкатор рахунку';
comment on column NBUR_LOG_FX2X.ACC_NUM     is 'Номер рахунку';
comment on column NBUR_LOG_FX2X.KV          is 'Код валюти рахунку';
comment on column NBUR_LOG_FX2X.CUST_ID     is 'Iдентифiкатор контрагента';
comment on column NBUR_LOG_FX2X.ND          is 'РЕФ КД';
comment on column NBUR_LOG_FX2X.LINK_GROUP  is 'Порядковий код групи контрагентів';
comment on column NBUR_LOG_FX2X.LINK_CODE   is 'Зашифрований код групи контрагентів';
comment on column NBUR_LOG_FX2X.COMM        is 'Опис/коментар';
comment on column NBUR_LOG_FX2X.BRANCH      is 'Код філії/бранчу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_FX2X to BARSUPL;
grant SELECT on NBUR_LOG_FX2X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_FX2X to BARSREADER_ROLE;
