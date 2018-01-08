

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_STAFF$BASE_BCP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_STAFF$BASE_BCP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_STAFF$BASE_BCP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_STAFF$BASE_BCP 
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




PROMPT *** ALTER_POLICIES to TMP_STAFF$BASE_BCP ***
 exec bpa.alter_policies('TMP_STAFF$BASE_BCP');


COMMENT ON TABLE BARS.TMP_STAFF$BASE_BCP IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.CLSID IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.COUNTCONN IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.COUNTPASS IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.CSCHEMA IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.WEB_PROFILE IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.ACTIVE IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.CREATED IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.EXPIRED IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.CHKSUM IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.USEGTW IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.BLK IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.TBLK IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.TEMPL_ID IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.CAN_SELECT_BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.CHGPWD IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.TIP IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.CURRENT_BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.DISABLE IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.ID IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.FIO IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.LOGNAME IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.TYPE IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.TABN IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.BAX IS '';
COMMENT ON COLUMN BARS.TMP_STAFF$BASE_BCP.TBAX IS '';




PROMPT *** Create  constraint SYS_C00109370 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109371 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (CREATED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109372 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (USEGTW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109373 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (TEMPL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109360 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109361 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (FIO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109369 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (POLICY_GROUP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109363 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109364 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (CLSID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109365 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109366 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109367 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (CSCHEMA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109368 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (WEB_PROFILE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109362 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_STAFF$BASE_BCP MODIFY (LOGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_STAFF$BASE_BCP.sql =========*** En
PROMPT ===================================================================================== 
