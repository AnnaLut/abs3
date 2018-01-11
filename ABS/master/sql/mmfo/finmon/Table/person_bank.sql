

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/PERSON_BANK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table PERSON_BANK ***
begin 
  execute immediate '
  CREATE TABLE FINMON.PERSON_BANK 
   (	ID VARCHAR2(15), 
	BANK_IDCODE VARCHAR2(25), 
	BANK_NAME VARCHAR2(254), 
	BANK_CNTRY VARCHAR2(254), 
	BANK_ADRES VARCHAR2(254), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.PERSON_BANK IS 'Список банков участников';
COMMENT ON COLUMN FINMON.PERSON_BANK.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.PERSON_BANK.ID IS 'Идентификатор записи';
COMMENT ON COLUMN FINMON.PERSON_BANK.BANK_IDCODE IS 'МФО или SWIFT BIC';
COMMENT ON COLUMN FINMON.PERSON_BANK.BANK_NAME IS 'Наименование банка';
COMMENT ON COLUMN FINMON.PERSON_BANK.BANK_CNTRY IS 'Код страны по справочнику НБУ';
COMMENT ON COLUMN FINMON.PERSON_BANK.BANK_ADRES IS 'Адрес банка';




PROMPT *** Create  constraint SYS_C00132673 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_BANK MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PERSON_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_BANK ADD CONSTRAINT XPK_PERSON_BANK PRIMARY KEY (ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_PERSONBANK_BIC ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_BANK MODIFY (BANK_IDCODE CONSTRAINT NK_PERSONBANK_BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PERSON_BANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_PERSON_BANK ON FINMON.PERSON_BANK (ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_BANK_BANKCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XAK_BANK_BANKCODE ON FINMON.PERSON_BANK (BANK_IDCODE, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERSON_BANK ***
grant SELECT                                                                 on PERSON_BANK     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/PERSON_BANK.sql =========*** End ***
PROMPT ===================================================================================== 
