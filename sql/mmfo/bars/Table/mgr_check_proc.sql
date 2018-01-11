

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MGR_CHECK_PROC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MGR_CHECK_PROC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MGR_CHECK_PROC ***
begin 
  execute immediate '
  CREATE TABLE BARS.MGR_CHECK_PROC 
   (	PROC_NAME VARCHAR2(93), 
	CREATION_TIME DATE DEFAULT sysdate, 
	PROC_COMMENT VARCHAR2(128), 
	 CONSTRAINT PK_MGRCHECKPROC PRIMARY KEY (PROC_NAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MGR_CHECK_PROC ***
 exec bpa.alter_policies('MGR_CHECK_PROC');


COMMENT ON TABLE BARS.MGR_CHECK_PROC IS 'Процедуры проверки перед миграцией';
COMMENT ON COLUMN BARS.MGR_CHECK_PROC.PROC_NAME IS 'Порядковый номер проверки';
COMMENT ON COLUMN BARS.MGR_CHECK_PROC.CREATION_TIME IS 'Время создания процедуры';
COMMENT ON COLUMN BARS.MGR_CHECK_PROC.PROC_COMMENT IS 'Комментарий процедуры проверки';




PROMPT *** Create  constraint CC_MGRCHECKPROC_PROCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECK_PROC MODIFY (PROC_NAME CONSTRAINT CC_MGRCHECKPROC_PROCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MGRCHECKPROC_CRTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECK_PROC MODIFY (CREATION_TIME CONSTRAINT CC_MGRCHECKPROC_CRTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MGRCHECKPROC ***
begin   
 execute immediate '
  ALTER TABLE BARS.MGR_CHECK_PROC ADD CONSTRAINT PK_MGRCHECKPROC PRIMARY KEY (PROC_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MGRCHECKPROC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MGRCHECKPROC ON BARS.MGR_CHECK_PROC (PROC_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MGR_CHECK_PROC ***
grant SELECT                                                                 on MGR_CHECK_PROC  to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MGR_CHECK_PROC.sql =========*** End **
PROMPT ===================================================================================== 
