

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Table/CA_RECEIVERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table CA_RECEIVERS ***
begin 
  execute immediate '
  CREATE TABLE BILLS.CA_RECEIVERS 
   (	KF NUMBER(6,0), 
	EXP_ID NUMBER(*,0), 
	NAME VARCHAR2(60), 
	INN VARCHAR2(12), 
	DOC_NO VARCHAR2(30), 
	DOC_DATE DATE, 
	DOC_WHO VARCHAR2(100), 
	CL_TYPE NUMBER(*,0), 
	CURRENCY VARCHAR2(3), 
	CUR_RATE NUMBER, 
	AMOUNT NUMBER, 
	PHONE VARCHAR2(100), 
	ACCOUNT VARCHAR2(14), 
	REQ_ID NUMBER(*,0), 
	BRANCH VARCHAR2(100), 
	COMMENTS CLOB, 
	STATUS VARCHAR2(2), 
	RNK NUMBER, 
	EXTRACT_NUMBER_ID NUMBER, 
	EXT_STATUS NUMBER, 
	SIGNER VARCHAR2(32), 
	SIGNATURE CLOB, 
	SIGN_DATE TIMESTAMP (6), 
	RES_CODE VARCHAR2(50), 
	RES_DATE DATE, 
	RES_ID NUMBER, 
	COURTNAME VARCHAR2(1000), 
	ADDRESS VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (COMMENTS) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (SIGNATURE) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BILLS.CA_RECEIVERS IS 'Отримувачі, по яким регіони надсилали запити до ДКСУ';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.NAME IS 'ПІБ/Найменування отримувача';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.INN IS 'ІНН/ЄДРПО отримувача';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.DOC_NO IS 'Номер документа отримувача (для фізосіб)';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.DOC_DATE IS 'Дата документа отримувача (для фізосіб)';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.DOC_WHO IS 'Ким виданий документ отримувача (для фізосіб)';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.CL_TYPE IS 'Тип отримувача(юр, фіз)';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.CURRENCY IS 'Код валюти рішення';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.CUR_RATE IS 'зафіксований курс для запиту на виплату рішення ';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.AMOUNT IS 'Сума для виплати ';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.PHONE IS 'Контактний телефон отримувача';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.ACCOUNT IS 'Номер рахунка отримувача';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.REQ_ID IS 'Номер запиту (в ДКСУ)';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.COMMENTS IS 'Коментарі по запиту';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.STATUS IS 'Поточний статус запису';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.RNK IS 'RNK клієнта банку';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.EXTRACT_NUMBER_ID IS 'Зовнішній ІД витягу ДКСУ';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.EXT_STATUS IS 'Зовнішній статус запиту (в ДКСУ)';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.RES_ID IS '';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.COURTNAME IS '';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.ADDRESS IS '';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.KF IS 'МФО ';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.EXP_ID IS 'Ід очікуваного отримувача з ДКСУ';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.RES_CODE IS '';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.SIGNER IS 'ID ключа';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.SIGNATURE IS 'ЕЦП';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.SIGN_DATE IS 'Дата підпису';
COMMENT ON COLUMN BILLS.CA_RECEIVERS.RES_DATE IS '';




PROMPT *** Create  constraint XPK_CA_RECEIVERS ***
begin   
 execute immediate '
  ALTER TABLE BILLS.CA_RECEIVERS ADD CONSTRAINT XPK_CA_RECEIVERS PRIMARY KEY (KF, EXP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CA_RECEIVERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BILLS.XPK_CA_RECEIVERS ON BILLS.CA_RECEIVERS (KF, EXP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CA_RECEIVERS_EXTR_N ***
begin   
 execute immediate '
  CREATE INDEX BILLS.I_CA_RECEIVERS_EXTR_N ON BILLS.CA_RECEIVERS (EXTRACT_NUMBER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Table/CA_RECEIVERS.sql =========*** End ***
PROMPT ===================================================================================== 
