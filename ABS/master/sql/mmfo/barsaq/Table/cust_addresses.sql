

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/CUST_ADDRESSES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table CUST_ADDRESSES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.CUST_ADDRESSES 
   (	RNK NUMBER(*,0), 
	TYPE_ID NUMBER(38,0), 
	COUNTRY_ID NUMBER(3,0), 
	ZIP VARCHAR2(20 CHAR), 
	REGION VARCHAR2(30 CHAR), 
	DISTRICT VARCHAR2(30 CHAR), 
	CITY VARCHAR2(30 CHAR), 
	ADDRESS VARCHAR2(100 CHAR), 
	BANK_ID VARCHAR2(11 CHAR), 
	 CONSTRAINT PK_CUST_ADDRESSES PRIMARY KEY (RNK, TYPE_ID, BANK_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.CUST_ADDRESSES IS 'Адреси контрагентів';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.RNK IS 'Код контрагента';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.TYPE_ID IS 'Код типу адреси';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.COUNTRY_ID IS 'Код країни';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.ZIP IS 'Поштовий індекс';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.REGION IS 'Область';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.DISTRICT IS 'Район';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.CITY IS 'Населений пункт';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.ADDRESS IS 'Адреса';
COMMENT ON COLUMN BARSAQ.CUST_ADDRESSES.BANK_ID IS '';




PROMPT *** Create  constraint CC_CUSTADDRESSES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_ADDRESSES MODIFY (TYPE_ID CONSTRAINT CC_CUSTADDRESSES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRESSES_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_ADDRESSES MODIFY (RNK CONSTRAINT CC_CUSTADDRESSES_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRESSES_COUNTRY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_ADDRESSES MODIFY (COUNTRY_ID CONSTRAINT CC_CUSTADDRESSES_COUNTRY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRESSES_BANKID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_ADDRESSES MODIFY (BANK_ID CONSTRAINT CC_CUSTADDRESSES_BANKID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUST_ADDRESSES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CUST_ADDRESSES ADD CONSTRAINT PK_CUST_ADDRESSES PRIMARY KEY (RNK, TYPE_ID, BANK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUST_ADDRESSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_CUST_ADDRESSES ON BARSAQ.CUST_ADDRESSES (RNK, TYPE_ID, BANK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/CUST_ADDRESSES.sql =========*** End 
PROMPT ===================================================================================== 
