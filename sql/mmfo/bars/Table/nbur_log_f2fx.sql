
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f2fx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F2FX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F2FX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[
  create table NBUR_LOG_F2FX
( REPORT_DATE     date       constraint CC_NBURLOGF2FX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF2FX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID      NUMBER
, EKP             VARCHAR2(6 CHAR)  constraint CC_NBURLOGF2FX_EKP_NN          NOT NULL
, D110            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF2FX_D110_NN         NOT NULL 
, K014            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF2FX_K014_NN         NOT NULL
, K019            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF2FX_K019_NN         NOT NULL
, K030            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF2FX_K030_NN         NOT NULL
, K040            VARCHAR2(3 CHAR)  constraint CC_NBURLOGF2FX_K040_NN         NOT NULL
, K044            VARCHAR2(2 CHAR)  constraint CC_NBURLOGF2FX_K044_NN         NOT NULL
, KU              VARCHAR2(3 CHAR)  constraint CC_NBURLOGF2FX_KU_NN           NOT NULL
, R030            VARCHAR2(3 CHAR)  constraint CC_NBURLOGF2FX_R030_NN         NOT NULL
, T070_1          NUMBER(38)		constraint CC_NBURLOGF2FX_T0701_NN        NOT NULL
, T070_2          NUMBER(38)		constraint CC_NBURLOGF2FX_T0702_NN        NOT NULL
, T100            NUMBER(38)		constraint CC_NBURLOGF2FX_T100_NN         NOT NULL
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

  dbms_output.put_line( 'Table "NBUR_LOG_F2FX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F2FX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F2FX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f2fx                 Comments

comment on table  NBUR_LOG_F2FX is '2FX - Дані про оцінку ризиків у сфері фінансового моніторингу';
comment on column NBUR_LOG_F2FX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F2FX.KF is 'Фiлiя';
comment on column NBUR_LOG_F2FX.VERSION_ID is 'Номер версії файлу';
comment on column NBUR_LOG_F2FX.NBUC is 'Код МФО';
comment on column NBUR_LOG_F2FX.EKP is 'Код показника';

comment on column NBUR_LOG_F2FX.D110 is 'код типу розрахунків';
comment on column NBUR_LOG_F2FX.K014 is 'код типу клієнта банку';
comment on column NBUR_LOG_F2FX.K019 is 'код типу публічних діячів';
comment on column NBUR_LOG_F2FX.K030 is 'код резидентності';
comment on column NBUR_LOG_F2FX.K040 is 'код країни';
comment on column NBUR_LOG_F2FX.K044 is 'код типу країни';
comment on column NBUR_LOG_F2FX.KU   is 'код адміністративно-територіальної одиниці України';
comment on column NBUR_LOG_F2FX.R030 is 'код валюти або банківського металу';

comment on column NBUR_LOG_F2FX.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_F2FX.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_F2FX.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_F2FX.KV is 'Ід. валюти';
comment on column NBUR_LOG_F2FX.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_F2FX.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_F2FX.BRANCH is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f2fx                   Grants

grant SELECT on NBUR_LOG_F2FX to BARSUPL;
grant SELECT on NBUR_LOG_F2FX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F2FX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f2fx.sql ======= *** End *** ===
PROMPT ===================================================================================== 
