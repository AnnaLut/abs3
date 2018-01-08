

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/FILE_OUT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table FILE_OUT ***
begin 
  execute immediate '
  CREATE TABLE FINMON.FILE_OUT 
   (	ID VARCHAR2(15), 
	OUT_NAME VARCHAR2(12), 
	OUT_DATE DATE DEFAULT SYSDATE, 
	OUT_TIME VARCHAR2(4) DEFAULT ''0000'', 
	OUT_OPER_N NUMBER(6,0) DEFAULT 0, 
	OUT_ID VARCHAR2(6), 
	OUT_SIGN VARCHAR2(256), 
	IN_NAME VARCHAR2(12), 
	IN_DATE DATE, 
	IN_TIME VARCHAR2(4), 
	IN_OPER_N NUMBER(6,0), 
	IN_ID VARCHAR2(6), 
	IN_SIGN VARCHAR2(128), 
	ERR_CODE VARCHAR2(4), 
	STATUS NUMBER(1,0), 
	XML_FILE CLOB, 
	XML_RECEIPT CLOB, 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (XML_FILE) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (XML_RECEIPT) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.FILE_OUT IS 'Репозитарий исходящих файлов';
COMMENT ON COLUMN FINMON.FILE_OUT.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.FILE_OUT.ID IS 'Идентификатор записи';
COMMENT ON COLUMN FINMON.FILE_OUT.OUT_NAME IS 'Имя исходящего файла';
COMMENT ON COLUMN FINMON.FILE_OUT.OUT_DATE IS 'Дата создания YYYYMMDD';
COMMENT ON COLUMN FINMON.FILE_OUT.OUT_TIME IS 'Время создания HHMM';
COMMENT ON COLUMN FINMON.FILE_OUT.OUT_OPER_N IS 'Количество записей';
COMMENT ON COLUMN FINMON.FILE_OUT.OUT_ID IS 'Идентификатор ключа ЭЦП';
COMMENT ON COLUMN FINMON.FILE_OUT.OUT_SIGN IS 'ЭЦП';
COMMENT ON COLUMN FINMON.FILE_OUT.IN_NAME IS 'Имя квитанции';
COMMENT ON COLUMN FINMON.FILE_OUT.IN_DATE IS 'Дата создания квитанции';
COMMENT ON COLUMN FINMON.FILE_OUT.IN_TIME IS 'Время создания квитанции';
COMMENT ON COLUMN FINMON.FILE_OUT.IN_OPER_N IS 'Количество квитуемых записей';
COMMENT ON COLUMN FINMON.FILE_OUT.IN_ID IS 'Идентификатор ключка ЭЦП квитанции';
COMMENT ON COLUMN FINMON.FILE_OUT.IN_SIGN IS 'ЭЦП квитанции';
COMMENT ON COLUMN FINMON.FILE_OUT.ERR_CODE IS 'Код ошибки';
COMMENT ON COLUMN FINMON.FILE_OUT.STATUS IS 'Статус исходящего файла';
COMMENT ON COLUMN FINMON.FILE_OUT.XML_FILE IS 'XML файл';
COMMENT ON COLUMN FINMON.FILE_OUT.XML_RECEIPT IS 'XML ?????????';




PROMPT *** Create  constraint NK_FILEOUT_OUT_NAME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_OUT MODIFY (OUT_NAME CONSTRAINT NK_FILEOUT_OUT_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEOUT_OUT_DATE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_OUT MODIFY (OUT_DATE CONSTRAINT NK_FILEOUT_OUT_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEOUT_OUT_TIME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_OUT MODIFY (OUT_TIME CONSTRAINT NK_FILEOUT_OUT_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEOUT_OUT_N ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_OUT MODIFY (OUT_OPER_N CONSTRAINT NK_FILEOUT_OUT_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FILE_OUT ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_OUT ADD CONSTRAINT XPK_FILE_OUT PRIMARY KEY (ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FILE_OUT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_FILE_OUT ON FINMON.FILE_OUT (ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_FILE_OUT_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XAK_FILE_OUT_NAME ON FINMON.FILE_OUT (OUT_NAME, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FILE_OUT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FILE_OUT        to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/FILE_OUT.sql =========*** End *** ==
PROMPT ===================================================================================== 
