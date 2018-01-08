

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_STAFFBASE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_STAFFBASE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_STAFFBASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_STAFFBASE 
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
	BRANCH VARCHAR2(30), 
	COUNTCONN NUMBER(10,0), 
	COUNTPASS NUMBER(10,0), 
	PROFILE VARCHAR2(30), 
	USEARC NUMBER(1,0), 
	CSCHEMA VARCHAR2(30), 
	WEB_PROFILE VARCHAR2(30), 
	POLICY_GROUP VARCHAR2(30), 
	ACTIVE NUMBER(1,0), 
	CREATED DATE, 
	EXPIRED DATE, 
	CHKSUM VARCHAR2(50), 
	USEGTW NUMBER(1,0), 
	BLK CHAR(1), 
	TBLK DATE, 
	TEMPL_ID NUMBER(38,0), 
	CAN_SELECT_BRANCH VARCHAR2(1), 
	CHGPWD CHAR(1), 
	TIP NUMBER(22,0), 
	CURRENT_BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_STAFFBASE ***
 exec bpa.alter_policies('TMP_STAFFBASE');


COMMENT ON TABLE BARS.TMP_STAFFBASE IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.ID IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.FIO IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.LOGNAME IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.TYPE IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.TABN IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.BAX IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.TBAX IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.DISABLE IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.CLSID IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.COUNTCONN IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.COUNTPASS IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.CSCHEMA IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.WEB_PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.ACTIVE IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.CREATED IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.EXPIRED IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.CHKSUM IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.USEGTW IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.BLK IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.TBLK IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.TEMPL_ID IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.CAN_SELECT_BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.CHGPWD IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.TIP IS '';
COMMENT ON COLUMN BARS.TMP_STAFFBASE.CURRENT_BRANCH IS '';




PROMPT *** Create  constraint SYS_C00109916 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109917 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (CREATED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109918 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (USEGTW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109919 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (TEMPL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109906 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109907 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (FIO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109908 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (LOGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109909 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109910 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (CLSID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109911 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109912 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109913 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (CSCHEMA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109914 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (WEB_PROFILE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109915 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFFBASE MODIFY (POLICY_GROUP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_STAFFBASE ***
grant SELECT                                                                 on TMP_STAFFBASE   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_STAFFBASE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_STAFFBASE.sql =========*** End ***
PROMPT ===================================================================================== 
