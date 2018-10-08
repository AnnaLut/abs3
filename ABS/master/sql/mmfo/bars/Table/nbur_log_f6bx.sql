
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f6bx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6BX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6BX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F6BX
( REPORT_DATE     date       constraint CC_NBURLOGF6BX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF6BX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR)  constraint CC_NBURLOGF6BX_EKP_NN          NOT NULL
, T070            NUMBER(38)
, F083            VARCHAR2(2 CHAR)  constraint CC_NBURLOGF6BX_F083_NN         NOT NULL 
, F082            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6BX_F082_NN         NOT NULL
, S083            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6BX_S083_NN         NOT NULL
, S080            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6BX_S080_NN         NOT NULL
, S031            VARCHAR2(2 CHAR)  constraint CC_NBURLOGF6BX_S031_NN         NOT NULL
, K030            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6BX_K030_NN         NOT NULL
, R030            VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6BX_R030_NN         NOT NULL
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

  dbms_output.put_line( 'Table "NBUR_LOG_F6BX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F6BX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F6BX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6bx                 Comments

comment on table  NBUR_LOG_F6BX is '6BX Дані про розмір кредитного ризику за активними банківськими операціями';
comment on column NBUR_LOG_F6BX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F6BX.KF is 'Фiлiя';
comment on column NBUR_LOG_F6BX.VERSION_ID is 'Номер версії файлу';
comment on column NBUR_LOG_F6BX.NBUC is 'Код МФО';
comment on column NBUR_LOG_F6BX.EKP is 'Код показника';
comment on column NBUR_LOG_F6BX.T070 is 'Сума';
comment on column NBUR_LOG_F6BX.F083 is 'Код значення коефіцієнта кредитної конверсії, рівня покриття боргу заставою, складової балансової вартості';
comment on column NBUR_LOG_F6BX.F082 is 'Код типу боржника';
comment on column NBUR_LOG_F6BX.S083 is 'Код типу оцінки кредитного ризику';
comment on column NBUR_LOG_F6BX.S080 is 'Код класу боржника/контрагента';
comment on column NBUR_LOG_F6BX.S031 is 'Код виду забезпечення кредиту';
comment on column NBUR_LOG_F6BX.K030 is 'Код резидентності';
comment on column NBUR_LOG_F6BX.R030 is 'Код валюти';

comment on column NBUR_LOG_F6BX.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_F6BX.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_F6BX.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_F6BX.KV is 'Ід. валюти';
comment on column NBUR_LOG_F6BX.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_F6BX.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_F6BX.BRANCH is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6bx                   Grants

grant SELECT on NBUR_LOG_F6BX to BARSUPL;
grant SELECT on NBUR_LOG_F6BX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F6BX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f6bx.sql ======= *** End *** ===
PROMPT ===================================================================================== 
