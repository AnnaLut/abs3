
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_ff8x.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FF8X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_FF8X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_FF8X
( REPORT_DATE     date       constraint CC_NBURLOGFF8X_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGFF8X_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR)  constraint CC_NBURLOGFF8X_EKP_NN          NOT NULL
, F034            VARCHAR2(2 CHAR)  constraint CC_NBURLOGFF8X_F034_NN         NOT NULL 
, F035            VARCHAR2(2 CHAR)  constraint CC_NBURLOGFF8X_F035_NN         NOT NULL
, R030            VARCHAR2(3 CHAR)  constraint CC_NBURLOGFF8X_R030_NN         NOT NULL
, S080            VARCHAR2(1 CHAR)  constraint CC_NBURLOGFF8X_S080_NN         NOT NULL
, K111            VARCHAR2(2 CHAR)  constraint CC_NBURLOGFF8X_K111_NN         NOT NULL
, S260            VARCHAR2(2 CHAR)  constraint CC_NBURLOGFF8X_S260_NN         NOT NULL
, S032            VARCHAR2(1 CHAR)  constraint CC_NBURLOGFF8X_S032_NN         NOT NULL
, S245            VARCHAR2(1 CHAR)  constraint CC_NBURLOGFF8X_S245_NN         NOT NULL
, T100            NUMBER(38)

, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         NUMBER(38)     
, CUST_CODE       VARCHAR2(14)
, CUST_NAME       VARCHAR2(70)
, ND              NUMBER(38)     
, AGRM_NUM        VARCHAR2(50)
, BEG_DT          DATE
, END_DT          DATE
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

  dbms_output.put_line( 'Table "NBUR_LOG_FF8X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FF8X" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_FF8X' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_fF8X                 Comments

comment on table  NBUR_LOG_FF8X is 'F8X Дані про найбільших (прямих та опосередкованих) учасників контрагентів банку';
comment on column NBUR_LOG_FF8X.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_FF8X.KF is 'Фiлiя';
comment on column NBUR_LOG_FF8X.VERSION_ID is 'Номер версії файлу';
comment on column NBUR_LOG_FF8X.NBUC   is 'Код МФО';
comment on column NBUR_LOG_FF8X.EKP    is 'Код показника';
comment on column NBUR_LOG_FF8X.F034   is 'Код кількості та обсягу заборгованості';
comment on column NBUR_LOG_FF8X.F035   is 'Код виду операцій';
comment on column NBUR_LOG_FF8X.R030   is 'Код валюти';
comment on column NBUR_LOG_FF8X.S080   is 'Код класу боржника/контрагента';
comment on column NBUR_LOG_FF8X.K111   is 'Код розділу виду економічної діяльності';
comment on column NBUR_LOG_FF8X.S260   is 'Код виду індивідуального споживання за цілями';
comment on column NBUR_LOG_FF8X.S032   is 'Код узагальненого виду забезпечення кредиту';
comment on column NBUR_LOG_FF8X.S245   is 'Код узагальнененого кінцевого строку погашення';
comment on column NBUR_LOG_FF8X.T100   is 'Сума/кількість';

comment on column NBUR_LOG_FF8X.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_FF8X.ACC_ID      is 'Ід. рахунка';
comment on column NBUR_LOG_FF8X.ACC_NUM     is 'Номер рахунка';
comment on column NBUR_LOG_FF8X.KV          is 'Валюта';
comment on column NBUR_LOG_FF8X.CUST_ID     is 'Ід. клієнта';
comment on column NBUR_LOG_FF8X.CUST_CODE   is 'Код клієнта';
comment on column NBUR_LOG_FF8X.CUST_NAME   is 'Назва клієнта';
comment on column NBUR_LOG_FF8X.ND          is 'Ід. договору';
comment on column NBUR_LOG_FF8X.AGRM_NUM    is 'Номер договору';
comment on column NBUR_LOG_FF8X.BEG_DT      is 'Дата початку договору';
comment on column NBUR_LOG_FF8X.END_DT      is 'Дата закінчення договору';
comment on column NBUR_LOG_FF8X.BRANCH      is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_fF8X                   Grants

grant SELECT on NBUR_LOG_FF8X to BARSUPL;
grant SELECT on NBUR_LOG_FF8X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_FF8X to BARSREADER_ROLE;
                          
                          
PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_ff8x.sql ======= *** End *** ===
PROMPT ===================================================================================== 
                          
                            
