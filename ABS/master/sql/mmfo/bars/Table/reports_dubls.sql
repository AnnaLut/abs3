

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORTS_DUBLS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORTS_DUBLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORTS_DUBLS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_DUBLS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_DUBLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORTS_DUBLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORTS_DUBLS 
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




PROMPT *** ALTER_POLICIES to REPORTS_DUBLS ***
 exec bpa.alter_policies('REPORTS_DUBLS');


COMMENT ON TABLE BARS.REPORTS_DUBLS IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.ID IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.NAME IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.FORM IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.PARAM IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.NDAT IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.WT IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.MASK IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.NAMEW IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.PATH IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.WT2 IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.IDF IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.NODEL IS '';
COMMENT ON COLUMN BARS.REPORTS_DUBLS.DBTYPE IS '';




PROMPT *** Create  constraint SYS_C008367 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS_DUBLS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008368 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS_DUBLS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPORTS_DUBLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_DUBLS   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_DUBLS   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORTS_DUBLS.sql =========*** End ***
PROMPT ===================================================================================== 
