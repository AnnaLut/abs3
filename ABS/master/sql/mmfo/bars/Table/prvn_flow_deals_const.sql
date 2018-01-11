

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_CONST.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FLOW_DEALS_CONST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_FLOW_DEALS_CONST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PRVN_FLOW_DEALS_CONST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_FLOW_DEALS_CONST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FLOW_DEALS_CONST ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FLOW_DEALS_CONST 
   (	ID NUMBER(38,0), 
	ND NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KV NUMBER(3,0), 
	DAT_ADD DATE, 
	VIDD NUMBER(38,0), 
	RNK NUMBER(38,0), 
	SDATE DATE, 
	WDATE DATE, 
	TIP CHAR(3), 
	DAOS DATE, 
	I_CR9 NUMBER(1,0), 
	PR_TR NUMBER(1,0), 
	KV8 NUMBER(3,0), 
	ACC8 NUMBER(38,0), 
	FL2 NUMBER(1,0), 
	DAZS DATE, 
	DATE_CLOSE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NDO NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FLOW_DEALS_CONST ***
 exec bpa.alter_policies('PRVN_FLOW_DEALS_CONST');


COMMENT ON TABLE BARS.PRVN_FLOW_DEALS_CONST IS 'Таблиця КД-угод для сховища';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.NDO IS 'Реф нового КД ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.ID IS 'Ід в табл ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.ND IS 'Реф КД АБС';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.ACC IS 'АСС норм тіла(рах)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.KV IS 'код вал рах.';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.DAT_ADD IS 'Дата внесення';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.VIDD IS 'поч.Вид КД';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.RNK IS 'поч.РНК позичальника';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.SDATE IS 'Дата початку';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.WDATE IS 'Дата заверш КД (Початкова)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.TIP IS '';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.DAOS IS 'Дата відкр.рах ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.I_CR9 IS 'поч.Востанавл=0, НеВостанавл CR9=1';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.PR_TR IS 'поч.Признак траншей (0-НЕТ/1-ДА)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.KV8 IS 'код вал КД';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.ACC8 IS 'АССС тіла(КД)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.FL2 IS '1=% за попередній день(anuitet)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.DAZS IS 'Дата закр.рах  (Реальнаа)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.DATE_CLOSE IS 'Фактична дата закриття договору';




PROMPT *** Create  constraint PK_PRVN_F_D_CONST ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DEALS_CONST ADD CONSTRAINT PK_PRVN_F_D_CONST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNDEALSCONST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DEALS_CONST MODIFY (KF CONSTRAINT CC_PRVNDEALSCONST_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRVN_F_D_CONST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVN_F_D_CONST ON BARS.PRVN_FLOW_DEALS_CONST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PRVN_F_D_CONST ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_PRVN_F_D_CONST ON BARS.PRVN_FLOW_DEALS_CONST (ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PRVNDEALSCONST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PRVNDEALSCONST ON BARS.PRVN_FLOW_DEALS_CONST (KF, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_FLOW_DEALS_CONST ***
grant SELECT                                                                 on PRVN_FLOW_DEALS_CONST to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS_CONST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_FLOW_DEALS_CONST to BARS_DM;
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS_CONST to START1;
grant SELECT                                                                 on PRVN_FLOW_DEALS_CONST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_CONST.sql =========***
PROMPT ===================================================================================== 
