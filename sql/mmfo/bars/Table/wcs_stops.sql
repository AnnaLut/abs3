

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_STOPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_STOPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_STOPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_STOPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_STOPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_STOPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_STOPS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	RESULT_QID VARCHAR2(100), 
	PLSQL VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_STOPS ***
 exec bpa.alter_policies('WCS_STOPS');


COMMENT ON TABLE BARS.WCS_STOPS IS 'Стопы';
COMMENT ON COLUMN BARS.WCS_STOPS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_STOPS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_STOPS.TYPE_ID IS 'Тип';
COMMENT ON COLUMN BARS.WCS_STOPS.RESULT_QID IS 'Идентификатор вопроса-результата выполнения';
COMMENT ON COLUMN BARS.WCS_STOPS.PLSQL IS 'plsql блок описывающий стоп фактор';




PROMPT *** Create  constraint PK_STOPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS ADD CONSTRAINT PK_STOPS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOPS_TID_STOPTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS ADD CONSTRAINT FK_STOPS_TID_STOPTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_STOP_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOPS_RQID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS ADD CONSTRAINT FK_STOPS_RQID_QUEST_ID FOREIGN KEY (RESULT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS MODIFY (NAME CONSTRAINT CC_STOPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOPS_RESULTQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS MODIFY (RESULT_QID CONSTRAINT CC_STOPS_RESULTQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOPS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS MODIFY (TYPE_ID CONSTRAINT CC_STOPS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STOPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STOPS ON BARS.WCS_STOPS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_STOPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_STOPS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_STOPS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_STOPS       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_STOPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
