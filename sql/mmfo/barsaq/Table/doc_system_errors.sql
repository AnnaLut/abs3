

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_SYSTEM_ERRORS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_SYSTEM_ERRORS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_SYSTEM_ERRORS 
   (	SE_ID NUMBER, 
	SE_TIME DATE, 
	SE_CODE NUMBER(*,0), 
	SE_MSG VARCHAR2(4000), 
	EXT_REF VARCHAR2(40), 
	DOC_XML SYS.XMLTYPE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS 
 XMLTYPE COLUMN DOC_XML STORE AS BASICFILE CLOB (
  TABLESPACE AQTS ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_SYSTEM_ERRORS IS 'Системные ошибки при импорте документов';
COMMENT ON COLUMN BARSAQ.DOC_SYSTEM_ERRORS.SE_ID IS 'ID системной ошибки';
COMMENT ON COLUMN BARSAQ.DOC_SYSTEM_ERRORS.SE_TIME IS 'Дата+время системной ошибки';
COMMENT ON COLUMN BARSAQ.DOC_SYSTEM_ERRORS.SE_CODE IS 'Код системной ошибки';
COMMENT ON COLUMN BARSAQ.DOC_SYSTEM_ERRORS.SE_MSG IS 'Описание системной ошибки';
COMMENT ON COLUMN BARSAQ.DOC_SYSTEM_ERRORS.EXT_REF IS 'Внешний референс документа интернет-банкинга';
COMMENT ON COLUMN BARSAQ.DOC_SYSTEM_ERRORS.DOC_XML IS 'XML-представление документа';




PROMPT *** Create  constraint PK_DOCSYSERR ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_SYSTEM_ERRORS ADD CONSTRAINT PK_DOCSYSERR PRIMARY KEY (SE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSYSERR_SEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_SYSTEM_ERRORS MODIFY (SE_ID CONSTRAINT CC_DOCSYSERR_SEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSYSERR_SETIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_SYSTEM_ERRORS MODIFY (SE_TIME CONSTRAINT CC_DOCSYSERR_SETIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSYSERR_SECODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_SYSTEM_ERRORS MODIFY (SE_CODE CONSTRAINT CC_DOCSYSERR_SECODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSYSERR_SECMSG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_SYSTEM_ERRORS MODIFY (SE_MSG CONSTRAINT CC_DOCSYSERR_SECMSG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSYSERR_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_SYSTEM_ERRORS MODIFY (EXT_REF CONSTRAINT CC_DOCSYSERR_EXTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCSYSERR ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCSYSERR ON BARSAQ.DOC_SYSTEM_ERRORS (SE_TIME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCSYSERR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCSYSERR ON BARSAQ.DOC_SYSTEM_ERRORS (SE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_SYSTEM_ERRORS ***
grant SELECT                                                                 on DOC_SYSTEM_ERRORS to BARSREADER_ROLE;
grant SELECT                                                                 on DOC_SYSTEM_ERRORS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOC_SYSTEM_ERRORS to START1;
grant SELECT                                                                 on DOC_SYSTEM_ERRORS to WR_REFREAD;



PROMPT *** Create SYNONYM  to DOC_SYSTEM_ERRORS ***

  CREATE OR REPLACE SYNONYM BARS.DOC_SYSTEM_ERRORS FOR BARSAQ.DOC_SYSTEM_ERRORS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_SYSTEM_ERRORS.sql =========*** E
PROMPT ===================================================================================== 
