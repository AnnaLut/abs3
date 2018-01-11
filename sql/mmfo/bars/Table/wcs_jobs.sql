

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_JOBS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_JOBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_JOBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_JOBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_JOBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_JOBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_JOBS 
   (	BID_ID NUMBER, 
	IQUERY_ID VARCHAR2(100), 
	STATUS_ID VARCHAR2(100), 
	ERR_MSG VARCHAR2(4000), 
	RS_ID VARCHAR2(100), 
	RS_IQS_TCNT NUMBER, 
	RS_STATE_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_JOBS ***
 exec bpa.alter_policies('WCS_JOBS');


COMMENT ON TABLE BARS.WCS_JOBS IS 'JOBы';
COMMENT ON COLUMN BARS.WCS_JOBS.BID_ID IS 'Идентификатор заявки';
COMMENT ON COLUMN BARS.WCS_JOBS.IQUERY_ID IS 'Идентификатор информационного запроса';
COMMENT ON COLUMN BARS.WCS_JOBS.STATUS_ID IS 'Идентификатор статуса JOBа';
COMMENT ON COLUMN BARS.WCS_JOBS.ERR_MSG IS 'Текст ошибки';
COMMENT ON COLUMN BARS.WCS_JOBS.RS_ID IS 'Идентификатор сессии запуска';
COMMENT ON COLUMN BARS.WCS_JOBS.RS_IQS_TCNT IS 'Кол-во инфо-запросов в сессии запуска';
COMMENT ON COLUMN BARS.WCS_JOBS.RS_STATE_ID IS 'Состояние сессии запуска';




PROMPT *** Create  constraint PK_WCSJOBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT PK_WCSJOBS PRIMARY KEY (BID_ID, IQUERY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSJOBS_RSIQSTCNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (RS_IQS_TCNT CONSTRAINT CC_WCSJOBS_RSIQSTCNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSJOBS_STATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (RS_STATE_ID CONSTRAINT CC_WCSJOBS_STATEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSJOBS_BIDID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (BID_ID CONSTRAINT CC_WCSJOBS_BIDID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSJOBS_IQUERYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (IQUERY_ID CONSTRAINT CC_WCSJOBS_IQUERYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSJOBS_STATUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (STATUS_ID CONSTRAINT CC_WCSJOBS_STATUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSJOBS_RSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (RS_ID CONSTRAINT CC_WCSJOBS_RSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSJOBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSJOBS ON BARS.WCS_JOBS (BID_ID, IQUERY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_JOBS ***
grant SELECT                                                                 on WCS_JOBS        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_JOBS        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_JOBS        to START1;
grant SELECT                                                                 on WCS_JOBS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_JOBS.sql =========*** End *** ====
PROMPT ===================================================================================== 
