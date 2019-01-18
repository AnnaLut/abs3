PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LOG_F6EX.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_LOG_F6EX ***

BEGIN 
  bpa.alter_policy_info('NBUR_LOG_F6EX', 'WHOLE' , null, null, null, null);    
  bpa.alter_policy_info('NBUR_LOG_F6EX', 'FILIAL',  'M', NULL,  'E',  'E');    
END; 
/

PROMPT *** Create  table NBUR_LOG_F6EX ***
begin 
  execute immediate q'[CREATE TABLE BARS.NBUR_LOG_F6EX 
   (	
     REPORT_DATE        date              constraint CC_NBURLOGF6EX_REPORTDT_NN  NOT NULL
     , KF               char(6)           constraint CC_NBURLOGF6EX_KF_NN        NOT NULL
     , VERSION_ID       NUMBER            constraint CC_NBURLOGF6EX_VERSIONID_NN NOT NULL
     , NBUC             VARCHAR2(20 CHAR) constraint CC_NBURLOGF6EX_NBUC_NN NOT NULL
     , EKP              VARCHAR2(6 CHAR)  constraint CC_NBURLOGF6EX_EKP_NN NOT NULL
     , RULE_ID	        NUMBER(38)        constraint CC_NBURLOGF6EX_RULEID_NN NOT NULL
     , R030             VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6EX_R030_NN NOT NULL     
     , T100             NUMBER(38)        constraint CC_NBURLOGF6EX_T100_NN NOT NULL     
     , T100_PCT	        NUMBER(38, 4)     constraint CC_NBURLOGF6EX_T100_PCT_NN NOT NULL
     , DESCRIPTION      VARCHAR2(250 CHAR)
     , ACC_ID           NUMBER(38)     
     , ACC_NUM          VARCHAR2(20 CHAR)
     , KV               NUMBER(38)
     , MATURITY_DATE    DATE
     , CUST_ID          NUMBER(38)
     , ND	        NUMBER(38)
     , BRANCH           VARCHAR2(30 CHAR)          
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
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_LOG_F6EX ***
 exec bpa.alter_policies('NBUR_LOG_F6EX');

COMMENT ON TABLE BARS.NBUR_LOG_F6EX IS 'Мапування до показників файлу 6EX';
comment on column BARS.NBUR_LOG_F6EX.REPORT_DATE is 'Звiтна дата';
comment on column BARS.NBUR_LOG_F6EX.KF is 'Код фiлiалу (МФО)';
comment on column BARS.NBUR_LOG_F6EX.VERSION_ID is 'Версія файлу';
comment on column BARS.NBUR_LOG_F6EX.NBUC is 'Код областi розрiзу юридичної особи';
comment on column BARS.NBUR_LOG_F6EX.EKP is 'Код показника';
comment on column BARS.NBUR_LOG_F6EX.RULE_ID is 'Код правила за яким змапувався показник';
comment on column BARS.NBUR_LOG_F6EX.R030 is 'Id валюти';
comment on column BARS.NBUR_LOG_F6EX.T100 is 'Сума/процент';
comment on column BARS.NBUR_LOG_F6EX.T100_PCT is 'Процент врахування в агрегуючому показнику';
comment on column BARS.NBUR_LOG_F6EX.DESCRIPTION is 'Опис (коментар)';
comment on column BARS.NBUR_LOG_F6EX.ACC_ID is 'Ід. рахунка';
comment on column BARS.NBUR_LOG_F6EX.ACC_NUM is 'Номер рахунка';
comment on column BARS.NBUR_LOG_F6EX.KV is 'Ід. валюти';
comment on column BARS.NBUR_LOG_F6EX.MATURITY_DATE is 'Дата Погашення';
comment on column BARS.NBUR_LOG_F6EX.CUST_ID is 'Ід. клієнта';
comment on column BARS.NBUR_LOG_F6EX.ND is 'Ід. договору';
comment on column BARS.NBUR_LOG_F6EX.BRANCH is 'Код підрозділу';

PROMPT *** Create  grants  NBUR_LOG_F6EX ***
grant SELECT                                                                 on NBUR_LOG_F6EX to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_LOG_F6EX to BARS_DM;
grant SELECT                                                                 on NBUR_LOG_F6EX to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LOG_F6EX.sql =========*** End 
PROMPT ===================================================================================== 