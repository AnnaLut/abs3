

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/CUST_INDIVIDUALS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table CUST_INDIVIDUALS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.CUST_INDIVIDUALS 
   (	BANK_ID VARCHAR2(11), 
	RNK NUMBER(*,0), 
	ID_ID NUMBER(*,0), 
	ID_SERIAL VARCHAR2(10), 
	ID_NUMBER VARCHAR2(20), 
	ID_DATE DATE, 
	ID_ISSUER VARCHAR2(70), 
	BIRTHDAY DATE, 
	BIRTHPLACE VARCHAR2(70), 
	PHONE_HOME VARCHAR2(30), 
	PHONE_WORK VARCHAR2(30), 
	PHONE_MOBILE VARCHAR2(30), 
	EMAIL VARCHAR2(128), 
	ID_DATE_VALID DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.CUST_INDIVIDUALS IS 'Реквизиты физлиц';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.ID_DATE_VALID IS 'Дійсний до';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.BANK_ID IS 'Код банку клієнта';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.RNK IS 'RNK клієнта';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.ID_ID IS 'Код документа(1-паспорт,2-военный билет и т.д.)';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.ID_SERIAL IS 'Серия документа';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.ID_NUMBER IS 'Номер документа';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.ID_DATE IS 'Дата документа';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.ID_ISSUER IS 'Издатель документа';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.BIRTHDAY IS 'Дата рождения';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.BIRTHPLACE IS 'Место рождения';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.PHONE_HOME IS 'Телефон домашний';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.PHONE_WORK IS 'Телефон рабочий';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.PHONE_MOBILE IS 'Телефон мобильный';
COMMENT ON COLUMN BARSAQ.CUST_INDIVIDUALS.EMAIL IS 'Адрес электронной почты';




PROMPT *** Create  constraint PK_CUSTINDIVID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS ADD CONSTRAINT PK_CUSTINDIVID PRIMARY KEY (BANK_ID, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_IDSERIAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS ADD CONSTRAINT CC_CUSTINDIVID_IDSERIAL_NN CHECK (id_serial is not null or (id_id = 7 and id_serial is null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (BANK_ID CONSTRAINT CC_CUSTINDIVID_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (RNK CONSTRAINT CC_CUSTINDIVID_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_IDID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (ID_ID CONSTRAINT CC_CUSTINDIVID_IDID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_IDNUMBER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (ID_NUMBER CONSTRAINT CC_CUSTINDIVID_IDNUMBER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_IDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (ID_DATE CONSTRAINT CC_CUSTINDIVID_IDDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_IDISSUER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (ID_ISSUER CONSTRAINT CC_CUSTINDIVID_IDISSUER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_BIRTHDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (BIRTHDAY CONSTRAINT CC_CUSTINDIVID_BIRTHDAY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTINDIVID_BIRTHPLACE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_INDIVIDUALS MODIFY (BIRTHPLACE CONSTRAINT CC_CUSTINDIVID_BIRTHPLACE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTINDIVID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_CUSTINDIVID ON BARSAQ.CUST_INDIVIDUALS (BANK_ID, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_INDIVIDUALS ***
grant SELECT                                                                 on CUST_INDIVIDUALS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/CUST_INDIVIDUALS.sql =========*** En
PROMPT ===================================================================================== 
