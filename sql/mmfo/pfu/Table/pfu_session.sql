

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_SESSION.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_SESSION ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_SESSION 
   (	ID NUMBER(10,0), 
	SESSION_TYPE_ID NUMBER(5,0), 
	REQUEST_ID NUMBER(10,0), 
	REQUEST_DATA CLOB, 
	RESPONSE_DATA CLOB, 
	REQUEST_XML_DATA CLOB, 
	RESPONSE_XML_DATA CLOB, 
	STATE_ID NUMBER(5,0), 
	NUMBER_OF_FAILURES NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (REQUEST_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPONSE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (REQUEST_XML_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPONSE_XML_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_SESSION IS '';
COMMENT ON COLUMN PFU.PFU_SESSION.ID IS 'Ідентифікатор запиту';
COMMENT ON COLUMN PFU.PFU_SESSION.SESSION_TYPE_ID IS 'Тип сесії (1 - запит на формування реєстру за період, 2 - опитування статусу формування реєстру, 3 - запит на отримання даних)';
COMMENT ON COLUMN PFU.PFU_SESSION.REQUEST_ID IS 'Ідентифікатор запиту, в рамках якого створюється сесія зв'язку з сервісом ПФУ';
COMMENT ON COLUMN PFU.PFU_SESSION.REQUEST_DATA IS 'Дані запиту (xml)';
COMMENT ON COLUMN PFU.PFU_SESSION.RESPONSE_DATA IS 'Дані відповіді (xml)';
COMMENT ON COLUMN PFU.PFU_SESSION.REQUEST_XML_DATA IS '';
COMMENT ON COLUMN PFU.PFU_SESSION.RESPONSE_XML_DATA IS '';
COMMENT ON COLUMN PFU.PFU_SESSION.STATE_ID IS 'Стан обробки запиту (0 - запит успішний, відповідь отримана, 1 - помилка отримання або відправки запиту)';
COMMENT ON COLUMN PFU.PFU_SESSION.NUMBER_OF_FAILURES IS '';




PROMPT *** Create  constraint PK_PFU_SESSION ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION ADD CONSTRAINT PK_PFU_SESSION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PFU_SESSION_REF_PFU_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION ADD CONSTRAINT FK_PFU_SESSION_REF_PFU_REQUEST FOREIGN KEY (REQUEST_ID)
	  REFERENCES PFU.PFU_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111534 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111532 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111533 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION MODIFY (REQUEST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SESSION_REF_STATE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION ADD CONSTRAINT FK_SESSION_REF_STATE FOREIGN KEY (STATE_ID)
	  REFERENCES PFU.PFU_SESSION_STATE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_SESSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_SESSION ON PFU.PFU_SESSION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_SESSION.sql =========*** End *** ==
PROMPT ===================================================================================== 
