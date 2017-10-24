

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/CUST_COMPANIES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table CUST_COMPANIES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.CUST_COMPANIES 
   (	BANK_ID VARCHAR2(11), 
	RNK NUMBER(*,0), 
	ARTICLE_NAME VARCHAR2(250), 
	HEAD_NAME VARCHAR2(70), 
	HEAD_PHONE VARCHAR2(30), 
	ACCOUNTANT_NAME VARCHAR2(70), 
	ACCOUNTANT_PHONE VARCHAR2(30), 
	FAX VARCHAR2(30), 
	EMAIL VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.CUST_COMPANIES IS '��������� �������� �����';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.BANK_ID IS '��� ����� �볺���';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.RNK IS 'RNK �볺���';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.ARTICLE_NAME IS '������������ �� ������';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.HEAD_NAME IS '��� ������������';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.HEAD_PHONE IS '������� ������������';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.ACCOUNTANT_NAME IS '��� ����������';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.ACCOUNTANT_PHONE IS '������� ����������';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.FAX IS '����';
COMMENT ON COLUMN BARSAQ.CUST_COMPANIES.EMAIL IS '����� ����������� �����';




PROMPT *** Create  constraint FK_CUSTCOMPANIES_CUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_COMPANIES ADD CONSTRAINT FK_CUSTCOMPANIES_CUSTOMERS FOREIGN KEY (BANK_ID, RNK)
	  REFERENCES BARSAQ.CUSTOMERS (BANK_ID, RNK) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTCOMPANIES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_COMPANIES ADD CONSTRAINT PK_CUSTCOMPANIES PRIMARY KEY (BANK_ID, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTCOMPANIES_HEADPHONE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_COMPANIES MODIFY (HEAD_PHONE CONSTRAINT CC_CUSTCOMPANIES_HEADPHONE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTCOMPANIES_HEADNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_COMPANIES MODIFY (HEAD_NAME CONSTRAINT CC_CUSTCOMPANIES_HEADNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTCOMPANIES_ARTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_COMPANIES MODIFY (ARTICLE_NAME CONSTRAINT CC_CUSTCOMPANIES_ARTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTCOMPANIES_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_COMPANIES MODIFY (RNK CONSTRAINT CC_CUSTCOMPANIES_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTCOMPANIES_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_COMPANIES MODIFY (BANK_ID CONSTRAINT CC_CUSTCOMPANIES_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTCOMPANIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_CUSTCOMPANIES ON BARSAQ.CUST_COMPANIES (BANK_ID, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/CUST_COMPANIES.sql =========*** End 
PROMPT ===================================================================================== 
