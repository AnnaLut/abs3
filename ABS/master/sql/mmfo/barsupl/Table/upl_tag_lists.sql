

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_LISTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_TAG_LISTS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_TAG_LISTS 
   (	TAG_TABLE VARCHAR2(20), 
	TAG VARCHAR2(20), 
	ISUSE NUMBER(1,0), 
	REF_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_TAG_LISTS IS 'Перечеь аттрибутов для таблиц которые нужно добавлять или недобавлять в выгрузку';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.TAG_TABLE IS 'Кодовое наименование таблицы параметров';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.TAG IS 'Параметр';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.ISUSE IS '1-используется для выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_TAG_LISTS.REF_ID IS 'ID справочника';




PROMPT *** Create  constraint PK_UPLTAGLISTS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_TAG_LISTS ADD CONSTRAINT PK_UPLTAGLISTS PRIMARY KEY (TAG_TABLE, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLTAGLISTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLTAGLISTS ON BARSUPL.UPL_TAG_LISTS (TAG_TABLE, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_TAG_LISTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_LISTS   to BARS;
grant SELECT                                                                 on UPL_TAG_LISTS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_LISTS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_LISTS.sql =========*** End 
PROMPT ===================================================================================== 
