

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KOD_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KOD_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KOD_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KOD_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_KOD_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KOD_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KOD_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ID NUMBER, 
	EMI NUMBER, 
	DOX NUMBER(38,0), 
	CP_ID VARCHAR2(20), 
	KV NUMBER, 
	NAME VARCHAR2(70), 
	COUNTRY NUMBER(38,0), 
	DATP DATE, 
	IR NUMBER, 
	TIP NUMBER, 
	DAT_EM DATE, 
	AMORT NUMBER, 
	DCP NUMBER, 
	CENA NUMBER, 
	BASEY NUMBER, 
	CENA_KUP NUMBER(10,2), 
	KY NUMBER, 
	DOK DATE, 
	DNK DATE, 
	RNK NUMBER, 
	PERIOD_KUP NUMBER, 
	IDT VARCHAR2(4), 
	DAT_RR DATE, 
	PR1_KUP NUMBER(*,0), 
	PR_AMR NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	VNCRR VARCHAR2(4), 
	PR_AKT NUMBER(*,0), 
	METR NUMBER(*,0), 
	GS NUMBER(2,0), 
	CENA_KUP0 NUMBER(10,2), 
	CENA_START NUMBER, 
	QUOT_SIGN NUMBER(*,0), 
	DATZR DATE, 
	DATVK DATE, 
	IO NUMBER(*,0), 
	RIVEN NUMBER(*,0), 
	IN_BR NUMBER(*,0), 
	EXPIRY NUMBER(*,0), 
	ZAL_CP NUMBER, 
	PAWN NUMBER(*,0), 
	HIERARCHY_ID NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KOD_UPDATE ***
 exec bpa.alter_policies('CP_KOD_UPDATE');


COMMENT ON TABLE BARS.CP_KOD_UPDATE IS 'Справочник кодов ЦБ';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.ID IS 'Номер пп - первичный ключ';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.EMI IS 'Вид эмитента';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DOX IS 'Вид доходности';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CP_ID IS 'Внешний код ЦБ';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KV IS 'Вал эмиссии';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.NAME IS 'Наименование эмитента';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.COUNTRY IS 'Страна эмитента';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DATP IS 'Дата погашения номинала';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IR IS 'Годовая % ставка';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.TIP IS 'Размещение(чужие), Привлечение(свои)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DAT_EM IS 'Дата эмиссии';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.AMORT IS 'Аморт.варт. = 1,Справ.варт. =0';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DCP IS '1-есть в ДЦП, 0-нет';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA IS 'Поточна Номiнальна вартiсть ЦП';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.BASEY IS 'Код базового року';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA_KUP IS 'Цена купона 1 ЦБ (в целых с коп 10.55)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KY IS 'Кiл-сть сплат купону в роц_';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DOK IS 'Дата сплати Останнього Купону';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DNK IS 'Дата сплати Наступного Купону';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.RNK IS 'Регистрационный номер контрагента - эмитента ЦБ';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PERIOD_KUP IS 'Купонный период (дней).';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IDT IS 'Вид ЦП';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DAT_RR IS 'Дата объявления эмитентом получателя купона';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PR1_KUP IS '1 = Начислать купон на номинал всего пакета,
2 = Начислать купон на номинал 1 шт и умножать на кол-во в пакете
null = по старому. те для вал 1 = на номинал пакета,
                      для грн 2 = на номинал 1 шт';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PR_AMR IS '5= Амортиз Диск/Прем по эф.ставке (алгоритм КБ, Куценко)
4= Амортизя Диск/Прем линейно(равн.долями)
 = Амортиз Диск/Прем по эф.ставке (алгоритм НБУ)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.VNCRR IS 'Внутрiшнiй кредитний рейтiнг';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PR_AKT IS 'Ознака актуальносту';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.METR IS 'Метод нарахування %';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.GS IS 'Ознака держ. ЦП';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA_KUP0 IS 'Ц_на купона...';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.CENA_START IS 'Стартова Номiнальна вартiсть ЦП';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.QUOT_SIGN IS 'sign quotation on the stock exchange(признак котировки на бирже)';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DATZR IS 'Дата завершення реал_зац_ї';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.DATVK IS 'Дата початку виплати купонного пер_оду';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IO IS 'Нарахування %-в по вх/вих залишку';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.RIVEN IS 'Рівень ієрархії ЦП в лістингу визначення спр. вартості';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.IN_BR IS 'Включено до біржового реєстру 0/1';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.EXPIRY IS 'Кількість днів прострочення';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.ZAL_CP IS 'Забезпечення на 1 шт.ЦП';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.PAWN IS 'Вид забезпечення';
COMMENT ON COLUMN BARS.CP_KOD_UPDATE.HIERARCHY_ID IS 'Рівень ієрархії справедливої вартості ЦП';




PROMPT *** Create  constraint SYS_C009607 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (DAT_EM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPKODUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (KF CONSTRAINT CC_CPKODUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPKODUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE ADD CONSTRAINT FK_CPKODUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009603 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (DOX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CPKOD_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE ADD CONSTRAINT PK_CPKOD_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009602 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (EMI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009604 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009605 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009606 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009601 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD_UPDATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPKOD_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPKOD_UPDATE ON BARS.CP_KOD_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CPKOD_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CPKOD_UPDATEEFFDAT ON BARS.CP_KOD_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CPKOD_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CPKOD_UPDATEPK ON BARS.CP_KOD_UPDATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table CP_KOD_UPDATE add fin_351 number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CP_KOD_UPDATE add pd number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CP_KOD_UPDATE add fair_method_id number(2)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 



PROMPT *** Create  grants  CP_KOD_UPDATE ***
grant SELECT                                                                 on CP_KOD_UPDATE   to BARSUPL;
grant SELECT                                                                 on CP_KOD_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KOD_UPDATE   to BARS_DM;
grant SELECT                                                                 on CP_KOD_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KOD_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
