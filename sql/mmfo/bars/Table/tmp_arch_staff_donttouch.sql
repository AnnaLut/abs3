

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_STAFF_DONTTOUCH.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ARCH_STAFF_DONTTOUCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ARCH_STAFF_DONTTOUCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH 
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




PROMPT *** ALTER_POLICIES to TMP_ARCH_STAFF_DONTTOUCH ***
 exec bpa.alter_policies('TMP_ARCH_STAFF_DONTTOUCH');


COMMENT ON TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.COUNTCONN IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.COUNTPASS IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.CSCHEMA IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.WEB_PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.ACTIVE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.EXPIRED IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.USEGTW IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.BLK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.TBLK IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.CAN_SELECT_BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.CHGPWD IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.TIP IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.ID IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.FIO IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.LOGNAME IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.TYPE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.TABN IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.BAX IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.TBAX IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.DISABLE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.CLSID IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.KF IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ARCH_STAFF_DONTTOUCH.TOBO IS '';




PROMPT *** Create  constraint SYS_C006989 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006990 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (FIO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007000 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (USEGTW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006999 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006998 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (WEB_PROFILE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006997 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006996 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (CSCHEMA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006995 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006994 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006993 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (CLSID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006992 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006991 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ARCH_STAFF_DONTTOUCH MODIFY (LOGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ARCH_STAFF_DONTTOUCH ***
grant SELECT                                                                 on TMP_ARCH_STAFF_DONTTOUCH to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ARCH_STAFF_DONTTOUCH.sql =========
PROMPT ===================================================================================== 
