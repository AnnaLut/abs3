

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_JOBS_JRNL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_JOBS_JRNL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_JOBS_JRNL'', ''CENTER'' , null, null, null, ''E'');
               bpa.alter_policy_info(''DPU_JOBS_JRNL'', ''FILIAL'' , null, null, null, ''E'');
               bpa.alter_policy_info(''DPU_JOBS_JRNL'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_JOBS_JRNL ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_JOBS_JRNL 
   (	RUN_ID NUMBER(38,0), 
	JOB_ID NUMBER(38,0), 
	START_DATE DATE DEFAULT sysdate, 
	FINISH_DATE DATE, 
	BANK_DATE DATE, 
	USER_ID NUMBER(38,0), 
	STATUS NUMBER(1,0) DEFAULT 0, 
	ERRMSG VARCHAR2(3000), 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_JOBS_JRNL ***
 exec bpa.alter_policies('DPU_JOBS_JRNL');


COMMENT ON TABLE BARS.DPU_JOBS_JRNL IS 'Журнал виконання автоматичних завдань';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.RUN_ID IS 'Ідентификатор запуску завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.JOB_ID IS 'Ідентификатор автоматичного завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.START_DATE IS 'Дата початку виконання завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.FINISH_DATE IS 'Дата закінчення виконання завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.BANK_DATE IS 'Банківска дата виконання завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.USER_ID IS 'Ініціатор виконання завдання';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.STATUS IS 'Статус виконання (1 = Ок / 0 - не заверш / 1 - помилка)';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.ERRMSG IS 'Повідомлення про помилку';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.BRANCH IS 'Код підрозділу';
COMMENT ON COLUMN BARS.DPU_JOBS_JRNL.KF IS '';




PROMPT *** Create  constraint CC_DPUJOBSJRNL_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT CC_DPUJOBSJRNL_STATUS CHECK ( STATUS IN ( -1, 0, 1 ) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUJOBSJRNL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT PK_DPUJOBSJRNL PRIMARY KEY (RUN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSJRNL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT FK_DPUJOBSJRNL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSJRNL_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT FK_DPUJOBSJRNL_DPTJOBSLIST FOREIGN KEY (JOB_ID)
	  REFERENCES BARS.DPT_JOBS_LIST (JOB_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSJRNL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT FK_DPUJOBSJRNL_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSJRNL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL MODIFY (KF CONSTRAINT CC_DPUJOBSJRNL_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSJRNL_STARTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL MODIFY (START_DATE CONSTRAINT CC_DPUJOBSJRNL_STARTDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSJRNL_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL MODIFY (BANK_DATE CONSTRAINT CC_DPUJOBSJRNL_BANKDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSJRNL_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL MODIFY (USER_ID CONSTRAINT CC_DPUJOBSJRNL_USERID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSJRNL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL MODIFY (BRANCH CONSTRAINT CC_DPUJOBSJRNL_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUJOBSJRNL_JOBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL MODIFY (JOB_ID CONSTRAINT CC_DPUJOBSJRNL_JOBID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUJOBSJRNL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUJOBSJRNL ON BARS.DPU_JOBS_JRNL (RUN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_JOBS_JRNL ***
grant SELECT                                                                 on DPU_JOBS_JRNL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_JOBS_JRNL   to BARS_DM;
grant SELECT                                                                 on DPU_JOBS_JRNL   to DPT_ADMIN;
grant SELECT                                                                 on DPU_JOBS_JRNL   to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_JOBS_JRNL.sql =========*** End ***
PROMPT ===================================================================================== 
