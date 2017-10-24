

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CUSTOMERS_SEGMENT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table CUSTOMERS_SEGMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CUSTOMERS_SEGMENT 
   (	PER_ID NUMBER, 
	KF VARCHAR2(6), 
	RNK NUMBER(15,0), 
	SEGMENT_ACT VARCHAR2(100), 
	SEGMENT_FIN VARCHAR2(100), 
	SEGMENT_BEH VARCHAR2(100), 
	SOCIAL_VIP VARCHAR2(100), 
	SEGMENT_TRANS NUMBER(5,0), 
	PRODUCT_AMOUNT NUMBER(32,12), 
	DEPOSIT_AMMOUNT NUMBER(32,12), 
	CREDITS_AMMOUNT NUMBER(32,12), 
	GARANTCREDITS_AMMOUNT NUMBER(32,12), 
	CARDCREDITS_AMMOUNT NUMBER(32,12), 
	ENERGYCREDITS_AMMOUNT NUMBER(32,12), 
	CARDS_AMMOUNT NUMBER(32,12), 
	ACCOUNTS_AMMOUNT NUMBER(32,12), 
	LASTCHANGEDT DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (PER_ID) INTERVAL (1) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CUSTOMERS_SEGMENT IS 'Сегментація';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.KF IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.RNK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.SEGMENT_ACT IS 'Сегмент активності';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.SEGMENT_FIN IS 'Сегмент фінансовий';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.SEGMENT_BEH IS 'Сегмент поведінковий';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.SOCIAL_VIP IS 'Соціальний VIP';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.SEGMENT_TRANS IS 'Кількість розрахунків карткою в ТСП';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.PRODUCT_AMOUNT IS 'Продуктове навантаження';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.DEPOSIT_AMMOUNT IS 'Прод. навантаження депозит';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.CREDITS_AMMOUNT IS 'Прод. навантаження кредит із забезпеченням';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.GARANTCREDITS_AMMOUNT IS 'Прод. навантаження кредит під поруку';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.CARDCREDITS_AMMOUNT IS 'Прод. навантаження кредит із БПК';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.ENERGYCREDITS_AMMOUNT IS 'Прод. навантаження кредит Енергоефективність';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.CARDS_AMMOUNT IS 'Прод. навантаження платіжна картка (БПК)';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.ACCOUNTS_AMMOUNT IS 'Прод. навантаження поточний рахунок';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_SEGMENT.LASTCHANGEDT IS 'Дата останнього редагування картки клієнта';




PROMPT *** Create  constraint FK_CUSTSEGM_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS_SEGMENT ADD CONSTRAINT FK_CUSTSEGM_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMERS_SEGMENT ***
grant SELECT                                                                 on CUSTOMERS_SEGMENT to BARS;
grant SELECT                                                                 on CUSTOMERS_SEGMENT to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CUSTOMERS_SEGMENT.sql =========*** 
PROMPT ===================================================================================== 
