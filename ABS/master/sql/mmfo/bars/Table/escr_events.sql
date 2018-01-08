

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_EVENTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_EVENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_EVENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_EVENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_EVENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_EVENTS 
   (	ID NUMBER, 
	NAME VARCHAR2(4000), 
	EVENT_TYPE NUMBER(3,0), 
	DATE_FROM DATE, 
	DATE_TO DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_EVENTS ***
 exec bpa.alter_policies('ESCR_EVENTS');


COMMENT ON TABLE BARS.ESCR_EVENTS IS 'Список енергоефективних заходів';
COMMENT ON COLUMN BARS.ESCR_EVENTS.ID IS 'Номер з/п';
COMMENT ON COLUMN BARS.ESCR_EVENTS.NAME IS 'Повне найменування енергоефективного заходу';
COMMENT ON COLUMN BARS.ESCR_EVENTS.EVENT_TYPE IS 'Тип енергоефективного заходу (1-матеріали,2-котли,999-технічна)';
COMMENT ON COLUMN BARS.ESCR_EVENTS.DATE_FROM IS 'Дата з якої дії даний енергоефективний захід';
COMMENT ON COLUMN BARS.ESCR_EVENTS.DATE_TO IS 'Дата закінчення дії енергоефективного заходу';




PROMPT *** Create  constraint SYS_C00118517 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_EVENTS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118518 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_EVENTS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118519 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_EVENTS MODIFY (EVENT_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118520 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_EVENTS MODIFY (DATE_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EV_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_EVENTS ADD CONSTRAINT PK_EV_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EV_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EV_ID ON BARS.ESCR_EVENTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_EVENTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_EVENTS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_EVENTS.sql =========*** End *** =
PROMPT ===================================================================================== 
