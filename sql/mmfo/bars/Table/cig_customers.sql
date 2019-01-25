

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_CUSTOMERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_CUSTOMERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_CUSTOMERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_CUSTOMERS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CIG_CUSTOMERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_CUSTOMERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_CUSTOMERS 
   (	CUST_ID NUMBER(38,0), 
	CUST_TYPE NUMBER(38,0), 
	RNK NUMBER(38,0), 
	UPD_DATE DATE, 
	SYNC_DATE DATE, 
	CUST_NAME VARCHAR2(128), 
	CUST_CODE VARCHAR2(14), 
	LAST_ERR VARCHAR2(1), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_CUSTOMERS ***
 exec bpa.alter_policies('CIG_CUSTOMERS');


COMMENT ON TABLE BARS.CIG_CUSTOMERS IS 'Таблиця персональних відомостей ЮО';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.CUST_ID IS 'Код клієнта';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.CUST_TYPE IS 'Тип клієнта';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.RNK IS 'Код клієнта (АБС)';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.UPD_DATE IS 'Дата оновлення реквізитів клієнта';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.SYNC_DATE IS 'Дата передачі реквізитів до центральної бази';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.CUST_NAME IS 'Назва';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.CUST_CODE IS 'Ідентифікаційний номер клієнта';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.LAST_ERR IS 'Наявність помилки при останній обробці ('E' - помилка)';
COMMENT ON COLUMN BARS.CIG_CUSTOMERS.BRANCH IS '';




PROMPT *** Create  constraint PK_CIGCUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS ADD CONSTRAINT PK_CIGCUSTOMERS PRIMARY KEY (CUST_ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CIGCUSTOMERS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS ADD CONSTRAINT UK_CIGCUSTOMERS_RNK UNIQUE (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTOMERS_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS MODIFY (CUST_ID CONSTRAINT CC_CIGCUSTOMERS_CUSTID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTOMERS_CUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS MODIFY (CUST_TYPE CONSTRAINT CC_CIGCUSTOMERS_CUSTTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTOMERS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS MODIFY (RNK CONSTRAINT CC_CIGCUSTOMERS_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTOMERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS MODIFY (CUST_NAME CONSTRAINT CC_CIGCUSTOMERS_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTOMERS_CUSTCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS MODIFY (CUST_CODE CONSTRAINT CC_CIGCUSTOMERS_CUSTCODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTOMERS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS MODIFY (BRANCH CONSTRAINT CC_CIGCUSTOMERS_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGCUSTOMERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGCUSTOMERS ON BARS.CIG_CUSTOMERS (CUST_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIGCUSTOMERS_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CIGCUSTOMERS_RNK ON BARS.CIG_CUSTOMERS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_CUSTOMERS ***
grant SELECT                                                                 on CIG_CUSTOMERS   to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on CIG_CUSTOMERS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_CUSTOMERS   to BARS_DM;
grant SELECT,UPDATE                                                          on CIG_CUSTOMERS   to CIG_ROLE;
grant SELECT                                                                 on CIG_CUSTOMERS   to UPLD;



PROMPT *** Create SYNONYM  to CIG_CUSTOMERS ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_CUSTOMERS FOR BARS.CIG_CUSTOMERS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_CUSTOMERS.sql =========*** End ***
PROMPT ===================================================================================== 
