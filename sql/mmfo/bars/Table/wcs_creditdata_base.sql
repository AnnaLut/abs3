

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_CREDITDATA_BASE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_CREDITDATA_BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_CREDITDATA_BASE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_CREDITDATA_BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_CREDITDATA_BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_CREDITDATA_BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_CREDITDATA_BASE 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	STATE_ID VARCHAR2(100), 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_CREDITDATA_BASE ***
 exec bpa.alter_policies('WCS_CREDITDATA_BASE');


COMMENT ON TABLE BARS.WCS_CREDITDATA_BASE IS 'Базовые параметры данных кредита';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.TYPE_ID IS 'Тип';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.STATE_ID IS 'Этап ввода';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.ORD IS 'Порядок отображения';




PROMPT *** Create  constraint PK_WCSCRDDATABASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE ADD CONSTRAINT PK_WCSCRDDATABASE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSCRDDATABASE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE MODIFY (NAME CONSTRAINT CC_WCSCRDDATABASE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSCRDDATABASE_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE MODIFY (TYPE_ID CONSTRAINT CC_WCSCRDDATABASE_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSCRDDATABASE_STID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE MODIFY (STATE_ID CONSTRAINT CC_WCSCRDDATABASE_STID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSCRDDATABASE_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE MODIFY (ORD CONSTRAINT CC_WCSCRDDATABASE_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSCRDDATABASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSCRDDATABASE ON BARS.WCS_CREDITDATA_BASE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_CREDITDATA_BASE ***
grant SELECT                                                                 on WCS_CREDITDATA_BASE to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_CREDITDATA_BASE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_CREDITDATA_BASE to BARS_DM;
grant SELECT                                                                 on WCS_CREDITDATA_BASE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_CREDITDATA_BASE.sql =========*** E
PROMPT ===================================================================================== 
