

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/METAAUTOID.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table METAAUTOID ***
begin 
  execute immediate '
  CREATE TABLE FINMON.METAAUTOID 
   (	TABNAME VARCHAR2(30), 
	COLNAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.METAAUTOID IS 'Метаописание сортировок';
COMMENT ON COLUMN FINMON.METAAUTOID.TABNAME IS 'Имя таблицы';
COMMENT ON COLUMN FINMON.METAAUTOID.COLNAME IS 'Имя колонки';




PROMPT *** Create  constraint R_METAAUTOID_COLS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METAAUTOID ADD CONSTRAINT R_METAAUTOID_COLS FOREIGN KEY (TABNAME, COLNAME)
	  REFERENCES FINMON.METACOLS (TABNAME, COLNAME) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_METAAUTOID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.METAAUTOID ADD CONSTRAINT XPK_METAAUTOID PRIMARY KEY (TABNAME, COLNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_METAAUTOID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_METAAUTOID ON FINMON.METAAUTOID (TABNAME, COLNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/METAAUTOID.sql =========*** End *** 
PROMPT ===================================================================================== 
