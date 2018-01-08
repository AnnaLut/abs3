

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_DOG_NONINSTALMENT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_NONINSTALMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_DOG_NONINSTALMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_NONINSTALMENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_NONINSTALMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_DOG_NONINSTALMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_DOG_NONINSTALMENT 
   (	ID NUMBER(38,0), 
	DOG_ID NUMBER(38,0), 
	LIMIT_CURR_ID NUMBER(38,0), 
	LIMIT_SUM NUMBER, 
	UPDATE_DATE DATE, 
	CREDIT_USAGE NUMBER(1,0), 
	USED_CURR_ID NUMBER(38,0), 
	USED_SUM NUMBER, 
	SYNC_DATE DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_DOG_NONINSTALMENT ***
 exec bpa.alter_policies('CIG_DOG_NONINSTALMENT');


COMMENT ON TABLE BARS.CIG_DOG_NONINSTALMENT IS 'Фінансова інформація по стандартим кредитам';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.ID IS 'Код';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.DOG_ID IS 'Код таблиці договорів CIG';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.LIMIT_CURR_ID IS 'Валюта';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.LIMIT_SUM IS 'Сума ліміту';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.UPDATE_DATE IS 'Дата оновлення';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.CREDIT_USAGE IS '';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.USED_CURR_ID IS '';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.USED_SUM IS '';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.SYNC_DATE IS 'Дата передачі реквізитів до центральної бази';
COMMENT ON COLUMN BARS.CIG_DOG_NONINSTALMENT.BRANCH IS '';




PROMPT *** Create  constraint PK_CIGDOGNINST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT ADD CONSTRAINT PK_CIGDOGNINST PRIMARY KEY (ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (ID CONSTRAINT CC_CIGDOGNINST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_DOGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (DOG_ID CONSTRAINT CC_CIGDOGNINST_DOGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_LIMITCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (LIMIT_CURR_ID CONSTRAINT CC_CIGDOGNINST_LIMITCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_LIMITSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (LIMIT_SUM CONSTRAINT CC_CIGDOGNINST_LIMITSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_UPDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (UPDATE_DATE CONSTRAINT CC_CIGDOGNINST_UPDDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_CRUSAGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (CREDIT_USAGE CONSTRAINT CC_CIGDOGNINST_CRUSAGE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_USEDCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (USED_CURR_ID CONSTRAINT CC_CIGDOGNINST_USEDCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_USEDSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (USED_SUM CONSTRAINT CC_CIGDOGNINST_USEDSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGNINST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_NONINSTALMENT MODIFY (BRANCH CONSTRAINT CC_CIGDOGNINST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGDOGNINST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGDOGNINST ON BARS.CIG_DOG_NONINSTALMENT (ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CIGDOGNINST_DOGIDBRANCH ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CIGDOGNINST_DOGIDBRANCH ON BARS.CIG_DOG_NONINSTALMENT (DOG_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIGDOGNINST_DOGIDUPDDATTE ***
begin   
 execute immediate '
  CREATE INDEX BARS.UK_CIGDOGNINST_DOGIDUPDDATTE ON BARS.CIG_DOG_NONINSTALMENT (DOG_ID, UPDATE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_DOG_NONINSTALMENT ***
grant SELECT                                                                 on CIG_DOG_NONINSTALMENT to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on CIG_DOG_NONINSTALMENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_DOG_NONINSTALMENT to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on CIG_DOG_NONINSTALMENT to CIG_ROLE;
grant SELECT                                                                 on CIG_DOG_NONINSTALMENT to UPLD;



PROMPT *** Create SYNONYM  to CIG_DOG_NONINSTALMENT ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_DOG_NONINSTALMENT FOR BARS.CIG_DOG_NONINSTALMENT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_DOG_NONINSTALMENT.sql =========***
PROMPT ===================================================================================== 
