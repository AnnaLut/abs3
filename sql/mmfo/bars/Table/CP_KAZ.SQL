

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KAZ.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KAZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KAZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KAZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KAZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KAZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KAZ 
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
    KF varchar2(6)         
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KAZ ***
 exec bpa.alter_policies('CP_KAZ');


COMMENT ON TABLE BARS.CP_KAZ IS 'Справочник кодов ЦБ';
COMMENT ON COLUMN BARS.CP_KAZ.FIN_351 IS 'Фін.стан згідно 351 пост.';
COMMENT ON COLUMN BARS.CP_KAZ.PD IS 'PD';
COMMENT ON COLUMN BARS.CP_KAZ.ID IS 'Номер пп - первичный ключ';
COMMENT ON COLUMN BARS.CP_KAZ.EMI IS 'Вид эмитента';
COMMENT ON COLUMN BARS.CP_KAZ.DOX IS 'Вид доходности';
COMMENT ON COLUMN BARS.CP_KAZ.CP_ID IS 'Внешний код ЦБ';
COMMENT ON COLUMN BARS.CP_KAZ.KV IS 'Вал эмиссии';
COMMENT ON COLUMN BARS.CP_KAZ.NAME IS 'Наименование эмитента';
COMMENT ON COLUMN BARS.CP_KAZ.COUNTRY IS 'Страна эмитента';
COMMENT ON COLUMN BARS.CP_KAZ.DATP IS 'Дата погашения номинала';
COMMENT ON COLUMN BARS.CP_KAZ.IR IS 'Годовая % ставка';
COMMENT ON COLUMN BARS.CP_KAZ.TIP IS 'Размещение(чужие), Привлечение(свои)';
COMMENT ON COLUMN BARS.CP_KAZ.DAT_EM IS 'Дата эмиссии';
COMMENT ON COLUMN BARS.CP_KAZ.AMORT IS 'Аморт.варт. = 1,Справ.варт. =0';
COMMENT ON COLUMN BARS.CP_KAZ.DCP IS '1-есть в ДЦП, 0-нет';
COMMENT ON COLUMN BARS.CP_KAZ.CENA IS 'Поточна Номiнальна вартiсть ЦП';
COMMENT ON COLUMN BARS.CP_KAZ.BASEY IS '';
COMMENT ON COLUMN BARS.CP_KAZ.CENA_KUP IS 'Цена купона 1 ЦБ (в целых с коп 10.55)';
COMMENT ON COLUMN BARS.CP_KAZ.KY IS 'Кiл-сть сплат купону в році';
COMMENT ON COLUMN BARS.CP_KAZ.DOK IS 'Дата сплати Останнього Купону';
COMMENT ON COLUMN BARS.CP_KAZ.DNK IS 'Дата сплати Наступного Купону';
COMMENT ON COLUMN BARS.CP_KAZ.RNK IS 'Регистрационный номер контрагента - эмитента ЦБ';
COMMENT ON COLUMN BARS.CP_KAZ.PERIOD_KUP IS 'Купонный период (дней).';
COMMENT ON COLUMN BARS.CP_KAZ.IDT IS '';
COMMENT ON COLUMN BARS.CP_KAZ.DAT_RR IS 'Дата объявления эмитентом получателя купона';
COMMENT ON COLUMN BARS.CP_KAZ.PR1_KUP IS '1 = Начислать купон на номинал всего пакета,
2 = Начислать купон на номинал 1 шт и умножать на кол-во в пакете
null = по старому. те для вал 1 = на номинал пакета,
                      для грн 2 = на номинал 1 шт';
COMMENT ON COLUMN BARS.CP_KAZ.PR_AMR IS '5= Амортиз Диск/Прем по эф.ставке (алгоритм КБ, Куценко)
4= Амортизя Диск/Прем линейно(равн.долями)
 = Амортиз Диск/Прем по эф.ставке (алгоритм НБУ)';
COMMENT ON COLUMN BARS.CP_KAZ.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.CP_KAZ.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.CP_KAZ.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.CP_KAZ.VNCRR IS 'Внутрiшнiй кредитний рейтiнг';
COMMENT ON COLUMN BARS.CP_KAZ.PR_AKT IS 'Ознака актуальносту';
COMMENT ON COLUMN BARS.CP_KAZ.METR IS '';
COMMENT ON COLUMN BARS.CP_KAZ.GS IS '';
COMMENT ON COLUMN BARS.CP_KAZ.CENA_KUP0 IS '';
COMMENT ON COLUMN BARS.CP_KAZ.CENA_START IS 'Стартова Номiнальна вартiсть ЦП';
COMMENT ON COLUMN BARS.CP_KAZ.QUOT_SIGN IS 'sign quotation on the stock exchange(признак котировки на бирже)';
COMMENT ON COLUMN BARS.CP_KAZ.DATZR IS 'Дата завершення реалізації';
COMMENT ON COLUMN BARS.CP_KAZ.DATVK IS 'Дата початку виплати купонного періоду';
COMMENT ON COLUMN BARS.CP_KAZ.IO IS 'Нарах.% по вх/вих залишку';
COMMENT ON COLUMN BARS.CP_KAZ.RIVEN IS 'Рівень ієрархії ЦП в лістингу визначення спр. вартості';
COMMENT ON COLUMN BARS.CP_KAZ.IN_BR IS 'Включено до біржового реєстру 0/1';
COMMENT ON COLUMN BARS.CP_KAZ.EXPIRY IS 'Кількість днів прострочення';
COMMENT ON COLUMN BARS.CP_KAZ.VNCRP IS 'Початковий ВКР';
COMMENT ON COLUMN BARS.CP_KAZ.ZAL_CP IS 'Забезпечення на 1 шт.ЦП';
COMMENT ON COLUMN BARS.CP_KAZ.PAWN IS 'Вид забезпечення';
COMMENT ON COLUMN BARS.CP_KAZ.HIERARCHY_ID IS 'Рівень ієрархії справедливої вартості цінних паперів';


PROMPT *** Create  constraint XPK_CP_KAZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KAZ ADD CONSTRAINT XPK_CP_KAZ PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  index XPK_CP_KAZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_KAZ ON BARS.CP_KAZ (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table CP_KAZ add fair_method_id number(2)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

COMMENT ON COLUMN BARS.CP_KAZ.fair_method_id IS 'Метод розрахунку справедливої вартості';




PROMPT *** Create  grants  CP_KAZ ***
grant SELECT                                                                 on CP_KAZ          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_KAZ          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KAZ          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_KAZ          to CP_ROLE;
grant SELECT                                                                 on CP_KAZ          to RPBN001;
grant SELECT                                                                 on CP_KAZ          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_KAZ          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KAZ.sql =========*** End *** ======
PROMPT ===================================================================================== 

begin

insert into cp_kaz (ID, EMI, DOX, CP_ID, KV, NAME, COUNTRY, DATP, IR, TIP, DAT_EM, AMORT, DCP, CENA, BASEY, CENA_KUP, KY, DOK, DNK, RNK, PERIOD_KUP, IDT, DAT_RR, PR1_KUP, PR_AMR, FIN23, KAT23, K23, VNCRR, PR_AKT, METR, GS, CENA_KUP0, CENA_START, QUOT_SIGN, DATZR, DATVK, IO, RIVEN, IN_BR)  
    select ID, EMI, DOX, CP_ID, KV, NAME, COUNTRY, DATP, IR, TIP, DAT_EM, AMORT, DCP, CENA, BASEY, CENA_KUP, KY, DOK, DNK, RNK, PERIOD_KUP, IDT, DAT_RR, PR1_KUP, PR_AMR, FIN23, KAT23, K23, VNCRR, PR_AKT, METR, GS, CENA_KUP0, CENA_START, QUOT_SIGN, DATZR, DATVK, IO, RIVEN, IN_BR from cp_kod
      where id in (select id from CP_KAZ_OB)
	    and id not in (select id from cp_kaz);

update cp_kaz
   set datp = to_date('30-12-2016','dd-mm-yyyy')
 where id = case f_ourmfo_g when '300465' then  465 else 282 end; 
 
end;
/
commit;


