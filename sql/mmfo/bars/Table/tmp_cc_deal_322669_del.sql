

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CC_DEAL_322669_DEL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CC_DEAL_322669_DEL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CC_DEAL_322669_DEL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CC_DEAL_322669_DEL 
   (	ND NUMBER(30,0), 
	SOS NUMBER(*,0), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	RNK NUMBER(*,0), 
	VIDD NUMBER(*,0), 
	LIMIT NUMBER(24,4), 
	KPROLOG NUMBER(*,0), 
	USER_ID NUMBER(*,0), 
	OBS NUMBER(*,0), 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6), 
	IR NUMBER, 
	PROD VARCHAR2(100), 
	SDOG NUMBER(24,2), 
	SKARB_ID VARCHAR2(50), 
	FIN NUMBER(*,0), 
	NDI NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	FIN_351 NUMBER, 
	PD NUMBER, 
	NDG NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CC_DEAL_322669_DEL ***
 exec bpa.alter_policies('TMP_CC_DEAL_322669_DEL');


COMMENT ON TABLE BARS.TMP_CC_DEAL_322669_DEL IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.ND IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.SOS IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.LIMIT IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.KPROLOG IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.USER_ID IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.OBS IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.KF IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.IR IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.PROD IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.SDOG IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.SKARB_ID IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.FIN IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.NDI IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.FIN23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.OBS23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.KAT23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.K23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.KOL_SP IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.S250 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.GRP IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.FIN_351 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.PD IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669_DEL.NDG IS '';




PROMPT *** Create  constraint SYS_C00132449 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669_DEL MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132450 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669_DEL MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132451 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669_DEL MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132452 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669_DEL MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132453 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669_DEL MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132454 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669_DEL MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132455 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669_DEL MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CC_DEAL_322669_DEL ***
grant SELECT                                                                 on TMP_CC_DEAL_322669_DEL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CC_DEAL_322669_DEL.sql =========**
PROMPT ===================================================================================== 
