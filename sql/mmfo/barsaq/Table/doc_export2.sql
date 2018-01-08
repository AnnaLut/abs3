

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_EXPORT2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_EXPORT2 ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_EXPORT2 
   (	DOC_ID NUMBER(*,0), 
	DOC_XML SYS.XMLTYPE , 
	BANK_ID VARCHAR2(11), 
	TYPE_ID VARCHAR2(12), 
	STATUS_ID NUMBER(*,0), 
	STATUS_CHANGE_TIME DATE, 
	BANK_ACCEPT_DATE DATE, 
	BANK_REF VARCHAR2(40), 
	BANK_BACK_DATE DATE, 
	BANK_BACK_REASON VARCHAR2(4000), 
	BANK_BACK_REASON_AUX VARCHAR2(4000), 
	BANK_SYSERR_DATE DATE, 
	BANK_SYSERR_MSG VARCHAR2(4000), 
	DOC_DESC BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS 
 XMLTYPE COLUMN DOC_XML STORE AS SECUREFILE BINARY XML (
  TABLESPACE AQTS ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA 
 LOB (DOC_DESC) STORE AS BASICFILE (
  TABLESPACE BRSBIGD DISABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE NOLOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_EXPORT2 IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.DOC_ID IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.DOC_XML IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_ID IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.TYPE_ID IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.STATUS_ID IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.STATUS_CHANGE_TIME IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_ACCEPT_DATE IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_REF IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_BACK_DATE IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_BACK_REASON IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_BACK_REASON_AUX IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_SYSERR_DATE IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.BANK_SYSERR_MSG IS '';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT2.DOC_DESC IS '';




PROMPT *** Create  constraint SYS_C0035253 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT2 MODIFY (DOC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035254 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT2 MODIFY (BANK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035255 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT2 MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035256 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT2 MODIFY (STATUS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035257 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT2 MODIFY (STATUS_CHANGE_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOC_EXPORT2 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT2 ADD CONSTRAINT PK_DOC_EXPORT2 PRIMARY KEY (DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOC_EXPORT2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOC_EXPORT2 ON BARSAQ.DOC_EXPORT2 (DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_EXPORT2 ***
grant SELECT                                                                 on DOC_EXPORT2     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_EXPORT2.sql =========*** End ***
PROMPT ===================================================================================== 
