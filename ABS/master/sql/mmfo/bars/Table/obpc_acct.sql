

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_ACCT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_ACCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_ACCT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_ACCT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OBPC_ACCT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_ACCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_ACCT 
   (	ID NUMBER(38,0), 
	REGION VARCHAR2(2), 
	REGION_N VARCHAR2(10), 
	BRANCH VARCHAR2(5), 
	BRANCH_N VARCHAR2(35), 
	MFO VARCHAR2(6), 
	CLIENT VARCHAR2(6), 
	TYPE VARCHAR2(1), 
	CARD_ACCT VARCHAR2(10), 
	ACC_TYPE VARCHAR2(2), 
	CURRENCY VARCHAR2(3), 
	LACCT VARCHAR2(25), 
	CLIENT_N VARCHAR2(40), 
	STREET VARCHAR2(30), 
	CITY VARCHAR2(15), 
	CNTRY VARCHAR2(15), 
	PCODE VARCHAR2(6), 
	STATUS VARCHAR2(1), 
	POST_DATE DATE, 
	CRD NUMBER(38,2), 
	BEGIN_BAL NUMBER(38,2), 
	DEBIT NUMBER(38,2), 
	CREDIT NUMBER(38,2), 
	END_BAL NUMBER(38,2), 
	AVAIL_AMT NUMBER(38,2), 
	MPREW_BAL NUMBER(38,2), 
	USED_AMNT NUMBER(38,2), 
	DEPOSIT NUMBER(38,2), 
	OBU NUMBER(38,0), 
	CARD_TYPE NUMBER(38,0), 
	OPEN_DATE DATE, 
	WORKS VARCHAR2(30), 
	OFFICE VARCHAR2(25), 
	QUAN_CARD NUMBER(38,0), 
	EXPIRY DATE, 
	STOP_DATE DATE, 
	MIN_BAL NUMBER(38,2), 
	COND_SET NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SERV_CODE VARCHAR2(2), 
	REG_NR VARCHAR2(10), 
	ID_NUMB VARCHAR2(14), 
	ACC NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_ACCT ***
 exec bpa.alter_policies('OBPC_ACCT');


COMMENT ON TABLE BARS.OBPC_ACCT IS 'Файл счетов принятый с ПЦ (ACCT*.DBF)';
COMMENT ON COLUMN BARS.OBPC_ACCT.ID IS 'Код файла';
COMMENT ON COLUMN BARS.OBPC_ACCT.REGION IS 'Регион';
COMMENT ON COLUMN BARS.OBPC_ACCT.REGION_N IS 'Наименование региона';
COMMENT ON COLUMN BARS.OBPC_ACCT.BRANCH IS 'Код отделения';
COMMENT ON COLUMN BARS.OBPC_ACCT.BRANCH_N IS 'Наименование отделения';
COMMENT ON COLUMN BARS.OBPC_ACCT.MFO IS 'МФО';
COMMENT ON COLUMN BARS.OBPC_ACCT.CLIENT IS '№ клиента';
COMMENT ON COLUMN BARS.OBPC_ACCT.TYPE IS 'Тип клиента';
COMMENT ON COLUMN BARS.OBPC_ACCT.CARD_ACCT IS 'Тех.карт.счет';
COMMENT ON COLUMN BARS.OBPC_ACCT.ACC_TYPE IS 'Тип счета';
COMMENT ON COLUMN BARS.OBPC_ACCT.CURRENCY IS 'Валюта ISO';
COMMENT ON COLUMN BARS.OBPC_ACCT.LACCT IS 'Бал счет';
COMMENT ON COLUMN BARS.OBPC_ACCT.CLIENT_N IS 'Наименование клиента';
COMMENT ON COLUMN BARS.OBPC_ACCT.STREET IS 'Улица';
COMMENT ON COLUMN BARS.OBPC_ACCT.CITY IS 'Город';
COMMENT ON COLUMN BARS.OBPC_ACCT.CNTRY IS 'Страна';
COMMENT ON COLUMN BARS.OBPC_ACCT.PCODE IS 'Почт.индекс';
COMMENT ON COLUMN BARS.OBPC_ACCT.STATUS IS 'Статус';
COMMENT ON COLUMN BARS.OBPC_ACCT.POST_DATE IS 'Дата обработки';
COMMENT ON COLUMN BARS.OBPC_ACCT.CRD IS 'Кредит разрешен';
COMMENT ON COLUMN BARS.OBPC_ACCT.BEGIN_BAL IS 'Нач.баланс';
COMMENT ON COLUMN BARS.OBPC_ACCT.DEBIT IS 'Обороты дебит';
COMMENT ON COLUMN BARS.OBPC_ACCT.CREDIT IS 'Обороты кредит';
COMMENT ON COLUMN BARS.OBPC_ACCT.END_BAL IS 'Кон. баланс';
COMMENT ON COLUMN BARS.OBPC_ACCT.AVAIL_AMT IS 'Доп.сумма';
COMMENT ON COLUMN BARS.OBPC_ACCT.MPREW_BAL IS 'Нач.остаток пред.месяца';
COMMENT ON COLUMN BARS.OBPC_ACCT.USED_AMNT IS 'Блок.сумма';
COMMENT ON COLUMN BARS.OBPC_ACCT.DEPOSIT IS 'Сумма депозита';
COMMENT ON COLUMN BARS.OBPC_ACCT.OBU IS 'ОБУ';
COMMENT ON COLUMN BARS.OBPC_ACCT.CARD_TYPE IS 'Тип карточки';
COMMENT ON COLUMN BARS.OBPC_ACCT.OPEN_DATE IS 'Дата открытия';
COMMENT ON COLUMN BARS.OBPC_ACCT.WORKS IS 'Место работы';
COMMENT ON COLUMN BARS.OBPC_ACCT.OFFICE IS 'Должность';
COMMENT ON COLUMN BARS.OBPC_ACCT.QUAN_CARD IS 'Кол-во карточек';
COMMENT ON COLUMN BARS.OBPC_ACCT.EXPIRY IS 'Дата истечения';
COMMENT ON COLUMN BARS.OBPC_ACCT.STOP_DATE IS 'Дата STOP';
COMMENT ON COLUMN BARS.OBPC_ACCT.MIN_BAL IS 'Мин.баланс';
COMMENT ON COLUMN BARS.OBPC_ACCT.COND_SET IS 'Условие';
COMMENT ON COLUMN BARS.OBPC_ACCT.KF IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT.SERV_CODE IS 'Категория клиента';
COMMENT ON COLUMN BARS.OBPC_ACCT.REG_NR IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT.ID_NUMB IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT.ACC IS '';




PROMPT *** Create  constraint CC_OBPCACCT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ACCT MODIFY (KF CONSTRAINT CC_OBPCACCT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBPCACCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ACCT ADD CONSTRAINT PK_OBPCACCT PRIMARY KEY (CARD_ACCT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCACCT_LACCT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCACCT_LACCT ON BARS.OBPC_ACCT (LACCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCACCT_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCACCT_ID ON BARS.OBPC_ACCT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCACCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCACCT ON BARS.OBPC_ACCT (CARD_ACCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCACCT_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCACCT_ACC ON BARS.OBPC_ACCT (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_ACCT ***
grant SELECT                                                                 on OBPC_ACCT       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_ACCT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_ACCT       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ACCT       to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ACCT       to OBPC_ACCT;
grant SELECT                                                                 on OBPC_ACCT       to PYOD001;
grant SELECT                                                                 on OBPC_ACCT       to RPBN001;
grant SELECT                                                                 on OBPC_ACCT       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_ACCT       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_ACCT       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_ACCT.sql =========*** End *** ===
PROMPT ===================================================================================== 
