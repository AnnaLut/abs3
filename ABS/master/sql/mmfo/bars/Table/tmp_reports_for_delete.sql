

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_FOR_DELETE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REPORTS_FOR_DELETE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REPORTS_FOR_DELETE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REPORTS_FOR_DELETE 
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
	USEARC NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REPORTS_FOR_DELETE ***
 exec bpa.alter_policies('TMP_REPORTS_FOR_DELETE');


COMMENT ON TABLE BARS.TMP_REPORTS_FOR_DELETE IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.ID IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.NAME IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.FORM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.PARAM IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.NDAT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.WT IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.MASK IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.NAMEW IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.PATH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.WT2 IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.IDF IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.NODEL IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.DBTYPE IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REPORTS_FOR_DELETE.USEARC IS '';




PROMPT *** Create  constraint SYS_C006460 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_FOR_DELETE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006461 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_FOR_DELETE MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006462 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_FOR_DELETE MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006463 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_FOR_DELETE MODIFY (FORM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006464 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_FOR_DELETE MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006465 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REPORTS_FOR_DELETE MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REPORTS_FOR_DELETE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REPORTS_FOR_DELETE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REPORTS_FOR_DELETE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REPORTS_FOR_DELETE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REPORTS_FOR_DELETE.sql =========**
PROMPT ===================================================================================== 
