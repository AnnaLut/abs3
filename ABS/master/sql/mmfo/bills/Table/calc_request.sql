

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Table/CALC_REQUEST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table CALC_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BILLS.CALC_REQUEST 
   (	REQUEST_ID NUMBER, 
	REQUEST_NAME VARCHAR2(256), 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	REQUEST_DATE DATE DEFAULT sysdate, 
	REQUEST_BODY CLOB, 
	SCAN_NAME VARCHAR2(256), 
	SCAN_BODY CLOB, 
	SCAN_DATE DATE, 
	SEND_DATE DATE, 
	STATUS VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (REQUEST_BODY) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (SCAN_BODY) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BILLS.CALC_REQUEST IS 'Расчеты сумм реструктуризированной задолженности (расчет + скан)';
COMMENT ON COLUMN BILLS.CALC_REQUEST.REQUEST_ID IS 'Внутренний ид расчета';
COMMENT ON COLUMN BILLS.CALC_REQUEST.REQUEST_NAME IS 'Имя файла расчета';
COMMENT ON COLUMN BILLS.CALC_REQUEST.DATE_FROM IS 'Дата с';
COMMENT ON COLUMN BILLS.CALC_REQUEST.DATE_TO IS 'Дата по';
COMMENT ON COLUMN BILLS.CALC_REQUEST.REQUEST_DATE IS 'Системная дата получения расчета';
COMMENT ON COLUMN BILLS.CALC_REQUEST.REQUEST_BODY IS 'Файл расчета';
COMMENT ON COLUMN BILLS.CALC_REQUEST.SCAN_NAME IS 'Имя файла скана';
COMMENT ON COLUMN BILLS.CALC_REQUEST.SCAN_BODY IS 'Файл - скан расчета';
COMMENT ON COLUMN BILLS.CALC_REQUEST.SCAN_DATE IS 'Дата отправки скана';
COMMENT ON COLUMN BILLS.CALC_REQUEST.SEND_DATE IS '';
COMMENT ON COLUMN BILLS.CALC_REQUEST.STATUS IS '';




PROMPT *** Create  constraint XPK_CALC_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE BILLS.CALC_REQUEST ADD CONSTRAINT XPK_CALC_REQUEST PRIMARY KEY (REQUEST_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0028918 ***
begin   
 execute immediate '
  ALTER TABLE BILLS.CALC_REQUEST MODIFY (DATE_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CALC_REQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BILLS.XPK_CALC_REQUEST ON BILLS.CALC_REQUEST (REQUEST_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CALC_REQUEST_DATEF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BILLS.UK_CALC_REQUEST_DATEF ON BILLS.CALC_REQUEST (TRUNC(DATE_FROM,''fmmonth'')) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Table/CALC_REQUEST.sql =========*** End ***
PROMPT ===================================================================================== 
