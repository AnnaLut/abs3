

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/FILE_IN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table FILE_IN ***
begin 
  execute immediate '
  CREATE TABLE FINMON.FILE_IN 
   (	ID VARCHAR2(15), 
	IN_NAME VARCHAR2(12), 
	IN_DATE DATE, 
	IN_TIME VARCHAR2(4), 
	IN_OPER_N NUMBER(6,0), 
	IN_ID VARCHAR2(6), 
	IN_SIGN VARCHAR2(128), 
	STATUS NUMBER(1,0), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.FILE_IN IS 'Репозитарий входящих файлов (запросов)';
COMMENT ON COLUMN FINMON.FILE_IN.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.FILE_IN.ID IS 'Идентификатор записи';
COMMENT ON COLUMN FINMON.FILE_IN.IN_NAME IS 'Имя входящего файла';
COMMENT ON COLUMN FINMON.FILE_IN.IN_DATE IS 'Дата создания';
COMMENT ON COLUMN FINMON.FILE_IN.IN_TIME IS 'Время создания';
COMMENT ON COLUMN FINMON.FILE_IN.IN_OPER_N IS 'Количество записей';
COMMENT ON COLUMN FINMON.FILE_IN.IN_ID IS 'Идентификатор ключка ЭЦП';
COMMENT ON COLUMN FINMON.FILE_IN.IN_SIGN IS 'ЭЦП';
COMMENT ON COLUMN FINMON.FILE_IN.STATUS IS 'Статус входящего файла';




PROMPT *** Create  constraint XPK_FILE_IN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_IN ADD CONSTRAINT XPK_FILE_IN PRIMARY KEY (ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSIMPDATA300465  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEIN_IN_NAME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_IN MODIFY (IN_NAME CONSTRAINT NK_FILEIN_IN_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEIN_IN_DATE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_IN MODIFY (IN_DATE CONSTRAINT NK_FILEIN_IN_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEIN_IN_TIME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_IN MODIFY (IN_TIME CONSTRAINT NK_FILEIN_IN_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEIN_IN_N ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_IN MODIFY (IN_OPER_N CONSTRAINT NK_FILEIN_IN_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FILEIN_STATUS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_IN MODIFY (STATUS CONSTRAINT NK_FILEIN_STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_FILE_IN_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XAK_FILE_IN_NAME ON FINMON.FILE_IN (IN_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FILE_IN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_FILE_IN ON FINMON.FILE_IN (ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSIMPDATA300465 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FILE_IN ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FILE_IN         to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/FILE_IN.sql =========*** End *** ===
PROMPT ===================================================================================== 
