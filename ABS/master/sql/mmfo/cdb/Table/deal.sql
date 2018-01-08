

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/DEAL.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  table DEAL ***
begin 
  execute immediate '
  CREATE TABLE CDB.DEAL 
   (	ID NUMBER(10,0), 
	DEAL_NUMBER VARCHAR2(30 CHAR), 
	LENDER_ID NUMBER(5,0), 
	BORROWER_ID NUMBER(5,0), 
	OPEN_DATE DATE, 
	EXPIRY_DATE DATE, 
	CLOSE_DATE DATE, 
	AMOUNT NUMBER(22,2), 
	CURRENCY_ID NUMBER(3,0), 
	BASE_YEAR NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.DEAL IS '';
COMMENT ON COLUMN CDB.DEAL.ID IS '';
COMMENT ON COLUMN CDB.DEAL.DEAL_NUMBER IS '';
COMMENT ON COLUMN CDB.DEAL.LENDER_ID IS '';
COMMENT ON COLUMN CDB.DEAL.BORROWER_ID IS '';
COMMENT ON COLUMN CDB.DEAL.OPEN_DATE IS '';
COMMENT ON COLUMN CDB.DEAL.EXPIRY_DATE IS '';
COMMENT ON COLUMN CDB.DEAL.CLOSE_DATE IS '';
COMMENT ON COLUMN CDB.DEAL.AMOUNT IS '';
COMMENT ON COLUMN CDB.DEAL.CURRENCY_ID IS '';
COMMENT ON COLUMN CDB.DEAL.BASE_YEAR IS '';




PROMPT *** Create  constraint SYS_C00118897 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118898 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL MODIFY (DEAL_NUMBER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118899 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL MODIFY (LENDER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118900 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL MODIFY (BORROWER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118901 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL MODIFY (OPEN_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118902 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL MODIFY (EXPIRY_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEAL ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL ADD CONSTRAINT PK_DEAL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DEAL ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL ADD CONSTRAINT UK_DEAL UNIQUE (DEAL_NUMBER, CURRENCY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_DEAL ON CDB.DEAL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.UK_DEAL ON CDB.DEAL (DEAL_NUMBER, CURRENCY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEAL ***
grant SELECT                                                                 on DEAL            to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/DEAL.sql =========*** End *** =========
PROMPT ===================================================================================== 
