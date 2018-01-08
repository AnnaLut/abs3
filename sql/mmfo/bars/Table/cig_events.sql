

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_EVENTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_EVENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_EVENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_EVENTS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CIG_EVENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_EVENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_EVENTS 
   (	EVT_ID NUMBER(38,0), 
	EVT_DATE DATE, 
	EVT_UNAME NUMBER(38,0), 
	EVT_STATE_ID NUMBER(4,0), 
	EVT_MESSAGE VARCHAR2(4000), 
	EVT_ORAERR VARCHAR2(4000), 
	EVT_ND NUMBER(38,0), 
	EVT_RNK NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	EVT_DTYPE NUMBER, 
	EVT_CUSTTYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_EVENTS ***
 exec bpa.alter_policies('CIG_EVENTS');


COMMENT ON TABLE BARS.CIG_EVENTS IS 'Журнал событий модуля CIG';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_ID IS 'Код події';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_DATE IS 'Дата події';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_UNAME IS 'Код користувача';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_STATE_ID IS 'Тип події';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_MESSAGE IS 'Текст';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_ORAERR IS 'Текст системної помилки';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_ND IS 'Код кредитного договору';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_RNK IS '';
COMMENT ON COLUMN BARS.CIG_EVENTS.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_DTYPE IS '3-БПК, 4-овердрафт';
COMMENT ON COLUMN BARS.CIG_EVENTS.EVT_CUSTTYPE IS '2-ЮЛ, 3-ФЛ';




PROMPT *** Create  constraint PK_CIGEVENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_EVENTS ADD CONSTRAINT PK_CIGEVENTS PRIMARY KEY (EVT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGEVENTS_EVTMESSAGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_EVENTS MODIFY (EVT_MESSAGE CONSTRAINT CC_CIGEVENTS_EVTMESSAGE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGEVENTS_EVTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_EVENTS MODIFY (EVT_DATE CONSTRAINT CC_CIGEVENTS_EVTDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGEVENTS_EVTUNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_EVENTS MODIFY (EVT_UNAME CONSTRAINT CC_CIGEVENTS_EVTUNAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGEVENTS_EVTSTATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_EVENTS MODIFY (EVT_STATE_ID CONSTRAINT CC_CIGEVENTS_EVTSTATEID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGEVENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGEVENTS ON BARS.CIG_EVENTS (EVT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_EVENTS ***
grant SELECT                                                                 on CIG_EVENTS      to BARS_DM;
grant SELECT                                                                 on CIG_EVENTS      to CIG_LOADER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_EVENTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
