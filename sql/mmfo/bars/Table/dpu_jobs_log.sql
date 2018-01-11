

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_JOBS_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_JOBS_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_JOBS_LOG'', ''CENTER'' , null, ''E'', ''E'', ''E'');
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


COMMENT ON TABLE BARS.DPU_JOBS_LOG IS 'Протокол выполнения автоматических операций';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.REC_ID IS 'Ідентификатор запису';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RUN_ID IS 'Ідентификатор запуску завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.JOB_ID IS 'Ідентификатор автоматичного завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.DPT_ID IS 'Ідентификатор деп. договору';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.BRANCH IS 'Код підрозділу';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RNK IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.KV IS 'Валюта депозиту';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.DPT_SUM IS 'Сума депозиту';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.INT_SUM IS 'Сума відсотків';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.STATUS IS 'Статус виконання (1 - Ок)';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.ERRMSG IS 'Повідомлення про помилку';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.DEAL_NUM IS 'Номер договору';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RATE_VAL IS 'Значення % ставки';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.RATE_DAT IS 'Дата встановлення % ставки';
COMMENT ON COLUMN BARS.DPU_JOBS_LOG.KF IS '';




PROMPT *** Create  constraint CC_DPUJOBSLOG_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT CC_DPUJOBSLOG_STATUS CHECK ( STATUS IN ( -1, 0, 1 ) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUJOBSLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT PK_DPUJOBSLOG PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_RUNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (RUN_ID CONSTRAINT CC_DPUJOBSLOG_RUNID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_JOBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (JOB_ID CONSTRAINT CC_DPUJOBSLOG_JOBID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (BRANCH CONSTRAINT CC_DPUJOBSLOG_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (STATUS CONSTRAINT CC_DPUJOBSLOG_STATUS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_DEALNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (DEAL_NUM CONSTRAINT CC_DPUJOBSLOG_DEALNUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSLOG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG MODIFY (KF CONSTRAINT CC_DPUJOBSLOG_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
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



PROMPT *** Create  grants  DPU_JOBS_LOG ***
grant SELECT                                                                 on DPU_JOBS_LOG    to BARSREADER_ROLE;
grant SELECT                                                                 on DPU_JOBS_LOG    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_JOBS_LOG    to BARS_DM;
grant SELECT                                                                 on DPU_JOBS_LOG    to DPT_ADMIN;
grant SELECT                                                                 on DPU_JOBS_LOG    to RPBN001;
grant SELECT                                                                 on DPU_JOBS_LOG    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_JOBS_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 
