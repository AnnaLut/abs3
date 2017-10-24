

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_TRANSACTION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_TRANSACTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_TRANSACTION'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOTARY_TRANSACTION'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_TRANSACTION'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_TRANSACTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_TRANSACTION 
   (	ID NUMBER(10,0), 
	ACCREDITATION_ID NUMBER(10,0), 
	TRANSACTION_TYPE_ID NUMBER(5,0), 
	TRANSACTION_DETAILS VARCHAR2(4000), 
	TRANSACTION_DATE DATE, 
	INCOME_AMOUNT NUMBER(22,2), 
	BRANCH_ID VARCHAR2(30 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_TRANSACTION ***
 exec bpa.alter_policies('NOTARY_TRANSACTION');


COMMENT ON TABLE BARS.NOTARY_TRANSACTION IS 'Інформація про доходи, що отримав банк в результті співпраці з нотаріусами';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION.ID IS 'Унікальний ідентифікатор транзакції';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION.ACCREDITATION_ID IS 'Ідентифікатор акредитації, в рамках якої виконана транзакція';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION.TRANSACTION_TYPE_ID IS 'Тип нотаріальної дії, що здійснювалася нотаріусом';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION.TRANSACTION_DETAILS IS 'Номер договору застави або номер документа, що посвідчував нотаріус, або інша інформація, що надасть додаткові відомості про операцію, що здійснив нотаріус';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION.TRANSACTION_DATE IS 'Дата здійснення нотаріальної дії';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION.INCOME_AMOUNT IS 'Сума доходу, що отримав банк внаслідок здійснення даної транзакції';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION.BRANCH_ID IS 'Бранч, в якому виконана дата транзакція';




PROMPT *** Create  constraint FK_NOTARY_TRAN_REF_ACCRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION ADD CONSTRAINT FK_NOTARY_TRAN_REF_ACCRED FOREIGN KEY (ACCREDITATION_ID)
	  REFERENCES BARS.NOTARY_ACCREDITATION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007426 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007427 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION MODIFY (ACCREDITATION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007428 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION MODIFY (TRANSACTION_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007429 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION MODIFY (TRANSACTION_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007430 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION MODIFY (INCOME_AMOUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007431 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NOTARY_TRANSACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION ADD CONSTRAINT PK_NOTARY_TRANSACTION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTARY_TRANSACTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTARY_TRANSACTION ON BARS.NOTARY_TRANSACTION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_TRANSACTION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY_TRANSACTION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_TRANSACTION.sql =========*** En
PROMPT ===================================================================================== 
