

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_JOBS_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_JOBS_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_JOBS_LOG'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPU_JOBS_LOG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_JOBS_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_JOBS_LOG 
   (	REC_ID NUMBER(38,0), 
	RUN_ID NUMBER(38,0), 
	JOB_ID NUMBER(38,0), 
	DPT_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	REF NUMBER(38,0), 
	RNK NUMBER(38,0), 
	KV NUMBER(3,0), 
	DPT_SUM NUMBER(24,0), 
	INT_SUM NUMBER(24,0), 
	STATUS NUMBER(1,0), 
	ERRMSG VARCHAR2(3000), 
	NLS VARCHAR2(14), 
	DEAL_NUM VARCHAR2(35), 
	RATE_VAL NUMBER(10,6), 
	RATE_DAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_JOBS_LOG ***
 exec bpa.alter_policies('DPU_JOBS_LOG');


COMMENT ON TABLE BARS.DPU_JOBS_LOG IS '�������� ���������� �������������� ��������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.DPT_ID IS '������������� ���. ��������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.BRANCH IS '��� ��������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.REF IS '�������� ���������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RNK IS '������������ ����� �볺���';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.KV IS '������ ��������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.DPT_SUM IS '���� ��������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.INT_SUM IS '���� �������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.STATUS IS '������ ��������� (1 - ��)';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.ERRMSG IS '����������� ��� �������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.NLS IS '����� �������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.DEAL_NUM IS '����� ��������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RATE_VAL IS '�������� % ������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RATE_DAT IS '���� ������������ % ������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.KF IS '';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.REC_ID IS '������������� ������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RUN_ID IS '������������� ������� ��������';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.JOB_ID IS '������������� ������������� ��������';




PROMPT *** Create  constraint FK_DPUJOBSLOG_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_DPTJOBSLIST FOREIGN KEY (JOB_ID)
	  REFERENCES BARS.DPT_JOBS_LIST (JOB_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_DPUJOBSJRNL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_DPUJOBSJRNL FOREIGN KEY (RUN_ID)
	  REFERENCES BARS.DPU_JOBS_JRNL (RUN_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_DPUDEAL FOREIGN KEY (DPT_ID)
	  REFERENCES BARS.DPU_DEAL (DPU_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_DEALNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (DEAL_NUM CONSTRAINT CC_DPUJOBSLOG_DEALNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (STATUS CONSTRAINT CC_DPUJOBSLOG_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (BRANCH CONSTRAINT CC_DPUJOBSLOG_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_JOBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (JOB_ID CONSTRAINT CC_DPUJOBSLOG_JOBID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_RUNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (RUN_ID CONSTRAINT CC_DPUJOBSLOG_RUNID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUJOBSLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT PK_DPUJOBSLOG PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT CC_DPUJOBSLOG_STATUS CHECK ( STATUS IN ( -1, 0, 1 ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (KF CONSTRAINT CC_DPUJOBSLOG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPUJOBSLOG_RUNID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPUJOBSLOG_RUNID ON BARS.DPU_JOBS_LOG (RUN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPUJOBSLOG_DPTID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPUJOBSLOG_DPTID ON BARS.DPU_JOBS_LOG (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUJOBSLOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUJOBSLOG ON BARS.DPU_JOBS_LOG (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_JOBS_LOG ***
grant SELECT                                                                 on DPU_JOBS_LOG    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_JOBS_LOG    to DPT_ADMIN;
grant SELECT                                                                 on DPU_JOBS_LOG    to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_JOBS_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 
