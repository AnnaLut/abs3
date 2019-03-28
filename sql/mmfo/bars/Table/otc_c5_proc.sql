PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_C5_PROC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_C5_PROC ***

BEGIN 
  execute immediate  
      'begin  
           bpa.alter_policy_info(''OTC_C5_PROC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
       end; 
      '; 
END; 
/

BEGIN 
    execute immediate  
      'ALTER TABLE OTC_C5_PROC RENAME to OTC_C5_PROC_OLD '; 
exception when others then       
  if sqlcode in (-942, -955) then null; else raise; end if; 
end;  
/

PROMPT *** Create  table OTC_C5_PROC ***
begin 
  execute immediate q'[CREATE TABLE BARS.OTC_C5_PROC 
   (DATF        DATE, 
    RNK         NUMBER, 
    ND          NUMBER, 
    ACC         NUMBER, 
    NLS         VARCHAR2(15), 
    KV          NUMBER, 
    KODP        VARCHAR2(35), 
    ZNAP        NUMBER, 
    LINK_GROUP  NUMBER,
    LINK_CODE   VARCHAR2(3),
    LINK_NAME   VARCHAR2(250),
    FL_PRINS    NUMBER,
    KF          VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo')
   ) 
    TABLESPACE BRSBIGD 
    COMPRESS BASIC
    STORAGE( INITIAL 128K NEXT 128K )
    PCTUSED   0
    PCTFREE   0
    PARTITION BY RANGE (DATF) INTERVAL( NUMTODSINTERVAL(1,'DAY') )
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

PROMPT *** ALTER_POLICIES to OTC_C5_PROC ***
 exec bpa.alter_policies('OTC_C5_PROC');

COMMENT ON TABLE BARS.OTC_C5_PROC IS 'Дані для розрахунку економічних нормативів (файл #42)';

COMMENT ON COLUMN BARS.OTC_C5_PROC.KF   IS 'Код філії';
COMMENT ON COLUMN BARS.OTC_C5_PROC.DATF IS 'Звітна дата';
COMMENT ON COLUMN BARS.OTC_C5_PROC.RNK  IS 'РНК контрагента';
COMMENT ON COLUMN BARS.OTC_C5_PROC.ND   IS 'Ід-р кредиту';
COMMENT ON COLUMN BARS.OTC_C5_PROC.ACC  IS 'Ід-р рахунка';
COMMENT ON COLUMN BARS.OTC_C5_PROC.NLS  IS 'Номер рахунку';
COMMENT ON COLUMN BARS.OTC_C5_PROC.KV   IS 'Код валюти';
COMMENT ON COLUMN BARS.OTC_C5_PROC.KODP IS 'Код показника';
COMMENT ON COLUMN BARS.OTC_C5_PROC.ZNAP IS 'Значення показника';

PROMPT *** Create  constraint CC_OTCC5PROC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_C5_PROC MODIFY (KF CONSTRAINT CC_OTCC5PROC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_OTC_C5_PROC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTC_C5_PROC ON BARS.OTC_C5_PROC (DATF, KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I2_OTC_C5_PROC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_OTC_C5_PROC ON BARS.OTC_C5_PROC (DATF, KF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  OTC_C5_PROC ***
grant SELECT                                                                 on OTC_C5_PROC     to BARSREADER_ROLE;
grant SELECT                                                                 on OTC_C5_PROC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTC_C5_PROC     to BARS_DM;
grant SELECT                                                                 on OTC_C5_PROC     to START1;
grant SELECT                                                                 on OTC_C5_PROC     to UPLD;

PROMPT *** Create SYNONYM  to OTC_C5_PROC ***

CREATE OR REPLACE PUBLIC SYNONYM OTC_C5_PROC FOR BARS.OTC_C5_PROC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_C5_PROC.sql =========*** End *** =
PROMPT ===================================================================================== 
