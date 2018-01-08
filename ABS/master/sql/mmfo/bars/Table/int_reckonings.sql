

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_RECKONINGS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_RECKONINGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_RECKONINGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_RECKONINGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT_RECKONINGS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_RECKONINGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_RECKONINGS 
   (	ID NUMBER(38,0), 
	LINE_TYPE_ID NUMBER(5,0), 
	DEAL_ID NUMBER(38,0), 
	ACCOUNT_ID NUMBER(38,0), 
	INTEREST_KIND_ID NUMBER(5,0), 
	DATE_FROM DATE, 
	DATE_THROUGH DATE, 
	ACCOUNT_REST NUMBER(38,0), 
	INTEREST_RATE NUMBER(38,12), 
	INTEREST_AMOUNT NUMBER(38,0), 
	INTEREST_TAIL NUMBER, 
	STATE_ID NUMBER(5,0), 
	GROUPING_LINE_ID NUMBER(38,0), 
	ACCRUAL_PURPOSE VARCHAR2(160 CHAR), 
	PAYMENT_PURPOSE VARCHAR2(160 CHAR), 
	ACCRUAL_DOCUMENT_ID NUMBER(38,0), 
	PAYMENT_DOCUMENT_ID NUMBER(38,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
  PARTITION BY RANGE (DATE_FROM) INTERVAL (NUMTOYMINTERVAL(1, ''MONTH'')) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (TO_DATE('' 2017-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD )  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_RECKONINGS ***
 exec bpa.alter_policies('INT_RECKONINGS');


COMMENT ON TABLE BARS.INT_RECKONINGS IS 'Дані розрахунків/нарахувань/виплат відсотків по рахунках';
COMMENT ON COLUMN BARS.INT_RECKONINGS.ID IS 'Ідентифікатор розрахунку відсотків';
COMMENT ON COLUMN BARS.INT_RECKONINGS.LINE_TYPE_ID IS 'Тип даних по відсотках (код довідника "RECKONING_LINE_TYPE")';
COMMENT ON COLUMN BARS.INT_RECKONINGS.DEAL_ID IS 'Ідентифікатор угоди, до якої відноситься розрахунок відсотків';
COMMENT ON COLUMN BARS.INT_RECKONINGS.ACCOUNT_ID IS 'Ідентифікатор рахунку по якому виконується розрахунок відсотків';
COMMENT ON COLUMN BARS.INT_RECKONINGS.INTEREST_KIND_ID IS 'Вид розрахунку відсотків (довідник - таблиця int_idn)';
COMMENT ON COLUMN BARS.INT_RECKONINGS.DATE_FROM IS 'Дата початку періоду (включається в період)';
COMMENT ON COLUMN BARS.INT_RECKONINGS.DATE_THROUGH IS 'Дата завершення періоду (включається в період)';
COMMENT ON COLUMN BARS.INT_RECKONINGS.ACCOUNT_REST IS 'Залишок рахунку протягом періоду нарахування';
COMMENT ON COLUMN BARS.INT_RECKONINGS.INTEREST_RATE IS 'Відсоткова ставка, що діє протягом періоду нарахування';
COMMENT ON COLUMN BARS.INT_RECKONINGS.INTEREST_AMOUNT IS 'Сума відсотків';
COMMENT ON COLUMN BARS.INT_RECKONINGS.INTEREST_TAIL IS 'Залишок дробової частини відсотків';
COMMENT ON COLUMN BARS.INT_RECKONINGS.STATE_ID IS 'Стан обробки запису (код довідника "INTEREST_RECKONING_STATE")';
COMMENT ON COLUMN BARS.INT_RECKONINGS.GROUPING_LINE_ID IS 'Ідентифікатор групуючого запису, що об'єднує сиру аналітику розрахунку відсотків';
COMMENT ON COLUMN BARS.INT_RECKONINGS.ACCRUAL_PURPOSE IS 'Встановлене вручну призначення документа нарахування';
COMMENT ON COLUMN BARS.INT_RECKONINGS.PAYMENT_PURPOSE IS 'Встановлене вручну призначення документа виплати відсотків';
COMMENT ON COLUMN BARS.INT_RECKONINGS.ACCRUAL_DOCUMENT_ID IS 'Ідентифікатор документу нарахування';
COMMENT ON COLUMN BARS.INT_RECKONINGS.PAYMENT_DOCUMENT_ID IS 'Ідентифікатор документу виплати (для пасивів)';




PROMPT *** Create  constraint SYS_C00132265 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132266 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS MODIFY (LINE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132267 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS MODIFY (ACCOUNT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132268 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS MODIFY (INTEREST_KIND_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132269 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS MODIFY (DATE_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132270 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS MODIFY (DATE_THROUGH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132271 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INT_RECKONINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS ADD CONSTRAINT PK_INT_RECKONINGS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INT_RECKONINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INT_RECKONINGS ON BARS.INT_RECKONINGS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INT_RECKONINGS_ACCOUNT_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_INT_RECKONINGS_ACCOUNT_ID ON BARS.INT_RECKONINGS (ACCOUNT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INT_RECKONINGS_GROUP_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_INT_RECKONINGS_GROUP_ID ON BARS.INT_RECKONINGS (GROUPING_LINE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INT_RECKONINGS_ACCR_DOC_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_INT_RECKONINGS_ACCR_DOC_ID ON BARS.INT_RECKONINGS (ACCRUAL_DOCUMENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INT_RECKONINGS_PAYM_DOC_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_INT_RECKONINGS_PAYM_DOC_ID ON BARS.INT_RECKONINGS (PAYMENT_DOCUMENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_RECKONINGS ***
grant SELECT                                                                 on INT_RECKONINGS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_RECKONINGS.sql =========*** End **
PROMPT ===================================================================================== 
