

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_BAK_GL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_BAK_GL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_BAK_GL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_BAK_GL 
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
	DAPPQ DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_BAK_GL ***
 exec bpa.alter_policies('ACCOUNTS_BAK_GL');


COMMENT ON TABLE BARS.ACCOUNTS_BAK_GL IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.ACC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.KF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.NLS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.KV IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.BRANCH IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.NLSALT IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.NBS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.NBS2 IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.DAOS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.DAPP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.ISP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.NMS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.LIM IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.OSTB IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.OSTC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.OSTF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.OSTQ IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.DOS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.KOS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.DOSQ IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.KOSQ IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.PAP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.TIP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.VID IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.TRCN IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.MDATE IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.DAZS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.SEC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.ACCC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.BLKD IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.BLKK IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.POS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.SECI IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.SECO IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.GRP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.OSTX IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.RNK IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.NOTIFIER_REF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.TOBO IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.BDATE IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.OPT IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.OB22 IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_BAK_GL.DAPPQ IS '';




PROMPT *** Create  constraint SYS_C001369486 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369485 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369484 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (BLKK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369483 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (BLKD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369482 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (TRCN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369481 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369480 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369479 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369478 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369477 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369476 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369475 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (OSTF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369474 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (OSTC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369473 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (OSTB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369472 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (LIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369471 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (NMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369470 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (DAOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369469 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369468 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369467 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369466 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369465 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001369487 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_BAK_GL MODIFY (TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_BAK_GL.sql =========*** End *
PROMPT ===================================================================================== 
