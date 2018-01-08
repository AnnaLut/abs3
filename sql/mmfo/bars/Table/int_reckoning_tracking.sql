

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_RECKONING_TRACKING.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_RECKONING_TRACKING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_RECKONING_TRACKING'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_RECKONING_TRACKING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT_RECKONING_TRACKING'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_RECKONING_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_RECKONING_TRACKING 
   (	ID NUMBER(38,0), 
	RECKONING_ID NUMBER(38,0), 
	STATE_ID NUMBER(5,0), 
	TRACKING_MESSAGE VARCHAR2(4000), 
	SYS_TIME DATE, 
	USER_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_RECKONING_TRACKING ***
 exec bpa.alter_policies('INT_RECKONING_TRACKING');


COMMENT ON TABLE BARS.INT_RECKONING_TRACKING IS 'Історія обробки розрахунків відсотків';
COMMENT ON COLUMN BARS.INT_RECKONING_TRACKING.ID IS 'Ідентифікатор запису про активність по розрахунку відсотків';
COMMENT ON COLUMN BARS.INT_RECKONING_TRACKING.RECKONING_ID IS 'Ідентифікатор розрахунку відсотків, по якому відбувалася активність';
COMMENT ON COLUMN BARS.INT_RECKONING_TRACKING.STATE_ID IS 'Стан розрахунку відсотків, отриманий ним після внесення змін';
COMMENT ON COLUMN BARS.INT_RECKONING_TRACKING.TRACKING_MESSAGE IS 'Текстовий коментар, що супроводжує внесення змін до розрахунку';
COMMENT ON COLUMN BARS.INT_RECKONING_TRACKING.SYS_TIME IS 'Системний час внесення змін';
COMMENT ON COLUMN BARS.INT_RECKONING_TRACKING.USER_ID IS 'Користувач, що виконував дії';




PROMPT *** Create  constraint SYS_C00132275 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132276 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING_TRACKING MODIFY (RECKONING_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132277 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING_TRACKING MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132278 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132279 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING_TRACKING MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INT_RECKONING_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING_TRACKING ADD CONSTRAINT PK_INT_RECKONING_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INT_RECKONING_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INT_RECKONING_TRACKING ON BARS.INT_RECKONING_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INT_RECKON_TRACK_RECKON_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_INT_RECKON_TRACK_RECKON_ID ON BARS.INT_RECKONING_TRACKING (RECKONING_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_RECKONING_TRACKING ***
grant SELECT                                                                 on INT_RECKONING_TRACKING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_RECKONING_TRACKING.sql =========**
PROMPT ===================================================================================== 
