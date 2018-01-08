

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/BANKS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  table BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.BANKS 
   (	BANK_ID VARCHAR2(11), 
	NAME VARCHAR2(254), 
	CLOSING_DATE DATE, 
	 CONSTRAINT PK_BANKS PRIMARY KEY (BANK_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.BANKS IS 'Довідник локальних банків';
COMMENT ON COLUMN BARSAQ.BANKS.BANK_ID IS 'ID(код) банку';
COMMENT ON COLUMN BARSAQ.BANKS.NAME IS 'Назва банку';
COMMENT ON COLUMN BARSAQ.BANKS.CLOSING_DATE IS 'Дата закриття банку(null - працюючий банк)';




PROMPT *** Create  constraint CC_BANKS_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BANKS MODIFY (BANK_ID CONSTRAINT CC_BANKS_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BANKS MODIFY (NAME CONSTRAINT CC_BANKS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BANKS ADD CONSTRAINT PK_BANKS PRIMARY KEY (BANK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_BANKS ON BARSAQ.BANKS (BANK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKS ***
grant SELECT                                                                 on BANKS           to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/BANKS.sql =========*** End *** =====
PROMPT ===================================================================================== 
