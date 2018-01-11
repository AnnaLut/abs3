

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_EVENTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_EVENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_EVENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_EVENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_EVENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_EVENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_EVENTS 
   (	ID NUMBER(38,0), 
	DEAL_ID NUMBER(31,0), 
	TYPE_ID NUMBER(4,0), 
	PLANNED_DATE DATE, 
	ACTUAL_DATE DATE, 
	COMMENT_TEXT VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_EVENTS ***
 exec bpa.alter_policies('GRT_EVENTS');


COMMENT ON TABLE BARS.GRT_EVENTS IS 'Таблица типов событий при обслуживании договоров залога';
COMMENT ON COLUMN BARS.GRT_EVENTS.ID IS 'Идетнификатор события';
COMMENT ON COLUMN BARS.GRT_EVENTS.DEAL_ID IS '';
COMMENT ON COLUMN BARS.GRT_EVENTS.TYPE_ID IS 'Наименование события';
COMMENT ON COLUMN BARS.GRT_EVENTS.PLANNED_DATE IS 'Плановая дата наступления события';
COMMENT ON COLUMN BARS.GRT_EVENTS.ACTUAL_DATE IS 'Фактическая дата наступления события';
COMMENT ON COLUMN BARS.GRT_EVENTS.COMMENT_TEXT IS 'Отметка пользователя';




PROMPT *** Create  constraint PK_GRTEVENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENTS ADD CONSTRAINT PK_GRTEVENTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTEVENTS_DEALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENTS MODIFY (DEAL_ID CONSTRAINT CC_GRTEVENTS_DEALID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTEVENTS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENTS MODIFY (TYPE_ID CONSTRAINT CC_GRTEVENTS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTEVENTS_PLANNEDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENTS MODIFY (PLANNED_DATE CONSTRAINT CC_GRTEVENTS_PLANNEDDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTEVENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTEVENTS ON BARS.GRT_EVENTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_EVENTS ***
grant SELECT                                                                 on GRT_EVENTS      to BARSREADER_ROLE;
grant SELECT                                                                 on GRT_EVENTS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_EVENTS      to BARS_DM;
grant SELECT                                                                 on GRT_EVENTS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_EVENTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
