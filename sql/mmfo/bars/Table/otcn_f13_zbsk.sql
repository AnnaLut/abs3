

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F13_ZBSK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F13_ZBSK ***


BEGIN 
    execute immediate  
      'begin  
           bpa.alter_policy_info(''OTCN_F13_ZBSK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
       end; 
      '; 
END; 
/

BEGIN 
    execute immediate  
      'ALTER TABLE OTCN_F13_ZBSK RENAME to OTCN_F13_ZBSK_OLD '; 
exception when others then       
  if sqlcode in (-942, -955) then null; else raise; end if; 
end;  
/

PROMPT *** Create  table OTCN_F13_ZBSK ***
begin 
  execute immediate q'[CREATE TABLE BARS.OTCN_F13_ZBSK 
   (REF NUMBER, 
	TT CHAR(3), 
	FDAT DATE, 
	ACCD NUMBER, 
	NLSD VARCHAR2(15), 
	KV NUMBER(3), 
	ACCK NUMBER, 
	NLSK VARCHAR2(15), 
	S NUMBER, 
	SQ NUMBER, 
	NAZN VARCHAR2(160), 
	ISP NUMBER, 
	SK_ZB NUMBER, 
	RECID NUMBER, 
	KO NUMBER(3), 
	TOBO VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo'), 
	STMT NUMBER
   ) 
    TABLESPACE BRSBIGD 
    COMPRESS BASIC
    STORAGE( INITIAL 128K NEXT 128K )
    PCTUSED   0
    PCTFREE   0
    PARTITION BY RANGE (FDAT) INTERVAL( NUMTODSINTERVAL(1,'DAY') )
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


PROMPT *** ALTER_POLICIES to OTCN_F13_ZBSK ***
 exec bpa.alter_policies('OTCN_F13_ZBSK');


COMMENT ON TABLE BARS.OTCN_F13_ZBSK IS 'Архив проводок по внебалансовых символам касспланае для файла #13';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.STMT IS '';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.RECID IS 'ID ';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.KO IS 'Код областi';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.TOBO IS 'Код ТОБО';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.KF IS '';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.REF IS 'Референс док-та';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.TT IS 'Код операцiї';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.FDAT IS 'Дата операцiї';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.ACCD IS 'Код рах. Дт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.NLSD IS 'Рах. Дт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.ACCK IS 'Код рах. Кт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.NLSK IS 'Рах. Кт';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.S IS 'Сума док-та номiнал';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.SQ IS 'Сума док-та еквiвалент';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.ISP IS 'Код виконавця';
COMMENT ON COLUMN BARS.OTCN_F13_ZBSK.SK_ZB IS 'Позабал. символ';




PROMPT *** Create  constraint PK_F13_ZBSK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK ADD CONSTRAINT PK_F13_ZBSK_1 PRIMARY KEY (KF, RECID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006487 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006488 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK MODIFY (RECID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNF13ZBSK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F13_ZBSK MODIFY (KF CONSTRAINT CC_OTCNF13ZBSK_KF_NN_1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_F13_ZBSK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_F13_ZBSK_1 ON BARS.OTCN_F13_ZBSK (KF, REF, STMT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_OTCN_F13_ZBSK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_OTCN_F13_ZBSK_1 ON BARS.OTCN_F13_ZBSK (KF, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  OTCN_F13_ZBSK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F13_ZBSK   to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F13_ZBSK   to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F13_ZBSK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F13_ZBSK   to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F13_ZBSK   to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F13_ZBSK   to SALGL;
grant SELECT                                                                 on OTCN_F13_ZBSK   to START1;
grant SELECT                                                                 on OTCN_F13_ZBSK   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F13_ZBSK   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F13_ZBSK.sql =========*** End ***
PROMPT ===================================================================================== 
