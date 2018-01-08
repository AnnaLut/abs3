

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ACCOUNT_TARIFF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table ACCOUNT_TARIFF ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ACCOUNT_TARIFF 
   (	BANK_ID VARCHAR2(11), 
	ACC_NUM VARCHAR2(15), 
	CUR_ID NUMBER(3,0), 
	START_DATE DATE, 
	TARIFF_CODE NUMBER(38,0), 
	TARIFF_NAME VARCHAR2(75), 
	ONE_DOC_SUM NUMBER(24,0), 
	ONE_DOC_PERC NUMBER(24,4), 
	MIN_SUM NUMBER(24,0), 
	MAX_SUM NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ACCOUNT_TARIFF IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.BANK_ID IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.ACC_NUM IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.CUR_ID IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.START_DATE IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.TARIFF_CODE IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.TARIFF_NAME IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.ONE_DOC_SUM IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.ONE_DOC_PERC IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.MIN_SUM IS '';
COMMENT ON COLUMN BARSAQ.ACCOUNT_TARIFF.MAX_SUM IS '';




PROMPT *** Create  constraint PK_ACCOUN_TARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNT_TARIFF ADD CONSTRAINT PK_ACCOUN_TARIFF PRIMARY KEY (BANK_ID, ACC_NUM, CUR_ID, TARIFF_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFF_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNT_TARIFF MODIFY (BANK_ID CONSTRAINT CC_ACCTARIFF_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFF_ACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNT_TARIFF MODIFY (ACC_NUM CONSTRAINT CC_ACCTARIFF_ACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFF_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACCOUNT_TARIFF MODIFY (CUR_ID CONSTRAINT CC_ACCTARIFF_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUN_TARIFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_ACCOUN_TARIFF ON BARSAQ.ACCOUNT_TARIFF (BANK_ID, ACC_NUM, CUR_ID, TARIFF_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNT_TARIFF ***
grant SELECT                                                                 on ACCOUNT_TARIFF  to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ACCOUNT_TARIFF.sql =========*** End 
PROMPT ===================================================================================== 
