

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_REG_HEADER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_REG_HEADER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_REG_HEADER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_REG_HEADER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ESCR_REG_HEADER'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_REG_HEADER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_REG_HEADER 
   (	ID NUMBER(38,0), 
	CUSTOMER_ID NUMBER(38,0), 
	CUSTOMER_NAME VARCHAR2(100), 
	CUSTOMER_OKPO VARCHAR2(111), 
	CUSTOMER_REGION VARCHAR2(4000), 
	CUSTOMER_FULL_ADDRESS VARCHAR2(4000), 
	SUBS_NUMB VARCHAR2(500), 
	SUBS_DATE DATE, 
	SUBS_DOC_TYPE VARCHAR2(500), 
	DEAL_ID NUMBER(10,0), 
	DEAL_NUMBER VARCHAR2(50), 
	DEAL_DATE_FROM DATE, 
	DEAL_DATE_TO DATE, 
	DEAL_TERM NUMBER, 
	DEAL_PRODUCT VARCHAR2(100), 
	DEAL_STATE VARCHAR2(35), 
	DEAL_TYPE_NAME VARCHAR2(70), 
	DEAL_SUM NUMBER, 
	GOOD_COST VARCHAR2(4000), 
	NLS VARCHAR2(15), 
	DOC_DATE DATE, 
	COMP_SUM NUMBER, 
	BRANCH_CODE VARCHAR2(30), 
	BRANCH_NAME VARCHAR2(70), 
	MFO VARCHAR2(6), 
	USER_ID NUMBER, 
	USER_NAME VARCHAR2(4000), 
	PAYMENT_REF VARCHAR2(4000), 
	NEW_GOOD_COST NUMBER, 
	NEW_DEAL_SUM NUMBER, 
	NEW_COMP_SUM NUMBER, 
	CREDIT_STATUS_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_REG_HEADER ***
 exec bpa.alter_policies('ESCR_REG_HEADER');


COMMENT ON TABLE BARS.ESCR_REG_HEADER IS 'Інформація по КД,які включені в реєстр';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.ID IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.CUSTOMER_ID IS 'РНК клієнта';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.CUSTOMER_NAME IS 'ПІБ клієнта';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.CUSTOMER_OKPO IS 'ІНН клієнта';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.CUSTOMER_REGION IS 'Область, в якій зареєстрований клієнт ';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.CUSTOMER_FULL_ADDRESS IS 'Повна адреса реєстрації клієнта';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.SUBS_NUMB IS 'Номер субсидії';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.SUBS_DATE IS 'Дата субсидії';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.SUBS_DOC_TYPE IS 'Тип документу по субсидії';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_ID IS 'Референс КД';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_NUMBER IS 'Номер КД';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_DATE_FROM IS 'Дата початку дії КД';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_DATE_TO IS 'Дата закінчення дії КД';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_TERM IS 'Період дії КД в місяцях';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_PRODUCT IS 'Код продутку КД';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_STATE IS 'Статус КД';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_TYPE_NAME IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DEAL_SUM IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.GOOD_COST IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.NLS IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.DOC_DATE IS 'Дата отримання документів про цільове використання';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.COMP_SUM IS 'Сума компенсації';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.BRANCH_CODE IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.BRANCH_NAME IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.MFO IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.USER_ID IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.USER_NAME IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.PAYMENT_REF IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.NEW_GOOD_COST IS 'Частина суми придбаного товару,яка підлягає компенсації';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.NEW_DEAL_SUM IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.NEW_COMP_SUM IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.CREDIT_STATUS_ID IS '';
COMMENT ON COLUMN BARS.ESCR_REG_HEADER.KF IS '';




PROMPT *** Create  constraint PK_ESCR_REG_HEADER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT PK_ESCR_REG_HEADER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ESCR_REG_HEADER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT UK_ESCR_REG_HEADER UNIQUE (CUSTOMER_ID, DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_USER_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_USER_NAME CHECK (USER_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_CUSTOMER21 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_CUSTOMER21 CHECK (CUSTOMER_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_CUSTOMER22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_CUSTOMER22 CHECK (CUSTOMER_OKPO IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_CUSTOMER23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_CUSTOMER23 CHECK (CUSTOMER_REGION IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_CUSTOMER1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_CUSTOMER1 CHECK (CUSTOMER_FULL_ADDRESS IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_ID CHECK (DEAL_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_NUMBER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_NUMBER CHECK (DEAL_NUMBER IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_DAT4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_DAT4 CHECK (DEAL_DATE_FROM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_DAT5 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_DAT5 CHECK (DEAL_DATE_TO IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_TERM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_TERM CHECK (DEAL_TERM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_PRO7 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_PRO7 CHECK (DEAL_PRODUCT IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_STATE CHECK (DEAL_STATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_TYP9 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_TYP9 CHECK (DEAL_TYPE_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DEAL_SUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DEAL_SUM CHECK (DEAL_SUM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_NLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_NLS CHECK (NLS IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_DOC_DATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_DOC_DATE CHECK (DOC_DATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_COMP_SUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_COMP_SUM CHECK (COMP_SUM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_BRANCH_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_BRANCH_CODE CHECK (BRANCH_CODE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_BRANCH_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_BRANCH_NAME CHECK (BRANCH_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_MFO CHECK (MFO IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_USER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_USER_ID CHECK (USER_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_HEADER_CUSTOMER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_HEADER ADD CONSTRAINT CC_ESCR_REG_HEADER_CUSTOMER_ID CHECK (CUSTOMER_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ESCR_REG_HEADER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ESCR_REG_HEADER ON BARS.ESCR_REG_HEADER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ESCR_REG_HEADER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ESCR_REG_HEADER ON BARS.ESCR_REG_HEADER (CUSTOMER_ID, DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REG_HEADER ***
grant SELECT                                                                 on ESCR_REG_HEADER to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_REG_HEADER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ESCR_REG_HEADER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_REG_HEADER.sql =========*** End *
PROMPT ===================================================================================== 
