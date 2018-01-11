

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CC_DEAL_322669.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CC_DEAL_322669 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CC_DEAL_322669 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CC_DEAL_322669 
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




PROMPT *** ALTER_POLICIES to TMP_CC_DEAL_322669 ***
 exec bpa.alter_policies('TMP_CC_DEAL_322669');


COMMENT ON TABLE BARS.TMP_CC_DEAL_322669 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.ND IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.SOS IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.LIMIT IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.KPROLOG IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.USER_ID IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.OBS IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.KF IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.IR IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.PROD IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.SDOG IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.SKARB_ID IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.FIN IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.NDI IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.FIN23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.OBS23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.KAT23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.K23 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.KOL_SP IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.S250 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.GRP IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.FIN_351 IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.PD IS '';
COMMENT ON COLUMN BARS.TMP_CC_DEAL_322669.NDG IS '';




PROMPT *** Create  constraint SYS_C00132442 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669 MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132443 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669 MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132444 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669 MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132445 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669 MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132446 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669 MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132447 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132448 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CC_DEAL_322669 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CC_DEAL_322669 ***
grant SELECT                                                                 on TMP_CC_DEAL_322669 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CC_DEAL_322669.sql =========*** En
PROMPT ===================================================================================== 
