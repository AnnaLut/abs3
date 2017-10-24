

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_PREFUN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_PREFUN ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_PREFUN 
   (	PREFUN VARCHAR2(30), 
	FUN_CODE CLOB, 
	DESCRIPTION VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD 
 LOB (FUN_CODE) STORE AS BASICFILE (
  TABLESPACE BRSUPLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_PREFUN IS 'Список таблиц, подлежащих разбивке по версиям';
COMMENT ON COLUMN BARSUPL.UPL_PREFUN.PREFUN IS 'Код прдопределенной функции';
COMMENT ON COLUMN BARSUPL.UPL_PREFUN.FUN_CODE IS 'Текст функции';
COMMENT ON COLUMN BARSUPL.UPL_PREFUN.DESCRIPTION IS 'Описание';




PROMPT *** Create  constraint PK_TABLELIST ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_PREFUN ADD CONSTRAINT PK_TABLELIST PRIMARY KEY (PREFUN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TABLELIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_TABLELIST ON BARSUPL.UPL_PREFUN (PREFUN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_PREFUN.sql =========*** End ***
PROMPT ===================================================================================== 
