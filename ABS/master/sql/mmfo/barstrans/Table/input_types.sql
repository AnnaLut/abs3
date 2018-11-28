PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table INPUT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.INPUT_TYPES 
   (ID NUMBER,
    TYPE_NAME VARCHAR2(50), 
	TYPE_DESC VARCHAR2(255), 
	SESS_TYPE VARCHAR2(10), 
	ACT_TYPE VARCHAR2(255), 
	OUTPUT_DATA_TYPE VARCHAR2(20), 
	INPUT_DATA_TYPE VARCHAR2(20), 
	PRIORITY NUMBER(2,0), 
	CONT_TYPE NUMBER, 
	JSON2XML NUMBER(1,0), 
	XML2JSON NUMBER(1,0), 
	COMPRESS_TYPE VARCHAR2(10), 
	INPUT_DECOMPRESS NUMBER(1,0), 
	OUTPUT_COMPRESS NUMBER(1,0), 
	INPUT_BASE_64 NUMBER(1,0), 
	OUTPUT_BASE_64 NUMBER(1,0), 
	STORE_HEAD NUMBER(1,0), 
	ADD_HEAD NUMBER(1,0), 
	CHECK_SUM VARCHAR2(10), 
	LOGING NUMBER,
	EXEC_TIMEOUT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
execute immediate'alter table INPUT_TYPES add EXEC_TIMEOUT NUMBER';
exception when others then
if sqlcode = -01430 then null; else raise; end if;
end;
/


COMMENT ON TABLE BARSTRANS.INPUT_TYPES IS 'Типи вхідних запипів';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.ID IS 'ID';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.TYPE_NAME IS 'Назва типу';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.TYPE_DESC IS 'Опис типу';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.SESS_TYPE IS 'Тип сесії СИНХРОННО/АСИНХРОННО';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.ACT_TYPE IS 'Процедура для обробки запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.OUTPUT_DATA_TYPE IS 'Тип даних(clob, blob) відповіді';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.INPUT_DATA_TYPE IS 'Тип даних(clob, blob) запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.PRIORITY IS 'Пріорітет';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.CONT_TYPE IS 'content-type запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.JSON2XML IS 'Конвертація відповіді json в xml';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.XML2JSON IS 'Конвертація запиту xml в json';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.COMPRESS_TYPE IS 'Тип архівації (ZIP, GZIP) на даний час реалізовано GZIP';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.INPUT_DECOMPRESS IS 'Признак розархівації даних відповіді';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.OUTPUT_COMPRESS IS 'Признак архівації даних запиту';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.INPUT_BASE_64 IS 'Конвертація відповіді з base_64';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.OUTPUT_BASE_64 IS 'Конвертація запиту в base_64';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.STORE_HEAD IS 'Зберігати вміст заголовку відповіді';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.ADD_HEAD IS 'Додавати заголовки в запит';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.CHECK_SUM IS 'Тип генерація контрольної суми(Не реалізовано)';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.LOGING IS '1-видаляти розгорнуті логи';
COMMENT ON COLUMN BARSTRANS.INPUT_TYPES.EXEC_TIMEOUT IS 'Проміжок часу в секундах більше хвилино після якого зупиняється процес обробки запиту з пріорітетом 1';




PROMPT *** Create  constraint PK_INPUT_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT PK_INPUT_TYPES PRIMARY KEY (TYPE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint UK_INPUT_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT UK_INPUT_TYPES UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_TYPE_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_TYPE_NAME CHECK (type_name = upper(type_name)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_OUT_DATA_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_OUT_DATA_TYPE CHECK (output_data_type in (''CLOB'',''BLOB'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_IN_DATA_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_IN_DATA_TYPE CHECK (input_data_type in (''CLOB'',''BLOB'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_SESS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_SESS_TYPE CHECK (sess_type in (''SYNCH'',''ASYNCH'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_COMPRESS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_COMPRESS CHECK (compress_type in (''GZIP'',''ZIP'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_TO_JSON ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_TO_JSON CHECK (xml2json in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_IN_BASE_64 ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_IN_BASE_64 CHECK (input_base_64 in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_OUT_BASE_64 ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_OUT_BASE_64 CHECK (output_base_64 in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_DEL_LOGS ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_DEL_LOGS CHECK (loging in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_INPUT_TYPES_STORE_H ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT CHK_INPUT_TYPES_STORE_H CHECK (store_head in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INPUT_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_INPUT_TYPES ON BARSTRANS.INPUT_TYPES (TYPE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index UK_INPUT_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.UK_INPUT_TYPES ON BARSTRANS.INPUT_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_TYPES.sql =========*** End 
PROMPT ===================================================================================== 