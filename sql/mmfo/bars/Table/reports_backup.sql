

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORTS_BACKUP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORTS_BACKUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORTS_BACKUP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_BACKUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_BACKUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORTS_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORTS_BACKUP 
   (	ID NUMBER, 
	NAME VARCHAR2(35), 
	DESCRIPTION VARCHAR2(210), 
	FORM VARCHAR2(35), 
	PARAM VARCHAR2(254), 
	NDAT NUMBER(*,0), 
	WT VARCHAR2(1), 
	MASK VARCHAR2(12), 
	NAMEW VARCHAR2(35), 
	PATH VARCHAR2(225), 
	WT2 VARCHAR2(1), 
	IDF NUMBER(*,0), 
	NODEL NUMBER(1,0), 
	DBTYPE VARCHAR2(3)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORTS_BACKUP ***
 exec bpa.alter_policies('REPORTS_BACKUP');


COMMENT ON TABLE BARS.REPORTS_BACKUP IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.ID IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.NAME IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.FORM IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.PARAM IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.NDAT IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.WT IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.MASK IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.NAMEW IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.PATH IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.WT2 IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.IDF IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.NODEL IS '';
COMMENT ON COLUMN BARS.REPORTS_BACKUP.DBTYPE IS '';




PROMPT *** Create  constraint SYS_C007964 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS_BACKUP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007965 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS_BACKUP MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPORTS_BACKUP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_BACKUP  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_BACKUP  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORTS_BACKUP.sql =========*** End **
PROMPT ===================================================================================== 
