

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_JOBS_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_JOBS_LOG'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_JOBS_LOG'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_JOBS_LOG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_JOBS_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_JOBS_LOG 
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
	CONTRACT_ID NUMBER(38,0), 
	DEAL_NUM VARCHAR2(35), 
	RATE_VAL NUMBER(10,6), 
	RATE_DAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_JOBS_LOG ***
 exec bpa.alter_policies('DPT_JOBS_LOG');


COMMENT ON TABLE BARS.DPT_JOBS_LOG IS 'Протокол выполнения автоматических операций';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.REC_ID IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.RUN_ID IS 'Идентификатор запуска';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.JOB_ID IS '№ операции';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.DPT_ID IS 'Референс деп.договора';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.BRANCH IS 'Подразделение';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.KV IS 'Валюта вклада';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.DPT_SUM IS 'Сумма депозита';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.INT_SUM IS 'Сумма процентов';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.STATUS IS 'Статус выполнения (1=ок)';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.ERRMSG IS 'Сообщение об ошибке';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.NLS IS 'Номер счета';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.CONTRACT_ID IS 'Референс соц.договора';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.DEAL_NUM IS 'Номер договору';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.RATE_VAL IS 'Значение ставки';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.RATE_DAT IS 'Дата установки ставки';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG.KF IS '';




PROMPT *** Create  constraint PK_DPTJOBSLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT PK_DPTJOBSLOG PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOG_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT CC_DPTJOBSLOG_STATUS CHECK (status IN (-1,0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOG_RUNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG MODIFY (RUN_ID CONSTRAINT CC_DPTJOBSLOG_RUNID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOG_JOBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG MODIFY (JOB_ID CONSTRAINT CC_DPTJOBSLOG_JOBID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOG_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG MODIFY (BRANCH CONSTRAINT CC_DPTJOBSLOG_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOG_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG MODIFY (STATUS CONSTRAINT CC_DPTJOBSLOG_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOG_DEALNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG MODIFY (DEAL_NUM CONSTRAINT CC_DPTJOBSLOG_DEALNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG MODIFY (KF CONSTRAINT CC_DPTJOBSLOG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTJOBSLOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTJOBSLOG ON BARS.DPT_JOBS_LOG (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTJOBSLOG_RUNID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTJOBSLOG_RUNID ON BARS.DPT_JOBS_LOG (RUN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTJOBSLOG_DPTID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTJOBSLOG_DPTID ON BARS.DPT_JOBS_LOG (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_JOBS_LOG ***
grant SELECT                                                                 on DPT_JOBS_LOG    to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_JOBS_LOG    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_JOBS_LOG    to BARS_DM;
grant SELECT                                                                 on DPT_JOBS_LOG    to DPT_ADMIN;
grant SELECT                                                                 on DPT_JOBS_LOG    to RPBN001;
grant SELECT                                                                 on DPT_JOBS_LOG    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_JOBS_LOG    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPT_JOBS_LOG ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_JOBS_LOG FOR BARS.DPT_JOBS_LOG;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 
