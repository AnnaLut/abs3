-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 20/09/2018
-- ======================================================================================
-- create table NBUR_LOG_F26X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F26X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F26X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F26X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_F26X';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F26X
( REPORT_DATE     date       constraint CC_NBURLOGF26X_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGF26X_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, KU              number(3)
, T020            varchar2(1 CHAR)
, R020            varchar2(4 CHAR)      
, R011            varchar2(1 CHAR)
, R013            varchar2(1 CHAR)
, R030            varchar2(3 CHAR)      
, K040            varchar2(3 CHAR)      
, Q001            varchar2(100 CHAR)
, K020            varchar2(10 CHAR)      
, K021            varchar2(1 CHAR)      
, K180            varchar2(1 CHAR)
, K190            varchar2(4 CHAR)
, S181            varchar2(1 CHAR)
, S245            varchar2(1 CHAR)
, S580            varchar2(1 CHAR)
, F033            varchar2(1 CHAR)
, T070            number(24)
, T071            number(24)
, ACC_ID          number(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         number(38)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F26X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F26X" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_LOG_F26X add ACC_ID number(38)]';
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
  bars.bpa.alter_policies( 'NBUR_LOG_F26X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_F26X             is 'Щомісячні знімки балансу РУ на звітну дату  (архів версій)';

comment on column NBUR_LOG_F26X.REPORT_DATE is 'Звітна дата';
comment on column NBUR_LOG_F26X.KF          is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_F26X.VERSION_ID  is 'Ідентифікатор версії';
comment on column NBUR_LOG_F26X.EKP         is 'Код показника';
comment on column NBUR_LOG_F26X.KU          is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_F26X.T020        is 'Код елементу даних за рахунком';
comment on column NBUR_LOG_F26X.R020        is 'Номер баланс./позабаланс. рахунку';
comment on column NBUR_LOG_F26X.R011        is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column NBUR_LOG_F26X.R013        is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column NBUR_LOG_F26X.R030        is 'Код валюти';
comment on column NBUR_LOG_F26X.K040        is 'Код країни учасника банку';
comment on column NBUR_LOG_F26X.Q001        is 'Назва банку-резидента/банку-нерезидента';
comment on column NBUR_LOG_F26X.K020        is 'Код учаснику банку';
comment on column NBUR_LOG_F26X.K021        is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column NBUR_LOG_F26X.K180        is 'Код належності банку до інвестиційного класу';
comment on column NBUR_LOG_F26X.K190        is 'Код рівня надійності';
comment on column NBUR_LOG_F26X.S181        is 'Код початкового строку погашення';
comment on column NBUR_LOG_F26X.S245        is 'Код узагальненого кінцевого строку погашення';
comment on column NBUR_LOG_F26X.S580        is 'Код розподілу активів за групами ризику';
comment on column NBUR_LOG_F26X.F033        is 'Код ознаки обтяженості коштів';
comment on column NBUR_LOG_F26X.T070        is 'Сума в національній валюті (грн.екв.)';
comment on column NBUR_LOG_F26X.T071        is 'Сума в іноземній валюті';      
comment on column NBUR_LOG_F26X.ACC_ID      is 'Iдентифiкатор рахунку';
comment on column NBUR_LOG_F26X.ACC_NUM     is 'Номер рахунку';
comment on column NBUR_LOG_F26X.KV          is 'Код валюти рахунку';
comment on column NBUR_LOG_F26X.CUST_ID     is 'Iдентифiкатор контрагента';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F26X to BARSUPL;
grant SELECT on NBUR_LOG_F26X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F26X to BARSREADER_ROLE;
