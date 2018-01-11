

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/JOBS_LIST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to JOBS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table JOBS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.JOBS_LIST 
   (	JOB_CODE VARCHAR2(30), 
	JOB_NAME VARCHAR2(100), 
	JOB_SYSID NUMBER(38,0), 
	JOB_FILTER VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to JOBS_LIST ***
 exec bpa.alter_policies('JOBS_LIST');


COMMENT ON TABLE BARS.JOBS_LIST IS 'Довідник завдань';
COMMENT ON COLUMN BARS.JOBS_LIST.JOB_CODE IS 'Код завдання';
COMMENT ON COLUMN BARS.JOBS_LIST.JOB_NAME IS 'Назва завдання';
COMMENT ON COLUMN BARS.JOBS_LIST.JOB_SYSID IS 'Системний код завдання';
COMMENT ON COLUMN BARS.JOBS_LIST.JOB_FILTER IS 'sql-умова фільтру по журналу подій для протоколу';




PROMPT *** Create  constraint PK_JOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.JOBS_LIST ADD CONSTRAINT PK_JOBSLIST PRIMARY KEY (JOB_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_JOBSLIST_JOBCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.JOBS_LIST MODIFY (JOB_CODE CONSTRAINT CC_JOBSLIST_JOBCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_JOBSLIST_JOBNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.JOBS_LIST MODIFY (JOB_NAME CONSTRAINT CC_JOBSLIST_JOBNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_JOBSLIST_JOBSYSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.JOBS_LIST MODIFY (JOB_SYSID CONSTRAINT CC_JOBSLIST_JOBSYSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_JOBSLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_JOBSLIST ON BARS.JOBS_LIST (JOB_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  JOBS_LIST ***
grant SELECT                                                                 on JOBS_LIST       to BARSREADER_ROLE;
grant SELECT                                                                 on JOBS_LIST       to BARS_DM;
grant SELECT                                                                 on JOBS_LIST       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on JOBS_LIST       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/JOBS_LIST.sql =========*** End *** ===
PROMPT ===================================================================================== 
