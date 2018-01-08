

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_JOBS_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_JOBS_QUEUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_JOBS_QUEUE'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_JOBS_QUEUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_JOBS_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_JOBS_QUEUE 
   (	RUN_ID NUMBER(38,0), 
	JOB_ID NUMBER(38,0), 
	BRANCH VARCHAR2(35), 
	BDATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_JOBS_QUEUE ***
 exec bpa.alter_policies('DPT_JOBS_QUEUE');


COMMENT ON TABLE BARS.DPT_JOBS_QUEUE IS 'Очередь автомат.заданий для offline-отделений';
COMMENT ON COLUMN BARS.DPT_JOBS_QUEUE.RUN_ID IS '№ запуска';
COMMENT ON COLUMN BARS.DPT_JOBS_QUEUE.JOB_ID IS 'Код автомат.операции';
COMMENT ON COLUMN BARS.DPT_JOBS_QUEUE.BRANCH IS 'Код отделения';
COMMENT ON COLUMN BARS.DPT_JOBS_QUEUE.BDATE IS 'Банк.дата запуска';
COMMENT ON COLUMN BARS.DPT_JOBS_QUEUE.KF IS '';




PROMPT *** Create  constraint FK_DPTJOBSQUEUE_DPTJOBSJRNL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_DPTJOBSJRNL FOREIGN KEY (RUN_ID)
	  REFERENCES BARS.DPT_JOBS_JRNL (RUN_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTJOBSQUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT PK_DPTJOBSQUEUE PRIMARY KEY (RUN_ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSQUEUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE MODIFY (KF CONSTRAINT CC_DPTJOBSQUEUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSQUEUE_BDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE MODIFY (BDATE CONSTRAINT CC_DPTJOBSQUEUE_BDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSQUEUE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE MODIFY (BRANCH CONSTRAINT CC_DPTJOBSQUEUE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSQUEUE_JOBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE MODIFY (JOB_ID CONSTRAINT CC_DPTJOBSQUEUE_JOBID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSQUEUE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSQUEUE_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_DPTJOBSLIST FOREIGN KEY (JOB_ID)
	  REFERENCES BARS.DPT_JOBS_LIST (JOB_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSQUEUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSQUEUE_RUNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE MODIFY (RUN_ID CONSTRAINT CC_DPTJOBSQUEUE_RUNID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTJOBSQUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTJOBSQUEUE ON BARS.DPT_JOBS_QUEUE (RUN_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_JOBS_QUEUE ***
grant SELECT                                                                 on DPT_JOBS_QUEUE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_JOBS_QUEUE  to BARS_DM;
grant SELECT                                                                 on DPT_JOBS_QUEUE  to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_JOBS_QUEUE  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPT_JOBS_QUEUE ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_JOBS_QUEUE FOR BARS.DPT_JOBS_QUEUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
