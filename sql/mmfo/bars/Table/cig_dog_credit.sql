

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_DOG_CREDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_CREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_DOG_CREDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_CREDIT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CIG_DOG_CREDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_DOG_CREDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_DOG_CREDIT 
   (	ID NUMBER(38,0), 
	DOG_ID NUMBER(38,0), 
	LIMIT_CURR_ID NUMBER(38,0), 
	LIMIT_SUM NUMBER, 
	UPDATE_DATE DATE, 
	CREDIT_USAGE NUMBER(1,0), 
	RES_CURR_ID NUMBER(38,0), 
	RES_SUM NUMBER, 
	OVERDUE_CURR_ID NUMBER(38,0), 
	OVERDUE_SUM NUMBER, 
	SYNC_DATE DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	OVERDUE_DAY_CNT NUMBER(38,0), 
	OVERDUE_CNT NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_DOG_CREDIT ***
 exec bpa.alter_policies('CIG_DOG_CREDIT');


COMMENT ON TABLE BARS.CIG_DOG_CREDIT IS 'Фынансова інформація по стандартим кредитам';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.OVERDUE_DAY_CNT IS '';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.OVERDUE_CNT IS '';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.ID IS 'Код';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.DOG_ID IS 'Код таблиці договорів CIG';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.LIMIT_CURR_ID IS 'Валюта';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.LIMIT_SUM IS 'Сума ліміту';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.UPDATE_DATE IS 'Дата оновлення';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.CREDIT_USAGE IS '';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.RES_CURR_ID IS '';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.RES_SUM IS '';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.OVERDUE_CURR_ID IS '';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.OVERDUE_SUM IS '';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.SYNC_DATE IS 'Дата передачі реквізитів до центральної бази';
COMMENT ON COLUMN BARS.CIG_DOG_CREDIT.BRANCH IS '';




PROMPT *** Create  constraint CC_CIGDOGCREDIT_DOGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (DOG_ID CONSTRAINT CC_CIGDOGCREDIT_DOGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (ID CONSTRAINT CC_CIGDOGCREDIT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGDOGCREDIT_CIGDOGGENERAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT ADD CONSTRAINT FK_CIGDOGCREDIT_CIGDOGGENERAL FOREIGN KEY (DOG_ID, BRANCH)
	  REFERENCES BARS.CIG_DOG_GENERAL (ID, BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIGDOGCRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT ADD CONSTRAINT PK_CIGDOGCRED PRIMARY KEY (ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_LIMITCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (LIMIT_CURR_ID CONSTRAINT CC_CIGDOGCREDIT_LIMITCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_LIMITSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (LIMIT_SUM CONSTRAINT CC_CIGDOGCREDIT_LIMITSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCRED_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (BRANCH CONSTRAINT CC_CIGDOGCRED_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_CRUSAGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (CREDIT_USAGE CONSTRAINT CC_CIGDOGCREDIT_CRUSAGE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_RESCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (RES_CURR_ID CONSTRAINT CC_CIGDOGCREDIT_RESCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_RESSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (RES_SUM CONSTRAINT CC_CIGDOGCREDIT_RESSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_OVERCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (OVERDUE_CURR_ID CONSTRAINT CC_CIGDOGCREDIT_OVERCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_OVERSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (OVERDUE_SUM CONSTRAINT CC_CIGDOGCREDIT_OVERSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGCREDIT_UPDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_CREDIT MODIFY (UPDATE_DATE CONSTRAINT CC_CIGDOGCREDIT_UPDDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CIGDOGCRED_DOGIDBRANCH ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CIGDOGCRED_DOGIDBRANCH ON BARS.CIG_DOG_CREDIT (DOG_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIGDOGCRD_DOGIDUPDDATTE ***
begin   
 execute immediate '
  CREATE INDEX BARS.UK_CIGDOGCRD_DOGIDUPDDATTE ON BARS.CIG_DOG_CREDIT (DOG_ID, UPDATE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGDOGCRED ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGDOGCRED ON BARS.CIG_DOG_CREDIT (ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_DOG_CREDIT ***
grant SELECT,UPDATE                                                          on CIG_DOG_CREDIT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_DOG_CREDIT  to BARS_DM;
grant SELECT,UPDATE                                                          on CIG_DOG_CREDIT  to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_DOG_CREDIT ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_DOG_CREDIT FOR BARS.CIG_DOG_CREDIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_DOG_CREDIT.sql =========*** End **
PROMPT ===================================================================================== 
