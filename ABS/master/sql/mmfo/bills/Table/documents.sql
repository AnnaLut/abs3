

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Table/DOCUMENTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table DOCUMENTS ***
begin 
  execute immediate '
  CREATE TABLE BILLS.DOCUMENTS 
   (	DOC_ID NUMBER, 
	REC_ID NUMBER(*,0), 
	DOC_TYPE NUMBER(*,0), 
	DOC_BODY CLOB, 
	STATUS VARCHAR2(2), 
	LAST_DT DATE, 
	LAST_USER VARCHAR2(30), 
	FILENAME VARCHAR2(64), 
	EXT_ID NUMBER, 
	DESCRIPT VARCHAR2(1024)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (DOC_BODY) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BILLS.DOCUMENTS IS '';
COMMENT ON COLUMN BILLS.DOCUMENTS.DOC_ID IS 'ИД документа';
COMMENT ON COLUMN BILLS.DOCUMENTS.REC_ID IS 'посилання на ід отримувача';
COMMENT ON COLUMN BILLS.DOCUMENTS.DOC_TYPE IS 'Тип документу';
COMMENT ON COLUMN BILLS.DOCUMENTS.DOC_BODY IS 'документ';
COMMENT ON COLUMN BILLS.DOCUMENTS.STATUS IS 'Статус документа';
COMMENT ON COLUMN BILLS.DOCUMENTS.LAST_DT IS 'Дата+час останніх змін';
COMMENT ON COLUMN BILLS.DOCUMENTS.LAST_USER IS 'Користувач, який вносив останні зміни';
COMMENT ON COLUMN BILLS.DOCUMENTS.FILENAME IS 'Ім"я файлу';
COMMENT ON COLUMN BILLS.DOCUMENTS.EXT_ID IS 'ИД файла в системе Казначейства';
COMMENT ON COLUMN BILLS.DOCUMENTS.DESCRIPT IS 'Описание документа';




PROMPT *** Create  constraint SYS_C0027192 ***
begin   
 execute immediate '
  ALTER TABLE BILLS.DOCUMENTS MODIFY (DOC_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_DOCUMENTS ***
begin   
 execute immediate '
  ALTER TABLE BILLS.DOCUMENTS ADD CONSTRAINT XPK_DOCUMENTS PRIMARY KEY (DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DOCUMENTS_EXT_ID ***
begin   
 execute immediate '
  ALTER TABLE BILLS.DOCUMENTS ADD CONSTRAINT UK_DOCUMENTS_EXT_ID UNIQUE (EXT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DOCUMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BILLS.XPK_DOCUMENTS ON BILLS.DOCUMENTS (DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DOCUMENTS_EXT_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BILLS.UK_DOCUMENTS_EXT_ID ON BILLS.DOCUMENTS (EXT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Table/DOCUMENTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
