
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f3mx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3MX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3MX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F3MX
( REPORT_DATE     date       constraint CC_NBURLOGF3MX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF3MX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR) constraint CC_NBURLOGF3MX_EKP_NN        NOT NULL
, KU              NUMBER(3)
, T071            NUMBER(38)
, Q003_1          VARCHAR2(3 CHAR)  constraint CC_NBURLOGF3MX_Q003_1_NN         NOT NULL 
, F091            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3MX_F091_NN         NOT NULL
, R030            VARCHAR2(3 CHAR)  constraint CC_NBURLOGF3MX_R030_NN         NOT NULL
, F090            VARCHAR2(3 CHAR)  constraint CC_NBURLOGF3MX_F090_NN         NOT NULL
, K040            VARCHAR2(3 CHAR)  constraint CC_NBURLOGF3MX_K040_NN         NOT NULL
, F089            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3MX_F089_NN         NOT NULL
, K020            VARCHAR2(10 CHAR) constraint CC_NBURLOGF3MX_K020_NN         NOT NULL
, K021            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3MX_K021_NN         NOT NULL
, Q001_1          VARCHAR2(135 CHAR)
, B010            VARCHAR2(10 CHAR)
, Q033            VARCHAR2(60 CHAR)
, Q001_2          VARCHAR2(135 CHAR) 
, Q003_2          VARCHAR2(50 CHAR) 
, Q007_1          VARCHAR2(10 CHAR) 
, F027            VARCHAR2(2 CHAR) 
, F02D            VARCHAR2(2 CHAR) 
, Q006            VARCHAR2(160 CHAR) 
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         NUMBER(38)     
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

  dbms_output.put_line( 'Table "NBUR_LOG_F3MX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F3MX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F3MX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f3mx                 Comments

comment on table  NBUR_LOG_F3MX is 'E9X Дані про перекази з використанням систем переказу коштів';
comment on column NBUR_LOG_F3MX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F3MX.KF is 'Фiлiя';
comment on column NBUR_LOG_F3MX.VERSION_ID is 'Номер версії файлу';
comment on column NBUR_LOG_F3MX.NBUC is 'Код МФО';
comment on column NBUR_LOG_F3MX.EKP is 'Код показника';
comment on column NBUR_LOG_F3MX.KU is 'Код території';
comment on column NBUR_LOG_F3MX.T071 is 'Сума';
comment on column NBUR_LOG_F3MX.Q003_1 is 'Умовний номер рядка';
comment on column NBUR_LOG_F3MX.F091 is 'Код операції';
comment on column NBUR_LOG_F3MX.R030 is 'Код валюти';
comment on column NBUR_LOG_F3MX.F090 is 'Код мети надходження/переказу';
comment on column NBUR_LOG_F3MX.K040 is 'Код країни';
comment on column NBUR_LOG_F3MX.F089 is 'Ознака консолідації';
comment on column NBUR_LOG_F3MX.K020 is 'Код відправника/отримувача';
comment on column NBUR_LOG_F3MX.K021 is 'Код ознаки ідентифікаційного коду';
comment on column NBUR_LOG_F3MX.Q001_1 is 'Найменування клієнта';
comment on column NBUR_LOG_F3MX.B010 is 'Код іноземного банку';
comment on column NBUR_LOG_F3MX.Q033 is 'Назва іноземного банку';
comment on column NBUR_LOG_F3MX.Q001_2 is 'Найменування контрагента - бенефіціара';
comment on column NBUR_LOG_F3MX.Q003_2 is 'Номер контракту/договору, кредитного договору/договору позики';
comment on column NBUR_LOG_F3MX.Q007_1 is 'Дата контракту/договору, кредитного договору/договору позики';
comment on column NBUR_LOG_F3MX.F027 is 'Код індикатора';
comment on column NBUR_LOG_F3MX.F02D is 'Код за деякими операціями';
comment on column NBUR_LOG_F3MX.Q006 is 'Відомості про операцію';

comment on column NBUR_LOG_F3MX.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_F3MX.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_F3MX.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_F3MX.KV is 'Ід. валюти';
comment on column NBUR_LOG_F3MX.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_F3MX.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_F3MX.BRANCH is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f3mx                   Grants

grant SELECT on NBUR_LOG_F3MX to BARSUPL;
grant SELECT on NBUR_LOG_F3MX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F3MX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f3mx.sql ======= *** End *** ===
PROMPT ===================================================================================== 
