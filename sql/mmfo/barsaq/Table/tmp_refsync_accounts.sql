

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_ACCOUNTS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REFSYNC_ACCOUNTS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS 
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
	ACTION CHAR(1), 
	CHANGE_DATE DATE, 
	CHANGE_NUMBER NUMBER, 
	SYSTEM_CHANGE_NUMBER NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.SECO IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.GRP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.OSTX IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.RNK IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.NOTIFIER_REF IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.TOBO IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.BDATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.OPT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.ACTION IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.CHANGE_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.SYSTEM_CHANGE_NUMBER IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.ACC IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.KF IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.NLS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.KV IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.BRANCH IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.NLSALT IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.NBS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.NBS2 IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.DAOS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.DAPP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.ISP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.NMS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.LIM IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.OSTB IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.OSTC IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.OSTF IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.OSTQ IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.DOS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.KOS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.DOSQ IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.KOSQ IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.PAP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.TIP IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.VID IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.TRCN IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.MDATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.DAZS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.SEC IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.ACCC IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.BLKD IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.BLKK IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.POS IS '';
COMMENT ON COLUMN BARSAQ.TMP_REFSYNC_ACCOUNTS.SECI IS '';




PROMPT *** Create  constraint SYS_C0010366 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (OSTC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010367 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (OSTF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010368 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010369 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010370 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010371 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010372 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010373 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010374 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (TRCN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010375 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (BLKD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010376 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (BLKK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010377 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010378 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010357 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010358 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010359 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010360 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010361 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010362 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (DAOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010363 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (NMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010364 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (LIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010365 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_REFSYNC_ACCOUNTS MODIFY (OSTB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFSYNC_ACCOUNTS ***
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_ACCOUNTS to BARS;
grant SELECT                                                                 on TMP_REFSYNC_ACCOUNTS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on TMP_REFSYNC_ACCOUNTS to KLBX;
grant SELECT                                                                 on TMP_REFSYNC_ACCOUNTS to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_REFSYNC_ACCOUNTS.sql =========**
PROMPT ===================================================================================== 
