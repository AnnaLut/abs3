

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_304665.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REPORTS_304665 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REPORTS_304665 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REPORTS_304665 
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




PROMPT *** ALTER_POLICIES to TMP_REPORTS_304665 ***
 exec bpa.alter_policies('TMP_REPORTS_304665');


COMMENT ON TABLE BARS.TMP_REPORTS_304665 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.ID IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.NAME IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.FORM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.PARAM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.NDAT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.WT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.MASK IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.NAMEW IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.PATH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.WT2 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.IDF IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.NODEL IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.DBTYPE IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_304665.EMPTYFILES IS '';




PROMPT *** Create  constraint SYS_C00138655 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_304665 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138656 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_304665 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138657 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_304665 MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138658 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_304665 MODIFY (FORM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138659 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_304665 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138660 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_304665 MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REPORTS_304665 ***
grant SELECT                                                                 on TMP_REPORTS_304665 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_304665.sql =========*** En
PROMPT ===================================================================================== 
