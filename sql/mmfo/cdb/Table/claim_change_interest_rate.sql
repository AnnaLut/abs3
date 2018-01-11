

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CLAIM_CHANGE_INTEREST_RATE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  table CLAIM_CHANGE_INTEREST_RATE ***
begin 
  execute immediate '
  CREATE TABLE CDB.CLAIM_CHANGE_INTEREST_RATE 
   (	CLAIM_ID NUMBER(10,0), 
	DEAL_NUMBER VARCHAR2(30 CHAR), 
	INTEREST_RATE_DATE DATE, 
	INTEREST_RATE NUMBER, 
	CURRENCY_ID NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.CLAIM_CHANGE_INTEREST_RATE IS '';
COMMENT ON COLUMN CDB.CLAIM_CHANGE_INTEREST_RATE.CLAIM_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_CHANGE_INTEREST_RATE.DEAL_NUMBER IS '';
COMMENT ON COLUMN CDB.CLAIM_CHANGE_INTEREST_RATE.INTEREST_RATE_DATE IS '';
COMMENT ON COLUMN CDB.CLAIM_CHANGE_INTEREST_RATE.INTEREST_RATE IS '';
COMMENT ON COLUMN CDB.CLAIM_CHANGE_INTEREST_RATE.CURRENCY_ID IS '';




PROMPT *** Create  constraint SYS_C00118925 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_CHANGE_INTEREST_RATE MODIFY (CLAIM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLAIM_CHANGE_INTEREST_RATE ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_CHANGE_INTEREST_RATE ADD CONSTRAINT PK_CLAIM_CHANGE_INTEREST_RATE PRIMARY KEY (CLAIM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLAIM_CHANGE_INTEREST_RATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CLAIM_CHANGE_INTEREST_RATE ON CDB.CLAIM_CHANGE_INTEREST_RATE (CLAIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLAIM_CHANGE_INTEREST_RATE ***
grant SELECT                                                                 on CLAIM_CHANGE_INTEREST_RATE to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CLAIM_CHANGE_INTEREST_RATE.sql ========
PROMPT ===================================================================================== 
