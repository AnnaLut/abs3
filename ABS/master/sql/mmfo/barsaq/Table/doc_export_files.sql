

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_EXPORT_FILES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_EXPORT_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_EXPORT_FILES 
   (	DOC_ID NUMBER(*,0), 
	BANK_REF NUMBER(38,0), 
	DOC_FILE BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (DOC_FILE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_EXPORT_FILES IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT_FILES.DOC_ID IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT_FILES.BANK_REF IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT_FILES.DOC_FILE IS '';




PROMPT *** Create  constraint CC_DOCEXPFILES_DOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT_FILES MODIFY (DOC_ID CONSTRAINT CC_DOCEXPFILES_DOCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCEXPFILES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT_FILES ADD CONSTRAINT PK_DOCEXPFILES PRIMARY KEY (DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCEXPFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCEXPFILES ON BARSAQ.DOC_EXPORT_FILES (DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCEXPFILES_BANKREF ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCEXPFILES_BANKREF ON BARSAQ.DOC_EXPORT_FILES (BANK_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_EXPORT_FILES ***
grant SELECT                                                                 on DOC_EXPORT_FILES to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_EXPORT_FILES.sql =========*** En
PROMPT ===================================================================================== 
