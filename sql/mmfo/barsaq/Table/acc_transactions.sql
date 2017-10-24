

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ACC_TRANSACTIONS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table ACC_TRANSACTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ACC_TRANSACTIONS 
   (	BANK_ID VARCHAR2(11), 
	ACC_NUM VARCHAR2(15), 
	CUR_ID NUMBER(3,0), 
	TRANS_DATE DATE, 
	TRANS_ID VARCHAR2(40), 
	DOC_ID VARCHAR2(40), 
	DOC_NUMBER VARCHAR2(40), 
	DOC_DATE DATE, 
	TYPE_ID VARCHAR2(1), 
	TRANS_SUM NUMBER, 
	TRANS_SUM_EQ NUMBER, 
	CORR_BANK_ID VARCHAR2(11), 
	CORR_BANK_NAME VARCHAR2(250), 
	CORR_IDENT_CODE VARCHAR2(20), 
	CORR_ACC_NUM VARCHAR2(35), 
	CORR_NAME VARCHAR2(250), 
	NARRATIVE VARCHAR2(4000), 
	NARRATIVE_EXTRA CLOB, 
	IBANK_DOCID NUMBER(*,0), 
	NAME VARCHAR2(250), 
	REF92_BANK_ID VARCHAR2(12 CHAR), 
	REF92_CUST_CODE VARCHAR2(14 CHAR), 
	REF92_ACC_NUM VARCHAR2(15 CHAR), 
	REF92_ACC_NAME VARCHAR2(38 CHAR), 
	REF92_BANK_NAME VARCHAR2(38 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (NARRATIVE_EXTRA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ACC_TRANSACTIONS IS 'Таблица транзакций(проводок) по счетам';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.BANK_ID IS 'Код банка владельца счета';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.ACC_NUM IS 'Номер счета';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.CUR_ID IS 'Валюта счета';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.TRANS_DATE IS 'банковская дата, в которой проведена транзакция';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.TRANS_ID IS 'id транзакции(проводки) - аналог поля opldok.stmt, текстовое на случай связи с другими АБС';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.DOC_ID IS 'id документа - аналог oper.ref или opldok.ref, текстовое на случай связи с другими АБС';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.DOC_NUMBER IS 'номер документа';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.DOC_DATE IS 'дата документа';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.TYPE_ID IS 'тип транзакции: D/C - Дебет/Кредит по отношению к основному счету acc_id';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.TRANS_SUM IS 'сумма транзакции(с плавающей точкой)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.TRANS_SUM_EQ IS 'эквивалент суммы транзакции в нац. валюте(с плавающей точкой)
может не заполняться если исходная сумма в нац. валюте';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.CORR_BANK_ID IS 'код банка корреспондента(локальный в СЭП или BIC-код в SWIFT)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.CORR_BANK_NAME IS 'наименование банка корреспондента';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.CORR_IDENT_CODE IS 'идент. код корреспондента';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.CORR_ACC_NUM IS 'счет корреспондента';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.CORR_NAME IS 'наименование корреспондента';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.NARRATIVE IS 'назначение платежа(краткое)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.NARRATIVE_EXTRA IS 'назначение платежа(полное - продолжение краткого)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.IBANK_DOCID IS 'id документа интернет-банкинга';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.NAME IS 'Наименование из документа в АБС';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.REF92_BANK_ID IS 'МФО отправителя (REF92)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.REF92_CUST_CODE IS 'Идент. код отправителя (REF92)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.REF92_ACC_NUM IS 'Счет отправителя (REF92)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.REF92_ACC_NAME IS 'Наименование отправителя (REF92)';
COMMENT ON COLUMN BARSAQ.ACC_TRANSACTIONS.REF92_BANK_NAME IS 'Наименование банка отправителя (REF92)';




PROMPT *** Create  constraint CC_ACCTRANS_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (BANK_ID CONSTRAINT CC_ACCTRANS_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_NARRATIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (NARRATIVE CONSTRAINT CC_ACCTRANS_NARRATIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTRANS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS ADD CONSTRAINT FK_ACCTRANS_BANKS FOREIGN KEY (BANK_ID)
	  REFERENCES BARS.BANKS$BASE (MFO) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS ADD CONSTRAINT PK_ACCTRANS PRIMARY KEY (BANK_ID, ACC_NUM, CUR_ID, TRANS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_TYPEID_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS ADD CONSTRAINT CC_ACCTRANS_TYPEID_CC CHECK (type_id in (''C'',''D'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_ACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (ACC_NUM CONSTRAINT CC_ACCTRANS_ACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (CUR_ID CONSTRAINT CC_ACCTRANS_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_TRANSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (TRANS_DATE CONSTRAINT CC_ACCTRANS_TRANSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_TRANSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (TRANS_ID CONSTRAINT CC_ACCTRANS_TRANSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_DOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (DOC_ID CONSTRAINT CC_ACCTRANS_DOCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_DOCNUMBER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (DOC_NUMBER CONSTRAINT CC_ACCTRANS_DOCNUMBER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_DOCDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (DOC_DATE CONSTRAINT CC_ACCTRANS_DOCDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (TYPE_ID CONSTRAINT CC_ACCTRANS_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_TRANSSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (TRANS_SUM CONSTRAINT CC_ACCTRANS_TRANSSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_CORRBANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (CORR_BANK_ID CONSTRAINT CC_ACCTRANS_CORRBANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_CORRBANKNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (CORR_BANK_NAME CONSTRAINT CC_ACCTRANS_CORRBANKNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_CORRACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (CORR_ACC_NUM CONSTRAINT CC_ACCTRANS_CORRACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTRANS_CORRNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS MODIFY (CORR_NAME CONSTRAINT CC_ACCTRANS_CORRNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTRANS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TRANSACTIONS ADD CONSTRAINT FK_ACCTRANS_TABVAL FOREIGN KEY (CUR_ID)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ACCTRANS ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_ACCTRANS ON BARSAQ.ACC_TRANSACTIONS (TRANS_DATE, BANK_ID, ACC_NUM, CUR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCTRANS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_ACCTRANS ON BARSAQ.ACC_TRANSACTIONS (BANK_ID, ACC_NUM, CUR_ID, TRANS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ACC_TRANSACTIONS.sql =========*** En
PROMPT ===================================================================================== 
