

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAYAVKA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAYAVKA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAYAVKA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAYAVKA'', ''FILIAL'' , ''M'', ''M'', null, ''M'');
               bpa.alter_policy_info(''ZAYAVKA'', ''WHOLE'' , null, ''E'', null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAYAVKA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAYAVKA 
   (	RNK NUMBER, 
	DK NUMBER, 
	ACC0 NUMBER, 
	ACC1 NUMBER, 
	FDAT DATE, 
	S2 NUMBER, 
	KURS_Z NUMBER(16,8), 
	KURS_F NUMBER(16,8), 
	MFOP VARCHAR2(12), 
	NLSP VARCHAR2(15), 
	SOS NUMBER(2,1), 
	KV2 NUMBER, 
	KOM NUMBER(10,4), 
	SKOM NUMBER(10,2), 
	VDATE DATE, 
	REF NUMBER, 
	MFO0 VARCHAR2(12), 
	NLS0 VARCHAR2(15), 
	OKPOP VARCHAR2(10), 
	OKPO0 VARCHAR2(10), 
	CONTRACT VARCHAR2(50), 
	DAT_VMD DATE, 
	DAT2_VMD DATE, 
	VIZA NUMBER, 
	META NUMBER, 
	DAT5_VMD VARCHAR2(240), 
	RNK_PF VARCHAR2(20), 
	PRIORITY NUMBER DEFAULT 0, 
	COUNTRY NUMBER, 
	BASIS VARCHAR2(512), 
	ID NUMBER, 
	FNAMEKB VARCHAR2(12), 
	IDENTKB VARCHAR2(16), 
	IDBACK NUMBER, 
	PID NUMBER, 
	TIPKB NUMBER(*,0), 
	DATEDOKKB DATE, 
	ND VARCHAR2(10), 
	DATT DATE, 
	OBZ NUMBER DEFAULT 0, 
	DATZ DATE, 
	FL_PF NUMBER, 
	FL_KURSZ NUMBER(1,0), 
	BENEFCOUNTRY NUMBER, 
	BANK_CODE VARCHAR2(10), 
	BANK_NAME VARCHAR2(60), 
	S3 NUMBER, 
	LIM NUMBER, 
	ISP NUMBER, 
	TOBO VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	PRODUCT_GROUP CHAR(2), 
	NUM_VMD VARCHAR2(35), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DETAILS VARCHAR2(254), 
	KURS_KL VARCHAR2(30), 
	COMM VARCHAR2(250), 
	CONTACT_FIO VARCHAR2(70), 
	CONTACT_TEL VARCHAR2(32), 
	CLOSE_TYPE NUMBER(1,0), 
	VERIFY_OPT NUMBER(1,0) DEFAULT 1, 
	AIMS_CODE NUMBER(2,0), 
	KV_CONV NUMBER(3,0), 
	OPERID_NOKK VARCHAR2(30), 
	SOPER NUMBER, 
	REF_SPS NUMBER, 
	S_PF NUMBER, 
	REF_PF NUMBER, 
	ID_PREV NUMBER, 
	REQ_TYPE NUMBER(10,0), 
	VDATE_PLAN DATE, 
	REASON_COMM VARCHAR2(254), 
	REFOPER NUMBER, 
	CODE_2C VARCHAR2(1), 
	P12_2C VARCHAR2(10), 
	SUPPORT_DOCUMENT NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAYAVKA ***
 exec bpa.alter_policies('ZAYAVKA');


COMMENT ON TABLE BARS.ZAYAVKA IS 'Заявки клиентов на покупку-продажу валюты';
COMMENT ON COLUMN BARS.ZAYAVKA.RNK IS 'РНК клиента';
COMMENT ON COLUMN BARS.ZAYAVKA.DK IS '1 - покупка,  2 - продажа, 3 - покупка за др.валюту (конверсия)';
COMMENT ON COLUMN BARS.ZAYAVKA.ACC0 IS 'для 1 - грн счет списания, для 2 - грн счет зачисления(при зачислении выруч.грн на межбанк - поле пустует,зато заполняются поля mfo0, nls0,okpo0), для 3 - вал счет для списания';
COMMENT ON COLUMN BARS.ZAYAVKA.ACC1 IS 'для 1 - вал счет зачисления, для 2 - вал счет списания, для 3 - вал счет зачисления';
COMMENT ON COLUMN BARS.ZAYAVKA.FDAT IS 'Дата заявки';
COMMENT ON COLUMN BARS.ZAYAVKA.S2 IS 'Сумма валюты';
COMMENT ON COLUMN BARS.ZAYAVKA.KURS_Z IS 'Курс заявленный (клиента)';
COMMENT ON COLUMN BARS.ZAYAVKA.KURS_F IS 'Курс фактический (дилера)';
COMMENT ON COLUMN BARS.ZAYAVKA.MFOP IS 'мфо пф';
COMMENT ON COLUMN BARS.ZAYAVKA.NLSP IS 'транз. счет клиента для отчисления в пф';
COMMENT ON COLUMN BARS.ZAYAVKA.SOS IS 'Состояние: 0 - введена, 0.5 - удовлетворена дилером незавизирована, 1 - удовлетворена дилером завизирована,  2 - оплачена, -1 - удалена';
COMMENT ON COLUMN BARS.ZAYAVKA.KV2 IS 'Валюта заявки';
COMMENT ON COLUMN BARS.ZAYAVKA.KOM IS '% комиссии';
COMMENT ON COLUMN BARS.ZAYAVKA.SKOM IS 'Сумма комиссии';
COMMENT ON COLUMN BARS.ZAYAVKA.VDATE IS 'Дата валютирования';
COMMENT ON COLUMN BARS.ZAYAVKA.REF IS 'Реф.док-та';
COMMENT ON COLUMN BARS.ZAYAVKA.MFO0 IS 'МФО для зачисления грн на м/б при продаже';
COMMENT ON COLUMN BARS.ZAYAVKA.NLS0 IS 'Счет для зачисления грн на м/б при продаже ';
COMMENT ON COLUMN BARS.ZAYAVKA.OKPOP IS 'окпо в пф';
COMMENT ON COLUMN BARS.ZAYAVKA.OKPO0 IS 'ОКПО для зачисления грн на м/б при продаже';
COMMENT ON COLUMN BARS.ZAYAVKA.CONTRACT IS '№ контракта';
COMMENT ON COLUMN BARS.ZAYAVKA.DAT_VMD IS 'дата последней вмд';
COMMENT ON COLUMN BARS.ZAYAVKA.DAT2_VMD IS 'дата контракта';
COMMENT ON COLUMN BARS.ZAYAVKA.VIZA IS 'Виза: 0 - введена, 1 - завизирована ZAY2, 2 - завизирована ZAY3, -1 - сторнирована(снята с визы)';
COMMENT ON COLUMN BARS.ZAYAVKA.META IS 'Цель покупки (спр-к zay_aims)';
COMMENT ON COLUMN BARS.ZAYAVKA.DAT5_VMD IS 'дата остальных вмд';
COMMENT ON COLUMN BARS.ZAYAVKA.RNK_PF IS 'для покупки - рег.№ клиента в пф для продажи: код для 27-го файла';
COMMENT ON COLUMN BARS.ZAYAVKA.PRIORITY IS 'Приоритет заявки: 0 - обычная, 1 - желательная, 2 - обязательная, 9 - гарантированная';
COMMENT ON COLUMN BARS.ZAYAVKA.COUNTRY IS 'код страны перечисления заявки';
COMMENT ON COLUMN BARS.ZAYAVKA.BASIS IS 'Основание для покупки валюты';
COMMENT ON COLUMN BARS.ZAYAVKA.ID IS 'Идентификатор заявки';
COMMENT ON COLUMN BARS.ZAYAVKA.FNAMEKB IS 'Имя файла заявок, принятых по клиент-банку';
COMMENT ON COLUMN BARS.ZAYAVKA.IDENTKB IS 'Признак заявки, принятой по клиент-банку (1)';
COMMENT ON COLUMN BARS.ZAYAVKA.IDBACK IS 'Код причины возврата заявки (спр-к zay_back)';
COMMENT ON COLUMN BARS.ZAYAVKA.PID IS 'референс контракта';
COMMENT ON COLUMN BARS.ZAYAVKA.TIPKB IS 'тип документа от клиент-банка';
COMMENT ON COLUMN BARS.ZAYAVKA.DATEDOKKB IS 'дата поступления заявки';
COMMENT ON COLUMN BARS.ZAYAVKA.ND IS 'номер документа, поступившего из кб';
COMMENT ON COLUMN BARS.ZAYAVKA.DATT IS 'граничная дата действия заявки';
COMMENT ON COLUMN BARS.ZAYAVKA.OBZ IS 'Признак заявки на обязательную продажу (1)';
COMMENT ON COLUMN BARS.ZAYAVKA.DATZ IS 'дата зачисления клиенту грн/вал';
COMMENT ON COLUMN BARS.ZAYAVKA.FL_PF IS 'признак формирования платежа в пенс.фонд';
COMMENT ON COLUMN BARS.ZAYAVKA.FL_KURSZ IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.BENEFCOUNTRY IS 'код страны клиента-бенефециара';
COMMENT ON COLUMN BARS.ZAYAVKA.BANK_CODE IS 'код иностранного банка';
COMMENT ON COLUMN BARS.ZAYAVKA.BANK_NAME IS 'наименование иностранного банка';
COMMENT ON COLUMN BARS.ZAYAVKA.S3 IS 'сумма комиссии';
COMMENT ON COLUMN BARS.ZAYAVKA.LIM IS 'сумма зарезервированной гривны';
COMMENT ON COLUMN BARS.ZAYAVKA.ISP IS 'код пользователя, который ввел заявку';
COMMENT ON COLUMN BARS.ZAYAVKA.TOBO IS 'код подразделения, в котором введена заявка';
COMMENT ON COLUMN BARS.ZAYAVKA.PRODUCT_GROUP IS 'код товарной группы (kod_70_4)';
COMMENT ON COLUMN BARS.ZAYAVKA.NUM_VMD IS '№ таможенной декларации';
COMMENT ON COLUMN BARS.ZAYAVKA.BRANCH IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.KF IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.DETAILS IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.KURS_KL IS 'Первоначальный клиентский курс';
COMMENT ON COLUMN BARS.ZAYAVKA.COMM IS 'Коментарий';
COMMENT ON COLUMN BARS.ZAYAVKA.CONTACT_FIO IS 'ФИО контактного лица';
COMMENT ON COLUMN BARS.ZAYAVKA.CONTACT_TEL IS 'ТЕЛ контактного лица';
COMMENT ON COLUMN BARS.ZAYAVKA.CLOSE_TYPE IS 'Тип закрытия заявки (1-на ВП банка; 2-на МВРУ; 3-заявка закрыта на другую заявку клиєнта))';
COMMENT ON COLUMN BARS.ZAYAVKA.VERIFY_OPT IS 'Унікальний номер операції в системі Клієнт-Банк HOKK';
COMMENT ON COLUMN BARS.ZAYAVKA.AIMS_CODE IS 'Цифровой код цели продажи валюты';
COMMENT ON COLUMN BARS.ZAYAVKA.KV_CONV IS 'Код валюти(конвертація)';
COMMENT ON COLUMN BARS.ZAYAVKA.OPERID_NOKK IS 'Унікальний номер операції в системі Клієнт-Банк HOKK';
COMMENT ON COLUMN BARS.ZAYAVKA.SOPER IS 'Общая сумма исходного вход.документа на 2603 для ОБЗ';
COMMENT ON COLUMN BARS.ZAYAVKA.REF_SPS IS 'Референс проводки по списанию средств';
COMMENT ON COLUMN BARS.ZAYAVKA.S_PF IS 'Сумма отчисления в ПФ';
COMMENT ON COLUMN BARS.ZAYAVKA.REF_PF IS 'Референс отчисления в ПФ';
COMMENT ON COLUMN BARS.ZAYAVKA.ID_PREV IS 'Ид заявки-родителя (для той, кот.разбивали)';
COMMENT ON COLUMN BARS.ZAYAVKA.REQ_TYPE IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.VDATE_PLAN IS 'Плановая дата валютирования';
COMMENT ON COLUMN BARS.ZAYAVKA.REASON_COMM IS 'Причина возврата заявки';
COMMENT ON COLUMN BARS.ZAYAVKA.REFOPER IS 'Референс исходного вход.документа на 2603 для ОБЗ';
COMMENT ON COLUMN BARS.ZAYAVKA.CODE_2C IS 'Код купівлі за імпортом (#2C)';
COMMENT ON COLUMN BARS.ZAYAVKA.P12_2C IS 'Ознака операції(#2C)';
COMMENT ON COLUMN BARS.ZAYAVKA.SUPPORT_DOCUMENT IS 'Наличие подтверждающих документов';



PROMPT *** Create  constraint FK_ZAYAVKA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_PRODUCT_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_PRODUCT_GROUP FOREIGN KEY (PRODUCT_GROUP)
	  REFERENCES BARS.KOD_70_4 (P70) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA MODIFY (KF CONSTRAINT CC_ZAYAVKA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA MODIFY (BRANCH CONSTRAINT CC_ZAYAVKA_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAYAVKA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA MODIFY (ID CONSTRAINT NK_ZAYAVKA_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TABVAL_CONV ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TABVAL_CONV FOREIGN KEY (KV_CONV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_ZATCLOSETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_ZATCLOSETYPES FOREIGN KEY (CLOSE_TYPE)
	  REFERENCES BARS.ZAY_CLOSE_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_ZAYBACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_ZAYBACK FOREIGN KEY (IDBACK)
	  REFERENCES BARS.ZAY_BACK (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ZAYAVKA_FNAMEKB_IDENTKB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT UK_ZAYAVKA_FNAMEKB_IDENTKB UNIQUE (FNAMEKB, IDENTKB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAYAVKA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT PK_ZAYAVKA_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_DK CHECK (dk in (1, 2, 3, 4)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_SOS CHECK (sos between -1 and 2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_VIZA ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_VIZA CHECK (viza in (-1, 0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_OBZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_OBZ CHECK (obz in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_FLPF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_FLPF CHECK (fl_pf in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_FLKURSZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_FLKURSZ CHECK (fl_kursz in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_CODE2C ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_CODE2C CHECK (code_2c in (''0'', ''1'', ''2'', ''3'', ''4'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_ZAYAVKA_BENEFCOUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT XFK_ZAYAVKA_BENEFCOUNTRY FOREIGN KEY (BENEFCOUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_ZAYAVKA_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT XFK_ZAYAVKA_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_ZAYAVKA_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT XFK_ZAYAVKA_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_ZAYAIMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_ZAYAIMS FOREIGN KEY (META)
	  REFERENCES BARS.ZAY_AIMS (AIM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_BANKS FOREIGN KEY (MFOP)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TABVAL FOREIGN KEY (KV2)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_BANKS2 FOREIGN KEY (MFO0)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_PRIORITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_PRIORITY FOREIGN KEY (PRIORITY)
	  REFERENCES BARS.ZAY_PRIORITY (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ZAYAVKA_FNAMEKB_IDENTKB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ZAYAVKA_FNAMEKB_IDENTKB ON BARS.ZAYAVKA (FNAMEKB, IDENTKB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYAVKA_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYAVKA_ID ON BARS.ZAYAVKA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_ZAYAVKA ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_ZAYAVKA ON BARS.ZAYAVKA (KV2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ZAYAVKA_KF_REF_DK ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ZAYAVKA_KF_REF_DK ON BARS.ZAYAVKA (KF, REFOPER, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



begin
  execute immediate
    ' alter table bars.zayavka add ATTACHMENTS_COUNT integer ';
exception when others then
  if sqlcode=-1430 then null; else raise; end if;
end;
/

COMMENT ON COLUMN BARS.ZAYAVKA.ATTACHMENTS_COUNT is 'Кількість доданих документів';




PROMPT *** Create  grants  ZAYAVKA ***
grant FLASHBACK,REFERENCES,SELECT                                            on ZAYAVKA         to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on ZAYAVKA         to BARSAQ_ADM with grant option;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAYAVKA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAYAVKA         to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on ZAYAVKA         to START1;
grant INSERT                                                                 on ZAYAVKA         to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAYAVKA         to WR_ALL_RIGHTS;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAYAVKA         to ZAY;

GRANT UPDATE 																ON BARS.ZAYAVKA 	TO BARSAQ;


PROMPT *** Create SYNONYM  to ZAYAVKA ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAYAVKA FOR BARS.ZAYAVKA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAYAVKA.sql =========*** End *** =====
PROMPT ===================================================================================== 
