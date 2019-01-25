PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_REQUESTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_REQUESTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_REQUESTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_REQUESTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_REQUESTS 
   (	REQ_ID NUMBER, 
	URL VARCHAR2(100), 
	REQ_TYPE VARCHAR2(100), 
	REQ_METH VARCHAR2(100), 
	REQ_BODY SYS.XMLTYPE , 
	CREATION_DATE DATE, 
	CREATOR VARCHAR2(100), 
	LAST_DT DATE, 
	LAST_USER VARCHAR2(100), 
	STATUS VARCHAR2(2), 
	WS_RESPONSE CLOB, 
	ENVELOPE SYS.XMLTYPE , 
	XML_RESPONSE SYS.XMLTYPE , 
	RESPONSE VARCHAR2(1000), 
	OPER_REF NUMBER, 
	OPER_AMOUNT NUMBER, 
	OPER_CURRENCY VARCHAR2(3), 
	OPER_AMOUNT_TXT VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 XMLTYPE COLUMN REQ_BODY STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA 
 LOB (WS_RESPONSE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 XMLTYPE COLUMN ENVELOPE STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA 
 XMLTYPE COLUMN XML_RESPONSE STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_REQUESTS ***
 exec bpa.alter_policies('TELLER_REQUESTS');


COMMENT ON TABLE BARS.TELLER_REQUESTS IS 'Виклики веб-сервісів для роботи з обладнанням Теллера';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.REQ_ID IS 'Ід запиту';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.URL IS 'УРЛ обладнання, на який скеровано запит';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.REQ_TYPE IS 'Тип запиту';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.REQ_METH IS 'Метод (код операції)';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.REQ_BODY IS 'Тіло запиту';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.CREATION_DATE IS 'Дата+час формування';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.CREATOR IS 'Користувач, який сформував запит';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.LAST_DT IS 'Дата+час останньої модифікації';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.LAST_USER IS 'Користувач, який змінював запит';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.STATUS IS 'Поточний статус запиту';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.WS_RESPONSE IS 'Відповідь веб-сервіса (текст)';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.ENVELOPE IS 'Тіло конверта, який був сформований';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.XML_RESPONSE IS 'Відповідь веб-сервіса (xml)';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.RESPONSE IS 'Код відповіді';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.OPER_REF IS 'ID операції в АБС';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.OPER_AMOUNT IS 'Сума виконаної операції';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.OPER_CURRENCY IS 'Валюта виконаної операції';
COMMENT ON COLUMN BARS.TELLER_REQUESTS.OPER_AMOUNT_TXT IS 'Сума операції для мультивалютної операції (StoreCashin, EndCashin)';




PROMPT *** Create  constraint XPK_TELLER_REQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_REQUESTS ADD CONSTRAINT XPK_TELLER_REQUESTS PRIMARY KEY (REQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_TELLER_REQUESTS_USER_DT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_TELLER_REQUESTS_USER_DT ON BARS.TELLER_REQUESTS (CREATOR, CREATION_DATE, REQ_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_TELLER_REQUEST_EQ_IP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_TELLER_REQUEST_EQ_IP ON BARS.TELLER_REQUESTS (URL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TELLER_REQUESTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TELLER_REQUESTS ON BARS.TELLER_REQUESTS (REQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_TELLER_REQUESTS_OPER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_TELLER_REQUESTS_OPER ON BARS.TELLER_REQUESTS (OPER_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_REQUESTS.sql =========*** End *
PROMPT ===================================================================================== 
