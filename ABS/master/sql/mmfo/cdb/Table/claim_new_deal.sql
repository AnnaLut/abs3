

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CLAIM_NEW_DEAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table CLAIM_NEW_DEAL ***
begin 
  execute immediate '
  CREATE TABLE CDB.CLAIM_NEW_DEAL 
   (	CLAIM_ID NUMBER(10,0), 
	DEAL_NUMBER VARCHAR2(50 CHAR), 
	OPEN_DATE DATE, 
	EXPIRY_DATE DATE, 
	LENDER_CODE VARCHAR2(30 CHAR), 
	BORROWER_CODE VARCHAR2(30 CHAR), 
	AMOUNT NUMBER(32,2), 
	CURRENCY_ID NUMBER(3,0), 
	INTEREST_RATE NUMBER(22,12), 
	BASE_YEAR NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.CLAIM_NEW_DEAL IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.CLAIM_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.DEAL_NUMBER IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.OPEN_DATE IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.EXPIRY_DATE IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.LENDER_CODE IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.BORROWER_CODE IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.AMOUNT IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.CURRENCY_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.INTEREST_RATE IS '';
COMMENT ON COLUMN CDB.CLAIM_NEW_DEAL.BASE_YEAR IS '';




PROMPT *** Create  constraint SYS_C00118933 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_NEW_DEAL MODIFY (CLAIM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLAIM_NEW_DEAL ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_NEW_DEAL ADD CONSTRAINT PK_CLAIM_NEW_DEAL PRIMARY KEY (CLAIM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLAIM_NEW_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CLAIM_NEW_DEAL ON CDB.CLAIM_NEW_DEAL (CLAIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLAIM_NEW_DEAL ***
grant SELECT                                                                 on CLAIM_NEW_DEAL  to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CLAIM_NEW_DEAL.sql =========*** End ***
PROMPT ===================================================================================== 
