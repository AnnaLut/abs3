

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_REPORTS_LIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_REPORTS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_REPORTS_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_REPORTS_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_REPORTS_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_REPORTS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_REPORTS_LIST 
   (	REPORT_ID NUMBER, 
	NAME VARCHAR2(128), 
	PROC VARCHAR2(256), 
	TEMPLATE VARCHAR2(128), 
	FILE_TYPE VARCHAR2(128), 
	FILE_NAME VARCHAR2(128), 
	USE_IN_TVBV NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_REPORTS_LIST ***
 exec bpa.alter_policies('CIM_REPORTS_LIST');


COMMENT ON TABLE BARS.CIM_REPORTS_LIST IS 'Звіти для модуля CIM v 1.00.02';
COMMENT ON COLUMN BARS.CIM_REPORTS_LIST.REPORT_ID IS 'ID звіту';
COMMENT ON COLUMN BARS.CIM_REPORTS_LIST.NAME IS 'Найменування звіту';
COMMENT ON COLUMN BARS.CIM_REPORTS_LIST.PROC IS 'Процедура для виконання перед формуванням';
COMMENT ON COLUMN BARS.CIM_REPORTS_LIST.TEMPLATE IS 'Імя файл шаблону (fastreport)';
COMMENT ON COLUMN BARS.CIM_REPORTS_LIST.FILE_TYPE IS 'Тип вихідного файлу - допустимі значення text,word,excel';
COMMENT ON COLUMN BARS.CIM_REPORTS_LIST.FILE_NAME IS 'Імя вихідного файлу';
COMMENT ON COLUMN BARS.CIM_REPORTS_LIST.USE_IN_TVBV IS 'Відображення звіту у ТВБВ';




PROMPT *** Create  constraint CC_CIMREP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORTS_LIST MODIFY (REPORT_ID CONSTRAINT CC_CIMREP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMREP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORTS_LIST MODIFY (NAME CONSTRAINT CC_CIMREP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMREP_FTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORTS_LIST MODIFY (FILE_TYPE CONSTRAINT CC_CIMREP_FTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMREPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORTS_LIST ADD CONSTRAINT PK_CIMREPS PRIMARY KEY (REPORT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMREPS_FTYPE_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORTS_LIST ADD CONSTRAINT CC_CIMREPS_FTYPE_CC CHECK (file_type in (''text'',''word'',''excel'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMREPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMREPS ON BARS.CIM_REPORTS_LIST (REPORT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_REPORTS_LIST ***
grant SELECT                                                                 on CIM_REPORTS_LIST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_REPORTS_LIST to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_REPORTS_LIST to CIM_ROLE;
grant SELECT                                                                 on CIM_REPORTS_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_REPORTS_LIST.sql =========*** End 
PROMPT ===================================================================================== 
