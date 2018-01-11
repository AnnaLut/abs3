

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/BPK_PLT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table BPK_PLT ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.BPK_PLT 
   (	PER_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(12), 
	RNK NUMBER(38,0), 
	ND NUMBER, 
	DAT_BEGIN DATE, 
	BPK_TYPE VARCHAR2(32), 
	NLS VARCHAR2(15), 
	DAOS DATE, 
	KV NUMBER(3,0), 
	INTRATE NUMBER, 
	OSTC NUMBER, 
	DATE_LASTOP DATE, 
	CRED_LINE VARCHAR2(20), 
	CRED_LIM NUMBER, 
	USE_CRED_SUM NUMBER, 
	DAZS DATE, 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
	BPK_STATUS NUMBER(1,0), 
	PK_OKPO VARCHAR2(10), 
	PK_NAME VARCHAR2(100), 
	PK_OKPO_N NUMBER(22,0), 
	VID VARCHAR2(35), 
	LIE_SUM VARCHAR2(254), 
	LIE_VAL VARCHAR2(254), 
	LIE_DATE VARCHAR2(254), 
	LIE_DOCN VARCHAR2(254), 
	LIE_ATRT VARCHAR2(254), 
	LIE_DOC VARCHAR2(254), 
	PK_TERM VARCHAR2(254), 
	PK_OLDND VARCHAR2(254), 
	PK_WORK VARCHAR2(254), 
	PK_CNTRW VARCHAR2(254), 
	PK_OFAX VARCHAR2(254), 
	PK_PHONE VARCHAR2(254), 
	PK_PCODW VARCHAR2(254), 
	PK_ODAT VARCHAR2(254), 
	PK_STRTW VARCHAR2(254), 
	PK_CITYW VARCHAR2(254), 
	PK_OFFIC VARCHAR2(254), 
	DKBO_DATE_OFF DATE, 
	DKBO_START_DATE DATE, 
	DKBO_DEAL_NUMBER VARCHAR2(30), 
	KOS NUMBER(24,0), 
	DOS NUMBER(24,0), 
	W4_ARSUM VARCHAR2(254), 
	W4_KPROC VARCHAR2(254), 
	W4_SEC VARCHAR2(254), 
	ACC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.BPK_PLT IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.ACC IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.BRANCH IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.KF IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.RNK IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.ND IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.BPK_TYPE IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.NLS IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DAOS IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.KV IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.INTRATE IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.OSTC IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DATE_LASTOP IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.CRED_LINE IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.CRED_LIM IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.USE_CRED_SUM IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DAZS IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.BLKD IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.BLKK IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.BPK_STATUS IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_OKPO IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_NAME IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_OKPO_N IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.VID IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.LIE_SUM IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.LIE_VAL IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.LIE_DATE IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.LIE_DOCN IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.LIE_ATRT IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.LIE_DOC IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_TERM IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_OLDND IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_WORK IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_CNTRW IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_OFAX IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_PHONE IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_PCODW IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_ODAT IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_STRTW IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_CITYW IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.PK_OFFIC IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DKBO_DATE_OFF IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DKBO_START_DATE IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DKBO_DEAL_NUMBER IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.KOS IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.DOS IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.W4_ARSUM IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.W4_KPROC IS '';
COMMENT ON COLUMN BARS_DM.BPK_PLT.W4_SEC IS '';




PROMPT *** Create  constraint SYS_C00120058 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT MODIFY (PER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00120059 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00120060 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00120061 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPLT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT ADD CONSTRAINT CC_BPKPLT_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPLT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT ADD CONSTRAINT CC_BPKPLT_KF_NN CHECK (KF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPLT_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT ADD CONSTRAINT CC_BPKPLT_PERID_NN CHECK (PER_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPLT_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK_PLT ADD CONSTRAINT CC_BPKPLT_RNK_NN CHECK (RNK IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_BPKPLT_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_BPKPLT_PERID ON BARS_DM.BPK_PLT (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PLT ***
grant SELECT                                                                 on BPK_PLT         to BARSREADER_ROLE;
grant SELECT                                                                 on BPK_PLT         to BARSUPL;
grant SELECT                                                                 on BPK_PLT         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/BPK_PLT.sql =========*** End *** ==
PROMPT ===================================================================================== 
