-- ======================================================================================
-- Module : NBUR
-- Author : Chaika
-- Date   : 10/12/2018
-- ======================================================================================
-- create table NBUR_LOG_F8BX
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F8BX
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F8BX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F8BX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_F8BX';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F8BX
( REPORT_DATE     date       constraint CC_NBURLOGF8BX_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGF8BX_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, F103		  varchar2(2 CHAR)      
, Q003_4          varchar2(4 CHAR)      
, T070            number(24)
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         NUMBER(38)     
, CUST_CODE	  VARCHAR2(14)
, CUST_NAME	  VARCHAR2(70)
, ND              NUMBER(38)
, AGRM_NUM	  VARCHAR2(50)
, BEG_DT	  date
, END_DT          date
, REF             NUMBER(38)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F8BX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F8BX" already exists.' );
end;
/


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F8BX' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_F8BX             is ' Окремі дані на вимогу Національного банку України';

comment on column NBUR_LOG_F8BX.REPORT_DATE is 'Звітна дата';
comment on column NBUR_LOG_F8BX.KF          is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_F8BX.VERSION_ID  is 'Ідентифікатор версії';
comment on column NBUR_LOG_F8BX.EKP         is 'Код показника';
comment on column NBUR_LOG_F8BX.F103        is 'Код окремих даних на вимогу Національного банку України (для файлу 8BX)';        
comment on column NBUR_LOG_F8BX.Q003_4      is 'Умовний порядковий номер контрагента';        
comment on column NBUR_LOG_F8BX.T070        is 'Cума';        
comment on column NBUR_LOG_F8BX.DESCRIPTION 	is 'Опис (коментар)';         
comment on column NBUR_LOG_F8BX.ACC_ID		is 'Ід. рахунка';             
comment on column NBUR_LOG_F8BX.ACC_NUM 	is 'Номер рахунка';           
comment on column NBUR_LOG_F8BX.KV		is 'Ід. валюти';              
comment on column NBUR_LOG_F8BX.CUST_ID 	is 'Ід. клієнта';             
comment on column NBUR_LOG_F8BX.CUST_CODE       is 'Код клієнта';             
comment on column NBUR_LOG_F8BX.CUST_NAME	is 'Назва клієнта';           
comment on column NBUR_LOG_F8BX.ND		is 'Ід. договору';            
comment on column NBUR_LOG_F8BX.AGRM_NUM	is 'Номер договору';          
comment on column NBUR_LOG_F8BX.BEG_DT		is 'Дата початку договору';   
comment on column NBUR_LOG_F8BX.END_DT		is 'Дата закінчення договору';
comment on column NBUR_LOG_F8BX.REF		is 'Ід. платіжного документа';
comment on column NBUR_LOG_F8BX.BRANCH		is 'Код підрозділу';          

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F8BX to BARSUPL;
grant SELECT on NBUR_LOG_F8BX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F8BX to BARSREADER_ROLE;
