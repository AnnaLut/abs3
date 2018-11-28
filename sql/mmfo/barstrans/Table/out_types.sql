

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/OUT_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table OUT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.OUT_TYPES 
   (ID NUMBER,
    TYPE_NAME VARCHAR2(50), 
	TYPE_DESC VARCHAR2(255), 
	SESS_TYPE VARCHAR2(10), 
	WEB_METHOD VARCHAR2(10), 
	HTTP_METHOD VARCHAR2(10), 
	OUTPUT_DATA_TYPE VARCHAR2(20), 
	INPUT_DATA_TYPE VARCHAR2(20), 
	CONT_TYPE NUMBER, 
	IS_PARALLEL NUMBER(1,0), 
	SEND_TYPE VARCHAR2(50), 
	URI_GROUP VARCHAR2(50), 
	URI_SUF VARCHAR2(255), 
	PRIORITY NUMBER(2,0), 
	DONE_ACCTION VARCHAR2(255), 
	MAIN_TIMEOUT NUMBER, 
	SEND_TRYS NUMBER(2,0), 
	SEND_PAUSE NUMBER(3,0), 
	CHK_PAUSE NUMBER(3,0), 
	XML2JSON NUMBER(1,0), 
	JSON2XML NUMBER(1,0), 
	COMPRESS_TYPE VARCHAR2(10), 
	INPUT_DECOMPRESS NUMBER(1,0), 
	OUTPUT_COMPRESS NUMBER(1,0), 
	INPUT_BASE_64 NUMBER(1,0), 
	OUTPUT_BASE_64 NUMBER(1,0), 
	CHECK_SUM VARCHAR2(10), 
	STORE_HEAD NUMBER(1,0), 
	ACC_CONT_TYPE NUMBER, 
	LOGING NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.OUT_TYPES IS 'Типи вихідних запипів';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.ID IS 'ID';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.TYPE_NAME IS 'Назва типу відправки';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.TYPE_DESC IS 'Опис типу відправки';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.SESS_TYPE IS 'Тип сесії СИНХРОННО/АСИНХРОННО';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.WEB_METHOD IS 'Метод відправки 1-WebApi 2-SOAP(На даний час не реалізовано)';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.HTTP_METHOD IS 'Тип HTTP запиту (post, get, put)';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.OUTPUT_DATA_TYPE IS 'Тип даних(clob, blob) запиту';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.INPUT_DATA_TYPE IS 'Тип даних(clob, blob) відповіді';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.CONT_TYPE IS 'content-type запиту';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.IS_PARALLEL IS 'Виконувати паралельно 0-ні, 1-так, 2-XX кількість сесій';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.SEND_TYPE IS 'Тип відправки (group - розсилка на групу, single - один адресат)';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.URI_GROUP IS 'ІД групи адресатів';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.URI_SUF IS 'Шлях до сервісу';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.PRIORITY IS 'Пріорітет 1 - ONLINE, 2.. - черга';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.DONE_ACCTION IS 'Процедура після виконання.';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.MAIN_TIMEOUT IS 'Таймаут запиту з підзапитами';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.SEND_TRYS IS 'Кількість спроб відправки основного запиту';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.SEND_PAUSE IS 'Проміжок часу між запитам';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.CHK_PAUSE IS 'Проміжок між запитами';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.XML2JSON IS 'Конвертація запиту xml в json';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.JSON2XML IS 'Конвертація відповіді json в xml';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.COMPRESS_TYPE IS 'Тип архівації (ZIP, GZIP) на даний час реалізовано GZIP';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.INPUT_DECOMPRESS IS 'Признак розархівації даних відповіді';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.OUTPUT_COMPRESS IS 'Признак архівації даних запиту';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.INPUT_BASE_64 IS 'Конвертація відповіді з base_64';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.OUTPUT_BASE_64 IS 'Конвертація запиту в base_64';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.CHECK_SUM IS 'Тип генерація контрольної суми(Не реалізовано)';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.STORE_HEAD IS 'Зберігати вміст заголовку запиту';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.ACC_CONT_TYPE IS 'content-type, який очікується в відповіді';
COMMENT ON COLUMN BARSTRANS.OUT_TYPES.LOGING IS '1-видаляти розгорнуті логи';




PROMPT *** Create  constraint PK_OUT_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT PK_OUT_TYPES PRIMARY KEY (TYPE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint UK_OUT_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT UK_OUT_TYPES UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_OUT_DATA_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_OUT_DATA_TYPE CHECK (output_data_type in (''CLOB'',''BLOB'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_TYPE_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_TYPE_NAME CHECK (type_name = upper(type_name)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_IN_DATA_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_IN_DATA_TYPE CHECK (input_data_type in (''CLOB'',''BLOB'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_SESS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_SESS_TYPE CHECK (sess_type in (''SYNCH'',''ASYNCH'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_WEBMETHOD ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_WEBMETHOD CHECK (web_method in (''WEBAPI'',''SOAP'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_HTTP_MET ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_HTTP_MET CHECK (http_method in (''POST'',''GET'',''PUT'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_SEND_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_SEND_TYPE CHECK (send_type in (''GROUP'',''SINGLE'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_COMPRESS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_COMPRESS CHECK (compress_type in (''GZIP'',''ZIP'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_TO_JSON ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_TO_JSON CHECK (xml2json in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_STORE_H ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_STORE_H CHECK (store_head in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_OUT_TYPES_LOGING ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT CHK_OUT_TYPES_LOGING CHECK (loging in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OUT_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_OUT_TYPES ON BARSTRANS.OUT_TYPES (TYPE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index UK_OUT_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.UK_OUT_TYPES ON BARSTRANS.OUT_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OUT_TYPES ***
grant SELECT                                                                 on OUT_TYPES       to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/OUT_TYPES.sql =========*** End **
PROMPT ===================================================================================== 

