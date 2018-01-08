

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_ACCOUNTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ARCH_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ARCH_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ARCH_ACCOUNTS 
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




PROMPT *** ALTER_POLICIES to TMP_ARCH_ACCOUNTS ***
 exec bpa.alter_policies('TMP_ARCH_ACCOUNTS');


COMMENT ON TABLE BARS.TMP_ARCH_ACCOUNTS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.KF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.NLS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.KV IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.NLSALT IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.NBS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.NBS2 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.DAOS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.ISP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.NMS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.LIM IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.OSTB IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.OSTC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.OSTF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.DOS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.KOS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.PAP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.TIP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.VID IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.TRCN IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.MDATE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.SEC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.ACCC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.BLKD IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.BLKK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.POS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.SECI IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.SECO IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.GRP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.OSTX IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.NOTIFIER_REF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.BDATE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.OPT IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.DAPPQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS.SEND_SMS IS '';




PROMPT *** Create  constraint SYS_C006977 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006978 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006979 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006980 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006981 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006982 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006983 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (TRCN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006984 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (BLKD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006985 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (BLKK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006986 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006987 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006988 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006966 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006967 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006968 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006969 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006970 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006971 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (DAOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006972 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (NMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006973 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (LIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006974 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (OSTB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006975 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (OSTC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006976 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS MODIFY (OSTF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ARCH_ACCOUNTS ***
grant SELECT                                                                 on TMP_ARCH_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ARCH_ACCOUNTS to BARS_DM;
grant SELECT                                                                 on TMP_ARCH_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_ACCOUNTS.sql =========*** End
PROMPT ===================================================================================== 
