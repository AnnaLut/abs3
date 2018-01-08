

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_AFTER_IMP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_AFTER_IMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_AFTER_IMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_AFTER_IMP 
   (	ACC NUMBER(38,0), 
	KF VARCHAR2(6), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	BRANCH VARCHAR2(30), 
	NLSALT VARCHAR2(15), 
	NBS CHAR(4), 
	NBS2 CHAR(4), 
	DAOS DATE, 
	DAPP DATE, 
	ISP NUMBER(38,0), 
	NMS VARCHAR2(70), 
	LIM NUMBER(24,0), 
	OSTB NUMBER(24,0), 
	OSTC NUMBER(24,0), 
	OSTF NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	PAP NUMBER(1,0), 
	TIP CHAR(3), 
	VID NUMBER(2,0), 
	TRCN NUMBER(24,0), 
	MDATE DATE, 
	DAZS DATE, 
	SEC RAW(64), 
	ACCC NUMBER(38,0), 
	BLKD NUMBER(2,0), 
	BLKK NUMBER(2,0), 
	POS NUMBER(38,0), 
	SECI NUMBER(38,0), 
	SECO NUMBER(38,0), 
	GRP NUMBER(38,0), 
	OSTX NUMBER(24,0), 
	RNK NUMBER(38,0), 
	NOTIFIER_REF NUMBER(38,0), 
	TOBO VARCHAR2(30), 
	BDATE DATE, 
	OPT NUMBER(*,0), 
	OB22 CHAR(2), 
	DAPPQ DATE, 
	SEND_SMS VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_AFTER_IMP ***
 exec bpa.alter_policies('ACCOUNTS_AFTER_IMP');


COMMENT ON TABLE BARS.ACCOUNTS_AFTER_IMP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.ACC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.KF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.NLS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.KV IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.BRANCH IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.NLSALT IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.NBS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.NBS2 IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.DAOS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.DAPP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.ISP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.NMS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.LIM IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.OSTB IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.OSTC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.OSTF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.OSTQ IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.DOS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.KOS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.DOSQ IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.KOSQ IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.PAP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.TIP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.VID IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.TRCN IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.MDATE IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.DAZS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.SEC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.ACCC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.BLKD IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.BLKK IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.POS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.SECI IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.SECO IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.GRP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.OSTX IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.RNK IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.NOTIFIER_REF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.TOBO IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.BDATE IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.OPT IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.OB22 IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.DAPPQ IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_AFTER_IMP.SEND_SMS IS '';




PROMPT *** Create  constraint SYS_C008270 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008271 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008292 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008291 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008290 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008289 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (BLKK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008288 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (BLKD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008287 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (TRCN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008286 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008285 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008284 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008283 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008282 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008281 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008280 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (OSTF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008279 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (OSTC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008278 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (OSTB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008277 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (LIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008276 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (NMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008275 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (DAOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008274 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008273 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008272 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_AFTER_IMP MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS_AFTER_IMP ***
grant SELECT                                                                 on ACCOUNTS_AFTER_IMP to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_AFTER_IMP.sql =========*** En
PROMPT ===================================================================================== 
