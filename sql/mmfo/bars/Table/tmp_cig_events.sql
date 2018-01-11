

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CIG_EVENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CIG_EVENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CIG_EVENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CIG_EVENTS 
   (	EVT_ID NUMBER(38,0), 
	EVT_DATE DATE, 
	EVT_UNAME NUMBER(38,0), 
	EVT_STATE_ID NUMBER(4,0), 
	EVT_MESSAGE VARCHAR2(4000), 
	EVT_ORAERR VARCHAR2(4000), 
	EVT_ND NUMBER(38,0), 
	EVT_RNK NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
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




PROMPT *** ALTER_POLICIES to TMP_CIG_EVENTS ***
 exec bpa.alter_policies('TMP_CIG_EVENTS');


COMMENT ON TABLE BARS.TMP_CIG_EVENTS IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_DATE IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_UNAME IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_STATE_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_MESSAGE IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_ORAERR IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_ND IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_RNK IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_DTYPE IS '';
COMMENT ON COLUMN BARS.TMP_CIG_EVENTS.EVT_CUSTTYPE IS '';




PROMPT *** Create  constraint SYS_C0033496 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_EVENTS MODIFY (EVT_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033497 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_EVENTS MODIFY (EVT_UNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033498 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_EVENTS MODIFY (EVT_STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033499 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_EVENTS MODIFY (EVT_MESSAGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CIG_EVENTS ***
grant SELECT                                                                 on TMP_CIG_EVENTS  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CIG_EVENTS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CIG_EVENTS.sql =========*** End **
PROMPT ===================================================================================== 
