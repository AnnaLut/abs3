

PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Table/NBUR_LOG_FF5X.sql ========= *** Run ***
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LOG_FF5X'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBUR_LOG_FF5X'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin 
  execute immediate q'[CREATE TABLE BARS.NBUR_LOG_FF5X 
   (   REPORT_DATE     DATE       constraint CC_NBURLOGFF5X_RPTDT_NN            NOT NULL 
     , KF              CHAR(6)    constraint CC_NBURLOGFF5X_KF_NN               NOT NULL
     , NBUC            VARCHAR2(20)     
     , VERSION_ID      NUMBER
     , EKP       VARCHAR2(6)      constraint CC_NBURLOGFF5X_EKP_NN          NOT NULL
     , Z230      VARCHAR2(2)      constraint CC_NBURLOGFF5X_Z230_NN         NOT NULL 
     , Z350      VARCHAR2(1)      constraint CC_NBURLOGFF5X_Z350_NN         NOT NULL 
     , K045      VARCHAR2(1)      constraint CC_NBURLOGFF5X_K045_NN         NOT NULL 
     , Z130      VARCHAR2(2)      constraint CC_NBURLOGFF5X_Z130_NN         NOT NULL 
     , Z140      VARCHAR2(1)      constraint CC_NBURLOGFF5X_Z140_NN         NOT NULL 
     , Z150      VARCHAR2(2)      constraint CC_NBURLOGFF5X_Z150_NN         NOT NULL 
     , KU        VARCHAR2(3)      constraint CC_NBURLOGFF5X_KU_NN         NOT NULL 
     , T070      NUMBER
     , T080      NUMBER
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

  dbms_output.put_line( 'Table "NBUR_LOG_FF5X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_FF5X" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_FF5X' );
end;
/

commit;


COMMENT ON TABLE  BARS.NBUR_LOG_FF5X IS 'F5X -Дані про збитки банку через cумнівні операції з платіжними картками';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.REPORT_DATE IS 'Звiтна дата';
comment on column BARS.NBUR_LOG_FF5X.KF  is 'Фiлiя';
comment on column BARS.NBUR_LOG_FF5X.VERSION_ID is 'Номер версії файлу';
comment on column BARS.NBUR_LOG_FF5X.NBUC    is 'Код МФО';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.EKP     IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.Z230    IS 'Код платіжної системи';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.Z350    IS 'Код емітента платіжної картки';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.K045    IS 'Код території, де здійснена незаконна дія/сумнівна операція';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.Z130    IS 'Тип незаконної дії або сумнівної операції з платіжними картками';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.Z140    IS 'Код учасника операцій з платіжними картками';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.Z150    IS 'Код місця здійснення операції з платіжною карткою';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.KU      IS 'Код адміністративно-територіальної одиниці України розташування платіжного пристрою';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.T070    IS 'Сума збитків від незаконних дій з платіжними картками';
COMMENT ON COLUMN BARS.NBUR_LOG_FF5X.T080    IS 'Кількість сумнівних операцій з платіжними картками';


PROMPT *** Create  grants  NBUR_LOG_FF5X ***
grant SELECT                          on NBUR_LOG_FF5X         to BARS_ACCESS_DEFROLE;
grant SELECT,DELETE,INSERT,UPDATE     on NBUR_LOG_FF5X         to START1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/Table/NBUR_LOG_FF5X.sql ========= *** End ***
PROMPT ===================================================================================== 


