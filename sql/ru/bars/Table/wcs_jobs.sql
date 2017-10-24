

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_JOBS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_JOBS ***


BEGIN 
        execute immediate  
          'begin  
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


COMMENT ON TABLE BARS.WCS_JOBS IS 'JOB�';
COMMENT ON COLUMN BARS.WCS_JOBS.BID_ID IS '������������� ������';
COMMENT ON COLUMN BARS.WCS_JOBS.IQUERY_ID IS '������������� ��������������� �������';
COMMENT ON COLUMN BARS.WCS_JOBS.STATUS_ID IS '������������� ������� JOB�';
COMMENT ON COLUMN BARS.WCS_JOBS.ERR_MSG IS '����� ������';
COMMENT ON COLUMN BARS.WCS_JOBS.RS_ID IS '������������� ������ �������';
COMMENT ON COLUMN BARS.WCS_JOBS.RS_IQS_TCNT IS '���-�� ����-�������� � ������ �������';
COMMENT ON COLUMN BARS.WCS_JOBS.RS_STATE_ID IS '��������� ������ �������';




PROMPT *** Create  constraint FK_WCSJOBS_RSSID_STATES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_RSSID_STATES_ID FOREIGN KEY (RS_STATE_ID)
	  REFERENCES BARS.WCS_STATES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSJOBS_IQID_IQS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_IQID_IQS_ID FOREIGN KEY (IQUERY_ID)
	  REFERENCES BARS.WCS_INFOQUERIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSJOBS_SID_JOBSTATUSES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_SID_JOBSTATUSES_ID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.WCS_JOB_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSJOBS_BID_BIDS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_BID_BIDS_ID FOREIGN KEY (BID_ID)
	  REFERENCES BARS.WCS_BIDS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




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




PROMPT *** Create  constraint CC_WCSJOBS_STATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (RS_STATE_ID CONSTRAINT CC_WCSJOBS_STATEID_NN NOT NULL ENABLE)';
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




PROMPT *** Create  constraint CC_WCSJOBS_RSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (RS_ID CONSTRAINT CC_WCSJOBS_RSID_NN NOT NULL ENABLE)';
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




PROMPT *** Create  constraint CC_WCSJOBS_IQUERYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS MODIFY (IQUERY_ID CONSTRAINT CC_WCSJOBS_IQUERYID_NN NOT NULL ENABLE)';
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





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_JOBS.sql =========*** End *** ====
PROMPT ===================================================================================== 
