

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_PROCS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_PROCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_PROCS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_PROCS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_PROCS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_PROCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_PROCS 
   (	ID NUMBER(12,0), 
	FILE_ID NUMBER(12,0), 
	PROC_TYPE VARCHAR2(1), 
	PROC_ACTIVE VARCHAR2(1), 
	SCHEME VARCHAR2(30), 
	PROC_NAME VARCHAR2(35), 
	DESCRIPTION VARCHAR2(200), 
	VERSION VARCHAR2(35), 
	DATE_START DATE, 
	DATE_FINISH DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_PROCS ***
 exec bpa.alter_policies('NBUR_REF_PROCS');


COMMENT ON TABLE BARS.NBUR_REF_PROCS IS 'Список процедур формування/контролю файлiв НБУ';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.ID IS 'Iдентифiкатор процедури';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.FILE_ID IS 'Iдентифiкатор файлу НБУ';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.PROC_TYPE IS 'Тип процедури (формування/контроль)';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.PROC_ACTIVE IS 'Ознака використання';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.SCHEME IS 'Схема';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.PROC_NAME IS 'Назва процедури';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.DESCRIPTION IS 'Опис призначення';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.VERSION IS 'Версiя';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.DATE_START IS 'Дата включення';
COMMENT ON COLUMN BARS.NBUR_REF_PROCS.DATE_FINISH IS 'Дата виключення';




PROMPT *** Create  constraint CC_NBURREFPROCS_PROCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_PROCS ADD CONSTRAINT CC_NBURREFPROCS_PROCTYPE CHECK ( PROC_TYPE in ( ''F'', ''C'', ''O'' ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_PROCS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBUR_REF_PROCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_PROCS ADD CONSTRAINT PK_NBUR_REF_PROCS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBUR_REF_PROCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBUR_REF_PROCS ON BARS.NBUR_REF_PROCS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURREFPROCS_PROCNAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURREFPROCS_PROCNAME ON BARS.NBUR_REF_PROCS (PROC_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_NBURREFPROCS_FILEID_PRCTP ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NBURREFPROCS_FILEID_PRCTP ON BARS.NBUR_REF_PROCS (FILE_ID, PROC_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_PROCS ***
grant SELECT                                                                 on NBUR_REF_PROCS  to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_REF_PROCS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_REF_PROCS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_PROCS.sql =========*** End **
PROMPT ===================================================================================== 
