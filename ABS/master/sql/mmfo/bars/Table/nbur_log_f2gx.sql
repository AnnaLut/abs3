
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f2gx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F2GX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F2GX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F2GX
( REPORT_DATE     date       constraint CC_NBURLOGF2GX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF2GX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR)   constraint CC_NBURLOGF2GX_EKP_NN            NOT NULL
, F091            VARCHAR2(1 CHAR)   constraint CC_NBURLOGF2GX_F091_NN           NOT NULL
, D100            VARCHAR2(2 CHAR)   constraint CC_NBURLOGF2GX_D100_NN           NOT NULL
, Q024            VARCHAR2(1 CHAR)   constraint CC_NBURLOGF2GX_Q024_NN           NOT NULL
, T070            NUMBER(38)
, KV              NUMBER(3)
, CUST_ID         NUMBER(38)     
, CUST_NAME       VARCHAR2(70)     
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20 BYTE)
, REF             NUMBER(38)
, DESCRIPTION     VARCHAR2(128 BYTE)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F2GX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F2GX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F2GX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_F2GX                 Comments

comment on table  NBUR_LOG_F2GX is '2GX -Інформація за операціями з купівлі/продажу іноземної валюти';
comment on column NBUR_LOG_F2GX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F2GX.KF is 'Фiлiя';
comment on column NBUR_LOG_F2GX.VERSION_ID is 'Номер версії файлу';
comment on column NBUR_LOG_F2GX.NBUC   is 'Код МФО';
comment on column NBUR_LOG_F2GX.EKP    is 'Код показника';
comment on column NBUR_LOG_F2GX.F091   is 'Код операції';
comment on column NBUR_LOG_F2GX.D100   is 'Умови валютної операції';
comment on column NBUR_LOG_F2GX.Q024   is 'Тип контрагента';
comment on column NBUR_LOG_F2GX.T070   is 'Сума в нац.валюті';

comment on column NBUR_LOG_F2GX.KV       is 'Ід. валюти';
comment on column NBUR_LOG_F2GX.REF       is 'Ід. платіжного документа';
comment on column NBUR_LOG_F2GX.CUST_ID    is 'Ід. клієнта';
comment on column NBUR_LOG_F2GX.CUST_NAME  is 'Назва клієнта';
COMMENT ON COLUMN NBUR_LOG_F2GX.ACC_ID    IS 'Ід. рахунка';
COMMENT ON COLUMN NBUR_LOG_F2GX.ACC_NUM   IS 'Номер рахунка';
COMMENT ON COLUMN NBUR_LOG_F2GX.DESCRIPTION   IS 'Опис операції';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_F2GX                   Grants

grant SELECT on NBUR_LOG_F2GX to BARSUPL;
grant SELECT on NBUR_LOG_F2GX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F2GX to BARSREADER_ROLE;
                          
                          
PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f2gx.sql ======= *** End *** ===
PROMPT ===================================================================================== 
                          
                            
