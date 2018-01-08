

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_335106.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REPORTS_335106 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REPORTS_335106 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REPORTS_335106 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(35), 
	DESCRIPTION VARCHAR2(210), 
	FORM VARCHAR2(35), 
	PARAM VARCHAR2(254), 
	NDAT NUMBER(5,0), 
	WT VARCHAR2(1), 
	MASK VARCHAR2(12), 
	NAMEW VARCHAR2(35), 
	PATH VARCHAR2(225), 
	WT2 VARCHAR2(1), 
	IDF NUMBER(38,0), 
	NODEL NUMBER(1,0), 
	DBTYPE VARCHAR2(3), 
	BRANCH VARCHAR2(30), 
	USEARC NUMBER(1,0), 
	EMPTYFILES NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REPORTS_335106 ***
 exec bpa.alter_policies('TMP_REPORTS_335106');


COMMENT ON TABLE BARS.TMP_REPORTS_335106 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.ID IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.NAME IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.FORM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.PARAM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.NDAT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.WT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.MASK IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.NAMEW IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.PATH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.WT2 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.IDF IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.NODEL IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.DBTYPE IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_335106.EMPTYFILES IS '';




PROMPT *** Create  constraint SYS_C00139226 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_335106 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139227 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_335106 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139228 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_335106 MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139229 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_335106 MODIFY (FORM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139230 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_335106 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139231 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_335106 MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REPORTS_335106 ***
grant SELECT                                                                 on TMP_REPORTS_335106 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_335106.sql =========*** En
PROMPT ===================================================================================== 
