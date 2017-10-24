

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/CURRENCY_RATES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table CURRENCY_RATES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.CURRENCY_RATES 
   (	RATE_DATE DATE, 
	BANK_ID VARCHAR2(11), 
	CUR_ID NUMBER(3,0), 
	BASE_SUM NUMBER(*,0), 
	RATE_OFFICIAL NUMBER(9,4), 
	RATE_BUYING NUMBER(9,4), 
	RATE_SELLING NUMBER(9,4), 
	 CONSTRAINT PK_CURRATES PRIMARY KEY (RATE_DATE, BANK_ID, CUR_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.CURRENCY_RATES IS 'Курсы валют';
COMMENT ON COLUMN BARSAQ.CURRENCY_RATES.RATE_DATE IS 'Дата курса';
COMMENT ON COLUMN BARSAQ.CURRENCY_RATES.BANK_ID IS 'Код банка';
COMMENT ON COLUMN BARSAQ.CURRENCY_RATES.CUR_ID IS 'Код валюты';
COMMENT ON COLUMN BARSAQ.CURRENCY_RATES.BASE_SUM IS 'Базовая сумма';
COMMENT ON COLUMN BARSAQ.CURRENCY_RATES.RATE_OFFICIAL IS 'Курс официальный';
COMMENT ON COLUMN BARSAQ.CURRENCY_RATES.RATE_BUYING IS 'Курс покупки';
COMMENT ON COLUMN BARSAQ.CURRENCY_RATES.RATE_SELLING IS 'Курс продажи';




PROMPT *** Create  constraint FK_CURRATES_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES ADD CONSTRAINT FK_CURRATES_BANKS FOREIGN KEY (BANK_ID)
	  REFERENCES BARS.BANKS$BASE (MFO) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CURRATES_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES ADD CONSTRAINT FK_CURRATES_TABVAL FOREIGN KEY (CUR_ID)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES_RATEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES MODIFY (RATE_DATE CONSTRAINT CC_CURRATES_RATEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES MODIFY (BANK_ID CONSTRAINT CC_CURRATES_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES MODIFY (CUR_ID CONSTRAINT CC_CURRATES_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES_BASESUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES MODIFY (BASE_SUM CONSTRAINT CC_CURRATES_BASESUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES_RATEOFFICIAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES MODIFY (RATE_OFFICIAL CONSTRAINT CC_CURRATES_RATEOFFICIAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CURRATES ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.CURRENCY_RATES ADD CONSTRAINT PK_CURRATES PRIMARY KEY (RATE_DATE, BANK_ID, CUR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CURRATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_CURRATES ON BARSAQ.CURRENCY_RATES (RATE_DATE, BANK_ID, CUR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/CURRENCY_RATES.sql =========*** End 
PROMPT ===================================================================================== 
