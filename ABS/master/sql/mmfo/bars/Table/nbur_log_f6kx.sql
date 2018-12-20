PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LOG_F6KX.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_LOG_F6KX ***

BEGIN 
  bpa.alter_policy_info('NBUR_LOG_F6KX', 'WHOLE' , null, null, null, null);    
  bpa.alter_policy_info('NBUR_LOG_F6KX', 'FILIAL',  'M', NULL,  'E',  'E');    
END; 
/

PROMPT *** Create  table NBUR_LOG_F6KX ***
begin 
  execute immediate q'[CREATE TABLE BARS.NBUR_LOG_F6KX 
   (	
     REPORT_DATE        date              constraint CC_NBURLOGF6KX_REPORTDT_NN  NOT NULL
     , KF               char(6)           constraint CC_NBURLOGF6KX_KF_NN        NOT NULL
     , VERSION_ID       NUMBER            constraint CC_NBURLOGF6KX_VERSIONID_NN NOT NULL
     , NBUC             VARCHAR2(20 CHAR) constraint CC_NBURLOGF6KX_NBUC_NN NOT NULL
     , EKP              VARCHAR2(6 CHAR)  constraint CC_NBURLOGF6KX_EKP_NN NOT NULL
     , RULE_ID	        NUMBER(38)        constraint CC_NBURLOGF6KX_RULEID_NN NOT NULL
     , R030             VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6KX_R030_NN NOT NULL     
     , T100             NUMBER(38)        constraint CC_NBURLOGF6KX_T100_NN NOT NULL     
     , T100_PCT	        NUMBER(38, 4)     constraint CC_NBURLOGF6KX_T100_PCT_NN NOT NULL
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

PROMPT *** ALTER_POLICIES to NBUR_LOG_F6KX ***
 exec bpa.alter_policies('NBUR_LOG_F6KX');

COMMENT ON TABLE BARS.NBUR_LOG_F6KX IS 'Мапування до показників файлу 6KX';
comment on column BARS.NBUR_LOG_F6KX.REPORT_DATE is 'Звiтна дата';
comment on column BARS.NBUR_LOG_F6KX.KF is 'Код фiлiалу (МФО)';
comment on column BARS.NBUR_LOG_F6KX.VERSION_ID is 'Версія файлу';
comment on column BARS.NBUR_LOG_F6KX.NBUC is 'Код областi розрiзу юридичної особи';
comment on column BARS.NBUR_LOG_F6KX.EKP is 'Код показника';
comment on column BARS.NBUR_LOG_F6KX.RULE_ID is 'Код правила за яким змапувався показник';
comment on column BARS.NBUR_LOG_F6KX.R030 is 'Id валюти';
comment on column BARS.NBUR_LOG_F6KX.T100 is 'Сума/процент';
comment on column BARS.NBUR_LOG_F6KX.T100_PCT is 'Процент врахування в агрегуючому показнику';
comment on column BARS.NBUR_LOG_F6KX.DESCRIPTION is 'Опис (коментар)';
comment on column BARS.NBUR_LOG_F6KX.ACC_ID is 'Ід. рахунка';
comment on column BARS.NBUR_LOG_F6KX.ACC_NUM is 'Номер рахунка';
comment on column BARS.NBUR_LOG_F6KX.KV is 'Ід. валюти';
comment on column BARS.NBUR_LOG_F6KX.MATURITY_DATE is 'Дата Погашення';
comment on column BARS.NBUR_LOG_F6KX.CUST_ID is 'Ід. клієнта';
comment on column BARS.NBUR_LOG_F6KX.ND is 'Ід. договору';
comment on column BARS.NBUR_LOG_F6KX.BRANCH is 'Код підрозділу';

PROMPT *** Create  grants  NBUR_LOG_F6KX ***
grant SELECT                                                                 on NBUR_LOG_F6KX to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_LOG_F6KX to BARS_DM;
grant SELECT                                                                 on NBUR_LOG_F6KX to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LOG_F6KX.sql =========*** End 
PROMPT ===================================================================================== 