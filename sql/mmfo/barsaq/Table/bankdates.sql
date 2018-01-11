

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/BANKDATES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table BANKDATES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.BANKDATES 
   (	BANK_ID VARCHAR2(11), 
	BANKDATE DATE, 
	 CONSTRAINT PK_BANKDATES PRIMARY KEY (BANK_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.BANKDATES IS 'Банковские даты(текущие)';
COMMENT ON COLUMN BARSAQ.BANKDATES.BANK_ID IS 'ID банка';
COMMENT ON COLUMN BARSAQ.BANKDATES.BANKDATE IS 'Банковская дата';




PROMPT *** Create  constraint CC_BANKDATES_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BANKDATES MODIFY (BANK_ID CONSTRAINT CC_BANKDATES_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKDATES_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BANKDATES MODIFY (BANKDATE CONSTRAINT CC_BANKDATES_BANKDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BANKDATES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BANKDATES ADD CONSTRAINT PK_BANKDATES PRIMARY KEY (BANK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKDATES_BANKDATE_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BANKDATES ADD CONSTRAINT CC_BANKDATES_BANKDATE_CC CHECK (trunc(bankdate)=bankdate) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKDATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_BANKDATES ON BARSAQ.BANKDATES (BANK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKDATES ***
grant SELECT                                                                 on BANKDATES       to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/BANKDATES.sql =========*** End *** =
PROMPT ===================================================================================== 
