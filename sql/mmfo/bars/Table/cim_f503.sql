

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F503.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F503 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F503'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F503'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F503 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F503 
   (	F503_ID NUMBER, 
	CONTR_ID NUMBER, 
	P_DATE_TO DATE DEFAULT sysdate, 
	DATE_REG DATE DEFAULT sysdate, 
	USER_REG VARCHAR2(30), 
	DATE_CH DATE, 
	USER_CH VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	P1000 VARCHAR2(27), 
	Z VARCHAR2(10), 
	P0100 VARCHAR2(2), 
	P1300 VARCHAR2(54), 
	P0300 VARCHAR2(3), 
	P1400 NUMBER(2,0), 
	P1900 NUMBER(2,0), 
	PVAL VARCHAR2(3), 
	P1500 NUMBER(2,0), 
	M NUMBER(2,0), 
	P1600 NUMBER(2,0), 
	P9800 VARCHAR2(2), 
	P1700 NUMBER(2,0), 
	P0200 VARCHAR2(4), 
	R_AGREE_NO VARCHAR2(5), 
	P1200 DATE, 
	P1800 NUMBER(2,0), 
	T VARCHAR2(2) DEFAULT ''0'', 
	P9500 NUMBER(5,3), 
	P9600 NUMBER(2,0), 
	P3100 DATE, 
	P9900 VARCHAR2(108), 
	P0400 NUMBER(2,0), 
	P0800_1 VARCHAR2(10), 
	P0800_2 VARCHAR2(3), 
	P0800_3 VARCHAR2(3), 
	P0700 NUMBER(6,4), 
	P0900 NUMBER, 
	P0500 VARCHAR2(16), 
	P0600 DATE, 
	P2010 NUMBER, 
	P2011 NUMBER, 
	P2012 NUMBER, 
	P2013 NUMBER, 
	P2014 NUMBER, 
	P2016 NUMBER, 
	P2017 NUMBER, 
	P2018 NUMBER, 
	P2020 NUMBER, 
	P2021 NUMBER, 
	P2022 NUMBER, 
	P2023 NUMBER, 
	P2024 NUMBER, 
	P2025 NUMBER, 
	P2026 NUMBER, 
	P2027 NUMBER, 
	P2028 NUMBER, 
	P2029 NUMBER, 
	P2030 NUMBER, 
	P2031 NUMBER, 
	P2032 NUMBER, 
	P2033 NUMBER, 
	P2034 NUMBER, 
	P2035 NUMBER, 
	P2036 NUMBER, 
	P2037 NUMBER, 
	P2038 NUMBER, 
	P2042 NUMBER, 
	P3000 NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F503 ***
 exec bpa.alter_policies('CIM_F503');


COMMENT ON TABLE BARS.CIM_F503 IS 'Дані для звіту f503';
COMMENT ON COLUMN BARS.CIM_F503.F503_ID IS 'Ідентифікатор унікальний';
COMMENT ON COLUMN BARS.CIM_F503.CONTR_ID IS 'Внутрішній код контракту';
COMMENT ON COLUMN BARS.CIM_F503.P_DATE_TO IS 'Звіт сформований на дату';
COMMENT ON COLUMN BARS.CIM_F503.DATE_REG IS 'Додано у звіт';
COMMENT ON COLUMN BARS.CIM_F503.USER_REG IS 'Користувач додав у звіт';
COMMENT ON COLUMN BARS.CIM_F503.DATE_CH IS 'Останне редагування';
COMMENT ON COLUMN BARS.CIM_F503.USER_CH IS 'Користувач редагування';
COMMENT ON COLUMN BARS.CIM_F503.BRANCH IS 'Номер відділеня';
COMMENT ON COLUMN BARS.CIM_F503.KF IS 'МФО';
COMMENT ON COLUMN BARS.CIM_F503.P1000 IS 'Найменування позичальника';
COMMENT ON COLUMN BARS.CIM_F503.Z IS 'Код позичальника';
COMMENT ON COLUMN BARS.CIM_F503.P0100 IS 'Вид позичальника';
COMMENT ON COLUMN BARS.CIM_F503.P1300 IS 'Назва нерезидента-кредитора';
COMMENT ON COLUMN BARS.CIM_F503.P0300 IS 'Код країни кредитора';
COMMENT ON COLUMN BARS.CIM_F503.P1400 IS 'Тип кредитора';
COMMENT ON COLUMN BARS.CIM_F503.P1900 IS 'Строковість кредиту';
COMMENT ON COLUMN BARS.CIM_F503.PVAL IS 'Код валюти';
COMMENT ON COLUMN BARS.CIM_F503.P1500 IS 'Тип кредиту';
COMMENT ON COLUMN BARS.CIM_F503.M IS 'Ознака кредиту';
COMMENT ON COLUMN BARS.CIM_F503.P1600 IS 'Дострокове погашення';
COMMENT ON COLUMN BARS.CIM_F503.P9800 IS 'Зміна строковості кредиту';
COMMENT ON COLUMN BARS.CIM_F503.P1700 IS 'Код періодичності здійснення платежів';
COMMENT ON COLUMN BARS.CIM_F503.P0200 IS 'Номер балансового рахунку';
COMMENT ON COLUMN BARS.CIM_F503.R_AGREE_NO IS 'Номер реєстрації договору(свідоцтва)';
COMMENT ON COLUMN BARS.CIM_F503.P1200 IS 'Дата реєстраційного свідоцтва';
COMMENT ON COLUMN BARS.CIM_F503.P1800 IS 'Підстава подання звіту';
COMMENT ON COLUMN BARS.CIM_F503.T IS 'Номер траншу(може бути літерою)';
COMMENT ON COLUMN BARS.CIM_F503.P9500 IS 'Величина процентної ставки';
COMMENT ON COLUMN BARS.CIM_F503.P9600 IS 'Цілі використання кредиту';
COMMENT ON COLUMN BARS.CIM_F503.P3100 IS 'Строк погашення кредиту';
COMMENT ON COLUMN BARS.CIM_F503.P9900 IS 'Примітка';
COMMENT ON COLUMN BARS.CIM_F503.P0400 IS 'Тип процентної ставки';
COMMENT ON COLUMN BARS.CIM_F503.P0800_1 IS 'База плаваючої процентної ставки(1із3)';
COMMENT ON COLUMN BARS.CIM_F503.P0800_2 IS 'База плаваючої процентної ставки(2із3)';
COMMENT ON COLUMN BARS.CIM_F503.P0800_3 IS 'База плаваючої процентної ставки(3із3)';
COMMENT ON COLUMN BARS.CIM_F503.P0700 IS 'Розмір маржі процентної ставки';
COMMENT ON COLUMN BARS.CIM_F503.P0900 IS 'Загальна сума кредиту';
COMMENT ON COLUMN BARS.CIM_F503.P0500 IS 'Номер кредитної угоди';
COMMENT ON COLUMN BARS.CIM_F503.P0600 IS 'Дата кредитної угоди';
COMMENT ON COLUMN BARS.CIM_F503.P2010 IS 'Сума заборгованості за одержаним, але ще не погашеним кредитом';
COMMENT ON COLUMN BARS.CIM_F503.P2011 IS 'Прострочена заборгованість за основною сумою боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2012 IS 'Прострочені процентні платежі';
COMMENT ON COLUMN BARS.CIM_F503.P2013 IS 'Прострочені комісійні та інші платежі';
COMMENT ON COLUMN BARS.CIM_F503.P2014 IS 'Несплачена пеня за прострочені платежі';
COMMENT ON COLUMN BARS.CIM_F503.P2016 IS 'Одержано суму кредиту';
COMMENT ON COLUMN BARS.CIM_F503.P2017 IS 'Планові платежі в рахунок погашення основної суми боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2018 IS 'Планові процентні платежі';
COMMENT ON COLUMN BARS.CIM_F503.P2020 IS 'Планові комісійні та інші платежі';
COMMENT ON COLUMN BARS.CIM_F503.P2021 IS 'Пеня за прострочені платежі, що підлягала сплаті у звітному періоді';
COMMENT ON COLUMN BARS.CIM_F503.P2022 IS 'Фактично сплачено платежів у рахунок погашення основної суми боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2023 IS 'Достроково сплачено платежів у рахунок погашення основної суми боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2024 IS 'Прострочена заборгованість сплачено платежів у рахунок погашення основної суми боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2025 IS 'Реорганізовано платежів у рахунок погашення основної суми боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2026 IS 'Реорганізовано шляхом збільшення частки кредитора в статутному капіталі позичальника';
COMMENT ON COLUMN BARS.CIM_F503.P2027 IS 'Реорганізовано прощення боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2028 IS 'Реорганізовано шляхом взаємозаліку';
COMMENT ON COLUMN BARS.CIM_F503.P2029 IS 'Фактично сплачено процентів';
COMMENT ON COLUMN BARS.CIM_F503.P2030 IS 'Достроково сплачено процентів';
COMMENT ON COLUMN BARS.CIM_F503.P2031 IS 'Фактично сплачена прострочена заборгованість у процентах';
COMMENT ON COLUMN BARS.CIM_F503.P2032 IS 'Реорганізовано платежів у рахунок погашення процентів';
COMMENT ON COLUMN BARS.CIM_F503.P2033 IS 'Реорганізовано платежів шляхом збільшення частки кредитора в статутному капіталі позичальника';
COMMENT ON COLUMN BARS.CIM_F503.P2034 IS 'Реорганізовано шляхом прощення боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2035 IS 'Реорганізовано шляхом взаємозаліку';
COMMENT ON COLUMN BARS.CIM_F503.P2036 IS 'Фактично сплачено комісійних та інших платежів';
COMMENT ON COLUMN BARS.CIM_F503.P2037 IS 'Фактично сплачено пені за прострочені платежі';
COMMENT ON COLUMN BARS.CIM_F503.P2038 IS 'Прострочена заборгованість за основною сумою боргу';
COMMENT ON COLUMN BARS.CIM_F503.P2042 IS 'Прострочені процентні платежі';
COMMENT ON COLUMN BARS.CIM_F503.P3000 IS 'Код стану розрахунків за кредитом';




PROMPT *** Create  constraint PK_F503_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT PK_F503_ID PRIMARY KEY (F503_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_F503_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_F503_ID ON BARS.CIM_F503 (F503_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



begin
    execute immediate 'alter table bars.cim_f503 add (p3200  number(1))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f503.p3200 IS 'Код типу реорганізації';

begin
    execute immediate 'alter table bars.cim_f503 add (p3300  VARCHAR2(3))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f503.p3300 IS 'Код валюти розрахунків';

begin
    execute immediate 'alter table bars.cim_f503 add (F057 CHAR(3))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.F057 IS 'Вид запозичення';
PROMPT *** Create  constraint FK_F503_F057 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT FK_F503_F057 FOREIGN KEY (F057)
	  REFERENCES BARS.F057 (F057) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.cim_f503 add (F009 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.F009 IS 'Код типу джерела фінансування';
PROMPT *** Create  constraint FK_F503_F009 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT FK_F503_F009 FOREIGN KEY (F009)
	  REFERENCES BARS.F009 (F009) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
        
begin
    execute immediate 'alter table bars.cim_f503 add (F010 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.F010 IS 'Код типу угоди';
PROMPT *** Create  constraint FK_F503_F010 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT FK_F503_F010 FOREIGN KEY (F010)
	  REFERENCES BARS.F010 (F010) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.cim_f503 add (F011 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.F011 IS 'Код графіка погашення платежів';
PROMPT *** Create  constraint FK_F503_F011 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT FK_F503_F011 FOREIGN KEY (F011)
	  REFERENCES BARS.F011 (F011) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.cim_f503 add (F012 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.F012 IS 'Код типу форми власності';
PROMPT *** Create  constraint FK_F503_F012 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT FK_F503_F012 FOREIGN KEY (F012)
	  REFERENCES BARS.F012 (F012) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.cim_f503 add (F014 CHAR(1))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.F014 IS 'Код виду подання звіту';
PROMPT *** Create  constraint FK_F503_F014 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT FK_F503_F014 FOREIGN KEY (F014)
	  REFERENCES BARS.F014 (F014) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.cim_f503 add (F036 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.F036 IS 'Код використання процентної ставки за кредитом';
PROMPT *** Create  constraint FK_F503_F036 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F503 ADD CONSTRAINT FK_F503_F036 FOREIGN KEY (F036)
	  REFERENCES BARS.F036 (F036) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.cim_f503 add (Q001_2	 VARCHAR2(70))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q001_2 IS 'ГАРАНТ З БОКУ ПОЗИЧАЛЬНИКА';

begin
    execute immediate 'alter table bars.cim_f503 add (Q001_4	 VARCHAR2(70))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q001_4 IS 'ГАРАНТ З БОКУ КРЕДИТОРА';

begin
    execute immediate 'alter table bars.cim_f503 add (Q007_1	 DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q007_1 IS 'ДАТА ПЕРШОГО АМАРТИЗАЦІЙНОГО ПЛАТЕЖУ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q007_2	 DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q007_2 IS 'ДАТА ОСТАННЬОГО АМАТТИЗАЦІЙНОГО ПЛАТЕЖУ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q007_3	 DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q007_3 IS 'ПОЧАТКОВА ДАТА ПЕРІОДУ КОНСОЛІДАЦІЇ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q007_4	 DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q007_4 IS 'КІНЦЕВА ДАТА ПЕРІОДУ КОНСОЛІДАЦІЇ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q007_6	 DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q007_6 IS 'ДАТА ПЕРШОГО ПЛАТЕЖУ ЗА ПРОЦЕНТАМИ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q007_7	 DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q007_7 IS 'ДАТА ОСТАННЬОГО ПЛАТЕЖУ З ПРОЦЕНТАМИ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q007_8	 DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q007_8 IS 'ДАТА , ПОЧИНАЮЧИ З ЯКОЇ ПРОЦЕНТИ СПЛАЧИВАЮТЬСЯ ЗА ДР. ПРОЦ. СТАВКОЮ АБО ДРУГЕ ЗНАЧЕННЯ МАРЖІ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q009	 VARCHAR2(230))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q009 IS 'МЕТА ПОЗИКИ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q010_1	 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q010_1 IS 'ПЕРІОД ЧАСУ У МІСЯЦЯХ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q011_1	 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q011_1 IS 'КІЛЬ-СТЬ АМОРТИЗАЦІЙНИХ ПЛАТЕЖІВ';

begin
    execute immediate 'alter table bars.cim_f503 add (Q011_2	 NUMBER(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F503.Q011_2 IS 'КІЛЬ-СТЬ ПЛАТЕЖІВ ЗА РІК';

begin   
 execute immediate 'alter table CIM_F503 modify p1000 VARCHAR2(200)';
 end;
/


begin   
 execute immediate 'alter table CIM_F503 modify p1300 VARCHAR2(200)';
 end;
/

begin   
 execute immediate 'alter table CIM_F503 modify p0500 VARCHAR2(100)';
 end;
/


PROMPT *** Create  grants  CIM_F503 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F503        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F503.sql =========*** End *** ====
PROMPT ===================================================================================== 
