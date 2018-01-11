

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GERC_ORDERS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GERC_ORDERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GERC_ORDERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GERC_ORDERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GERC_ORDERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GERC_ORDERS 
   (	REF NUMBER, 
	DOCUMENTNUMBER VARCHAR2(10) DEFAULT NULL, 
	OPERATIONTYPE CHAR(3), 
	DOCUMENTTYPE NUMBER, 
	DOCUMENTDATE DATE, 
	DEBITMFO VARCHAR2(12), 
	CREDITMFO VARCHAR2(12), 
	DEBITACCOUNT VARCHAR2(15), 
	CREDITACCOUNT VARCHAR2(15), 
	DEBITNAME VARCHAR2(38), 
	CREDITNAME VARCHAR2(38), 
	DEBITEDRPOU VARCHAR2(14), 
	CREDITEDRPOU VARCHAR2(14), 
	AMOUNT NUMBER, 
	CURRENCY CHAR(3), 
	PURPOSE VARCHAR2(160), 
	CASHSYMBOL NUMBER(2,0), 
	DEBITFLAG NUMBER(1,0), 
	ADDITIONALREQUISITES VARCHAR2(60), 
	DIGITALSIGNATURE VARCHAR2(4000), 
	DOCUMENTAUTHOR VARCHAR2(100), 
	BRANCH VARCHAR2(30), 
	EXTERNALDOCUMENTID VARCHAR2(32), 
	REQ_MESSAGE VARCHAR2(400), 
	OUR_BUFFER VARCHAR2(4000), 
	GERC_SIGN VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GERC_ORDERS ***
 exec bpa.alter_policies('GERC_ORDERS');


COMMENT ON TABLE BARS.GERC_ORDERS IS 'Операции, принятые из ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_ORDERS.REF IS '';
COMMENT ON COLUMN BARS.GERC_ORDERS.DOCUMENTNUMBER IS 'Номер документа';
COMMENT ON COLUMN BARS.GERC_ORDERS.OPERATIONTYPE IS 'Код операції (перелік операцій, що будуть дозволені для виконання через даний веб-сервіс та їх бухмодель, має бути узгоджена з Банком)';
COMMENT ON COLUMN BARS.GERC_ORDERS.DOCUMENTTYPE IS 'Тип документа (1-Пл. доручення, 6-Мем.ордер)';
COMMENT ON COLUMN BARS.GERC_ORDERS.DOCUMENTDATE IS 'Дата документу';
COMMENT ON COLUMN BARS.GERC_ORDERS.DEBITMFO IS 'МФО відправника';
COMMENT ON COLUMN BARS.GERC_ORDERS.CREDITMFO IS 'МФО отримувача';
COMMENT ON COLUMN BARS.GERC_ORDERS.DEBITACCOUNT IS 'Рахунок відправника';
COMMENT ON COLUMN BARS.GERC_ORDERS.CREDITACCOUNT IS 'Рахунок отримувача';
COMMENT ON COLUMN BARS.GERC_ORDERS.DEBITNAME IS 'Назва рахунку відправника';
COMMENT ON COLUMN BARS.GERC_ORDERS.CREDITNAME IS 'Назва рахунку отримувача';
COMMENT ON COLUMN BARS.GERC_ORDERS.DEBITEDRPOU IS 'ЄДРПОУ відправника';
COMMENT ON COLUMN BARS.GERC_ORDERS.CREDITEDRPOU IS 'ЄДРПОУ одержувача';
COMMENT ON COLUMN BARS.GERC_ORDERS.AMOUNT IS 'Сума операції в коп.';
COMMENT ON COLUMN BARS.GERC_ORDERS.CURRENCY IS 'Код валюти в форматі ISO (UAH)';
COMMENT ON COLUMN BARS.GERC_ORDERS.PURPOSE IS 'Призначення платежу';
COMMENT ON COLUMN BARS.GERC_ORDERS.CASHSYMBOL IS 'Символ касового плану';
COMMENT ON COLUMN BARS.GERC_ORDERS.DEBITFLAG IS 'Ознака Дебет/Кредит (0-Дт., 1-Кт.)';
COMMENT ON COLUMN BARS.GERC_ORDERS.ADDITIONALREQUISITES IS 'Додаткові реквізити СЕП';
COMMENT ON COLUMN BARS.GERC_ORDERS.DIGITALSIGNATURE IS 'Цифровий підпис (зараз не використовується)';
COMMENT ON COLUMN BARS.GERC_ORDERS.DOCUMENTAUTHOR IS 'Логін користувача АБС, від імені якого буде створено документ';
COMMENT ON COLUMN BARS.GERC_ORDERS.BRANCH IS 'Код відділення в АБС';
COMMENT ON COLUMN BARS.GERC_ORDERS.EXTERNALDOCUMENTID IS 'Ідентифікатор документа в системі Герц';
COMMENT ON COLUMN BARS.GERC_ORDERS.REQ_MESSAGE IS 'Сообщение при обработке';
COMMENT ON COLUMN BARS.GERC_ORDERS.OUR_BUFFER IS 'Наш буфер при валидации';
COMMENT ON COLUMN BARS.GERC_ORDERS.GERC_SIGN IS 'Подпись ГЕРЦ для валидации';




PROMPT *** Create  constraint CC_GERC_ORDERS_EXTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_ORDERS ADD CONSTRAINT CC_GERC_ORDERS_EXTID_NN CHECK (EXTERNALDOCUMENTID IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UIDX_GERC_ORDERS_EXTID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UIDX_GERC_ORDERS_EXTID ON BARS.GERC_ORDERS (EXTERNALDOCUMENTID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GERC_ORDERS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on GERC_ORDERS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GERC_ORDERS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GERC_ORDERS.sql =========*** End *** =
PROMPT ===================================================================================== 
