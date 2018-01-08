

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_351823.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REPORTS_351823 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REPORTS_351823 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REPORTS_351823 
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




PROMPT *** ALTER_POLICIES to TMP_REPORTS_351823 ***
 exec bpa.alter_policies('TMP_REPORTS_351823');


COMMENT ON TABLE BARS.TMP_REPORTS_351823 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.ID IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.NAME IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.FORM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.PARAM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.NDAT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.WT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.MASK IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.NAMEW IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.PATH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.WT2 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.IDF IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.NODEL IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.DBTYPE IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_351823.EMPTYFILES IS '';




PROMPT *** Create  constraint SYS_C00138069 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_351823 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138070 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_351823 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138071 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_351823 MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138072 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_351823 MODIFY (FORM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138073 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_351823 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138074 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_351823 MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REPORTS_351823 ***
grant SELECT                                                                 on TMP_REPORTS_351823 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_351823.sql =========*** En
PROMPT ===================================================================================== 
