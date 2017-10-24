

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IOT_CALENDAR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IOT_CALENDAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IOT_CALENDAR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''IOT_CALENDAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IOT_CALENDAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.IOT_CALENDAR 
   (	CDAT DATE, 
	 CONSTRAINT PK_IOTCALENDAR PRIMARY KEY (CDAT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IOT_CALENDAR ***
 exec bpa.alter_policies('IOT_CALENDAR');


COMMENT ON TABLE BARS.IOT_CALENDAR IS '';
COMMENT ON COLUMN BARS.IOT_CALENDAR.CDAT IS '';




PROMPT *** Create  constraint PK_IOTCALENDAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.IOT_CALENDAR ADD CONSTRAINT PK_IOTCALENDAR PRIMARY KEY (CDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IOTCALENDAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_IOTCALENDAR ON BARS.IOT_CALENDAR (CDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IOT_CALENDAR.sql =========*** End *** 
PROMPT ===================================================================================== 
