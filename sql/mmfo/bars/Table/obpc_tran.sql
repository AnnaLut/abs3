

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRAN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRAN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TRAN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRAN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRAN 
   (	ID NUMBER(38,0), 
	CARD_ACCT VARCHAR2(10), 
	CURRENCY VARCHAR2(3), 
	CCY VARCHAR2(3), 
	TRAN_DATE DATE, 
	TRAN_TYPE VARCHAR2(2), 
	CARD VARCHAR2(16), 
	SLIP_NR VARCHAR2(7), 
	BATCH_NR VARCHAR2(7), 
	ABVR_NAME VARCHAR2(27), 
	CITY VARCHAR2(15), 
	MERCHANT VARCHAR2(7), 
	TRAN_AMT NUMBER(38,2), 
	AMOUNT NUMBER(38,2), 
	TRAN_NAME VARCHAR2(40), 
	TRAN_RUSS VARCHAR2(40), 
	POST_DATE DATE, 
	CARD_TYPE NUMBER(38,0), 
	COUNTRY VARCHAR2(3), 
	MCC_CODE VARCHAR2(4), 
	TERMINAL VARCHAR2(1), 
	IDN NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRAN ***
 exec bpa.alter_policies('OBPC_TRAN');


COMMENT ON TABLE BARS.OBPC_TRAN IS 'Файлы транзакций принятые с ПЦ (TRAN*.DBF)';
COMMENT ON COLUMN BARS.OBPC_TRAN.ID IS 'Код файла';
COMMENT ON COLUMN BARS.OBPC_TRAN.CARD_ACCT IS 'Тех. карточный счет';
COMMENT ON COLUMN BARS.OBPC_TRAN.CURRENCY IS 'Вал счета';
COMMENT ON COLUMN BARS.OBPC_TRAN.CCY IS 'Вал операции';
COMMENT ON COLUMN BARS.OBPC_TRAN.TRAN_DATE IS 'Дата операции';
COMMENT ON COLUMN BARS.OBPC_TRAN.TRAN_TYPE IS 'Тип транзакции';
COMMENT ON COLUMN BARS.OBPC_TRAN.CARD IS '№ карточки';
COMMENT ON COLUMN BARS.OBPC_TRAN.SLIP_NR IS '№ слипа';
COMMENT ON COLUMN BARS.OBPC_TRAN.BATCH_NR IS '№ пакета';
COMMENT ON COLUMN BARS.OBPC_TRAN.ABVR_NAME IS 'ABVR_NAME';
COMMENT ON COLUMN BARS.OBPC_TRAN.CITY IS 'Город';
COMMENT ON COLUMN BARS.OBPC_TRAN.MERCHANT IS 'MERCHANT';
COMMENT ON COLUMN BARS.OBPC_TRAN.TRAN_AMT IS 'Сумма опер';
COMMENT ON COLUMN BARS.OBPC_TRAN.AMOUNT IS 'Сумма в валюте счета';
COMMENT ON COLUMN BARS.OBPC_TRAN.TRAN_NAME IS 'Наименование операции';
COMMENT ON COLUMN BARS.OBPC_TRAN.TRAN_RUSS IS 'Наименование операции (русское)';
COMMENT ON COLUMN BARS.OBPC_TRAN.POST_DATE IS 'Дата обработки';
COMMENT ON COLUMN BARS.OBPC_TRAN.CARD_TYPE IS 'Тип карточки';
COMMENT ON COLUMN BARS.OBPC_TRAN.COUNTRY IS 'Страна';
COMMENT ON COLUMN BARS.OBPC_TRAN.MCC_CODE IS 'Код торг точки';
COMMENT ON COLUMN BARS.OBPC_TRAN.TERMINAL IS 'Код терминала';
COMMENT ON COLUMN BARS.OBPC_TRAN.IDN IS '№';




PROMPT *** Create  constraint FK_OBPC_TRAN_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRAN ADD CONSTRAINT FK_OBPC_TRAN_FILES FOREIGN KEY (ID)
	  REFERENCES BARS.OBPC_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBPCTRAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRAN ADD CONSTRAINT PK_OBPCTRAN PRIMARY KEY (IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRAN_CARDACCT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRAN_CARDACCT ON BARS.OBPC_TRAN (CARD_ACCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRANS_TRANTYPE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRANS_TRANTYPE ON BARS.OBPC_TRAN (TRAN_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRAN ON BARS.OBPC_TRAN (IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRAN_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRAN_ID ON BARS.OBPC_TRAN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRAN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRAN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TRAN       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRAN       to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRAN       to OBPC_TRAN;
grant SELECT                                                                 on OBPC_TRAN       to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRAN       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_TRAN       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRAN.sql =========*** End *** ===
PROMPT ===================================================================================== 
