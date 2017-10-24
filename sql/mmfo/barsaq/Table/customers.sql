

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/CUSTOMERS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table CUSTOMERS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.CUSTOMERS 
   (	BANK_ID VARCHAR2(11), 
	RNK NUMBER(*,0), 
	TYPE_ID NUMBER(1,0), 
	NAME VARCHAR2(70), 
	ENGLISH_NAME VARCHAR2(70), 
	SHORT_NAME VARCHAR2(35), 
	CUST_CODE VARCHAR2(14), 
	PRT_ID NUMBER(1,0), 
	COUNTRY_ID NUMBER(3,0), 
	COV_ID NUMBER(1,0), 
	INSIDER_ID NUMBER(38,0), 
	OPENED DATE DEFAULT trunc(sysdate), 
	CLOSED DATE, 
	NOTES VARCHAR2(512), 
	CUST_LIMIT NUMBER(38,0), 
	RUSSIAN_NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.CUSTOMERS IS 'Клієнти';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.BANK_ID IS 'Код банку клієнта';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.RNK IS 'RNK клієнта';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.TYPE_ID IS 'Тип клієнта';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.NAME IS 'Найменування';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.ENGLISH_NAME IS '';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.SHORT_NAME IS 'Коротке найменування';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.CUST_CODE IS 'Ідентифікаційний код';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.PRT_ID IS 'Тип державного реєстру';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.COUNTRY_ID IS 'Код країни';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.COV_ID IS 'Код характеристики контрагента';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.INSIDER_ID IS 'Код інсайдера
(використовується для розмежування прав на різні види вкладів, на бонуси, відсоткові ставки)';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.OPENED IS 'Дата відкриття';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.CLOSED IS 'Дата закриття';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.NOTES IS 'Нотатки';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.CUST_LIMIT IS 'Ліміт';
COMMENT ON COLUMN BARSAQ.CUSTOMERS.RUSSIAN_NAME IS '';




PROMPT *** Create  constraint CC_CUSTOMERS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (TYPE_ID CONSTRAINT CC_CUSTOMERS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (RNK CONSTRAINT CC_CUSTOMERS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (OPENED CONSTRAINT CC_CUSTOMERS_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_INSIDERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (INSIDER_ID CONSTRAINT CC_CUSTOMERS_INSIDERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_COVID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (COV_ID CONSTRAINT CC_CUSTOMERS_COVID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_COUNTRYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (COUNTRY_ID CONSTRAINT CC_CUSTOMERS_COUNTRYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_PRTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (PRT_ID CONSTRAINT CC_CUSTOMERS_PRTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_CUSTCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (CUST_CODE CONSTRAINT CC_CUSTOMERS_CUSTCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (BANK_ID CONSTRAINT CC_CUSTOMERS_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_CLOSED ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS ADD CONSTRAINT CC_CUSTOMERS_CLOSED CHECK (closed = trunc(closed)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS ADD CONSTRAINT PK_CUSTOMERS PRIMARY KEY (BANK_ID, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (NAME CONSTRAINT CC_CUSTOMERS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_ENGLISHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (ENGLISH_NAME CONSTRAINT CC_CUSTOMERS_ENGLISHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_SHORTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUSTOMERS MODIFY (SHORT_NAME CONSTRAINT CC_CUSTOMERS_SHORTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_CUSTOMERS ON BARSAQ.CUSTOMERS (BANK_ID, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CUSTOMERS ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_CUSTOMERS ON BARSAQ.CUSTOMERS (CUST_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CUSTOMERS ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I2_CUSTOMERS ON BARSAQ.CUSTOMERS (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/CUSTOMERS.sql =========*** End *** =
PROMPT ===================================================================================== 
