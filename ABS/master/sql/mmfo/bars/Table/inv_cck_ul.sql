

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INV_CCK_UL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INV_CCK_UL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INV_CCK_UL'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''INV_CCK_UL'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''INV_CCK_UL'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INV_CCK_UL ***
begin 
  execute immediate '
  CREATE TABLE BARS.INV_CCK_UL 
   (	G00 DATE, 
	G01 VARCHAR2(70), 
	G02 VARCHAR2(30), 
	G03 VARCHAR2(10), 
	G04 VARCHAR2(70), 
	G05 VARCHAR2(2), 
	G06 NUMBER, 
	G07 NUMBER, 
	G08 NUMBER, 
	G09 NUMBER(*,0), 
	G10 VARCHAR2(20), 
	G11 CHAR(10), 
	G12 CHAR(10), 
	G13 CHAR(10), 
	G14 CHAR(10), 
	G15 CHAR(10), 
	G16 CHAR(10), 
	G17 CHAR(5), 
	G18 CHAR(2), 
	G19 CHAR(2), 
	G20 CHAR(4), 
	G21 NUMBER, 
	G22 NUMBER, 
	G23 NUMBER, 
	G24 NUMBER, 
	G25 NUMBER, 
	G26 NUMBER, 
	G27 NUMBER, 
	G28 NUMBER, 
	G29 NUMBER, 
	G30 NUMBER, 
	G31 CHAR(2), 
	G32 CHAR(2), 
	G33 NUMBER, 
	G34 NUMBER, 
	G35 CHAR(1), 
	G36 CHAR(1), 
	G37 CHAR(1), 
	G38 CHAR(2), 
	G39 CHAR(1), 
	G40 VARCHAR2(20), 
	G41 CHAR(10), 
	G42 VARCHAR2(70), 
	G43 VARCHAR2(10), 
	G44 NUMBER, 
	G45 VARCHAR2(20), 
	G46 NUMBER, 
	G47 CHAR(10), 
	G48 CHAR(10), 
	G49 NUMBER, 
	G50 VARCHAR2(20), 
	G51 CHAR(10), 
	G52 VARCHAR2(30), 
	G53 NUMBER, 
	G54 NUMBER, 
	G55 NUMBER, 
	G56 NUMBER, 
	G57 NUMBER, 
	G58 NUMBER, 
	G59 NUMBER, 
	G60 NUMBER, 
	G61 NUMBER, 
	G62 NUMBER, 
	G63 NUMBER, 
	G64 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INV_CCK_UL ***
 exec bpa.alter_policies('INV_CCK_UL');


COMMENT ON TABLE BARS.INV_CCK_UL IS 'Данi про класифiкацiю кредитних операцiй та розрахунок суми розрахункового резерву по ЮО';
COMMENT ON COLUMN BARS.INV_CCK_UL.G00 IS 'Дата формирования инвентаризации';
COMMENT ON COLUMN BARS.INV_CCK_UL.G01 IS '01 Найменування п_дрозд_лу';
COMMENT ON COLUMN BARS.INV_CCK_UL.G02 IS '02 МФО п_дрозд_лу';
COMMENT ON COLUMN BARS.INV_CCK_UL.G03 IS '03 ЄДРПОУ позичальника';
COMMENT ON COLUMN BARS.INV_CCK_UL.G04 IS '04 Назва позичальника';
COMMENT ON COLUMN BARS.INV_CCK_UL.G05 IS '05 Кл_єнт/Некл_єнт банку';
COMMENT ON COLUMN BARS.INV_CCK_UL.G06 IS '06 Ознака _нсайдера зг_дно KL_K061';
COMMENT ON COLUMN BARS.INV_CCK_UL.G07 IS '07 Резидент/Нерезидент';
COMMENT ON COLUMN BARS.INV_CCK_UL.G08 IS '08 Сума за угодою в валют_ договору';
COMMENT ON COLUMN BARS.INV_CCK_UL.G09 IS '09 Валюта кредиту';
COMMENT ON COLUMN BARS.INV_CCK_UL.G10 IS '10 № кредитної угоди';
COMMENT ON COLUMN BARS.INV_CCK_UL.G11 IS '11 Дата укладання угоди';
COMMENT ON COLUMN BARS.INV_CCK_UL.G12 IS '12 Дата фактичної видач_ кредиту';
COMMENT ON COLUMN BARS.INV_CCK_UL.G13 IS '13 Дата погашення кредиту за угодою';
COMMENT ON COLUMN BARS.INV_CCK_UL.G14 IS '14 Чинна дата погашення з врахуванням останн_х зм_н';
COMMENT ON COLUMN BARS.INV_CCK_UL.G15 IS '15 Дата в_днесення на рахунок прострочених';
COMMENT ON COLUMN BARS.INV_CCK_UL.G16 IS '16 Дата в_днесення на рахунок сумн_вних';
COMMENT ON COLUMN BARS.INV_CCK_UL.G17 IS '17 Галузь економ_ки';
COMMENT ON COLUMN BARS.INV_CCK_UL.G18 IS '18 Приналежн_сть до малого б_знесу  ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G19 IS '19 Форма власност_';
COMMENT ON COLUMN BARS.INV_CCK_UL.G20 IS '20 Номер балансового, на якому обл_ковується кредит';
COMMENT ON COLUMN BARS.INV_CCK_UL.G21 IS '21 Заборгован_сть в валют_ кредиту';
COMMENT ON COLUMN BARS.INV_CCK_UL.G22 IS '22 Заборгован_сть в нац.валют_';
COMMENT ON COLUMN BARS.INV_CCK_UL.G23 IS '23 Сума позабалансових неризикових зобов"язань';
COMMENT ON COLUMN BARS.INV_CCK_UL.G24 IS '24 Сума позабалансових ризикових зобов"язань ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G25 IS '25 Д_юча ставка (% р_чних)';
COMMENT ON COLUMN BARS.INV_CCK_UL.G26 IS '26 Нарахован_, але несплачен_ доходи (не прострочен_)';
COMMENT ON COLUMN BARS.INV_CCK_UL.G27 IS '27 Нарахован_ прострочен_ доходи до 31 дня';
COMMENT ON COLUMN BARS.INV_CCK_UL.G28 IS '28 Нарахован_ прострочен_ доходи понад 31 день ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G29 IS '29 Нарахован_ сумн_вн_ доходи ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G30 IS '30 Сума несплачених в_дсотк_в';
COMMENT ON COLUMN BARS.INV_CCK_UL.G31 IS '31 Заходи щодо повернненя по прострочених кредитах';
COMMENT ON COLUMN BARS.INV_CCK_UL.G32 IS '32 Заходи щодо повернненя по сумн_вних кредитах';
COMMENT ON COLUMN BARS.INV_CCK_UL.G33 IS '33 Ф_нансовий результат у попередньому роц_ прибуток(+)/збиток(-) ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G34 IS '34 Ф_нансовий результат у попередньому квартал_ прибуток(+)/збиток(-) ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G35 IS '35 Оц_?нка ф_нансового стану позичальника (клас) ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G36 IS '36 Категор_я ризику кредитної операц_ї ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G37 IS '37 Обслуговування боргу позичальником ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G38 IS '38 Вид застави';
COMMENT ON COLUMN BARS.INV_CCK_UL.G39 IS '39 М_сцезнаходження застави  ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G40 IS '40 Номер договору застави ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G41 IS '41 Дата укладання договору застави ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G42 IS '42 Назхва заставленого майна';
COMMENT ON COLUMN BARS.INV_CCK_UL.G43 IS '43 Одиниця вим_ру застави';
COMMENT ON COLUMN BARS.INV_CCK_UL.G44 IS '44 К_ль-то одиниць застави ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G45 IS '45 Реєстр.номер в держ.реєстр_ прав вл-т_';
COMMENT ON COLUMN BARS.INV_CCK_UL.G46 IS '46 Загальна варт_сть застави ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G47 IS '47 Дата останньої перев_рки наявност_ застави';
COMMENT ON COLUMN BARS.INV_CCK_UL.G48 IS '48 Дата переоц_нки застави ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G49 IS '49 Переглянута оц_ночна варт_сть застави';
COMMENT ON COLUMN BARS.INV_CCK_UL.G50 IS '50 Номер договору страхування застави';
COMMENT ON COLUMN BARS.INV_CCK_UL.G51 IS '51 Дата укладання договору страхування застави ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G52 IS '52 Вид забезпечення KL_S031';
COMMENT ON COLUMN BARS.INV_CCK_UL.G53 IS '53 Сума забезпечення, що береться до розрахунку резерву';
COMMENT ON COLUMN BARS.INV_CCK_UL.G54 IS '54 Сума заборгованост_, що береться до розрахунку резерву';
COMMENT ON COLUMN BARS.INV_CCK_UL.G55 IS '55 Коеф_ц_єнт резервування за ступенем ризику (%)';
COMMENT ON COLUMN BARS.INV_CCK_UL.G56 IS '56 Розрахункова сума резерву ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G57 IS '57 Фактично сформована сума резерву за рах-к прибутку';
COMMENT ON COLUMN BARS.INV_CCK_UL.G58 IS '58 Фактично сформована сума резерву за рах-к валових витрат ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G59 IS '59 В_дхилення суми  фактично сформованого резерву в_д суми розрахункового резерву ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G60 IS '60 Пеня та штрафи (сума визнана в судовому порядку), грн.';
COMMENT ON COLUMN BARS.INV_CCK_UL.G61 IS '61 В_дношення кредиту до проблемного (код типу проблемної заборгованост_)';
COMMENT ON COLUMN BARS.INV_CCK_UL.G62 IS '62 Розрахункова сума резерву Прострочен_ та сумн_вн_ проценти ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G63 IS '63 Фактична сума резерву Прострочен_ та сумн_вн_ проценти ';
COMMENT ON COLUMN BARS.INV_CCK_UL.G64 IS '64 Сума неамортизованого дисконту ';



PROMPT *** Create  grants  INV_CCK_UL ***
grant SELECT                                                                 on INV_CCK_UL      to BARSREADER_ROLE;
grant SELECT                                                                 on INV_CCK_UL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INV_CCK_UL      to BARS_DM;
grant SELECT                                                                 on INV_CCK_UL      to RCC_DEAL;
grant SELECT                                                                 on INV_CCK_UL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INV_CCK_UL.sql =========*** End *** ==
PROMPT ===================================================================================== 
