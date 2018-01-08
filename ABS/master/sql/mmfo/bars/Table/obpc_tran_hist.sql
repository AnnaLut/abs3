

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRAN_HIST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRAN_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRAN_HIST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TRAN_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRAN_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRAN_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRAN_HIST 
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
	REF NUMBER(38,0), 
	IDN NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRAN_HIST ***
 exec bpa.alter_policies('OBPC_TRAN_HIST');


COMMENT ON TABLE BARS.OBPC_TRAN_HIST IS 'Файлы транзакций принятые с ПЦ (TRAN*.DBF)';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.ID IS 'Код файла';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.CARD_ACCT IS 'Тех. карточный счет';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.CURRENCY IS 'Вал счета';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.CCY IS 'Вал операции';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.TRAN_DATE IS 'Дата операции';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.TRAN_TYPE IS 'Тип транзакции';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.CARD IS '№ карточки';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.SLIP_NR IS '№ слипа';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.BATCH_NR IS '№ пакета';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.ABVR_NAME IS 'ABVR_NAME';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.CITY IS 'Город';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.MERCHANT IS 'MERCHANT';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.TRAN_AMT IS 'Сумма опер';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.AMOUNT IS 'Сумма в валюте счета';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.TRAN_NAME IS 'Наименование операции';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.TRAN_RUSS IS 'Наименование операции (русское)';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.POST_DATE IS 'Дата обработки';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.CARD_TYPE IS 'Тип карточки';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.COUNTRY IS 'Страна';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.MCC_CODE IS 'Код торг точки';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.TERMINAL IS 'Код терминала';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.REF IS 'Референс';
COMMENT ON COLUMN BARS.OBPC_TRAN_HIST.IDN IS '№';




PROMPT *** Create  constraint FK_OBPCTRANHIST_OBPCFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRAN_HIST ADD CONSTRAINT FK_OBPCTRANHIST_OBPCFILES FOREIGN KEY (ID)
	  REFERENCES BARS.OBPC_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBPCTRANHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRAN_HIST ADD CONSTRAINT PK_OBPCTRANHIST PRIMARY KEY (IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRANHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRANHIST ON BARS.OBPC_TRAN_HIST (IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRANHIST_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRANHIST_ID ON BARS.OBPC_TRAN_HIST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRANHIST_TRANTYPE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRANHIST_TRANTYPE ON BARS.OBPC_TRAN_HIST (TRAN_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRANHIST_CARDACCT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRANHIST_CARDACCT ON BARS.OBPC_TRAN_HIST (CARD_ACCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRAN_HIST ***
grant INSERT,SELECT                                                          on OBPC_TRAN_HIST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TRAN_HIST  to BARS_DM;
grant INSERT,SELECT                                                          on OBPC_TRAN_HIST  to OBPC;
grant SELECT                                                                 on OBPC_TRAN_HIST  to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRAN_HIST.sql =========*** End **
PROMPT ===================================================================================== 
