

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_CUREX_EXCLUSIVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_CUREX_EXCLUSIVE ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_CUREX_EXCLUSIVE 
   (	RATE_ID NUMBER(38,0), 
	RNK NUMBER(*,0), 
	BUY_SELL_FLAG NUMBER(1,0), 
	CUR_GROUP NUMBER(38,0), 
	CUR_ID NUMBER(3,0), 
	LIMIT NUMBER(38,0), 
	COMMISSION_RATE NUMBER(38,8), 
	COMMISSION_SUM NUMBER(38,0), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	BANK_ID VARCHAR2(11 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_CUREX_EXCLUSIVE IS 'Індивідуальні тарифи на біржові операції version 1.0';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.RATE_ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.RNK IS 'Ідентифікатор клієнта';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.BUY_SELL_FLAG IS '1-купівля,2-продаж валюти';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.CUR_GROUP IS 'Код групи валюти';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.CUR_ID IS 'Код валюти';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.LIMIT IS 'Гранична сума';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.COMMISSION_RATE IS 'Ставка комісії';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.COMMISSION_SUM IS 'Сума комісії';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.DATE_ON IS 'Дата початку дії';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.DATE_OFF IS 'Дата завершення дії';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_EXCLUSIVE.BANK_ID IS '';




PROMPT *** Create  constraint CC_DOCCUREXEXCLUSIVE_CUSTID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_EXCLUSIVE ADD CONSTRAINT CC_DOCCUREXEXCLUSIVE_CUSTID CHECK (buy_sell_flag in (1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCCUREXEXCLUSIVE ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_EXCLUSIVE ADD CONSTRAINT PK_DOCCUREXEXCLUSIVE PRIMARY KEY (RATE_ID, BANK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXEXCLUSIVE_RATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_EXCLUSIVE MODIFY (RATE_ID CONSTRAINT CC_DOCCUREXEXCLUSIVE_RATEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXEXCLUSIVE_BSFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_EXCLUSIVE MODIFY (BUY_SELL_FLAG CONSTRAINT CC_DOCCUREXEXCLUSIVE_BSFLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXEXCLUSIVE_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_EXCLUSIVE MODIFY (DATE_ON CONSTRAINT CC_DOCCUREXEXCLUSIVE_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXEXCLUSIVE_BANKID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_EXCLUSIVE MODIFY (BANK_ID CONSTRAINT CC_DOCCUREXEXCLUSIVE_BANKID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCCUREXEXCLUSIVE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCCUREXEXCLUSIVE ON BARSAQ.DOC_CUREX_EXCLUSIVE (RATE_ID, BANK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_CUREX_EXCLUSIVE.sql =========***
PROMPT ===================================================================================== 
