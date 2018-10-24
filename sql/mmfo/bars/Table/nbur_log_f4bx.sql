

PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Table/NBUR_LOG_F4BX.sql ========= *** Run ***
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LOG_F4BX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBUR_LOG_F4BX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin 
  execute immediate q'[CREATE TABLE BARS.NBUR_LOG_F4BX 
   (   REPORT_DATE     DATE       constraint CC_NBURLOGF4BX_RPTDT_NN            NOT NULL 
     , KF              CHAR(6)    constraint CC_NBURLOGF4BX_KF_NN               NOT NULL
     , NBUC            VARCHAR2(20)     
     , VERSION_ID      NUMBER
     , EKP       VARCHAR2(6)      constraint CC_NBURLOGF4BX_EKP_NN          NOT NULL
     , F058      VARCHAR2(1)      constraint CC_NBURLOGF4BX_F058_NN         NOT NULL 
     , Q003_2    VARCHAR2(10)     constraint CC_NBURLOGF4BX_Q003_2_NN       NOT NULL 
     , T070      NUMBER
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

  dbms_output.put_line( 'Table "NBUR_LOG_F4BX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F4BX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F4BX' );
end;
/

commit;


COMMENT ON TABLE  BARS.NBUR_LOG_F4BX IS '4BX Дані про дотримання вимог щодо достатності регулятивного капіталу та економічних нормативів';
COMMENT ON COLUMN BARS.NBUR_LOG_F4BX.REPORT_DATE IS 'Звiтна дата';
comment on column BARS.NBUR_LOG_F4BX.KF  is 'Фiлiя';
comment on column BARS.NBUR_LOG_F4BX.VERSION_ID is 'Номер версії файлу';
comment on column BARS.NBUR_LOG_F4BX.NBUC    is 'Код МФО';
COMMENT ON COLUMN BARS.NBUR_LOG_F4BX.EKP     IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_LOG_F4BX.F058    IS 'Код підгрупи банківської групи';
COMMENT ON COLUMN BARS.NBUR_LOG_F4BX.Q003_2  IS 'Порядковий номер підгрупи';
COMMENT ON COLUMN BARS.NBUR_LOG_F4BX.T070    IS 'Сума -грн.eквівалент';


PROMPT *** Create  grants  NBUR_LOG_F4BX ***
grant SELECT                          on NBUR_LOG_F4BX         to BARS_ACCESS_DEFROLE;
grant SELECT,DELETE,INSERT,UPDATE     on NBUR_LOG_F4BX         to START1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/Table/NBUR_LOG_F4BX.sql ========= *** End ***
PROMPT ===================================================================================== 


