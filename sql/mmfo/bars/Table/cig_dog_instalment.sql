

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_DOG_INSTALMENT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_INSTALMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_DOG_INSTALMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_INSTALMENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_INSTALMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_DOG_INSTALMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_DOG_INSTALMENT 
   (	ID NUMBER(38,0), 
	DOG_ID NUMBER(38,0), 
	BODY_SUM NUMBER, 
	BODY_CURR_ID NUMBER(3,0), 
	BODY_TOTAL_CNT NUMBER(38,0), 
	INSTALMENT_CURR_ID NUMBER(38,0), 
	INSTALMENT_SUM NUMBER, 
	UPDATE_DATE DATE, 
	OUTSTAND_CNT NUMBER(38,0), 
	OUTSTAND_CURR_ID NUMBER(38,0), 
	OUTSTAND_SUM NUMBER, 
	OVERDUE_CNT NUMBER(38,0), 
	OVERDUE_CURR_ID NUMBER(38,0), 
	OVERDUE_SUM NUMBER, 
	SYNC_DATE DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	OVERDUE_DAY_CNT NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_DOG_INSTALMENT ***
 exec bpa.alter_policies('CIG_DOG_INSTALMENT');


COMMENT ON TABLE BARS.CIG_DOG_INSTALMENT IS 'Фінансова інформація по стандартим кредитам';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.ID IS 'Код';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.DOG_ID IS 'Код таблиці договорів CIG';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.BODY_SUM IS 'Загальна сума';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.BODY_CURR_ID IS 'Валюта';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.BODY_TOTAL_CNT IS 'Загальна кількість платежів';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.INSTALMENT_CURR_ID IS 'Валюта щомісячного платежу';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.INSTALMENT_SUM IS 'Сума платежу кожного місяця';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.UPDATE_DATE IS 'Дата оновлення';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.OUTSTAND_CNT IS 'Кількість платежів, що підлягають сплаті в майбутньому';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.OUTSTAND_CURR_ID IS 'Сума платежів, які підлягають сплаті в майбутньому (валюта)';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.OUTSTAND_SUM IS 'Сума платежів, які підлягають сплаті в майбутньому';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.OVERDUE_CNT IS 'Кількість прострочених платежів';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.OVERDUE_CURR_ID IS 'Сума простроченої заборгованості (валюта)';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.OVERDUE_SUM IS 'Сума простроченої заборгованості';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.SYNC_DATE IS 'Дата передачі реквізитів до центральної бази';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.BRANCH IS '';
COMMENT ON COLUMN BARS.CIG_DOG_INSTALMENT.OVERDUE_DAY_CNT IS '';




PROMPT *** Create  constraint CC_CIGDOGINST_BODYCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (BODY_CURR_ID CONSTRAINT CC_CIGDOGINST_BODYCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (BRANCH CONSTRAINT CC_CIGDOGINST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_DOGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (DOG_ID CONSTRAINT CC_CIGDOGINST_DOGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (ID CONSTRAINT CC_CIGDOGINST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIGDOGINST_CIGDOGGENERAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT ADD CONSTRAINT FK_CIGDOGINST_CIGDOGGENERAL FOREIGN KEY (DOG_ID, BRANCH)
	  REFERENCES BARS.CIG_DOG_GENERAL (ID, BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIGDOGINSTLMNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT ADD CONSTRAINT PK_CIGDOGINSTLMNT PRIMARY KEY (ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_BODYCNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (BODY_TOTAL_CNT CONSTRAINT CC_CIGDOGINST_BODYCNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_INSTCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (INSTALMENT_CURR_ID CONSTRAINT CC_CIGDOGINST_INSTCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_INSTSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (INSTALMENT_SUM CONSTRAINT CC_CIGDOGINST_INSTSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_UPDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (UPDATE_DATE CONSTRAINT CC_CIGDOGINST_UPDDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_OUTSTANDCNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (OUTSTAND_CNT CONSTRAINT CC_CIGDOGINST_OUTSTANDCNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_OUTSTANDCURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (OUTSTAND_CURR_ID CONSTRAINT CC_CIGDOGINST_OUTSTANDCURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_OUTSTANDSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (OUTSTAND_SUM CONSTRAINT CC_CIGDOGINST_OUTSTANDSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_OVERDUECNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (OVERDUE_CNT CONSTRAINT CC_CIGDOGINST_OVERDUECNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_OVERDUECURR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (OVERDUE_CURR_ID CONSTRAINT CC_CIGDOGINST_OVERDUECURR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_OVERDUESUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (OVERDUE_SUM CONSTRAINT CC_CIGDOGINST_OVERDUESUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGINST_BODYSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_INSTALMENT MODIFY (BODY_SUM CONSTRAINT CC_CIGDOGINST_BODYSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CIGDOGINST_DOGIDBRANCH ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CIGDOGINST_DOGIDBRANCH ON BARS.CIG_DOG_INSTALMENT (DOG_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIGDOGINST_DOGIDUPDDATTE ***
begin   
 execute immediate '
  CREATE INDEX BARS.UK_CIGDOGINST_DOGIDUPDDATTE ON BARS.CIG_DOG_INSTALMENT (DOG_ID, UPDATE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGDOGINSTLMNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGDOGINSTLMNT ON BARS.CIG_DOG_INSTALMENT (ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_DOG_INSTALMENT ***
grant SELECT,UPDATE                                                          on CIG_DOG_INSTALMENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_DOG_INSTALMENT to BARS_DM;
grant SELECT,UPDATE                                                          on CIG_DOG_INSTALMENT to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_DOG_INSTALMENT ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_DOG_INSTALMENT FOR BARS.CIG_DOG_INSTALMENT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_DOG_INSTALMENT.sql =========*** En
PROMPT ===================================================================================== 
