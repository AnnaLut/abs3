

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/METALOOKUP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table METALOOKUP ***
begin 
  execute immediate '
  CREATE TABLE FINMON.METALOOKUP 
   (	TABNAME VARCHAR2(30), 
	COLNAME VARCHAR2(30), 
	LOOKUP_TAB VARCHAR2(30), 
	LOOKUP_COL VARCHAR2(256), 
	LINKING_COL VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.METALOOKUP IS 'Метаописание lookup связей';
COMMENT ON COLUMN FINMON.METALOOKUP.TABNAME IS 'Имя таблицы';
COMMENT ON COLUMN FINMON.METALOOKUP.COLNAME IS 'Имя колонки';
COMMENT ON COLUMN FINMON.METALOOKUP.LOOKUP_TAB IS 'Таблица справочник';
COMMENT ON COLUMN FINMON.METALOOKUP.LOOKUP_COL IS 'Колонка семантика';
COMMENT ON COLUMN FINMON.METALOOKUP.LINKING_COL IS 'Связная колонка справочника';




PROMPT *** Create  constraint XPK_METALOOKUP ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METALOOKUP ADD CONSTRAINT XPK_METALOOKUP PRIMARY KEY (TABNAME, COLNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METALKUP_TAB ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METALOOKUP MODIFY (LOOKUP_TAB CONSTRAINT NK_METALKUP_TAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METALKUP_COL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METALOOKUP MODIFY (LOOKUP_COL CONSTRAINT NK_METALKUP_COL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_METALKUP_LCOL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METALOOKUP MODIFY (LINKING_COL CONSTRAINT NK_METALKUP_LCOL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_METALOOKUP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_METALOOKUP ON FINMON.METALOOKUP (TABNAME, COLNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/METALOOKUP.sql =========*** End *** 
PROMPT ===================================================================================== 
