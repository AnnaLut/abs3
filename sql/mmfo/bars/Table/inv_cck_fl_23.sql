

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_23.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INV_CCK_FL_23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INV_CCK_FL_23'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INV_CCK_FL_23'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INV_CCK_FL_23'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INV_CCK_FL_23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.INV_CCK_FL_23 
   (	G00 DATE, 
	G01 VARCHAR2(70), 
	G02 VARCHAR2(30), 
	G03 VARCHAR2(30), 
	G04 VARCHAR2(70), 
	G05 VARCHAR2(9), 
	G05I VARCHAR2(14), 
	G06 NUMBER, 
	G07 NUMBER(38,0), 
	G08 VARCHAR2(20), 
	G09 CHAR(10), 
	G10 CHAR(10), 
	G11 CHAR(10), 
	G12 CHAR(1), 
	G13 NUMBER, 
	G13A NUMBER, 
	G13B NUMBER, 
	G13V NUMBER, 
	G13G NUMBER, 
	G13D NUMBER, 
	G13E NUMBER, 
	G13J NUMBER, 
	G13Z NUMBER, 
	G13I NUMBER, 
	G14 CHAR(10), 
	G15 CHAR(10), 
	G16 CHAR(10), 
	G17 NUMBER, 
	G18 VARCHAR2(250), 
	G19 CHAR(4), 
	G20 VARCHAR2(9), 
	G21 NUMBER, 
	G22 NUMBER, 
	G23 NUMBER, 
	G24 NUMBER(38,0), 
	G25 NUMBER, 
	G26 NUMBER, 
	G27 NUMBER(22,4), 
	G28 NUMBER(22,4), 
	G29 NUMBER, 
	G30 NUMBER, 
	G31 NUMBER, 
	G32 CHAR(1), 
	G33 CHAR(3), 
	G34 CHAR(10), 
	G35 CHAR(1), 
	G36 CHAR(1), 
	G37 VARCHAR2(30), 
	G38 CHAR(10), 
	G39 NUMBER, 
	G40 NUMBER, 
	G41 NUMBER(22,3), 
	G42 NUMBER, 
	G43 NUMBER, 
	G44 NUMBER, 
	G45 NUMBER, 
	G46 CHAR(1), 
	G47 CHAR(1), 
	G48 VARCHAR2(2), 
	G49 CHAR(10), 
	G50 NUMBER, 
	G51 NUMBER, 
	G52 NUMBER, 
	G53 VARCHAR2(10), 
	G54 NUMBER, 
	G55 NUMBER(1,0), 
	G56 NUMBER, 
	G57 NUMBER, 
	G58 VARCHAR2(30), 
	G59 NUMBER, 
	G60 VARCHAR2(30), 
	G61 NUMBER, 
	G62 VARCHAR2(30), 
	G63 NUMBER, 
	G64 VARCHAR2(300), 
	G65 NUMBER, 
	GT NUMBER, 
	GR VARCHAR2(1), 
	ACC NUMBER, 
	RNK NUMBER, 
	ACC2208 NUMBER, 
	ACC2209 NUMBER, 
	ACC9129 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INV_CCK_FL_23 ***
 exec bpa.alter_policies('INV_CCK_FL_23');


COMMENT ON TABLE BARS.INV_CCK_FL_23 IS 'Данi про класифiкацiю кред.операцiй та розр-к суми резерву по ФО - 23 постанова';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G00 IS 'Дата формування';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G01 IS '01 Назва РУ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G02 IS '02 МФО установи (вiддiлення)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G03 IS '03 Номер ТВБВ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G04 IS '04 ПIБ позичальника';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G05 IS '05 Реєстраційний номер облікової картки платника податків';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G05I IS '05I Iдентифiкацiйний код ФО';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G06 IS '06 Сума кредиту за угодою в валютi угоди';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G07 IS '07 Валюта кредиту';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G08 IS '08 № кредитної угоди';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G09 IS '09 Дата фактичного надання кредиту';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G10 IS '10 Планова дата погашення (початкова)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G11 IS '11 Чинна дата погашення з врахуванням ост.пролонгацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G12 IS '12 Ознака реструктуризацiї кредиту';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13 IS '13 Кiль-ть здiйснених реструктуризацiй';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13A IS '13a Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13B IS '13b Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13V IS '13v Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13G IS '13g Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13D IS '13d Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13E IS '13e Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13J IS '13j Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13Z IS '13z Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G13I IS '13i Кiль-ть здiйснених реструктуризацiй в розрiзi видiв реструктуризацiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G14 IS '14 Дата виникнення першого непогашеного на звітну дату платежу за осн.боргом';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G15 IS '15 Дата виникнення першого непогашеного на звітну дату платежу за нарах.%%';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G16 IS '16 Дата визнання кредиту проблемним на КК';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G17 IS '17 Ознака iнсайдера згiдно класифiкатору KL_K061';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G18 IS '18 Пiдстава для надання кредиту iнсайдеру банку';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G19 IS '19 Номер БР, на якому облiковується кредит на звiтну дату';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G20 IS '20 Частина № аналiтичного рахунку';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G21 IS '21 Сума залишку на звiтну дату в валютi кредиту ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G22 IS '22 Сума залишку в нац.валютi';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G23 IS '23 Сума неамортизованого дисконту';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G24 IS '24 Код облiку заборгованостi на балансових рахунках';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G25 IS '25 Сума позабал.зобов"язань неризикових';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G26 IS '26 Сума позабал.зобов"язань ризикових';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G27 IS '27 Дiюча % ставка';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G28 IS '28 Ефективна % ставка';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G29 IS '29 Непрострочені нарах.доходи';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G30 IS '30 Прострочені нарах.доходи';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G31 IS '31 Сума забезпечення на звітну дату у вигляді поруки (34 код згідно класифікатора НБУ KL_S031), грн';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G32 IS '32 Оцiнка фiнансового стану позичальника (клас)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G33 IS '33 Внутрiшнiй кредитний рейтинг позичальника';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G34 IS '34 Дата останньої оцінки фін.стану';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G35 IS '35 Категорiя якості кредитної операцiї';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G36 IS '36 Обслуговування боргу позичальником';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G37 IS '37 Вид забезпечення  (зг.з класифiкатором KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G38 IS '38 Дата віднесення до 5 категорії якості ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G39 IS '39 Переглянута оціночна вартість, грн';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G40 IS '40 Сума прийнятого до розрахунку резерву забезпечення, грн';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G41 IS '41 Значення показника ризику за кред.операцією';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G42 IS '42 Розрахункова сума резерву, грн.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G43 IS '43 Фактично сформована сума резерву, грн., за кредитами, які не враховані в ПО';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G44 IS '44 Фактично сформована сума резерву, грн., за кредитами, які враховані в ПО';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G45 IS '45 Вiдхилення суми  фактично сформованого резерву вiд суми розрахункового резерву';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G46 IS '46 Категорiя громадян, якi постраждали внаслiдок Чорнобильської катастрофи';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G47 IS '47 Приналежнiсть до працiвникiв банку';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G48 IS '48 Цiльове призначення кредиту (заповнюється по кредитах, наданих працiвникам банку)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G49 IS '49 Дата останньої пролонгацiї кредиту';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G50 IS '50 БР групи 891, на якому облiковуються сума нарах.та неотрим.доходiв по кредитах, що не будуть отриманi';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G51 IS '51 Сума нарах.та неотрим.доходiв по кредитах, що не будуть отриманi';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G52 IS '52 Референс договора';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G53 IS '53 Дата останньої реструктуризації кредита';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G54 IS '54 Фактично сформована сума резерву для відшкодування можливих втрат за позабалансовими зобовязаннями (рах. 3690), грн';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G55 IS '55 Порядок розрахунку платежів (1-Ануїтет, 2-Рівними частинами)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G56 IS '56 Балансова вартість кредиту, грн.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G57 IS '57 Теперішня вартість ...';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G58 IS '58 Розшифровка 40-45кодів забезпечення - Вид забезпечення  (зг.з класифiкатором KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G59 IS '59 Розшифровка 40-45кодів забезпечення - Сума забезпечення на звітну дату, грн.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G60 IS '60 Розшифровка 40-45кодів забезпечення - Вид забезпечення  (зг.з класифiкатором KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G61 IS '61 Розшифровка 40-45кодів забезпечення - Сума забезпечення на звітну дату, грн.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G62 IS '62 Розшифровка 40-45кодів забезпечення - Вид забезпечення  (зг.з класифiкатором KL_S031)';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G63 IS '63 Розшифровка 40-45кодів забезпечення - Сума забезпечення на звітну дату, грн.';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G64 IS '64 Примітка';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.G65 IS '65 БПК - несанкціонований овердрафт';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.GT IS 'Тип ведомости (ежеднев(0)/ежемес(1)) ';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.GR IS 'Признак типа данных';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC IS 'ACC счета, на котором учитывается задолженность';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.RNK IS 'РНК клиента';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC2208 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC2209 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.ACC9129 IS '';
COMMENT ON COLUMN BARS.INV_CCK_FL_23.KF IS '';




PROMPT *** Create  constraint PK_INVCCKFL23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 ADD CONSTRAINT PK_INVCCKFL23 PRIMARY KEY (G00, GT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_GR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (GR CONSTRAINT CC_INVCCKFL23_GR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_G00_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (G00 CONSTRAINT CC_INVCCKFL23_G00_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_GT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (GT CONSTRAINT CC_INVCCKFL23_GT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (ACC CONSTRAINT CC_INVCCKFL23_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INVCCKFL23_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 MODIFY (KF CONSTRAINT CC_INVCCKFL23_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INVCCKFL23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INVCCKFL23 ON BARS.INV_CCK_FL_23 (G00, GT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INV_CCK_FL_23 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_23   to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on INV_CCK_FL_23   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_23   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INV_CCK_FL_23   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INV_CCK_FL_23   to RCC_DEAL;
grant SELECT                                                                 on INV_CCK_FL_23   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INV_CCK_FL_23.sql =========*** End ***
PROMPT ===================================================================================== 
