

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/TMP_IMP_DEALS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_IMP_DEALS ***
begin 
  execute immediate '
  CREATE TABLE CDB.TMP_IMP_DEALS 
   (	ID NUMBER(10,0), 
	DEAL_NUMBER VARCHAR2(50 CHAR), 
	START_DATE DATE, 
	EXPIRY_DATE DATE, 
	DEAL_AMOUNT NUMBER(24,4), 
	DEAL_CURRENCY NUMBER(3,0), 
	INTEREST_CALENDAR NUMBER(*,0), 
	LENDER_MFO VARCHAR2(6 CHAR), 
	BORROWER_MFO VARCHAR2(6 CHAR), 
	BARS_LOAN_ID NUMBER(10,0), 
	BARS_LOAN_ACCOUNT_ID NUMBER(10,0), 
	BARS_LOAN_ACCOUNT VARCHAR2(15 CHAR), 
	BARS_LOAN_INT_ACCOUNT_ID NUMBER(10,0), 
	BARS_LOAN_INT_ACCOUNT VARCHAR2(15 CHAR), 
	LOAN_TRANSIT_ACCOUNT VARCHAR2(15 CHAR), 
	BARS_DEPOSIT_ID NUMBER(10,0), 
	BARS_DEPOSIT_ACCOUNT_ID NUMBER(10,0), 
	BARS_DEPOSIT_ACCOUNT VARCHAR2(15 CHAR), 
	BARS_DEPOSIT_INT_ACCOUNT_ID NUMBER(10,0), 
	BARS_DEPOSIT_INT_ACCOUNT VARCHAR2(15 CHAR), 
	DEPOSIT_TRANSIT_ACCOUNT VARCHAR2(15 CHAR), 
	STATE NUMBER(5,0), 
	STATE_MESSAGE VARCHAR2(4000), 
	CDB_DEAL_ID NUMBER(10,0), 
	CDB_LOAN_ID NUMBER(10,0), 
	CDB_DEPOSIT_ID NUMBER(10,0), 
	CDB_LOAN_ACCOUNT_ID NUMBER(10,0), 
	CDB_LOAN_INT_ACCOUNT_ID NUMBER(10,0), 
	CDB_DEPOSIT_ACCOUNT_ID NUMBER(10,0), 
	CDB_DEPOSIT_INT_ACCOUNT_ID NUMBER(10,0), 
	CDB_LENDER_ID NUMBER(5,0), 
	CDB_BORROWER_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.TMP_IMP_DEALS IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.DEAL_NUMBER IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.START_DATE IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.EXPIRY_DATE IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.DEAL_AMOUNT IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.DEAL_CURRENCY IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.INTEREST_CALENDAR IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.LENDER_MFO IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BORROWER_MFO IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_LOAN_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_LOAN_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_LOAN_ACCOUNT IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_LOAN_INT_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_LOAN_INT_ACCOUNT IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.LOAN_TRANSIT_ACCOUNT IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_DEPOSIT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_DEPOSIT_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_DEPOSIT_ACCOUNT IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_DEPOSIT_INT_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.BARS_DEPOSIT_INT_ACCOUNT IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.DEPOSIT_TRANSIT_ACCOUNT IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.STATE IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.STATE_MESSAGE IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_DEAL_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_LOAN_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_DEPOSIT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_LOAN_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_LOAN_INT_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_DEPOSIT_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_DEPOSIT_INT_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_LENDER_ID IS '';
COMMENT ON COLUMN CDB.TMP_IMP_DEALS.CDB_BORROWER_ID IS '';




PROMPT *** Create  constraint SYS_C00118981 ***
begin   
 execute immediate '
  ALTER TABLE CDB.TMP_IMP_DEALS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00118981 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.SYS_C00118981 ON CDB.TMP_IMP_DEALS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_IMP_DEALS ***
grant SELECT                                                                 on TMP_IMP_DEALS   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/TMP_IMP_DEALS.sql =========*** End *** 
PROMPT ===================================================================================== 
