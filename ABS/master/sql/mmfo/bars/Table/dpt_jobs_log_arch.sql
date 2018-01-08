

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LOG_ARCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_JOBS_LOG_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_JOBS_LOG_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_JOBS_LOG_ARCH'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_JOBS_LOG_ARCH'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_JOBS_LOG_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_JOBS_LOG_ARCH 
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
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_JOBS_LOG_ARCH ***
 exec bpa.alter_policies('DPT_JOBS_LOG_ARCH');


COMMENT ON TABLE BARS.DPT_JOBS_LOG_ARCH IS 'Протокол виконання автоматичних операцій';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.REC_ID IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.RUN_ID IS 'Ідентифікатор запуску';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.JOB_ID IS '№ операції';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.DPT_ID IS 'Референс деп.договору';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.BRANCH IS 'Підрозділ';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.REF IS 'Референс документу';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.RNK IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.KV IS 'Валюта депозиту';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.DPT_SUM IS 'Сума депозиту';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.INT_SUM IS 'Сума відсотків';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.STATUS IS 'Статус виконання (1=ок)';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.ERRMSG IS 'Повідомлення про помилку';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.CONTRACT_ID IS 'Референс соц.договора';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.DEAL_NUM IS 'Номер договору';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.RATE_VAL IS 'Значение відсоткової ставки';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.RATE_DAT IS 'Дата встановлення відсоткової ставки';
COMMENT ON COLUMN BARS.DPT_JOBS_LOG_ARCH.KF IS '';




PROMPT *** Create  constraint PK_DPTJOBSLOGARCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH ADD CONSTRAINT PK_DPTJOBSLOGARCH PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOGARCH_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH ADD CONSTRAINT CC_DPTJOBSLOGARCH_STATUS CHECK (status IN (-1,0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOGARCH_RUNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH MODIFY (RUN_ID CONSTRAINT CC_DPTJOBSLOGARCH_RUNID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOGARCH_JOBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH MODIFY (JOB_ID CONSTRAINT CC_DPTJOBSLOGARCH_JOBID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOGARCH_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH MODIFY (BRANCH CONSTRAINT CC_DPTJOBSLOGARCH_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOGARCH_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH MODIFY (STATUS CONSTRAINT CC_DPTJOBSLOGARCH_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOGARCH_DEALNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH MODIFY (DEAL_NUM CONSTRAINT CC_DPTJOBSLOGARCH_DEALNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLOGARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG_ARCH MODIFY (KF CONSTRAINT CC_DPTJOBSLOGARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTJOBSLOGARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTJOBSLOGARCH ON BARS.DPT_JOBS_LOG_ARCH (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTJOBSLOGARCH_RUNID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTJOBSLOGARCH_RUNID ON BARS.DPT_JOBS_LOG_ARCH (RUN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTJOBSLOGARCH_DPTID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTJOBSLOGARCH_DPTID ON BARS.DPT_JOBS_LOG_ARCH (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_JOBS_LOG_ARCH ***
grant SELECT                                                                 on DPT_JOBS_LOG_ARCH to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_JOBS_LOG_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_JOBS_LOG_ARCH to BARS_DM;
grant SELECT                                                                 on DPT_JOBS_LOG_ARCH to DPT_ADMIN;
grant SELECT                                                                 on DPT_JOBS_LOG_ARCH to RPBN001;
grant SELECT                                                                 on DPT_JOBS_LOG_ARCH to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_JOBS_LOG_ARCH to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LOG_ARCH.sql =========*** End
PROMPT ===================================================================================== 
