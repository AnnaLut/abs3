

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_REPORTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_REPORTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_REPORTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_REPORTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_REPORTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_REPORTS 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	TYPEID NUMBER, 
	PARAMS VARCHAR2(4000), 
	TEMPLATE_NAME VARCHAR2(100), 
	RESULT_FILE_NAME VARCHAR2(254), 
	SQLPREPARE CLOB, 
	DESCRIPTION VARCHAR2(200), 
	FORM_PROC VARCHAR2(4000), 
	STMT VARCHAR2(4000), 
	FILE_NAME VARCHAR2(254), 
	ENCODING VARCHAR2(3), 
	SQLCUTTING CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (SQLPREPARE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (SQLCUTTING) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_REPORTS ***
 exec bpa.alter_policies('DWH_REPORTS');


COMMENT ON TABLE BARS.DWH_REPORTS IS 'reports of DWH';
COMMENT ON COLUMN BARS.DWH_REPORTS.ID IS 'Id of report';
COMMENT ON COLUMN BARS.DWH_REPORTS.NAME IS 'Name of report';
COMMENT ON COLUMN BARS.DWH_REPORTS.TYPEID IS 'Type in dwh_report_type';
COMMENT ON COLUMN BARS.DWH_REPORTS.PARAMS IS 'JSON description params for prepare report';
COMMENT ON COLUMN BARS.DWH_REPORTS.TEMPLATE_NAME IS 'Name or patch to template file';
COMMENT ON COLUMN BARS.DWH_REPORTS.RESULT_FILE_NAME IS 'Result file name';
COMMENT ON COLUMN BARS.DWH_REPORTS.SQLPREPARE IS 'SQL command for prepare report';
COMMENT ON COLUMN BARS.DWH_REPORTS.DESCRIPTION IS 'Description of report';
COMMENT ON COLUMN BARS.DWH_REPORTS.FORM_PROC IS '';
COMMENT ON COLUMN BARS.DWH_REPORTS.STMT IS '';
COMMENT ON COLUMN BARS.DWH_REPORTS.FILE_NAME IS '';
COMMENT ON COLUMN BARS.DWH_REPORTS.ENCODING IS '';
COMMENT ON COLUMN BARS.DWH_REPORTS.SQLCUTTING IS 'SQL для нарезки';




PROMPT *** Create  constraint CC_DWHREPORTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORTS MODIFY (NAME CONSTRAINT CC_DWHREPORTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DWHREPORTS_DWHREPORTSTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORTS ADD CONSTRAINT FK_DWHREPORTS_DWHREPORTSTYPE FOREIGN KEY (TYPEID)
	  REFERENCES BARS.DWH_REPORT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DWHREPORTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORTS ADD CONSTRAINT PK_DWHREPORTS_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DWHREPORTS_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DWHREPORTS_ID ON BARS.DWH_REPORTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_REPORTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_REPORTS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_REPORTS.sql =========*** End *** =
PROMPT ===================================================================================== 
