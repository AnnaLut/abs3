

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_SHED_JOBS_STATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_SHED_JOBS_STATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_SHED_JOBS_STATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_SHED_JOBS_STATE'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CIG_SHED_JOBS_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_SHED_JOBS_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_SHED_JOBS_STATE 
   (	JOB_NAME VARCHAR2(128), 
	LAST_START_DATE DATE, 
	THIS_START_DATE DATE, 
	NEXT_START_DATE DATE, 
	TOTAL_TIME VARCHAR2(64), 
	BROKEN VARCHAR2(1), 
	INTERVAL VARCHAR2(4000), 
	FAILURES NUMBER(38,0), 
	WHAT VARCHAR2(4000), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_SHED_JOBS_STATE ***
 exec bpa.alter_policies('CIG_SHED_JOBS_STATE');


COMMENT ON TABLE BARS.CIG_SHED_JOBS_STATE IS 'Довідник стану виконання завдань';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.JOB_NAME IS 'Найменування';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.LAST_START_DATE IS 'Дата та час останього запуску';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.THIS_START_DATE IS 'Дата та час поточного запуску';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.NEXT_START_DATE IS 'Дата та час наступного запуску';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.TOTAL_TIME IS 'Час виконання';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.BROKEN IS 'Флаг активності';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.INTERVAL IS 'Інтервал виконання';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.FAILURES IS 'Кількість невдалих запусків';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.WHAT IS 'Текст, що виконується';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.BRANCH IS 'Відділення';




PROMPT *** Create  constraint PK_CIGSHEDJOBS_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SHED_JOBS_STATE ADD CONSTRAINT PK_CIGSHEDJOBS_STATE PRIMARY KEY (JOB_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGSHEDJOBS_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGSHEDJOBS_STATE ON BARS.CIG_SHED_JOBS_STATE (JOB_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_SHED_JOBS_STATE ***
grant SELECT,UPDATE                                                          on CIG_SHED_JOBS_STATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_SHED_JOBS_STATE to BARS_DM;
grant SELECT,UPDATE                                                          on CIG_SHED_JOBS_STATE to CIG_ROLE;
grant SELECT                                                                 on CIG_SHED_JOBS_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_SHED_JOBS_STATE.sql =========*** E
PROMPT ===================================================================================== 
