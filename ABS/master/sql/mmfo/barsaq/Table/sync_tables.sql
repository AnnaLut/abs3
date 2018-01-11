

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/SYNC_TABLES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table SYNC_TABLES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.SYNC_TABLES 
   (	TABLE_NAME VARCHAR2(128), 
	SYNC_SQL VARCHAR2(512), 
	PARAMETER_NAME VARCHAR2(128), 
	SYNC_DATE DATE, 
	 CONSTRAINT PK_SYNCTABLES PRIMARY KEY (TABLE_NAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.SYNC_TABLES IS 'Список таблиць для синхронізації з інтернет банкінгом';
COMMENT ON COLUMN BARSAQ.SYNC_TABLES.TABLE_NAME IS 'Назва таблиці';
COMMENT ON COLUMN BARSAQ.SYNC_TABLES.SYNC_SQL IS 'Повний виклик процедури синхронізації включаючи параметр (якщо є)';
COMMENT ON COLUMN BARSAQ.SYNC_TABLES.PARAMETER_NAME IS 'Найменування параметру (null - якщо відсутній)';
COMMENT ON COLUMN BARSAQ.SYNC_TABLES.SYNC_DATE IS '';




PROMPT *** Create  constraint CC_SYNCTABLES_TABLENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_TABLES MODIFY (TABLE_NAME CONSTRAINT CC_SYNCTABLES_TABLENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SYNCTABLES_SYNCSQL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_TABLES MODIFY (SYNC_SQL CONSTRAINT CC_SYNCTABLES_SYNCSQL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SYNCTABLES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.SYNC_TABLES ADD CONSTRAINT PK_SYNCTABLES PRIMARY KEY (TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SYNCTABLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_SYNCTABLES ON BARSAQ.SYNC_TABLES (TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SYNC_TABLES ***
grant SELECT                                                                 on SYNC_TABLES     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/SYNC_TABLES.sql =========*** End ***
PROMPT ===================================================================================== 
