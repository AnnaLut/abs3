

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_EVENT_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_EVENT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_EVENT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_EVENT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_EVENT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_EVENT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_EVENT_TYPES 
   (	EVENT_ID NUMBER(4,0), 
	EVENT_NAME VARCHAR2(32), 
	EVENT_DESCR VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_EVENT_TYPES ***
 exec bpa.alter_policies('GRT_EVENT_TYPES');


COMMENT ON TABLE BARS.GRT_EVENT_TYPES IS 'Таблица типов событий при обслуживании договоров залога';
COMMENT ON COLUMN BARS.GRT_EVENT_TYPES.EVENT_ID IS 'Идетнификатор события';
COMMENT ON COLUMN BARS.GRT_EVENT_TYPES.EVENT_NAME IS 'Наименование события';
COMMENT ON COLUMN BARS.GRT_EVENT_TYPES.EVENT_DESCR IS 'Описание события';




PROMPT *** Create  constraint PK_GRTEVTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENT_TYPES ADD CONSTRAINT PK_GRTEVTTYPES PRIMARY KEY (EVENT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTEVTTYPES_EVTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENT_TYPES MODIFY (EVENT_NAME CONSTRAINT CC_GRTEVTTYPES_EVTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTEVTTYPES_EVTDESCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENT_TYPES MODIFY (EVENT_DESCR CONSTRAINT CC_GRTEVTTYPES_EVTDESCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTEVTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTEVTTYPES ON BARS.GRT_EVENT_TYPES (EVENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_EVENT_TYPES ***
grant SELECT                                                                 on GRT_EVENT_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_EVENT_TYPES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_EVENT_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
