-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 14/09/2018
-- ======================================================================================
-- create table NBUR_LOG_FE8X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_FE8X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FE8X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FE8X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_FE8X';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_FE8X
( REPORT_DATE     date       constraint CC_NBURLOGFE8X_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGFE8X_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, KU              number(3)
, Q001            varchar2(250 CHAR) 
, Q029            varchar2(50 CHAR) 
, K074            varchar2(1 CHAR) 
, K110            varchar2(5 CHAR) 
, K040            varchar2(3 CHAR) 
, KU_1            varchar2(3 CHAR) 
, Q020            varchar2(27 CHAR) 
, K020            varchar2(10 CHAR) 
, K014            varchar2(1 CHAR) 
, R020            varchar2(4 CHAR) 
, R030            varchar2(3 CHAR)
, Q003_1          varchar2(4 CHAR) 
, Q003_2          varchar2(30 CHAR)      
, Q007_1          varchar2(10 CHAR)
, Q007_2          varchar2(10 CHAR)
, T070_1          number(24)
, T070_2          number(24)
, T070_3          number(24)
, T070_4          number(24)
, T090            varchar2(20 CHAR) 
, Q003_12         number(24)
, K021            varchar2(1 CHAR) 
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

  dbms_output.put_line( 'Table "NBUR_LOG_FE8X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FE8X" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_LOG_FE8X add ACC_ID number(38)]';
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
  bars.bpa.alter_policies( 'NBUR_LOG_FE8X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_FE8X             is 'Щомісячні знімки балансу РУ на звітну дату  (архів версій)';

comment on column NBUR_LOG_FE8X.REPORT_DATE is 'Звітна дата';
comment on column NBUR_LOG_FE8X.KF          is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_FE8X.VERSION_ID  is 'Ідентифікатор версії';
comment on column NBUR_LOG_FE8X.EKP         is 'Код показника';
comment on column NBUR_LOG_FE8X.KU          is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_FE8X.Q003_12     is 'Умовний порядковий номер запису у звітному файлі';        
comment on column NBUR_LOG_FE8X.Q001        is 'Найменування кредитора';        
comment on column NBUR_LOG_FE8X.K020        is 'Код кредитора';        
comment on column NBUR_LOG_FE8X.K021        is 'Код ознаки коду кредитора';        
comment on column NBUR_LOG_FE8X.Q029        is 'Код кредитора - нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини';        
comment on column NBUR_LOG_FE8X.Q020        is 'Код типу пов''язаної з банком особи';        
comment on column NBUR_LOG_FE8X.K040        is 'Код країни кредитора';        
comment on column NBUR_LOG_FE8X.KU_1        is 'Код регіону, у якому зареєстрований кредитор';        
comment on column NBUR_LOG_FE8X.K014        is 'Код типу клієнта банку';        
comment on column NBUR_LOG_FE8X.K110        is 'Код виду економічної діяльності кредитора';        
comment on column NBUR_LOG_FE8X.K074        is 'Код інституційного сектору економіки';        
comment on column NBUR_LOG_FE8X.Q003_1      is 'Умовний порядковий номер договору у звітному файлі';        
comment on column NBUR_LOG_FE8X.Q003_2      is 'Номер договору';        
comment on column NBUR_LOG_FE8X.Q007_1      is 'Дата договору або дата першого руху коштів';        
comment on column NBUR_LOG_FE8X.Q007_2      is 'Дата кінцевого погашення заборгованості';        
comment on column NBUR_LOG_FE8X.R030        is 'Код валюти';        
comment on column NBUR_LOG_FE8X.T090        is 'Розмір процентної ставки';        
comment on column NBUR_LOG_FE8X.R020        is 'Номер балансового рахунку';        
comment on column NBUR_LOG_FE8X.T070_1      is 'Основна сума боргу';        
comment on column NBUR_LOG_FE8X.T070_2      is 'Неамортизовані дисконт/премія';        
comment on column NBUR_LOG_FE8X.T070_3      is 'Нараховані витрати';        
comment on column NBUR_LOG_FE8X.T070_4      is 'Переоцінка (дооцінка/уцінка)'; 
comment on column NBUR_LOG_FE8X.ACC_ID      is 'Iдентифiкатор рахунку';
comment on column NBUR_LOG_FE8X.ACC_ID      is 'Номер рахунку';
comment on column NBUR_LOG_FE8X.KV          is 'Код валюти рахунку';
comment on column NBUR_LOG_FE8X.CUST_ID     is 'Iдентифiкатор контрагента';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_FE8X to BARSUPL;
grant SELECT on NBUR_LOG_FE8X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_FE8X to BARSREADER_ROLE;
