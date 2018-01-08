

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_DETAIL_TABLES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_DETAIL_TABLES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_DETAIL_TABLES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DETAIL_TABLES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DETAIL_TABLES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_DETAIL_TABLES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_DETAIL_TABLES 
   (	TABLE_ID NUMBER(3,0), 
	TABLE_NAME VARCHAR2(32), 
	TABLE_DESC VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_DETAIL_TABLES ***
 exec bpa.alter_policies('GRT_DETAIL_TABLES');


COMMENT ON TABLE BARS.GRT_DETAIL_TABLES IS 'Справочник таблиц, в которых представлены спец реквизиты залога';
COMMENT ON COLUMN BARS.GRT_DETAIL_TABLES.TABLE_ID IS 'Идентификатор таблицы';
COMMENT ON COLUMN BARS.GRT_DETAIL_TABLES.TABLE_NAME IS 'Наименования теблицы';
COMMENT ON COLUMN BARS.GRT_DETAIL_TABLES.TABLE_DESC IS 'Описание таблицы';




PROMPT *** Create  constraint PK_GRTDETAILTABS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DETAIL_TABLES ADD CONSTRAINT PK_GRTDETAILTABS PRIMARY KEY (TABLE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDETAILTABS_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DETAIL_TABLES MODIFY (TABLE_NAME CONSTRAINT CC_GRTDETAILTABS_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDETAILTABS_TABDESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DETAIL_TABLES MODIFY (TABLE_DESC CONSTRAINT CC_GRTDETAILTABS_TABDESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTDETAILTABS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTDETAILTABS ON BARS.GRT_DETAIL_TABLES (TABLE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_DETAIL_TABLES ***
grant SELECT                                                                 on GRT_DETAIL_TABLES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_DETAIL_TABLES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_DETAIL_TABLES.sql =========*** End
PROMPT ===================================================================================== 
