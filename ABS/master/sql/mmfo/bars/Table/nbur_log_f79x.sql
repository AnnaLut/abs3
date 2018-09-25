-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 20/09/2018
-- ======================================================================================
-- create table NBUR_LOG_F79X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F79X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F79X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F79X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_F79X';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F79X
( REPORT_DATE     date       constraint CC_NBURLOGF79X_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGF79X_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, KU              number(3)
, R030            varchar2(3 CHAR)      
, K030            varchar2(1 CHAR)      
, Q001            varchar2(100 CHAR)
, K020            varchar2(10 CHAR)      
, K021            varchar2(1 CHAR)  
, Q007_1          date
, Q007_2          date
, Q007_3          date
, Q007_4          date    
, Q003_1          varchar2(10 CHAR)
, Q003_2          varchar2(5 CHAR)
, Q003_3          varchar2(4 CHAR)
, T070_1          number(24)
, T070_2          number(24)
, T070_3          number(24)
, T070_4          number(24)
, T090_1          number(16,4)
, T090_2          number(16,4)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F79X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F79X" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_LOG_F79X add ACC_ID number(38)]';
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
  bars.bpa.alter_policies( 'NBUR_LOG_F79X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_F79X             is 'Щомісячні знімки балансу РУ на звітну дату  (архів версій)';

comment on column NBUR_LOG_F79X.REPORT_DATE is 'Звітна дата';
comment on column NBUR_LOG_F79X.KF          is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_F79X.VERSION_ID  is 'Ідентифікатор версії';
comment on column NBUR_LOG_F79X.EKP         is 'Код показника';
comment on column NBUR_LOG_F79X.KU          is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_F79X.R030        is 'код валюти субординованого боргу';
comment on column NBUR_LOG_F79X.K030        is 'код резидентності інвестора';
comment on column NBUR_LOG_F79X.Q001        is 'Повне найменування юридичної особи або прізвище, ім’я, по батькові фізичної особи інвестора';
comment on column NBUR_LOG_F79X.K020        is 'Код інвестора';
comment on column NBUR_LOG_F79X.K021        is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column NBUR_LOG_F79X.Q007_1      is 'дата укладення угоди про субординований борг';
comment on column NBUR_LOG_F79X.Q007_2      is 'дата закінчення дії угоди про субординований борг';
comment on column NBUR_LOG_F79X.Q007_3      is 'дата рішення Комітету з питань нагляду та регулювання діяльності банків про включення до капіталу';
comment on column NBUR_LOG_F79X.Q007_4      is 'дата реєстрації договору';
comment on column NBUR_LOG_F79X.Q003_1      is 'номер рішення Комітету з питань нагляду та регулювання діяльності банків про включення до капіталу';
comment on column NBUR_LOG_F79X.Q003_2      is 'номер реєстрації договору';
comment on column NBUR_LOG_F79X.Q003_3      is 'умовний порядковий номер боргу для конкретного інвестора';
comment on column NBUR_LOG_F79X.T070_1      is 'сума залученого субординованого боргу для врахування до капіталу банку за б/р 3660,3661';      
comment on column NBUR_LOG_F79X.T070_2      is 'сума, на яку отримано дозвіл на врахування залучених коштів на умовах субординованого боргу до капіталу банку';      
comment on column NBUR_LOG_F79X.T070_3      is 'сума субординованого боргу, яка враховується в розрахунку регулятивного капіталу банку';      
comment on column NBUR_LOG_F79X.T070_4      is 'сума перевищення обмеження, установленого пунктом 3.10 глави 3 розділу III Інструкції № 368';      
comment on column NBUR_LOG_F79X.T090_1      is 'процент, який береться до розрахунку суми субординованого боргу';      
comment on column NBUR_LOG_F79X.T090_2      is 'розмір процентної ставки, яка встановлюється за субординованим боргом, згідно з угодою';      
comment on column NBUR_LOG_F79X.ACC_ID      is 'Iдентифiкатор рахунку';
comment on column NBUR_LOG_F79X.ACC_NUM     is 'Номер рахунку';
comment on column NBUR_LOG_F79X.KV          is 'Код валюти рахунку';
comment on column NBUR_LOG_F79X.CUST_ID     is 'Iдентифiкатор контрагента';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F79X to BARSUPL;
grant SELECT on NBUR_LOG_F79X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F79X to BARSREADER_ROLE;
