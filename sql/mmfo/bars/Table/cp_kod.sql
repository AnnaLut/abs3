

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KOD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KOD'', ''CENTER'' , null, null, null, ''E'');
               bpa.alter_policy_info(''CP_KOD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_KOD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KOD 
   (	ID NUMBER, 
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
	CENA_KUP NUMBER(20,2), 
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
	PR_AKT NUMBER(*,0) DEFAULT 0, 
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
	VNCRP VARCHAR2(4), 
	ZAL_CP NUMBER, 
	PAWN NUMBER(*,0), 
	HIERARCHY_ID NUMBER(*,0), 
	FIN_351 NUMBER, 
	PD NUMBER,
        KF varchar2(6) default sys_context(''bars_context'',''user_mfo'')        
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KOD ***
 exec bpa.alter_policies('CP_KOD');


COMMENT ON TABLE BARS.CP_KOD IS 'Справочник кодов ЦБ';
COMMENT ON COLUMN BARS.CP_KOD.FIN_351 IS 'Фін.стан згідно 351 пост.';
COMMENT ON COLUMN BARS.CP_KOD.PD IS 'PD';
COMMENT ON COLUMN BARS.CP_KOD.ID IS 'Номер пп - первичный ключ';
COMMENT ON COLUMN BARS.CP_KOD.EMI IS 'Вид эмитента';
COMMENT ON COLUMN BARS.CP_KOD.DOX IS 'Вид доходности';
COMMENT ON COLUMN BARS.CP_KOD.CP_ID IS 'Внешний код ЦБ';
COMMENT ON COLUMN BARS.CP_KOD.KV IS 'Вал эмиссии';
COMMENT ON COLUMN BARS.CP_KOD.NAME IS 'Наименование эмитента';
COMMENT ON COLUMN BARS.CP_KOD.COUNTRY IS 'Страна эмитента';
COMMENT ON COLUMN BARS.CP_KOD.DATP IS 'Дата погашения номинала';
COMMENT ON COLUMN BARS.CP_KOD.IR IS 'Годовая % ставка';
COMMENT ON COLUMN BARS.CP_KOD.TIP IS 'Размещение(чужие), Привлечение(свои)';
COMMENT ON COLUMN BARS.CP_KOD.DAT_EM IS 'Дата эмиссии';
COMMENT ON COLUMN BARS.CP_KOD.AMORT IS 'Аморт.варт. = 1,Справ.варт. =0';
COMMENT ON COLUMN BARS.CP_KOD.DCP IS '1-есть в ДЦП, 0-нет';
COMMENT ON COLUMN BARS.CP_KOD.CENA IS 'Поточна Номiнальна вартiсть ЦП';
COMMENT ON COLUMN BARS.CP_KOD.BASEY IS '';
COMMENT ON COLUMN BARS.CP_KOD.CENA_KUP IS 'Цена купона 1 ЦБ (в целых с коп 10.55)';
COMMENT ON COLUMN BARS.CP_KOD.KY IS 'Кiл-сть сплат купону в році';
COMMENT ON COLUMN BARS.CP_KOD.DOK IS 'Дата сплати Останнього Купону';
COMMENT ON COLUMN BARS.CP_KOD.DNK IS 'Дата сплати Наступного Купону';
COMMENT ON COLUMN BARS.CP_KOD.RNK IS 'Регистрационный номер контрагента - эмитента ЦБ';
COMMENT ON COLUMN BARS.CP_KOD.PERIOD_KUP IS 'Купонный период (дней).';
COMMENT ON COLUMN BARS.CP_KOD.IDT IS '';
COMMENT ON COLUMN BARS.CP_KOD.DAT_RR IS 'Дата объявления эмитентом получателя купона';
COMMENT ON COLUMN BARS.CP_KOD.PR1_KUP IS '1 = Начислать купон на номинал всего пакета,
2 = Начислать купон на номинал 1 шт и умножать на кол-во в пакете
null = по старому. те для вал 1 = на номинал пакета,
                      для грн 2 = на номинал 1 шт';
COMMENT ON COLUMN BARS.CP_KOD.PR_AMR IS '5= Амортиз Диск/Прем по эф.ставке (алгоритм КБ, Куценко)
4= Амортизя Диск/Прем линейно(равн.долями)
 = Амортиз Диск/Прем по эф.ставке (алгоритм НБУ)';
COMMENT ON COLUMN BARS.CP_KOD.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.CP_KOD.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.CP_KOD.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.CP_KOD.VNCRR IS 'Внутрiшнiй кредитний рейтiнг';
COMMENT ON COLUMN BARS.CP_KOD.PR_AKT IS 'Ознака актуальносту';
COMMENT ON COLUMN BARS.CP_KOD.METR IS '';
COMMENT ON COLUMN BARS.CP_KOD.GS IS '';
COMMENT ON COLUMN BARS.CP_KOD.CENA_KUP0 IS '';
COMMENT ON COLUMN BARS.CP_KOD.CENA_START IS 'Стартова Номiнальна вартiсть ЦП';
COMMENT ON COLUMN BARS.CP_KOD.QUOT_SIGN IS 'sign quotation on the stock exchange(признак котировки на бирже)';
COMMENT ON COLUMN BARS.CP_KOD.DATZR IS 'Дата завершення реалізації';
COMMENT ON COLUMN BARS.CP_KOD.DATVK IS 'Дата початку виплати купонного періоду';
COMMENT ON COLUMN BARS.CP_KOD.IO IS 'Нарах.% по вх/вих залишку';
COMMENT ON COLUMN BARS.CP_KOD.RIVEN IS 'Рівень ієрархії ЦП в лістингу визначення спр. вартості';
COMMENT ON COLUMN BARS.CP_KOD.IN_BR IS 'Включено до біржового реєстру 0/1';
COMMENT ON COLUMN BARS.CP_KOD.EXPIRY IS 'Кількість днів прострочення';
COMMENT ON COLUMN BARS.CP_KOD.VNCRP IS 'Початковий ВКР';
COMMENT ON COLUMN BARS.CP_KOD.ZAL_CP IS 'Забезпечення на 1 шт.ЦП';
COMMENT ON COLUMN BARS.CP_KOD.PAWN IS 'Вид забезпечення';
COMMENT ON COLUMN BARS.CP_KOD.HIERARCHY_ID IS 'Рівень ієрархії справедливої вартості цінних паперів';




PROMPT *** Create  constraint SYS_C008837 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (EMI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FX_CP_KOD_IDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FX_CP_KOD_IDT FOREIGN KEY (IDT)
	  REFERENCES BARS.CP_TYPE (IDT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008842 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (DAT_EM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008841 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008840 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008839 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPKOD_DOX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (DOX CONSTRAINT CC_CPKOD_DOX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008836 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_VNCRR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_VNCRR FOREIGN KEY (VNCRR)
	  REFERENCES BARS.CCK_RATING (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_EMI ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_EMI FOREIGN KEY (EMI)
	  REFERENCES BARS.CP_EMI (EMI) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_KOD_DOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_KOD_DOX FOREIGN KEY (DOX)
	  REFERENCES BARS.CP_DOX (DOX) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_HIERARCHY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT FK_CP_HIERARCHY FOREIGN KEY (HIERARCHY_ID)
	  REFERENCES BARS.CP_HIERARCHY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_CP_KOD_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CHK_CP_KOD_RNK CHECK (RNK is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



/*
PROMPT *** Create  constraint XPK_CP_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT XPK_CP_KOD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
*/
begin   
 execute immediate 'alter table CP_KOD drop constraint XPK_CP_KOD cascade';
exception when others then
  if  sqlcode=-2443 then null; else raise; end if;
end;
/

PROMPT *** Create  constraint XPK_CP_KOD_ID_KF ***
begin   
 execute immediate 'alter table CP_KOD add constraint XPK_CP_KOD_ID_KF primary key (ID, KF)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint CP_KOD_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CP_KOD_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CP_KOD_VR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KOD ADD CONSTRAINT CP_KOD_VR FOREIGN KEY (AMORT)
	  REFERENCES BARS.CP_VR (VR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDXEMI ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDXEMI ON BARS.CP_KOD (EMI) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



/*
PROMPT *** Create  index XPK_CP_KOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_KOD ON BARS.CP_KOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
*/

begin   
 execute immediate 'drop index XPK_CP_KOD';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/


begin   
 execute immediate 'drop index XAK_CP_ID_CP_KOD';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/

/*
PROMPT *** Create  index XAK_CP_ID_CP_KOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_CP_ID_CP_KOD ON BARS.CP_KOD (CP_ID, DAT_EM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
*/
begin   
 execute immediate 'CREATE UNIQUE INDEX BARS.XAK_CP_ID_DAT_EM ON BARS.CP_KOD (CP_ID, KF, DAT_EM) 
  TABLESPACE BRSMDLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table CP_KOD add fair_method_id number(2)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

COMMENT ON COLUMN BARS.CP_KOD.fair_method_id IS 'Метод розрахунку справедливої вартості';


begin   
 execute immediate 'alter table CP_KOD
  add constraint FK_CP_FAIR_METHOD foreign key (FAIR_METHOD_ID)
  references cp_fair_method (ID)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_KOD ***
grant SELECT                                                                 on CP_KOD          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_KOD          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KOD          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_KOD          to CP_ROLE;
grant SELECT                                                                 on CP_KOD          to RPBN001;
grant SELECT                                                                 on CP_KOD          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_KOD          to WR_REFREAD;



PROMPT *** Create SYNONYM  to CP_KOD ***

  CREATE OR REPLACE PUBLIC SYNONYM CP_KOD FOR BARS.CP_KOD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KOD.sql =========*** End *** ======
PROMPT ===================================================================================== 
