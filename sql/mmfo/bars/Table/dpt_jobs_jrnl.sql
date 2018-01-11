

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_JRNL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_JOBS_JRNL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_JOBS_JRNL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_JOBS_JRNL'', ''FILIAL'' , ''d'', null, null, ''E'');
               bpa.alter_policy_info(''DPT_JOBS_JRNL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_JOBS_JRNL ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_JOBS_JRNL 
   (	RUN_ID NUMBER(38,0), 
	JOB_ID NUMBER(38,0), 
	START_DATE DATE DEFAULT sysdate, 
	FINISH_DATE DATE, 
	BANK_DATE DATE, 
	USER_ID NUMBER(38,0), 
	STATUS NUMBER(1,0) DEFAULT 0, 
	ERRMSG VARCHAR2(3000), 
	BRANCH VARCHAR2(30), 
	DELETED DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_JOBS_JRNL ***
 exec bpa.alter_policies('DPT_JOBS_JRNL');


COMMENT ON TABLE BARS.DPT_JOBS_JRNL IS 'Журнал выполнения автоматических операций';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.RUN_ID IS 'Идентификатор запуска';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.JOB_ID IS '№ операции';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.START_DATE IS 'Начало выполнения';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.FINISH_DATE IS 'Окончание выполнения';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.BANK_DATE IS 'Текущая банковская дата';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.USER_ID IS 'Инициатор выполнения';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.STATUS IS 'Статус выполнения (1=ок, 0=не заверш, -1=ошибка)';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.ERRMSG IS 'Сообщение об ошибке';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.DELETED IS '';
COMMENT ON COLUMN BARS.DPT_JOBS_JRNL.KF IS '';




PROMPT *** Create  constraint CC_DPTJOBSJRNL_JOBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL MODIFY (JOB_ID CONSTRAINT CC_DPTJOBSJRNL_JOBID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSJRNL_STARTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL MODIFY (START_DATE CONSTRAINT CC_DPTJOBSJRNL_STARTDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSJRNL_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL MODIFY (BANK_DATE CONSTRAINT CC_DPTJOBSJRNL_BANKDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSJRNL_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL MODIFY (USER_ID CONSTRAINT CC_DPTJOBSJRNL_USERID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSJRNL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL MODIFY (BRANCH CONSTRAINT CC_DPTJOBSJRNL_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSJRNL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL MODIFY (KF CONSTRAINT CC_DPTJOBSJRNL_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTJOBSJRNL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL ADD CONSTRAINT PK_DPTJOBSJRNL PRIMARY KEY (RUN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSJRNL_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_JRNL ADD CONSTRAINT CC_DPTJOBSJRNL_STATUS CHECK (status IN (-1, 0, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTJOBSJRNL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTJOBSJRNL ON BARS.DPT_JOBS_JRNL (RUN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_JOBS_JRNL ***
grant SELECT                                                                 on DPT_JOBS_JRNL   to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_JOBS_JRNL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_JOBS_JRNL   to BARS_DM;
grant SELECT                                                                 on DPT_JOBS_JRNL   to DPT_ADMIN;
grant SELECT                                                                 on DPT_JOBS_JRNL   to RPBN001;
grant SELECT                                                                 on DPT_JOBS_JRNL   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_JOBS_JRNL   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPT_JOBS_JRNL ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_JOBS_JRNL FOR BARS.DPT_JOBS_JRNL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_JRNL.sql =========*** End ***
PROMPT ===================================================================================== 
