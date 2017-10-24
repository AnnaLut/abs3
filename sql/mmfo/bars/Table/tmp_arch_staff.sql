

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_STAFF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ARCH_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ARCH_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ARCH_STAFF 
   (	ID NUMBER(38,0), 
	FIO VARCHAR2(60), 
	LOGNAME VARCHAR2(30), 
	TYPE NUMBER(1,0), 
	TABN VARCHAR2(10), 
	BAX NUMBER(1,0), 
	TBAX DATE, 
	DISABLE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	CLSID NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	KF VARCHAR2(12), 
	BRANCH VARCHAR2(30), 
	TOBO VARCHAR2(30), 
	COUNTCONN NUMBER(10,0), 
	COUNTPASS NUMBER(10,0), 
	PROFILE VARCHAR2(30), 
	CSCHEMA VARCHAR2(30), 
	USEARC NUMBER(1,0), 
	WEB_PROFILE VARCHAR2(30), 
	ACTIVE NUMBER(1,0), 
	EXPIRED DATE, 
	USEGTW NUMBER(1,0), 
	BLK CHAR(1), 
	TBLK DATE, 
	CAN_SELECT_BRANCH VARCHAR2(1), 
	CHGPWD CHAR(1), 
	TIP NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ARCH_STAFF ***
 exec bpa.alter_policies('TMP_ARCH_STAFF');


COMMENT ON TABLE BARS.TMP_ARCH_STAFF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.ID IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.FIO IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.LOGNAME IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.TYPE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.TABN IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.BAX IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.TBAX IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.DISABLE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.CLSID IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.KF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.COUNTCONN IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.COUNTPASS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.CSCHEMA IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.WEB_PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.ACTIVE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.EXPIRED IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.USEGTW IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.BLK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.TBLK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.CAN_SELECT_BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.CHGPWD IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF.TIP IS '';




PROMPT *** Create  constraint SYS_C009584 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009585 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (WEB_PROFILE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009583 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (CSCHEMA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009582 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009581 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009580 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (CLSID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009579 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009578 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (LOGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009577 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (FIO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009576 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009587 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (USEGTW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009586 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF MODIFY (ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_STAFF.sql =========*** End **
PROMPT ===================================================================================== 
