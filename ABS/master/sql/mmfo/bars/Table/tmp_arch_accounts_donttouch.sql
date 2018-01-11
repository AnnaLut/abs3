

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_ACCOUNTS_DONTTOUCH.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ARCH_ACCOUNTS_DONTTOUCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ARCH_ACCOUNTS_DONTTOUCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH 
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




PROMPT *** ALTER_POLICIES to TMP_ARCH_ACCOUNTS_DONTTOUCH ***
 exec bpa.alter_policies('TMP_ARCH_ACCOUNTS_DONTTOUCH');


COMMENT ON TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.KF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.NLS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.KV IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.NLSALT IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.NBS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.NBS2 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.DAOS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.ISP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.NMS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.LIM IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.OSTB IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.OSTC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.OSTF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.DOS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.KOS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.PAP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.TIP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.VID IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.TRCN IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.MDATE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.SEC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.ACCC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.BLKD IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.BLKK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.POS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.SECI IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.SECO IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.GRP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.OSTX IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.NOTIFIER_REF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.BDATE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.OPT IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.DAPPQ IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH.SEND_SMS IS '';




PROMPT *** Create  constraint SYS_C005629 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005630 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005631 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005632 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005633 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005634 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (DAOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005635 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (NMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005636 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (LIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005637 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (OSTB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005638 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (OSTC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005639 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (OSTF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005640 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005641 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005642 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005643 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005644 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005645 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005646 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (TRCN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005647 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (BLKD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005648 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (BLKK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005649 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005650 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005651 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_ACCOUNTS_DONTTOUCH MODIFY (TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ARCH_ACCOUNTS_DONTTOUCH ***
grant SELECT                                                                 on TMP_ARCH_ACCOUNTS_DONTTOUCH to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ARCH_ACCOUNTS_DONTTOUCH to BARS_DM;
grant SELECT                                                                 on TMP_ARCH_ACCOUNTS_DONTTOUCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_ACCOUNTS_DONTTOUCH.sql ======
PROMPT ===================================================================================== 
