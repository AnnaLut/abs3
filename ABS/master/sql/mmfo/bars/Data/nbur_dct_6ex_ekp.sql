SET DEFINE OFF;

delete from NBUR_DCT_F6EX_EKP;

Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E001', 'Загальний обсяг високоякісних ліквідних активів (ВЛА)', '1', 'A6E006', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E002', 'Сукупні очікувані відтоки грошових коштів', '1', 'A6E007', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E003', 'Сукупні очікувані надходження грошових коштів', '1', 'A6E008', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E004', 'Чистий очікуваний відтік грошових коштів', '1', NULL, NULL, 
    'A6E002 - LEAST(A6E003, 0.75 * A6E002)', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E005', 'Коефіцієнт покриття ліквідністю', '1', NULL, NULL, 
    'AE6001/AE6004', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E006', 'Загальний обсяг високоякісних ліквідних активів (ВЛА) ', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E007', 'Сукупні очікувані відтоки грошових коштів', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E008', 'Сукупні очікувані надходження грошових коштів', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E009', 'Чистий очікуваний відтік грошових коштів', '0', NULL, NULL, 
    'A6E007 - LEAST(A6E008, 0.75 * A6E007)', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E010', 'Коефіцієнт покриття ліквідністю (LCR)', '0', NULL, NULL, 
    'AE6006/AE6009', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E011', 'Сума за облігаціями внутрішньої державної позики (ОВДП) зі строком погашення більше 30 днів', '1', 'A6E001', NULL, 
    NULL, 100, 100, '1');
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E012', 'Сума за облігаціями внутрішньої державної позики (ОВДП) зі строком погашення до 30 днів', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E013', 'Сума за облігаціями зовнішньої державної позики (ОЗДП) зі строком погашення до 30 днів', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E014', 'Сума за облігаціями зовнішньої державної позики (ОЗДП) зі строком погашення більше 30 днів ', '1', 'A6E001', NULL, 
    NULL, 85, 85, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E015', 'Сума за борговими цінними паперами міжнародних фінансових організацій/державних органів країн G-7 з рейтингами провідних світових рейтингових агенств не нижче "АА-"/"Аа3"', '1', 'A6E001', 0, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E016', 'Кошти на кореспондентських рахунках в банках з рейтингом не нижче інвестиційного класу', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E017', 'Сума незнижувального залишку на рахунках ностро в банках з рейтингом не нижче інвестиційного класу', '1', 'A6E001', 0, 
    NULL, -100, -100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E001', 'Банкноти та монети', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E002', 'Резерви за готівковими коштами, наявність яких є непідтвердженою ', '1', 'A6E001', NULL, 
    NULL, -100, -100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E003', 'Кошти на кореспондентському рахунку в Національному банку України', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E024', 'Сума за борговими цінними паперами, емітованими міжнародними банками розвитку', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E025', 'Сума за депозитними сертифікатами Національного банку України', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E026', 'Сума за депозитами в Національному банку України до 1 дня ', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E018', 'Сума строкових вкладів фізичних осіб, які згідно з умовами договорів, не можуть бути повернені протягом 30 днів', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E019', 'Сума строкових вкладів фізичних осіб, на які було накладено обмеження на розпорядження протягом 30 днів', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E020', 'Сума строкових вкладів фізичних осіб, за якими отримано повідомленням про їх повернення', '1', 'A6E002', 0, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E021', 'Сума інших строкових вкладів фізичних осіб, які згідно з умовами договорів, можуть бути повернені протягом 30 днів', '1', 'A6E002', NULL, 
    NULL, 10, 10, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E022', 'Сума строкових вкладів суб''єктів господарської діяльності (СГД), які згідно з умовами договорів, не можуть бути повернені протягом 30 днів', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E023', 'Сума строкових вкладів суб''єктів господарської діяльності (СГД) на які було накладено обмеження на розпорядження протягом 30 днів', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E024', 'Сума строкових вкладів суб''єктів господарської діяльності (СГД) за якими отримано повідомленням про їх повернення ', '1', 'A6E002', 0, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E025', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими вкладами суб''єктів господарської діяльності (СГД)', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E026', 'Сума за лоро рахунками, які не включені до розрахунку високоякісних ліквідних активів (ВЛА)', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E027', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими депозитами інших банків та за строковими кредитами, що отримані від інших банків', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E028', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими коштами бюджетних установ', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E029', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими коштами небанківських фінансових установ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E030', 'Вклади небанківських фінансових установ за якими було отримано повідомленням про їх повернення', '1', 'A6E002', 0, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E031', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими кошти Національного банку України ', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E032', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредитами від міжнародних банків розвитку', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E033', 'Сума очікуваних контрактних відтоків протягом 30 днів кредитами від інших організацій ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E034', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими ощадними (депозитними) сертифікатами зі строком до 30 днів', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E035', 'Сума очікуваних контрактних відтоків протягом 30 днів за іншими цінними паперами власного боргу', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E036', 'Сума очікуваних контрактних відтоків протягом 30 днів за субординованим боргом ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E037', 'Сума за безвідкличними зобов''язаннями з кредитування, що надані  фізичним особам', '1', 'A6E002', NULL, 
    NULL, 5, 5, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E038', 'Сума за безвідкличними зобов''язаннями з кредитування, що надані суб''єктам господарської діяльності, органам державної влади, органам місцевого самоврядування та міжнародним фінансовим організаціям ', '1', 'A6E002', NULL, 
    NULL, 10, 10, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E039', 'Сума за безвідкличними зобов''язаннями з кредитування, що надані іншим фінансовим установам', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E040', 'Сума очікуваних контрактних відтоків протягом 30 днів за операціями, пов''язаними з торговим фінансуванням (акредитиви, гарантії)', '1', 'A6E002', NULL, 
    NULL, 30, 30, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E041', 'Сума очікуваних контрактних відтоків протягом 30 днів за іншими балансовими та позабалансовими зобов''язаннями', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E042', 'Сума очікуваних контрактних відтоків протягом 30 днів за операціями з деривативами', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E043', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредиторською заборгованістю з придбання та продажу іноземної валюти за рахунок банку', '1', 'A6E007', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E044', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредиторською заборгованістю', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E045', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредитами, що отримані від Національного банку України', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E046', 'Сума очікуваних контрактних відтоків протягом 30 днів за коштами, що отримані за операціями репо та забезпечені вискоякісними ліквідними активами (ВЛА)', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E047', 'Сума очікуваних контрактних відтоків протягом 30 днів за коштами, що отримані за операціями репо та забезпечені не вискоякісними ліквідними активами (ВЛА)', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E048', 'Сума простроченої заборгованості за відтоками', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E066', 'Кошти банків у розрахунках', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E005', 'Кошти фізичних осіб на вимогу', '1', 'A6E002', NULL, 
    NULL, 20, 20, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E006', 'Нараховані витрати за вкладами фізичних осіб', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E007', 'Кошти суб''єктів господарської діяльності на вимогу', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E008', 'Кошти в розрахунках інших банків', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E009', 'Нараховані витрати за коштами банків', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E010', 'Поточні рахунки бюджетних  установ', '1', 'A6E002', NULL, 
    NULL, 100, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E011', 'Нараховані витрати за рахунками бюджетних  установ ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E012', 'Кошти виборчих фондів та фонду референдуму', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E013', 'Кошти на вимогу небанківських фінансових установ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E014', 'Нараховані витрати за коштами небанківських фінансових установ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E015', 'Кошти Національного банку України на вимогу ', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E016', 'Нараховані витрати за коштами Національного банку України', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E017', 'Нараховані витрати за кредитами від міжнародних банків розвитку та інших фінанансових організацій', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E018', 'Нараховані витрати за цінними паперами власного боргу', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E019', 'Нараховані витрати за субординованим боргом', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E020', 'Безвідкличні зобов''язання з кредитування, що надані банкам', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E021', 'Відтоки за транзитними та кліринговими рахунками', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E023', 'Сума за нарахованими витратами за вкладами суб''єктів господарської діяльності (СГД)', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E027', 'Сума нарахованих витрат за кредитами Національного банку та коштами отриманими за операціями репо', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E049', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами фізичних осіб на поточні потреби', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E050', 'Сума очікуваних контрактних надходжень протягом 30 днів за іпотечними кредитами фізичних осіб', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E051', 'Сума очікуваних контрактних надходжень протягом 30 днів за фінансовим лізингом (оренда) фізичних осіб', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E052', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами фізичних осіб, що надані за врахованими векселями', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E053', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за кредитами фізичних осіб', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E054', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами суб''єктам господарської діяльності в поточну діяльність', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E055', 'Сума очікуваних контрактних надходжень протягом 30 днів за іпотечними кредитами суб''єктам господарської діяльності', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E056', 'Сума очікуваних контрактних надходжень протягом 30 днів за фінансовим лізингом (оренда) суб''єктам господарської діяльності', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E057', 'Сума очікуваних контрактних надходжень протягом 30 днів за факторинговими операціями із суб''єктами господарської діяльності', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E058', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами суб''єктам господарської діяльності, що надані за врахованими векселями', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E059', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за кредитами суб''єктам господарської діяльності', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E060', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами органам державної влади та місцевого самоврядування', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E061', 'Сума очікуваних контрактних надходжень протягом 30 днів за іпотечними кредитами органам державної влади та місцевого самоврядування', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E062', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за кредитами органам державної влади та місцевого самоврядування', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E063', 'Сума за депозитами в Національному банку України, які не включені до високоякісних ліквідних активів (ВЛА), та нараховані доходи за ними', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E064', 'Сума за ностро рахунками, яка не включена до високоякісних ліквідних активів (ВЛА)', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E065', 'Сума незнижувального залишку на рахунках ностро, яка не включена до високоякісних ліквідних активів (ВЛА)', '1', 'A6E003', 0, 
    NULL, -100, -100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E067', 'Сума очікуваних контрактних надходжень протягом 30 днів за вкладами (депозитами) в інших банках', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E068', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами та фінансовим лізингом наданим іншим банкам', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E069', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами та депозитами, що надані (розміщені) на умовах субординованого боргу ', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E070', 'Сума невикористаної частини безвідкличних кредитних ліній для підтримання ліквідності, відкритих материнським банком', '1', 'A6E003', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E071', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за коштами в інших банках', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E072', 'Сума очікуваних контрактних надходжень протягом 30 днів за борговими цінними паперами, які не включені до високоякісних ліквідних активів (ВЛА), та нарахованими доходами за ними', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E073', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями зворотнього репо без переходу права власності/розпорядження та нарахованими доходами за ними ', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E074', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями зворотнього репо з переходом права власності/розпорядження, забезпеченими не високоякісними ліквідними активами, та нарахованими доходами за ними ', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E075', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями зворотнього репо з переходом права власності/розпорядження, забезпеченими високоякісними ліквідними активами, та нарахованими доходами за ними', '1', 'A6E003', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E076', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями з деривативами', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E077', 'Сума очікуваних контрактних надходжень протягом 30 днів за дебіторською заборгованістю з придбання та продажу іноземної валюти за рахунок банку', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E078', 'Сума очікуваних контрактних надходжень протягом 30 днів за дебіторською заборгованістю за операціями з банками та клієнтами', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E022', 'Надходження за транзитними і кліринговими рахунками', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E080', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за кредитами фізичних осіб на поточні потреби ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E081', 'Фактична сума роловеру за повністю працюючими кредитами фізичних осіб на поточні потреби, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E082', 'Фактична сума лонгацій за повністю працюючими  кредитами фізичних осіб на поточні потреби, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E083', 'Сума фактичних понад контрактних надходжень грошових коштів протягом 30 днів за кредитами фізичних осіб на поточні потреби ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E084', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за іпотечними кредитами фізичних осіб ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E085', 'Фактична сума роловеру за повністю працюючими іпотечними кредитами фізичних осіб, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E086', 'Фактична сума лонгацій за повністю працюючими іпотечними кредитами фізичних осіб, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E087', 'Сума фактичних понад контрактних надходжень грошових коштів протягом 30 днів за іпотечними кредитами фізичних осіб ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E088', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за фінансовим лізингом (оренда) фізичних осіб ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E089', 'Фактична сума роловеру за повністю працюючим фінансовим лізингом (оренда) фізичних осіб, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E090', 'Фактична сума лонгацій за повністю працюючим фінансовим лізингом (оренда) фізичних осіб, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E091', 'Сума фактичних понад контрактних надходжень грошових коштів протягом 30 днів за фінансовим лізингом (оренда) фізичних осіб ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E092', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за кредитами фізичних осіб, що надані за врахованими векселями', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E093', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за нарахованими доходами за кредитами фізичних осіб', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E094', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за кредитами суб''єктам господарської діяльності в поточну діяльність', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E095', 'Фактична сума роловеру за повністю працюючими кредитами суб''єктам господарської діяльності в поточну діяльність, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E096', 'Фактична сума лонгацій за повністю працюючими кредитами суб''єктам господарської діяльності в поточну діяльність, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E097', 'Сума фактичних понад контрактних надходжень грошових коштів протягом 30 днів за кредитами суб''єктам господарської діяльності в поточну діяльність', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E098', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за іпотечними кредитами суб''єктам господарської діяльності ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E099', 'Фактична сума роловеру за повністю працюючими  іпотечними кредитами  суб''єктам господарської діяльності, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E100', 'Фактична сума лонгацій за повністю працюючими  іпотечними кредитами суб''єктам господарської діяльності, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E101', 'Сума фактичних понад контрактних надходжень грошових коштів протягом 30 днів за іпотечними кредитами суб''єктам господарської діяльності ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E102', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за фінансовим лізингом (оренда) суб''єктам господарської діяльності ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E103', 'Фактична сума роловеру за повністю працюючим фінансовим лізингом (оренда) суб''єктам господарської діяльності, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E104', 'Фактична сума лонгацій за повністю працюючим фінансовим лізингом (оренда) суб''єктам господарської діяльності, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E105', 'Сума фактичних понад контрактних надходжень грошових коштів протягом 30 днів за фінансовим лізингом(оренда) суб''єктам господарської діяльності ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E106', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за кредитами суб''єктам господарської діяльності, що надані за врахованими векселями', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E107', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за нарахованими доходами за кредитами суб''єктам господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E108', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за факторинговими операціями із суб''єктам господарської діяльності ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E109', 'Фактична сума роловеру грошових надходжень за факторинговими операціями із суб''єктам господарської діяльності, що очікувалися протягом 30 днів ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E110', 'Фактична сума лонгацій грошових надходжень за факторинговими операціями із суб''єктам господарської діяльності, що очікувалися протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E111', 'Сума фактичних понад контрактних надходжень грошових коштів протягом 30 днів за факторинговими операціями  із суб''єктам господарської діяльності ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E112', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за нарахованими доходами за кредитами органів державної влади та самоврядування', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E113', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за кредитами органів державної влади та органів місцевого самоврядування', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E114', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за іпотечними кредитами органів державної влади та органів місцевого самоврядування', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E115', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за кредитами та фінансовими лізингом, наданим іншим банкам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E116', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 дні за кредитами та депозитами, що надані (розміщені) на умовах субординованого боргу ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E117', 'Сума фактичних контрактних надходжень грошових коштів протягом 30 днів за нарахованими доходами з інших банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E118', 'Сума фактичних контрактних надходжень, що очікувалися, протягом 30 днів за борговими цінними паперами, які не включені до високоякісних ліквідних активів (ВЛА), та нарахованими доходами за ними', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E119', 'Сума фактичних контрактних надходжень, що очікувалися протягом 30 днів за операціями з деривативами', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E120', 'Сума фактичних контрактних надходжень, що очікувалися протягом 30 днів, за дебіторською заборгованістю з придбання та продажу іноземної валюти за рахунок банку', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E121', 'Сума фактичних контрактних надходжень, що очікувалися протягом 30 днів, за дебіторською заборгованістю за операціями з банками та клієнтами', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E122', 'Сума фактичних контрактних надходжень, що очікувалися протягом 30 днів, за операціями зворотнього репо без переходу права власності/розпорядження та нарахованими доходами за ними ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E123', 'Сума фактичних контрактних надходжень, що очікувалися протягом 30 днів, за операціями зворотнього репо з переходом права власності/розпорядження, забезпеченими не високоякісними ліквідними активами, та нарахованими доходами за ними ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E124', 'Сума фактичних контрактних надходжень, що очікувалися протягом 30 днів, за операціями зворотнього репо з переходом права власності/розпорядження, забезпеченими високоякісними ліквідними активами, та нарахованими доходами за ними ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E125', 'Сума фактичних відтоків за кредитами овердрафт фізичним особам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E126', 'Сума безвідкличних зобов''язань банку за кредитами овердрафт фізичним особам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E127', 'Сума відкличних зобов''язань банку за кредитами овердрафт фізичним особам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E128', 'Сума фактичних відтоків за кредитами овердрафт суб''єктам господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E129', 'Сума безвідкличних зобов''язань банку за кредитами овердрафт суб''єктам господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E130', 'Сума відкличних зобов''язань банку за кредитами овердрафт суб''єктам господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E131', 'Сума фактичних відтоків за кредитами овердрафт банкам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E132', 'Сума безвідкличних  зобов''язань банку за кредитами овердрафт банкам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E133', 'Сума відкличних  зобов''язань банку за кредитами овердрафт банкам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E134', 'Сума фактичних відтоків за кредитними лініями фізичним особам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E135', 'Сума безвідкличних зобов''язань банку за кредитними лініями фізичним особам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E136', 'Сума відкличних зобов''язань банку за кредитними лініями фізичним особам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E137', 'Сума фактичних відтоків за кредитними лініями суб''єктам господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E138', 'Сума безвідкличних зобов''язань банку за кредитними лініями суб''єктам господарської діяльност', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E139', 'Сума відкличних зобов''язань банку за кредитними лініями суб''єктам господарської діяльност', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E140', 'Сума фактичних відтоків за кредитними лініями банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E141', 'Сума відкличних зобов''язань банку за кредитними лініями банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E142', 'Сума безвідкличних зобов''язань банку за кредитними лініями банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E143', 'Сума фактичних відтоків за рахунками-ескроу фізичних осіб', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E144', 'Сума залишку за рахунками-ескроу фізичних осіб', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E145', 'Сума фактичних відтоків за рахунками-ескроу суб''єктів господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E146', 'Сума залишку за рахунками-ескроу суб''єктів господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E147', 'Сума фактичних відтоків за рахунками - ескроу банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E148', 'Сума залишку за рахунками-ескроу банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E149', 'Сума фактичних надходжень за кредитами овердрафт фізичним особам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E150', 'Сума фактичних надходжень за кредитами овердрафт суб''єктам господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E151', 'Сума фактичних надходжень за кредитами овердрафт банкам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E152', 'Сума фактичних грошових відтоків протягом 30 днів за строковими вкладами фізичних осіб, які були повернуті згідно з отриманим повідомленням про їх повернення', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E153', 'Сума фактичних грошових відтоків протягом 30 днів за строковими вкладами фізичних осіб', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E154', 'Сума пролонгованих та повторно заключених договорів/контрактів за  строковими вкладами фізичних осіб, які згідно з умовами договорів мали бути  повернені протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E155', 'Сума за новими договорами/контрактами за строковими вкладами фізичних осіб', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E156', 'Сума фактичних грошових відтоків протягом 30 днів за за строковими вкладами суб''єктів господарської діяльності, які були повернуті згідно з отриманим повідомленням про їх повернення', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E157', 'Сума фактичних грошових відтоків протягом 30 днів за строковими вкладами суб''єктів господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E158', 'Сума пролонгованих та повторно заключених договорів/контрактів за  строковими вкладами суб''єктів господарської діяльності, які згідно з умовами договорів, мали бути  повернені протягом 30 днів', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E159', 'Сума за новими договорами/контрактами за строковими вкладами суб''єктів господарської діяльності', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E160', 'Сума фактичних грошових відтоків протягом 30 днів за строковими депозитами інших банків та за строковими кредитами, що отримані від інших банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E161', 'Сума фактичних грошових відтоків протягом 30 днів за вкладами бюджетних установ, які були повернуті згідно з отриманим повідомленням про їх повернення', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E162', 'Сума фактичних грошових відтоків протягом 30 днів за строковими коштами бюджетних установ ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E163', 'Сума фактичних грошових відтоків протягом 30 днів за строковими коштами небанківських фінансових установ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E164', 'Сума фактичних грошових відтоків протягом 30 днів за вкладами небанківських фінансових установ, які були повернені відповідно до отриманого повідомлення про їх повернення ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E165', 'Сума фактичних грошових відтоків протягом 30 днів за кредитами від міжнародних банків розвитку ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E166', 'Сума фактичних грошових відтоків протягом 30 днів за кредитами від інших організацій', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E167', 'Сума фактичних грошових відтоків протягом 30 днів за строковими ощадними (депозитними) сертифікатами зі строком до 30 днів ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E168', 'Сума фактичних грошових відтоків протягом 30 днів за іншими цінними паперами власного боргу ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E169', 'Сума фактичних грошових відтоків протягом 30 днів за субординованим боргом ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E170', 'Сума фактичних грошових відтоків за безвідкличними зобов''язаннями з кредитування, що надані іншим фінансовим установам', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E171', 'Сума фактичних грошових відтоків протягом 30 днів за операціями, пов''язаними з торговим фінансуванням (акредитиви, гарантії)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E172', 'Сума фактичних грошових відтоків протягом 30 днів за іншими балансовими та позабалансовими зобов''язаннями', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E173', 'Сума фактичних грошових відтоків протягом 30 днів за операціями з деривативами', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E174', 'Сума фактичних грошових відтоків протягом 30 днів за кредиторською заборгованістю з придбання та продажу іноземної валюти за рахунок банку', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E175', 'Сума фактичних грошових відтоків протягом 30 днів за кредиторською заборгованістю', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E176', 'Сума фактичних грошових відтоків протягом 30 днів за коштами, що отримані за операціями репо та забезпечені вискоякісними ліквідними активами (ВЛА)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E177', 'Сума пролонгованих та повторно заключених договорів/контрактів протягом 30 днів за коштами, що отримані за операціями репо та забезпечені вискоякісними ліквідними активами (ВЛА)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E178', 'Сума за новими договорами/контрактами протягом 30 днів за коштами, що отримані за операціями репо та забезпечені вискоякісними ліквідними активами (ВЛА)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E179', 'Сума фактичних грошових відтоків протягом 30 днів за коштами, що отримані за операціями репо та забезпечені не вискоякісними ліквідними активами (ВЛА)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E180', 'Сума пролонгованих договорів/контрактів протягом 30 днів за коштами, що отримані за операціями репо та забезпечені не вискоякісними ліквідними активами (ВЛА)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E181', 'Сума нових договорів/контрактів протягом 30 днів за коштами, що отримані за операціями репо та забезпечені не вискоякісними ліквідними активами (ВЛА)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E182', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів   за вкладами фізичних осіб', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E183', 'Сума фактичних грошових відтоків протягом 30 днів за грошовим покриттям інших банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E184', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів  за коштами банків', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E185', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів   за рахунками бюджетних  установ ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E186', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів за коштами небанківських фінансових установ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E187', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів за кредитами від міжнародних банків розвитку та інших фінанансових організацій', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E188', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів   за цінними паперами власного боргу', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E189', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів за субординованим боргом', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E190', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів за вкладами суб''єктів господарської діяльності (СГД)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E191', 'Сума фактичних грошових відтоків за нарахованими витратами протягом 30 днів за кредитами Національного банку та коштами отриманими за операціями репо', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
COMMIT;
