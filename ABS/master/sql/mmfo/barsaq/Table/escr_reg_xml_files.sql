

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_XML_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REG_XML_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REG_XML_FILES 
   (	ID NUMBER, 
	BRANCH VARCHAR2(30), 
	CLOB CLOB, 
	OPER_DATE DATE, 
	REG_COUNT NUMBER, 
	REG_HEADER_COUNT NUMBER, 
	REG_BODY_COUNT NUMBER, 
	ERR_TEXT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (CLOB) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REG_XML_FILES IS 'Список файлів,які прийши від РУ на ЦА';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.BRANCH IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.CLOB IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.OPER_DATE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.REG_COUNT IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.REG_HEADER_COUNT IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.REG_BODY_COUNT IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_XML_FILES.ERR_TEXT IS '';




PROMPT *** Create  constraint PK_ESCR_XML ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_XML_FILES ADD CONSTRAINT PK_ESCR_XML PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_XML_FILES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_XML_FILES ADD CONSTRAINT CC_ESCR_REG_XML_FILES_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ESCR_XML ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_ESCR_XML ON BARSAQ.ESCR_REG_XML_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_XML_FILES.sql =========*** 
PROMPT ===================================================================================== 
