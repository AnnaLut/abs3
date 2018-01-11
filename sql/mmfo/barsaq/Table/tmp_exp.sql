

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_EXP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_EXP ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.TMP_EXP 
   (	DOC_ID NUMBER(*,0), 
	STATUS_ID NUMBER(*,0), 
	STATUS_CHANGE_TIME DATE, 
	BANK_ACCEPT_DATE DATE, 
	BANK_REF VARCHAR2(40), 
	BANK_BACK_DATE DATE, 
	DOC_XML SYS.XMLTYPE , 
	BANK_ID VARCHAR2(11), 
	TYPE_ID VARCHAR2(12), 
	BANK_BACK_REASON VARCHAR2(4000), 
	BANK_BACK_REASON_AUX VARCHAR2(4000), 
	BANK_SYSERR_DATE DATE, 
	BANK_SYSERR_MSG VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS 
 XMLTYPE COLUMN DOC_XML STORE AS SECUREFILE BINARY XML (
  TABLESPACE AQTS ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_EXP IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.DOC_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.STATUS_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.STATUS_CHANGE_TIME IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_ACCEPT_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_REF IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_BACK_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.DOC_XML IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.TYPE_ID IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_BACK_REASON IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_BACK_REASON_AUX IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_SYSERR_DATE IS '';
COMMENT ON COLUMN BARSAQ.TMP_EXP.BANK_SYSERR_MSG IS '';




PROMPT *** Create  constraint SYS_C0035199 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_EXP MODIFY (DOC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035200 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_EXP MODIFY (STATUS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035201 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_EXP MODIFY (STATUS_CHANGE_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035202 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_EXP MODIFY (BANK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035203 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_EXP MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMP_EXP ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_EXP ADD CONSTRAINT PK_TMP_EXP PRIMARY KEY (DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_EXP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_TMP_EXP ON BARSAQ.TMP_EXP (DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_EXP ***
grant SELECT                                                                 on TMP_EXP         to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_EXP.sql =========*** End *** ===
PROMPT ===================================================================================== 
