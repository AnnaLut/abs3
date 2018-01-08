

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_CHANGED_TABLES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_CHANGED_TABLES ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_CHANGED_TABLES 
   (	TABLE_NAME VARCHAR2(30)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_CHANGED_TABLES IS 'Список измененных таблиц';
COMMENT ON COLUMN BARSAQ.TMP_CHANGED_TABLES.TABLE_NAME IS 'Имя таблицы';




PROMPT *** Create  constraint PK_TMPCHANGEDTABLES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_CHANGED_TABLES ADD CONSTRAINT PK_TMPCHANGEDTABLES PRIMARY KEY (TABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPCHANGEDTABLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_TMPCHANGEDTABLES ON BARSAQ.TMP_CHANGED_TABLES (TABLE_NAME) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CHANGED_TABLES ***
grant SELECT                                                                 on TMP_CHANGED_TABLES to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_CHANGED_TABLES.sql =========*** 
PROMPT ===================================================================================== 
