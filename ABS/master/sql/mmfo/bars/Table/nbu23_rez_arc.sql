

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU23_REZ_ARC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBU23_REZ_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU23_REZ_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBU23_REZ_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU23_REZ_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBU23_REZ_ARC 
   (	FDAT DATE, 
	KF VARCHAR2(6), 
	ID VARCHAR2(50), 
	RNK NUMBER, 
	NBS CHAR(4), 
	KV NUMBER, 
	ND NUMBER, 
	CC_ID VARCHAR2(50), 
	ACC NUMBER, 
	NLS VARCHAR2(20), 
	BRANCH VARCHAR2(30), 
	FIN NUMBER, 
	OBS NUMBER, 
	KAT NUMBER, 
	K NUMBER, 
	IRR NUMBER, 
	ZAL NUMBER, 
	BV NUMBER, 
	PV NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	DD CHAR(1), 
	DDD CHAR(3), 
	BVQ NUMBER, 
	CUSTTYPE NUMBER, 
	IDR NUMBER, 
	WDATE DATE, 
	OKPO NUMBER, 
	NMK VARCHAR2(35), 
	RZ NUMBER, 
	PAWN NUMBER, 
	ISTVAL NUMBER, 
	R013 CHAR(1), 
	REZN NUMBER, 
	REZNQ NUMBER, 
	ARJK NUMBER, 
	PVZ NUMBER, 
	PVZQ NUMBER, 
	ZALQ NUMBER, 
	ZPR NUMBER, 
	ZPRQ NUMBER, 
	PVQ NUMBER, 
	RU VARCHAR2(70), 
	INN VARCHAR2(20), 
	NRC VARCHAR2(70), 
	SDATE DATE, 
	IR NUMBER, 
	S031 VARCHAR2(2), 
	K040 VARCHAR2(3), 
	PROD VARCHAR2(50), 
	K110 VARCHAR2(5), 
	K070 VARCHAR2(5), 
	K051 VARCHAR2(2), 
	S260 VARCHAR2(2), 
	R011 VARCHAR2(1), 
	R012 VARCHAR2(1), 
	S240 VARCHAR2(1), 
	S180 VARCHAR2(1), 
	S580 VARCHAR2(1), 
	NLS_REZ VARCHAR2(15), 
	NLS_REZN VARCHAR2(15), 
	S250 CHAR(1), 
	ACC_REZ NUMBER, 
	FIN_R NUMBER(*,0), 
	DISKONT NUMBER, 
	ISP NUMBER(*,0), 
	OB22 CHAR(2), 
	TIP CHAR(3), 
	SPEC CHAR(1), 
	ZAL_BL NUMBER, 
	S280_290 CHAR(1), 
	ZAL_BLQ NUMBER, 
	REZD NUMBER, 
	ACC_REZN NUMBER, 
	OB22_REZ CHAR(2), 
	OB22_REZN CHAR(2), 
	IR0 NUMBER, 
	IRR0 NUMBER, 
	ND_CP VARCHAR2(40), 
	SUM_IMP NUMBER, 
	SUMQ_IMP NUMBER, 
	PV_ZAL NUMBER, 
	VKR VARCHAR2(10), 
	S_L NUMBER, 
	SQ_L NUMBER, 
	ZAL_SV NUMBER, 
	ZAL_SVQ NUMBER, 
	GRP NUMBER(*,0), 
	KOL_SP NUMBER(*,0), 
	PVP NUMBER, 
	BV_30 NUMBER, 
	BVQ_30 NUMBER, 
	REZ_30 NUMBER, 
	REZQ_30 NUMBER, 
	NLS_REZ_30 VARCHAR2(15), 
	ACC_REZ_30 NUMBER, 
	BV_0 NUMBER, 
	BVQ_0 NUMBER, 
	REZ_0 NUMBER, 
	REZQ_0 NUMBER, 
	NLS_REZ_0 VARCHAR2(15), 
	ACC_REZ_0 NUMBER, 
	REZ39 NUMBER, 
	S250_23 VARCHAR2(1), 
	KAT39 NUMBER, 
	REZQ39 NUMBER, 
	S250_39 VARCHAR2(1), 
	REZ23 NUMBER, 
	REZQ23 NUMBER, 
	KAT23 NUMBER, 
	DAT_MI DATE, 
	OB22_REZ_30 CHAR(2), 
	OB22_REZ_0 CHAR(2), 
	TIPA NUMBER(*,0), 
	BVUQ NUMBER, 
	BVU NUMBER, 
	EAD NUMBER, 
	EADQ NUMBER, 
	CR NUMBER, 
	CRQ NUMBER, 
	FIN_351 NUMBER, 
	KOL_351 NUMBER, 
	KPZ NUMBER, 
	KL_351 NUMBER, 
	LGD NUMBER, 
	OVKR VARCHAR2(50), 
	P_DEF VARCHAR2(50), 
	OVD VARCHAR2(50), 
	OPD VARCHAR2(50), 
	ZAL_351 NUMBER, 
	ZALQ_351 NUMBER, 
	RC NUMBER, 
	RCQ NUMBER, 
	CCF NUMBER, 
	TIP_351 NUMBER, 
	PD_0 NUMBER, 
	FIN_Z NUMBER, 
	ISTVAL_351 NUMBER(1,0), 
	RPB NUMBER, 
	S080 VARCHAR2(1), 
	S080_Z VARCHAR2(1), 
	DDD_6B CHAR(3), 
	FIN_P NUMBER(*,0), 
	FIN_D NUMBER(*,0), 
	Z NUMBER, 
	PD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBU23_REZ_ARC ***
 exec bpa.alter_policies('NBU23_REZ_ARC');


COMMENT ON TABLE BARS.NBU23_REZ_ARC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ACC_REZ_0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZ39 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S250_23 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KAT39 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZQ39 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S250_39 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZ23 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZQ23 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KAT23 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.DAT_MI IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OB22_REZ_30 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OB22_REZ_0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.TIPA IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BVUQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BVU IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.EAD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.EADQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.CR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.CRQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.FIN_351 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KOL_351 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KPZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KL_351 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.LGD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OVKR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.P_DEF IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OVD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OPD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZAL_351 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZALQ_351 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.RC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.RCQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.CCF IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.TIP_351 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PD_0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.FIN_Z IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ISTVAL_351 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.RPB IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S080 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S080_Z IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.DDD_6B IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.FIN_P IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.FIN_D IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.Z IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.FDAT IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KF IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ID IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.RNK IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NBS IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KV IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ND IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.CC_ID IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ACC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NLS IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.FIN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OBS IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KAT IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.K IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.IRR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZAL IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BV IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PV IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.DD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.DDD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BVQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.IDR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.WDATE IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OKPO IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NMK IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.RZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PAWN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ISTVAL IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.R013 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZNQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ARJK IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PVZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PVZQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZALQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZPR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZPRQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PVQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.RU IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.INN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NRC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.SDATE IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.IR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S031 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.K040 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PROD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.K110 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.K070 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.K051 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S260 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.R011 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.R012 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S240 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S180 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S580 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NLS_REZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NLS_REZN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S250 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ACC_REZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.FIN_R IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.DISKONT IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ISP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OB22 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.TIP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.SPEC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZAL_BL IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S280_290 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZAL_BLQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ACC_REZN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OB22_REZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.OB22_REZN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.IR0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.IRR0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ND_CP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.SUM_IMP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.SUMQ_IMP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PV_ZAL IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.VKR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.S_L IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.SQ_L IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZAL_SV IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ZAL_SVQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.GRP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.KOL_SP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.PVP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BV_30 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BVQ_30 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZ_30 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZQ_30 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NLS_REZ_30 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.ACC_REZ_30 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BV_0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.BVQ_0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZ_0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.REZQ_0 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ_ARC.NLS_REZ_0 IS '';




PROMPT *** Create  constraint SYS_C00120458 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ_ARC MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00120459 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ_ARC MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00120460 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ_ARC MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00120461 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ_ARC MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBU23_REZ_ARC_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ_ARC ADD CONSTRAINT PK_NBU23_REZ_ARC_ID PRIMARY KEY (ID, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBU23_REZ_ARC_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBU23_REZ_ARC_ID ON BARS.NBU23_REZ_ARC (ID, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_NBU23REZARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_NBU23REZARC ON BARS.NBU23_REZ_ARC (RNK, ND, KAT, KV, RZ, DDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_NBU23REZARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_NBU23REZARC ON BARS.NBU23_REZ_ARC (ACC, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_NBU23REZARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_NBU23REZARC ON BARS.NBU23_REZ_ARC (FDAT, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBU23_REZ_ARC ***
grant SELECT                                                                 on NBU23_REZ_ARC   to BARSREADER_ROLE;
grant SELECT                                                                 on NBU23_REZ_ARC   to RCC_DEAL;
grant SELECT                                                                 on NBU23_REZ_ARC   to START1;
grant SELECT                                                                 on NBU23_REZ_ARC   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBU23_REZ_ARC.sql =========*** End ***
PROMPT ===================================================================================== 
