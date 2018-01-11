

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_JOBS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_JOBS_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_JOBS_LIST'', ''FILIAL'' , ''d'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_JOBS_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_JOBS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_JOBS_LIST 
   (	JOB_ID NUMBER(38,0), 
	JOB_CODE CHAR(8), 
	JOB_NAME VARCHAR2(100), 
	JOB_PROC VARCHAR2(128), 
	ORD NUMBER(5,0), 
	DELETED DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_JOBS_LIST ***
 exec bpa.alter_policies('DPT_JOBS_LIST');


COMMENT ON TABLE BARS.DPT_JOBS_LIST IS 'Справочник автоматических операций';
COMMENT ON COLUMN BARS.DPT_JOBS_LIST.JOB_ID IS '№ операции';
COMMENT ON COLUMN BARS.DPT_JOBS_LIST.JOB_CODE IS 'Код операции';
COMMENT ON COLUMN BARS.DPT_JOBS_LIST.JOB_NAME IS 'Наименование операции';
COMMENT ON COLUMN BARS.DPT_JOBS_LIST.JOB_PROC IS 'Имя выполняемой процедуры';
COMMENT ON COLUMN BARS.DPT_JOBS_LIST.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.DPT_JOBS_LIST.DELETED IS '';




PROMPT *** Create  constraint PK_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LIST ADD CONSTRAINT PK_DPTJOBSLIST PRIMARY KEY (JOB_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LIST ADD CONSTRAINT UK_DPTJOBSLIST UNIQUE (JOB_PROC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLIST_JOBCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LIST MODIFY (JOB_CODE CONSTRAINT CC_DPTJOBSLIST_JOBCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLIST_JOBNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LIST MODIFY (JOB_NAME CONSTRAINT CC_DPTJOBSLIST_JOBNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTJOBSLIST_JOBPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LIST MODIFY (JOB_PROC CONSTRAINT CC_DPTJOBSLIST_JOBPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTJOBSLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTJOBSLIST ON BARS.DPT_JOBS_LIST (JOB_PROC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTJOBSLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTJOBSLIST ON BARS.DPT_JOBS_LIST (JOB_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_JOBS_LIST ***
grant SELECT                                                                 on DPT_JOBS_LIST   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_JOBS_LIST   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_JOBS_LIST   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_JOBS_LIST   to DPT_ADMIN;
grant SELECT                                                                 on DPT_JOBS_LIST   to RPBN001;
grant SELECT                                                                 on DPT_JOBS_LIST   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_JOBS_LIST   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_JOBS_LIST   to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPT_JOBS_LIST ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_JOBS_LIST FOR BARS.DPT_JOBS_LIST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LIST.sql =========*** End ***
PROMPT ===================================================================================== 
