

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_ZPROD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_ZPROD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_ZPROD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_ZPROD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_ZPROD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_ZPROD ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_ZPROD 
   (	ID NUMBER, 
	FL NUMBER, 
	NAMEF VARCHAR2(12), 
	FIO1 VARCHAR2(96), 
	FIO2 VARCHAR2(96), 
	I_VA VARCHAR2(16), 
	SUMVAL VARCHAR2(96), 
	KURS VARCHAR2(32), 
	SUMKURS VARCHAR2(32), 
	RAHBANK VARCHAR2(96), 
	RAHPOT VARCHAR2(96), 
	KOMIS VARCHAR2(32), 
	RAHPOTVAL VARCHAR2(96), 
	RAHVAL VARCHAR2(96), 
	PS_NUMBER VARCHAR2(96), 
	DATETIMEPICKER1 VARCHAR2(16), 
	NAME VARCHAR2(254), 
	POSTIND VARCHAR2(32), 
	RAYON VARCHAR2(96), 
	CITY VARCHAR2(96), 
	STREET VARCHAR2(96), 
	HOUSE VARCHAR2(32), 
	APARTMENT VARCHAR2(32), 
	FONFAX VARCHAR2(96), 
	REGION VARCHAR2(96), 
	NAMEUP VARCHAR2(96), 
	TELUP VARCHAR2(96), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DATEDOKKB DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_ZPROD ***
 exec bpa.alter_policies('KLP_ZPROD');


COMMENT ON TABLE BARS.KLP_ZPROD IS 'Документообіг - Заява на купівлю валюти';
COMMENT ON COLUMN BARS.KLP_ZPROD.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.KLP_ZPROD.FL IS 'Флаг обработки';
COMMENT ON COLUMN BARS.KLP_ZPROD.NAMEF IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.FIO1 IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.FIO2 IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.I_VA IS 'Умови продажу іноземної валюти або банківських металів, Код валюти';
COMMENT ON COLUMN BARS.KLP_ZPROD.SUMVAL IS 'Умови продажу іноземної валюти або банківських металів, Сума валюти або маса банківських металів';
COMMENT ON COLUMN BARS.KLP_ZPROD.KURS IS 'Умови продажу іноземної валюти або банківських металів, Курс продажу в гривнях';
COMMENT ON COLUMN BARS.KLP_ZPROD.SUMKURS IS 'Умови продажу іноземної валюти або банківських металів, Сума в гривнях відповідно до курсу';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHBANK IS 'Зобов'язання та доручення, Суму іноземної валюти, що підлягає продажу перерахувати на рахунок';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHPOT IS 'Зобов'язання та доручення, Гривневий еквівалент проданої іноземної валюти перерахувати на поточний рахунок';
COMMENT ON COLUMN BARS.KLP_ZPROD.KOMIS IS 'Зобов'язання та доручення, Утримання комісійної винагороди в грн. (%)';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHPOTVAL IS 'Зобов'язання та доручення, Повернути іноземну валюту на рахунок';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHVAL IS 'Рахунок в іноземній валюті або банківських металів';
COMMENT ON COLUMN BARS.KLP_ZPROD.PS_NUMBER IS 'Заява про продаж валюти або банківських металів юридичнмх осіб, підприємців N%';
COMMENT ON COLUMN BARS.KLP_ZPROD.DATETIMEPICKER1 IS 'від';
COMMENT ON COLUMN BARS.KLP_ZPROD.NAME IS 'Юридична особа, підприємець, Найменування клієнта / П.І.Б.';
COMMENT ON COLUMN BARS.KLP_ZPROD.POSTIND IS 'Місцезнаходження / місце проживання, Індекс';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAYON IS 'Місцезнаходження / місце проживання, Район';
COMMENT ON COLUMN BARS.KLP_ZPROD.CITY IS 'Місцезнаходження / місце проживання, Місто';
COMMENT ON COLUMN BARS.KLP_ZPROD.STREET IS 'Місцезнаходження / місце проживання, Вулиця';
COMMENT ON COLUMN BARS.KLP_ZPROD.HOUSE IS 'Місцезнаходження / місце проживання, Будинок';
COMMENT ON COLUMN BARS.KLP_ZPROD.APARTMENT IS 'Місцезнаходження / місце проживання, Кімната / офіс / кв.';
COMMENT ON COLUMN BARS.KLP_ZPROD.FONFAX IS 'Місцезнаходження / місце проживання, Телефон / факс';
COMMENT ON COLUMN BARS.KLP_ZPROD.REGION IS 'Місцезнаходження / місце проживання, Область';
COMMENT ON COLUMN BARS.KLP_ZPROD.NAMEUP IS 'Уповноважений працівник, П.І.Б.';
COMMENT ON COLUMN BARS.KLP_ZPROD.TELUP IS 'Уповноважений працівник, Телефон';
COMMENT ON COLUMN BARS.KLP_ZPROD.KF IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.DATEDOKKB IS '';




PROMPT *** Create  constraint KLP_ZPROD_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD ADD CONSTRAINT KLP_ZPROD_PK PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZPROD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD ADD CONSTRAINT FK_KLPZPROD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZPROD_FL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD ADD CONSTRAINT FK_KLPZPROD_FL FOREIGN KEY (FL)
	  REFERENCES BARS.KLP_FL (FL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPZPROD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD MODIFY (KF CONSTRAINT CC_KLPZPROD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_ZPROD_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_ZPROD_PK ON BARS.KLP_ZPROD (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_ZPROD ***
grant SELECT                                                                 on KLP_ZPROD       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZPROD       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KLP_ZPROD       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZPROD       to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_ZPROD.sql =========*** End *** ===
PROMPT ===================================================================================== 
