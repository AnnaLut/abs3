

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ACCOUNTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ACCOUNTS 
   (	BANK_ID VARCHAR2(11), 
	ACC_NUM VARCHAR2(15), 
	CUR_ID NUMBER(3,0), 
	RNK NUMBER(*,0), 
	NAME VARCHAR2(70), 
	BRANCH_ID VARCHAR2(30), 
	OPENING_DATE DATE, 
	CLOSING_DATE DATE, 
	PAF_ID NUMBER(1,0), 
	TYPE_ID VARCHAR2(30), 
	LOCK_DEBIT NUMBER(2,0) DEFAULT 0, 
	LOCK_CREDIT NUMBER(2,0) DEFAULT 0, 
	ALT_NAME VARCHAR2(70), 
	LIMIT NUMBER DEFAULT 0, 
	FIN_DATE DATE, 
	FIN_BALANCE NUMBER DEFAULT 0, 
	DEBIT_TURNS NUMBER DEFAULT 0, 
	CREDIT_TURNS NUMBER DEFAULT 0, 
	EQ_DATE DATE, 
	EQ_BALANCE NUMBER DEFAULT 0, 
	EQ_DEBIT_TURNS NUMBER DEFAULT 0, 
	EQ_CREDIT_TURNS NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ACCOUNTS IS 'Рахунки';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.BANK_ID IS 'Код банку, де відкрито рахунок';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.ACC_NUM IS 'Номер рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.CUR_ID IS 'Код валюти рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.RNK IS 'RNK клієнта-власника рахунку (реєстраційний номер клієнта в АБС)';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.NAME IS 'Назва рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.BRANCH_ID IS 'Код відділення банку, де відкрито рахунок';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.OPENING_DATE IS 'Дата відкриття рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.CLOSING_DATE IS 'Дата закриття рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.PAF_ID IS 'Признак актива/пасива';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.TYPE_ID IS 'Тип рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.LOCK_DEBIT IS 'Код блокування по дебету';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.LOCK_CREDIT IS 'Код блокування по кредиту';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.ALT_NAME IS 'Альтернативна назва рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.LIMIT IS 'Ліміт по рахунку';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.FIN_DATE IS 'дата останнього руху';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.FIN_BALANCE IS 'вихідний залишок в номіналі';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.DEBIT_TURNS IS 'дебетові обороти в номіналі';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.CREDIT_TURNS IS 'кредитові обороти в номіналі';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.EQ_DATE IS 'дата розрахунку еквіваленту';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.EQ_BALANCE IS 'вихідний залишок в еквіваленті';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.EQ_DEBIT_TURNS IS 'дебетові обороти в еквіваленті';
COMMENT ON COLUMN BARSAQ.ACCOUNTS.EQ_CREDIT_TURNS IS 'кредитові обороти в  еквіваленті';




PROMPT *** Create  constraint PK_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS ADD CONSTRAINT PK_ACCOUNTS PRIMARY KEY (BANK_ID, ACC_NUM, CUR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (BANK_ID CONSTRAINT CC_ACCOUNTS_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_ACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (ACC_NUM CONSTRAINT CC_ACCOUNTS_ACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (CUR_ID CONSTRAINT CC_ACCOUNTS_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (RNK CONSTRAINT CC_ACCOUNTS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_ACCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (NAME CONSTRAINT CC_ACCOUNTS_ACCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BRANCHID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (BRANCH_ID CONSTRAINT CC_ACCOUNTS_BRANCHID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_OPENINGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (OPENING_DATE CONSTRAINT CC_ACCOUNTS_OPENINGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_PAFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (PAF_ID CONSTRAINT CC_ACCOUNTS_PAFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (TYPE_ID CONSTRAINT CC_ACCOUNTS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_LOCKDEBIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (LOCK_DEBIT CONSTRAINT CC_ACCOUNTS_LOCKDEBIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_LOCKCREDIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (LOCK_CREDIT CONSTRAINT CC_ACCOUNTS_LOCKCREDIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_LIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (LIMIT CONSTRAINT CC_ACCOUNTS_LIMIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_FINDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (FIN_DATE CONSTRAINT CC_ACCOUNTS_FINDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_FINBAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (FIN_BALANCE CONSTRAINT CC_ACCOUNTS_FINBAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_DT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (DEBIT_TURNS CONSTRAINT CC_ACCOUNTS_DT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_CT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (CREDIT_TURNS CONSTRAINT CC_ACCOUNTS_CT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_EQDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (EQ_DATE CONSTRAINT CC_ACCOUNTS_EQDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_EQBAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (EQ_BALANCE CONSTRAINT CC_ACCOUNTS_EQBAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_EQDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (EQ_DEBIT_TURNS CONSTRAINT CC_ACCOUNTS_EQDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_EQCT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNTS MODIFY (EQ_CREDIT_TURNS CONSTRAINT CC_ACCOUNTS_EQCT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_ACCOUNTS ON BARSAQ.ACCOUNTS (BANK_ID, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_ACCOUNTS ON BARSAQ.ACCOUNTS (BANK_ID, ACC_NUM, CUR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Modify lock_debit ***
begin   
 execute immediate 'alter table BARSAQ.ACCOUNTS modify lock_debit NUMBER(3)';
end;
/

PROMPT *** Modify lock_credit ***
begin   
 execute immediate 'alter table BARSAQ.ACCOUNTS modify lock_credit NUMBER(3)';
end;
/


PROMPT *** Create  grants  ACCOUNTS ***
grant SELECT                                                                 on ACCOUNTS        to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ACCOUNTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
