-- ======================================================================================
-- Module : NBUR
-- Author : chaika
-- Date   : 04.04.2019
-- ======================================================================================
-- create table NBUR_LOG_F25X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F25X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F25X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F25X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_F25X';
exception
  when e_tab_not_exists then null;  
end;
/


declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F25X
( REPORT_DATE     date       constraint CC_NBURLOGF25X_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGF25X_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, KU              number(3)
, R020            char(4)
, T020            char(1)
, R030            char(3)
, K040            char(3)
, T070            number(24)
, T071            number(24)
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          number(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         number(38)
, CUST_CODE	  VARCHAR2(14)
, CUST_NAME	  VARCHAR2(70)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F25X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F25X" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F25X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_F25X             is '25X Данi про обороти щодо згортання та залишки на рахунках';

comment on column NBUR_LOG_F25X.REPORT_DATE is 'Звітна дата';                                          
comment on column NBUR_LOG_F25X.KF          is 'Код фiлiалу (МФО)';                                    
comment on column NBUR_LOG_F25X.VERSION_ID  is 'Ідентифікатор версії';                                 
comment on column NBUR_LOG_F25X.NBUC        is 'Код розрізу даних у звітному файлі';
comment on column NBUR_LOG_F25X.EKP         is 'Код показника';                                        
comment on column NBUR_LOG_F25X.KU          is 'Код областi розрiзу юридичної особи';                  
comment on column NBUR_LOG_F25X.R020        is 'Номер рахунку';                                        
comment on column NBUR_LOG_F25X.T020        is 'Код елементу даних за рахунком';                       
comment on column NBUR_LOG_F25X.R030        is 'Код валюти';                                           
comment on column NBUR_LOG_F25X.K040        is 'Код країни';                                           
comment on column NBUR_LOG_F25X.T070        is 'Сума в гривневому еквіваленті';                        
comment on column NBUR_LOG_F25X.T071        is 'Сума в іноземній валюті';                              
comment on column NBUR_LOG_F25X.DESCRIPTION is 'Опис (коментар)';                                      
comment on column NBUR_LOG_F25X.ACC_ID      is 'Iдентифiкатор рахунку';                                
comment on column NBUR_LOG_F25X.ACC_NUM     is 'Номер рахунка';                                        
comment on column NBUR_LOG_F25X.KV 	    is 'Ід. валюти';                                           
comment on column NBUR_LOG_F25X.CUST_ID     is 'Iдентифiкатор контрагента';                            
comment on column NBUR_LOG_F25X.CUST_CODE   is 'Код клієнта';                                          
comment on column NBUR_LOG_F25X.CUST_NAME   is 'Назва клієнта';                                        
comment on column NBUR_LOG_F25X.BRANCH      is 'Код підрозділу';                                       
                                                                                                       

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F25X to BARSUPL;
grant SELECT on NBUR_LOG_F25X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F25X to BARSREADER_ROLE;
