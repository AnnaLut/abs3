

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_OWNER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_OWNER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_OWNER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OWNER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OWNER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_OWNER ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_OWNER 
   (	ID NUMBER(10,0), 
	BDATE DATE, 
	OZN NUMBER(2,0), 
	POS VARCHAR2(254), 
	NAT_COD_KR NUMBER(3,0), 
	NAT_DT DATE, 
	PRUCH_VIDSOTOK NUMBER(7,4), 
	PRUCH_NOMINAL NUMBER(16,2), 
	PRUCH_GOLOSI NUMBER(16,0), 
	OPRUCH_VIDSOTOK NUMBER(7,4), 
	OPRUCH_NOMINAL NUMBER(16,2), 
	OPRUCH_GOLOSI NUMBER(16,0), 
	GOLUCH_VIDSOTOK NUMBER(7,4), 
	GOLUCH_GOLOS NUMBER(16,0), 
	ZAGUCH_VIDSOTOK NUMBER(7,4), 
	ZAGUCH_GOLOS NUMBER(16,0), 
	NM1 VARCHAR2(254), 
	NM2 VARCHAR2(50), 
	NM3 VARCHAR2(50), 
	TYPE NUMBER(1,0), 
	COD VARCHAR2(20), 
	PS_SR VARCHAR2(7), 
	PS_NM VARCHAR2(20), 
	PS_DT DATE, 
	PS_ORG VARCHAR2(254), 
	DORG VARCHAR2(254), 
	COD_KR NUMBER(3,0), 
	INDX VARCHAR2(10), 
	PUNKT VARCHAR2(254), 
	UL VARCHAR2(50), 
	BUD VARCHAR2(10), 
	KORP VARCHAR2(10), 
	OFF VARCHAR2(10), 
	NM_UA VARCHAR2(254), 
	NAT VARCHAR2(254), 
	PUNKT_UA VARCHAR2(254), 
	UL_UA VARCHAR2(50), 
	REL_TYPE NUMBER(10,0), 
	ROZ VARCHAR2(2000), 
	OWNER_OZN NUMBER(1,0), 
	NBU_DOC_NUM VARCHAR2(100), 
	NBU_DOC_DATE DATE, 
	GROUP_ID NUMBER(10,0), 
	GROUP_REASON VARCHAR2(100), 
	GROUP_DOC_NUM VARCHAR2(100), 
	GROUP_DOC_DATE DATE, 
	CONDITION VARCHAR2(250), 
	COND_DOC_NUM VARCHAR2(100), 
	COND_DOC_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_OWNER ***
 exec bpa.alter_policies('SV_OWNER');


COMMENT ON TABLE BARS.SV_OWNER IS '';
COMMENT ON COLUMN BARS.SV_OWNER.ID IS 'Id';
COMMENT ON COLUMN BARS.SV_OWNER.BDATE IS 'Дата народження';
COMMENT ON COLUMN BARS.SV_OWNER.OZN IS 'Ознака особи';
COMMENT ON COLUMN BARS.SV_OWNER.POS IS 'Посада';
COMMENT ON COLUMN BARS.SV_OWNER.NAT_COD_KR IS 'Громадянство (Код країни)';
COMMENT ON COLUMN BARS.SV_OWNER.NAT_DT IS 'Дата прийняття громадянства';
COMMENT ON COLUMN BARS.SV_OWNER.PRUCH_VIDSOTOK IS 'Пряма участь: Відсотки статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_OWNER.PRUCH_NOMINAL IS 'Пряма участь: Номінал статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_OWNER.PRUCH_GOLOSI IS 'Пряма участь: Кількість голосів';
COMMENT ON COLUMN BARS.SV_OWNER.OPRUCH_VIDSOTOK IS 'Опосередкована участь: Відсотки статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_OWNER.OPRUCH_NOMINAL IS 'Опосередкована участь: Номінал статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_OWNER.OPRUCH_GOLOSI IS 'Опосередкована участь: Кількість голосів';
COMMENT ON COLUMN BARS.SV_OWNER.GOLUCH_VIDSOTOK IS 'Набуте право голосу: Відсотки статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_OWNER.GOLUCH_GOLOS IS 'Набуте право голосу: Кількість голосів';
COMMENT ON COLUMN BARS.SV_OWNER.ZAGUCH_VIDSOTOK IS 'Загальні дані: Загальний відсоток статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_OWNER.ZAGUCH_GOLOS IS 'Загальні дані: Загальна кількість голосів';
COMMENT ON COLUMN BARS.SV_OWNER.NM1 IS 'Прізвище/найменування';
COMMENT ON COLUMN BARS.SV_OWNER.NM2 IS 'Ім’я/скорочене найменування';
COMMENT ON COLUMN BARS.SV_OWNER.NM3 IS 'По батькові';
COMMENT ON COLUMN BARS.SV_OWNER.TYPE IS 'Тип учасника:0-Держава, 1-ЮО, 2-ФО';
COMMENT ON COLUMN BARS.SV_OWNER.COD IS 'Ідентифікаційний код';
COMMENT ON COLUMN BARS.SV_OWNER.PS_SR IS 'Серія документа';
COMMENT ON COLUMN BARS.SV_OWNER.PS_NM IS 'Номер документа';
COMMENT ON COLUMN BARS.SV_OWNER.PS_DT IS 'Дата видачі документа';
COMMENT ON COLUMN BARS.SV_OWNER.PS_ORG IS 'Повне найменування органу, який видав документ';
COMMENT ON COLUMN BARS.SV_OWNER.DORG IS 'Державний орган, який здійснив реєстрацію (для іноземних ЮО)';
COMMENT ON COLUMN BARS.SV_OWNER.COD_KR IS 'Код країни';
COMMENT ON COLUMN BARS.SV_OWNER.INDX IS 'Поштовий індекс';
COMMENT ON COLUMN BARS.SV_OWNER.PUNKT IS 'Назва населеного пункту ';
COMMENT ON COLUMN BARS.SV_OWNER.UL IS 'Вулиця';
COMMENT ON COLUMN BARS.SV_OWNER.BUD IS 'Будинок';
COMMENT ON COLUMN BARS.SV_OWNER.KORP IS 'Корпус (споруда)';
COMMENT ON COLUMN BARS.SV_OWNER.OFF IS 'Офіс';
COMMENT ON COLUMN BARS.SV_OWNER.NM_UA IS 'Ім’я/найменування (транслітерація українською мовою)';
COMMENT ON COLUMN BARS.SV_OWNER.NAT IS 'Громадянство';
COMMENT ON COLUMN BARS.SV_OWNER.PUNKT_UA IS 'Назва населеного пункту (транслітерація українською мовою)';
COMMENT ON COLUMN BARS.SV_OWNER.UL_UA IS 'Вулиця (транслітерація українською мовою)';
COMMENT ON COLUMN BARS.SV_OWNER.REL_TYPE IS 'Взаємозв’язки особи з банком ';
COMMENT ON COLUMN BARS.SV_OWNER.ROZ IS 'Розрахунок, %';
COMMENT ON COLUMN BARS.SV_OWNER.OWNER_OZN IS 'Тип істотної участі';
COMMENT ON COLUMN BARS.SV_OWNER.NBU_DOC_NUM IS 'Номер рішення НБУ про надання згоди на набуття істотної участі в банку';
COMMENT ON COLUMN BARS.SV_OWNER.NBU_DOC_DATE IS 'Дата рішення НБУ про надання згоди на набуття істотної участі в банку';
COMMENT ON COLUMN BARS.SV_OWNER.GROUP_ID IS 'Група осіб, якщо особа спільно з іншими особами як група осіб є власником істотної участі в банку';
COMMENT ON COLUMN BARS.SV_OWNER.GROUP_REASON IS 'Підстава, у зв'язку з якою особа належать до наведеної групи';
COMMENT ON COLUMN BARS.SV_OWNER.GROUP_DOC_NUM IS '№ док-та на підставі якого особа належать до наведеної групи';
COMMENT ON COLUMN BARS.SV_OWNER.GROUP_DOC_DATE IS 'Дата док-та на підставі якого особа належать до наведеної групи';
COMMENT ON COLUMN BARS.SV_OWNER.CONDITION IS 'Обставини, у зв'язку з якими особа має можливість значного або вирішального впливу на управління та діяльність банку/юридичної особи';
COMMENT ON COLUMN BARS.SV_OWNER.COND_DOC_NUM IS '№ док-та у зв'язку з яким особа має можливість значного або вирішального впливу на управління та діяльність банку/юридичної особи';
COMMENT ON COLUMN BARS.SV_OWNER.COND_DOC_DATE IS 'Дата док-та у зв'язку з яким особа має можливість значного або вирішального впливу на управління та діяльність банку/юридичної особи';




PROMPT *** Create  constraint CC_SVOWNER_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER ADD CONSTRAINT CC_SVOWNER_TYPE CHECK (type in (0,1,2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNER_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER ADD CONSTRAINT CC_SVOWNER_TYPE_NN CHECK (type   is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNER_COD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER ADD CONSTRAINT CC_SVOWNER_COD_NN CHECK (cod    is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNER_TYPE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER ADD CONSTRAINT CC_SVOWNER_TYPE1 CHECK (type in (0,1,2,3,4,5)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SVOWNER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER ADD CONSTRAINT PK_SVOWNER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNER_NM1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER ADD CONSTRAINT CC_SVOWNER_NM1_NN CHECK (nm1    is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNER_OZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER MODIFY (OZN CONSTRAINT CC_SVOWNER_OZN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNER_NM2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER ADD CONSTRAINT CC_SVOWNER_NM2_NN CHECK (nm2    is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNER_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER MODIFY (ID CONSTRAINT CC_SVOWNER_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVOWNER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVOWNER ON BARS.SV_OWNER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_OWNER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OWNER        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_OWNER        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OWNER        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_OWNER.sql =========*** End *** ====
PROMPT ===================================================================================== 
