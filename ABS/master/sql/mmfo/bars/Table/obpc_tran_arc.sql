

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRAN_ARC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRAN_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRAN_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TRAN_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRAN_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRAN_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRAN_ARC 
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
	IDN NUMBER(38,0), 
	DONEBY VARCHAR2(30), 
	ARC_DATE DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRAN_ARC ***
 exec bpa.alter_policies('OBPC_TRAN_ARC');


COMMENT ON TABLE BARS.OBPC_TRAN_ARC IS 'Транзакции, принятые из ПЦ (TRAN*.DBF) - НЕОБРАБОТАННЫЕ';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.ID IS 'Код файла';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.CARD_ACCT IS 'Тех. карточный счет';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.CURRENCY IS 'Вал счета';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.CCY IS 'Вал операции';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.TRAN_DATE IS 'Дата операции';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.TRAN_TYPE IS 'Тип транзакции';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.CARD IS '№ карточки';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.SLIP_NR IS '№ слипа';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.BATCH_NR IS '№ пакета';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.ABVR_NAME IS 'ABVR_NAME';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.CITY IS 'Город';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.MERCHANT IS 'MERCHANT';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.TRAN_AMT IS 'Сумма опер';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.AMOUNT IS 'Сумма в валюте счета';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.TRAN_NAME IS 'Наименование операции';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.TRAN_RUSS IS 'Наименование операции (русское)';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.POST_DATE IS 'Дата обработки';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.CARD_TYPE IS 'Тип карточки';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.COUNTRY IS 'Страна';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.MCC_CODE IS 'Код торг точки';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.TERMINAL IS 'Код терминала';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.IDN IS '№';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.DONEBY IS 'Пользователь, кот.удалил запись в архив';
COMMENT ON COLUMN BARS.OBPC_TRAN_ARC.ARC_DATE IS 'Дата удаления записи в архив';




PROMPT *** Create  constraint PK_OBPCTRANARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRAN_ARC ADD CONSTRAINT PK_OBPCTRANARC PRIMARY KEY (IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRANARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRANARC ON BARS.OBPC_TRAN_ARC (IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRANARC_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRANARC_ID ON BARS.OBPC_TRAN_ARC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRANARC_TRANTYPE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRANARC_TRANTYPE ON BARS.OBPC_TRAN_ARC (TRAN_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCTRANARC_CARDACCT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCTRANARC_CARDACCT ON BARS.OBPC_TRAN_ARC (CARD_ACCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRAN_ARC ***
grant SELECT                                                                 on OBPC_TRAN_ARC   to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on OBPC_TRAN_ARC   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TRAN_ARC   to BARS_DM;
grant INSERT,SELECT                                                          on OBPC_TRAN_ARC   to OBPC;
grant SELECT                                                                 on OBPC_TRAN_ARC   to RPBN001;
grant SELECT                                                                 on OBPC_TRAN_ARC   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRAN_ARC.sql =========*** End ***
PROMPT ===================================================================================== 
