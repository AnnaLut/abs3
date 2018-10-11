

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/IMPORT_ACTIVITY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table IMPORT_ACTIVITY ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.IMPORT_ACTIVITY 
   (	START_TIME DATE, 
	WORKING_PERIOD NUMBER, 
	START_SCN NUMBER, 
	FINISH_SCN NUMBER, 
	SYSTEM_ERROR VARCHAR2(4000), 
	EMAIL_SENT VARCHAR2(1), 
	DOCS_COUNT NUMBER,
    KF varchar2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.IMPORT_ACTIVITY IS 'Активність імпорту документів';
COMMENT ON COLUMN BARSAQ.IMPORT_ACTIVITY.START_TIME IS 'Час початку виконання імпорту';
COMMENT ON COLUMN BARSAQ.IMPORT_ACTIVITY.WORKING_PERIOD IS 'Тривалість виконання імпорту в секундах';
COMMENT ON COLUMN BARSAQ.IMPORT_ACTIVITY.START_SCN IS 'SCN початку виконання імпорту';
COMMENT ON COLUMN BARSAQ.IMPORT_ACTIVITY.FINISH_SCN IS 'SCN закінчення виконання імпорту';
COMMENT ON COLUMN BARSAQ.IMPORT_ACTIVITY.SYSTEM_ERROR IS '';
COMMENT ON COLUMN BARSAQ.IMPORT_ACTIVITY.EMAIL_SENT IS '';
COMMENT ON COLUMN BARSAQ.IMPORT_ACTIVITY.DOCS_COUNT IS '';




PROMPT *** Create  constraint CC_IMPORTACTIVITY_EMAILSENT_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IMPORT_ACTIVITY ADD CONSTRAINT CC_IMPORTACTIVITY_EMAILSENT_CC CHECK (email_sent=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_IMPACT ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IMPORT_ACTIVITY ADD CONSTRAINT PK_IMPACT PRIMARY KEY (START_TIME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IMPACT_STARTTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IMPORT_ACTIVITY MODIFY (START_TIME CONSTRAINT CC_IMPACT_STARTTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IMPACT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_IMPACT ON BARSAQ.IMPORT_ACTIVITY (START_TIME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin   
 execute immediate '
   alter table BARSAQ.IMPORT_ACTIVITY add kf VARCHAR2(6)';
exception when others then
  if  sqlcode=-1430  then null; else raise; end if;
 end;
/


begin   
 execute immediate 'alter table BARSAQ.IMPORT_ACTIVITY
  drop constraint PK_IMPACT cascade';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'drop index barsaq.PK_IMPACT';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/


begin   
 execute immediate 'alter table BARSAQ.IMPORT_ACTIVITY
  add constraint PK_IMPACT primary key (START_TIME, KF)';
exception when others then
  if  sqlcode=-2260  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  IMPORT_ACTIVITY ***
grant SELECT                                                                 on IMPORT_ACTIVITY to BARSREADER_ROLE;
grant SELECT                                                                 on IMPORT_ACTIVITY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IMPORT_ACTIVITY to START1;
grant SELECT                                                                 on IMPORT_ACTIVITY to WR_REFREAD;



PROMPT *** Create SYNONYM  to IMPORT_ACTIVITY ***

  CREATE OR REPLACE SYNONYM BARS.IMPORT_ACTIVITY FOR BARSAQ.IMPORT_ACTIVITY;


PROMPT *** Create SYNONYM  to IMPORT_ACTIVITY ***

  CREATE OR REPLACE PUBLIC SYNONYM IMPORT_ACTIVITY FOR BARSAQ.IMPORT_ACTIVITY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/IMPORT_ACTIVITY.sql =========*** End
PROMPT ===================================================================================== 
