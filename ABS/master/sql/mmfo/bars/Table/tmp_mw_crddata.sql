

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MW_CRDDATA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MW_CRDDATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_MW_CRDDATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_MW_CRDDATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_MW_CRDDATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MW_CRDDATA ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_MW_CRDDATA 
   (	ND NUMBER(38,0), 
	CR_NUMBER VARCHAR2(50), 
	CR_DATE_OPEN DATE, 
	CR_DATE_CLOSE DATE, 
	CR_AMOUNT NUMBER(38,0), 
	CR_CURRENCY_LCV VARCHAR2(3), 
	CR_CURRENCY NUMBER(3,0), 
	CR_ACCOUNT VARCHAR2(14), 
	CR_INTEREST_RATE NUMBER(4,2), 
	CR_INTEREST_AMOUNT NUMBER(38,0), 
	CR_NEXT_PAYM NUMBER(38,0), 
	CR_NEXT_PAYM_DATE DATE, 
	CR_TRANCHE_POSSIBLE NUMBER(1,0), 
	CR_BALANCE NUMBER(38,0), 
	CR_INSURANCE_DATE DATE, 
	CR_INSURANCE_AMOUNT NUMBER(38,0), 
	CR_VIDD NUMBER(5,0), 
	CLIENT_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	CR_ACCOUNT_LIM VARCHAR2(15), 
	CR_ACCOUNT_SS VARCHAR2(15), 
	CR_AGREEMENT VARCHAR2(50), 
	CR_DUE_AMOUNT NUMBER(38,0), 
	CR_PRINCIPAL_BASE NUMBER, 
	CR_INTEREST_BASE NUMBER, 
	CR_PRINCIPAL_OVERDUE NUMBER, 
	CR_INTEREST_OVERDUE NUMBER, 
	CR_SOS NUMBER(2,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MW_CRDDATA ***
 exec bpa.alter_policies('TMP_MW_CRDDATA');


COMMENT ON TABLE BARS.TMP_MW_CRDDATA IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_SOS IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_CURRENCY IS 'Валюта кредита';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_ACCOUNT IS 'Номер расчетного счета, через который клиент может производить погашение кредита';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_INTEREST_RATE IS 'Процентная ставка';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_INTEREST_AMOUNT IS 'Сумма начисленных процентов';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_NEXT_PAYM IS 'Размер следующего платежа';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_NEXT_PAYM_DATE IS 'Дата ближайшего погашения';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_TRANCHE_POSSIBLE IS 'Возможность снятия очередного транша по кредиту';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_BALANCE IS 'Остаток не выбранного кредита';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_INSURANCE_DATE IS 'Ближайшая дата страховки по кредиту';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_INSURANCE_AMOUNT IS 'Ориентировочная сумма страховки';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_VIDD IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CLIENT_ID IS 'ID клиента, который передается в запросе';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_ACCOUNT_LIM IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_ACCOUNT_SS IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_AGREEMENT IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_DUE_AMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_PRINCIPAL_BASE IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_INTEREST_BASE IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_PRINCIPAL_OVERDUE IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_INTEREST_OVERDUE IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.ND IS '';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_NUMBER IS 'Номер договора';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_DATE_OPEN IS 'Дата выдачи кредита';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_DATE_CLOSE IS 'Дата окончания кредита';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_AMOUNT IS 'Сумма кредита';
COMMENT ON COLUMN BARS.TMP_MW_CRDDATA.CR_CURRENCY_LCV IS '';




PROMPT *** Create  constraint PK_TMPMWAYCRDDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_MW_CRDDATA ADD CONSTRAINT PK_TMPMWAYCRDDATA PRIMARY KEY (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPMWAYCRDDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPMWAYCRDDATA ON BARS.TMP_MW_CRDDATA (ND) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_MW_CRDDATA ***
grant SELECT                                                                 on TMP_MW_CRDDATA  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_MW_CRDDATA  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MW_CRDDATA.sql =========*** End **
PROMPT ===================================================================================== 
