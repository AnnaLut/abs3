

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/METASORT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table METASORT ***
begin 
  execute immediate '
  CREATE TABLE FINMON.METASORT 
   (	TABNAME VARCHAR2(30), 
	COLNAME VARCHAR2(30), 
	SORTTYPE VARCHAR2(4) DEFAULT ''ASC'', 
	SORTPOS NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.METASORT IS 'Метаописание сортировок';
COMMENT ON COLUMN FINMON.METASORT.TABNAME IS 'Имя таблицы';
COMMENT ON COLUMN FINMON.METASORT.COLNAME IS 'Имя колонки';
COMMENT ON COLUMN FINMON.METASORT.SORTTYPE IS 'Тип сортировки (ASC/DESC)';
COMMENT ON COLUMN FINMON.METASORT.SORTPOS IS 'Порядок в сортировке';




PROMPT *** Create  constraint XPK_METASORT ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METASORT ADD CONSTRAINT XPK_METASORT PRIMARY KEY (TABNAME, COLNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_METASORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_METASORT ON FINMON.METASORT (TABNAME, COLNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  METASORT ***
grant SELECT                                                                 on METASORT        to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/METASORT.sql =========*** End *** ==
PROMPT ===================================================================================== 
