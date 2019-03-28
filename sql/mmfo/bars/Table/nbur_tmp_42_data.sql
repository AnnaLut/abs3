PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_42_DATA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_42_DATA ***

BEGIN 
  execute immediate  
      'begin  
           bpa.remove_policies(''NBUR_TMP_42_DATA''); 
           bpa.alter_policy_info(''NBUR_TMP_42_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
           bpa.alter_policy_info(''NBUR_TMP_42_DATA'', ''WHOLE'' , NULL, NULL, NULL, NULL );
       end; 
      '; 
END; 
/

PROMPT *** Drop table NBUR_TMP_42_DATA ***
begin 
  execute immediate 'drop table NBUR_TMP_42_DATA cascade constraints';

exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/
  

PROMPT *** Create  table NBUR_TMP_42_DATA ***
begin 
  execute immediate q'[CREATE TABLE BARS.NBUR_TMP_42_DATA 
   (REPORT_DATE DATE, 
    RNK         NUMBER, 
    ACC         NUMBER, 
    KV          NUMBER, 
    NBS         CHAR(4), 
    OB22        VARCHAR2(2),
    NLS         VARCHAR2(15), 
    OST_NOM     NUMBER, 
    OST_EQV     NUMBER, 
    AP          NUMBER, 
    R012        CHAR(1), 
    DDD         CHAR(3), 
    R020        CHAR(4), 
    ACCC        NUMBER, 
    ZAL         NUMBER, 
    LINK_GROUP  NUMBER,
    LINK_CODE   VARCHAR2(3),
    LINK_NAME   VARCHAR2(250),
    FL_PRINS    NUMBER,
    KF          VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo') CONSTRAINT CC_NBURTMP42DATA_KF_NN NOT NULL ENABLE
   ) 
    TABLESPACE BRSBIGD 
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
    ( PARTITION P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2018','DD/MM/YYYY') ) ) ]';

exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_TMP_42_DATA ***
exec bpa.alter_policies('NBUR_TMP_42_DATA');

COMMENT ON TABLE BARS.NBUR_TMP_42_DATA IS 'Дані для розрахунку економічних нормативів (файл #42)';

COMMENT ON COLUMN BARS.NBUR_TMP_42_DATA.KF   IS 'Код філії';
COMMENT ON COLUMN BARS.NBUR_TMP_42_DATA.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_TMP_42_DATA.RNK  IS 'РНК контрагента';
COMMENT ON COLUMN BARS.NBUR_TMP_42_DATA.ACC  IS 'Ід-р рахунка';
COMMENT ON COLUMN BARS.NBUR_TMP_42_DATA.NLS  IS 'Номер рахунку';
COMMENT ON COLUMN BARS.NBUR_TMP_42_DATA.KV   IS 'Код валюти';

PROMPT *** Create  index I1_NBUR_TMP_42_DATA ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_NBUR_TMP_42_DATA ON BARS.NBUR_TMP_42_DATA (REPORT_DATE, KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I2_NBUR_TMP_42_DATA ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_NBUR_TMP_42_DATA ON BARS.NBUR_TMP_42_DATA (REPORT_DATE, KF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  NBUR_TMP_42_DATA ***
grant SELECT                                                                 on NBUR_TMP_42_DATA     to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_TMP_42_DATA     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_TMP_42_DATA     to BARS_DM;
grant SELECT                                                                 on NBUR_TMP_42_DATA     to START1;
grant SELECT                                                                 on NBUR_TMP_42_DATA     to UPLD;

PROMPT *** Create SYNONYM  to NBUR_TMP_42_DATA ***

CREATE OR REPLACE PUBLIC SYNONYM NBUR_TMP_42_DATA FOR BARS.NBUR_TMP_42_DATA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_42_DATA.sql =========*** End *** =
PROMPT ===================================================================================== 
