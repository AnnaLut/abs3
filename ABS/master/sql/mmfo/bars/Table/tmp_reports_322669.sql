

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_322669.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REPORTS_322669 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REPORTS_322669 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REPORTS_322669 
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




PROMPT *** ALTER_POLICIES to TMP_REPORTS_322669 ***
 exec bpa.alter_policies('TMP_REPORTS_322669');


COMMENT ON TABLE BARS.TMP_REPORTS_322669 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.ID IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.NAME IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.FORM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.PARAM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.NDAT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.WT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.MASK IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.NAMEW IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.PATH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.WT2 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.IDF IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.NODEL IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.DBTYPE IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.USEARC IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_322669.EMPTYFILES IS '';




PROMPT *** Create  constraint SYS_C00132019 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_322669 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132020 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_322669 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132021 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_322669 MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132022 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_322669 MODIFY (FORM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132023 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_322669 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132024 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_322669 MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REPORTS_322669 ***
grant SELECT                                                                 on TMP_REPORTS_322669 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_322669.sql =========*** En
PROMPT ===================================================================================== 
