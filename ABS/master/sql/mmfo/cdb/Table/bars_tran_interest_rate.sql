

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BARS_TRAN_INTEREST_RATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table BARS_TRAN_INTEREST_RATE ***
begin 
  execute immediate '
  CREATE TABLE CDB.BARS_TRAN_INTEREST_RATE 
   (	TRANSACTION_ID NUMBER(10,0), 
	RATE_KIND NUMBER(5,0), 
	RATE_DATE DATE, 
	RATE_VALUE NUMBER(22,12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BARS_TRAN_INTEREST_RATE IS '';
COMMENT ON COLUMN CDB.BARS_TRAN_INTEREST_RATE.TRANSACTION_ID IS '';
COMMENT ON COLUMN CDB.BARS_TRAN_INTEREST_RATE.RATE_KIND IS '';
COMMENT ON COLUMN CDB.BARS_TRAN_INTEREST_RATE.RATE_DATE IS '';
COMMENT ON COLUMN CDB.BARS_TRAN_INTEREST_RATE.RATE_VALUE IS '';




PROMPT *** Create  constraint SYS_C00118930 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRAN_INTEREST_RATE MODIFY (TRANSACTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118931 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRAN_INTEREST_RATE MODIFY (RATE_KIND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118932 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRAN_INTEREST_RATE MODIFY (RATE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BARS_TRAN_INTEREST_RATE ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRAN_INTEREST_RATE ADD CONSTRAINT PK_BARS_TRAN_INTEREST_RATE PRIMARY KEY (TRANSACTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_TRAN_INTEREST_RATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BARS_TRAN_INTEREST_RATE ON CDB.BARS_TRAN_INTEREST_RATE (TRANSACTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_TRAN_INTEREST_RATE ***
grant SELECT                                                                 on BARS_TRAN_INTEREST_RATE to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BARS_TRAN_INTEREST_RATE.sql =========**
PROMPT ===================================================================================== 
