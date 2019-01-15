SET DEFINE OFF;

exec bc.home;

delete from NBUR_DCT_F6KX_EKP;

Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K001', 'Загальний обсяг високоякісних ліквідних активів у гривні', '1', 'A6K006', NULL, 
    NULL, NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K002', 'Сукупні очікувані відпливи грошових коштів у гривні', '1', 'A6K007', NULL, 
    NULL, NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K003', 'Сукупні очікувані надходження грошових коштів у гривні', '1', 'A6K008', NULL, 
    NULL, NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K004', 'Чистий очікуваний відплив грошових коштів у гривні', '1', NULL, NULL, 
    'A6K002 - LEAST(A6K003, 0.75 * A6K002)', NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K005', 'Коефіцієнт покриття ліквідністю (LCR) у гривні', '1', NULL, NULL, 
    'AE6001/AE6004', NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K006', 'Загальний обсяг високоякісних ліквідних активів (за всіма валютами)', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K007', 'Сукупні очікувані відпливи грошових коштів (за всіма валютами)', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K008', 'Сукупні очікувані надходження грошових коштів (за всіма валютами)', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K009', 'Чистий очікуваний відплив грошових коштів (за всіма валютами)', '0', NULL, NULL, 
    'A6K007 - LEAST(A6K008, 0.75 * A6K007)', NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K010', 'Коефіцієнт покриття ліквідністю (LCR) за всіма валютами (LCRвв)', '0', NULL, NULL, 
    'AE6006/AE6009', NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K011', 'Сума за облігаціями внутрішньої державної позики (ОВДП) зі строком погашення більше 30 днів', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K012', 'Сума за облігаціями внутрішньої державної позики (ОВДП) зі строком погашення до 30 днів', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K013', 'Сума за облігаціями зовнішньої державної позики в іноземній валюті зі строком погашення до 30 днів', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K014', 'Сума за облігаціями зовнішньої державної позики в іноземній валюті зі строком погашення більше 30 днів', '1', 'A6K001', NULL, 
    NULL, 85, 85, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K015', 'Сума за борговими цінними паперами міжнародних фінансових організацій/державних органів країн G-7 з рейтингами провідних світових рейтингових агенств не нижче "АА-"/"Аа3"', '1', 'A6K001', 0, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K016', 'Кошти в іноземній валюті на кореспондентських рахунках у банках з рейтингом не нижче інвестиційного класу', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K017', 'Сума незнижувального залишку в іноземній валюті на рахунках ностро в банках з рейтингом не нижче інвестицій-ного класу', '1', 'A6K001', 0, 
    NULL, -100, -100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K001', 'Банкноти та монети', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K002', 'Резерви за готівковими коштами, наявність яких непідтверджена', '1', 'A6K001', NULL, 
    NULL, -100, -100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K003', 'Кошти на кореспондентському рахунку в Національному банку України', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K024', 'Сума за борговими цінними паперами, емітованими міжнародними банками розвитку', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K025', 'Сума за депозитними сертифікатами Національного банку України', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K026', 'Сума за депозитами в Національному банку України до 1 дня ', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K018', 'Сума строкових вкладів фізичних осіб, які згідно з умовами договорів не будуть повернені протягом 30 днів', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K019', 'Сума строкових вкладів фізичних осіб, на які було накладено обмеження на розпорядження протягом 30 днів', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K020', 'Сума вкладів фізичних осіб, за якими отримано повідомлення про їх повернення (вклади на вимогу та строкові вклади)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K021', 'Сума інших строкових вкладів фізичних осіб, які згідно з умовами договорів, можуть бути повернені протягом 30 днів', '1', 'A6K002', NULL, 
    NULL, 10, 10, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K022', 'Сума строкових вкладів суб’єктів господарської діяльності, які згідно з умовами договорів не будуть повернені протягом 30 днів', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K023', 'Сума строкових вкладів суб’єктів господарської діяльності, на які було накладено обмеження на розпорядження
', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K024', 'Сума строкових вкладів суб’єктів господарської діяльності, за якими отримано повідомлення про їх повернення (вклади на вимогу та строкові вклади)
', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K025', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими вкладами суб''єктів господарської діяльності (СГД)', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K026', 'Сума за лоро рахунками, які не включені до розрахунку високоякісних ліквідних активів (ВЛА)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K027', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими депозитами інших банків та за строковими кредитами, що отримані від інших банків', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K028', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими коштами бюджетних установ', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K029', 'Сума очікуваних контрактних відтоків протягом 30 днів за строковими коштами небанківських фінансових установ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K030', 'Вклади небанківських фінансових установ, за якими отримано повідомлення про їх повернення (вклади на вимогу та строкові вклади)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K031', 'Сума очікуваних контрактних відпливів протягом 30 днів за строковими коштами Національного банку України', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K032', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредитами від міжнародних банків розвитку', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K033', 'Сума очікуваних контрактних відтоків протягом 30 днів кредитами від інших організацій ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K034', 'Сума очікуваних контрактних відпливів протягом 30 днів за строковими ощадними (депозитними) сертифікатами', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K035', 'Сума очікуваних контрактних відтоків протягом 30 днів за іншими цінними паперами власного боргу', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K036', 'Сума очікуваних контрактних відтоків протягом 30 днів за субординованим боргом ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K037', 'Сума за безвідкличними зобов''язаннями з кредитування, що надані  фізичним особам', '1', 'A6K002', NULL, 
    NULL, 5, 5, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K038', 'Сума за безвідкличними зобов''язаннями з кредитування, що надані суб''єктам господарської діяльності, органам державної влади, органам місцевого самоврядування та міжнародним фінансовим організаціям ', '1', 'A6K002', NULL, 
    NULL, 10, 10, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K039', 'Сума за безвідкличними зобов''язаннями з кредитування, що надані іншим фінансовим установам', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K040', 'Сума очікуваних контрактних відпливів протягом 30 днів за операціями, пов’язаними з торговим фінансуванням (гарантії, акредитиви)
', '1', 'A6K002', NULL, 
    NULL, 30, 30, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K041', 'Сума очікуваних контрактних відтоків протягом 30 днів за іншими балансовими та позабалансовими зобов''язаннями', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K042', 'Сума очікуваних контрактних відтоків протягом 30 днів за операціями з деривативами', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K043', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредиторською заборгованістю з придбання та продажу іноземної валюти за рахунок банку', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K044', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредиторською заборгованістю', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K046', 'Сума очікуваних контрактних відтоків протягом 30 днів за коштами, що отримані за операціями репо та забезпечені вискоякісними ліквідними активами (ВЛА)', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K047', 'Сума очікуваних контрактних відтоків протягом 30 днів за коштами, що отримані за операціями репо та забезпечені не вискоякісними ліквідними активами (ВЛА)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K048', 'Сума простроченої заборгованості за відтоками', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K066', 'Кошти банків у розрахунках, які є забезпеченням за кредитами рефінансування Національного банку України', '1', 'A6K003', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K005', 'Кошти фізичних осіб на вимогу', '1', 'A6K002', NULL, 
    NULL, 20, 20, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K006', 'Нараховані витрати за коштами фізичних осіб', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K007', 'Кошти суб''єктів господарської діяльності на вимогу', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K008', 'Кошти в розрахунках інших банків', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K009', 'Нараховані витрати за коштами банків', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K010', 'Поточні рахунки бюджетних  установ', '1', 'A6K002', NULL, 
    NULL, 100, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K011', 'Нараховані витрати за коштами бюджетних  установ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K012', 'Кошти виборчих фондів та фонду референдуму', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K013', 'Кошти на вимогу небанківських фінансових установ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K014', 'Нараховані витрати за коштами небанківських фінансових установ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K015', 'Кошти Національного банку України на вимогу ', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K016', 'Нараховані витрати за коштами Національного банку України', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K017', 'Нараховані витрати за кредитами від міжнародних банків розвитку та інших організацій', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K018', 'Нараховані витрати за цінними паперами власного боргу', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K019', 'Нараховані витрати за субординованим боргом', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K020', 'Безвідкличні зобов''язання з кредитування, що надані банкам', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K021', 'Відтоки за транзитними та кліринговими рахунками', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K023', 'Нараховані витрати за коштами суб''єктів господарської діяльності', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K027', 'Нараховані витрати за кредитами Національного банку України та коштами отриманими за операціями репо', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K049', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами фізичних осіб на поточні потреби', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K050', 'Сума очікуваних контрактних надходжень протягом 30 днів за іпотечними кредитами фізичних осіб', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K051', 'Сума очікуваних контрактних надходжень протягом 30 днів за фінансовим лізингом (орендою) фізичних осіб', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K052', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами фізичних осіб, що надані за врахованими векселями', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K053', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за кредитами фізичних осіб', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K054', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами суб''єктам господарської діяльності в поточну діяльність', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K055', 'Сума очікуваних контрактних надходжень протягом 30 днів за іпотечними кредитами суб''єктам господарської діяльності', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K056', 'Сума очікуваних контрактних надходжень протягом 30 днів за фінансовим лізингом (орендою) суб''єктам господарської діяльності', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K057', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями факторингу із суб''єктами господарської діяльності', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K058', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами суб''єктам господарської діяльності, що надані за врахованими векселями', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K059', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за кредитами суб''єктам господарської діяльності', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K060', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами органам державної влади та місцевого самоврядування', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K061', 'Сума очікуваних контрактних надходжень протягом 30 днів за іпотечними кредитами органам державної влади та місцевого самоврядування', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K062', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за кредитами органам державної влади та місцевого самоврядування', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K063', 'Сума за депозитами в Національному банку України, яка не включена до високоякісних ліквідних активів, та нараховані доходи за ними', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K064', 'Сума за ностро рахунками, яка не включена до високоякісних ліквідних активів (ВЛА)', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K065', 'Сума незнижувального залишку на рахунках ностро, яка не включена до високоякісних ліквідних активів (ВЛА)', '1', 'A6K003', 0, 
    NULL, -100, -100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K067', 'Сума очікуваних контрактних надходжень протягом 30 днів за вкладами (депозитами) в інших банках', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K068', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами та фінансовим лізингом (орендою) наданим іншим банкам', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K069', 'Сума очікуваних контрактних надходжень протягом 30 днів за кредитами (депозитами), що надані (розміщені) на умовах субординованого боргу ', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K070', 'Сума невикористаної частини безвідкличних кредитних ліній для підтримання ліквідності, відкритих материнським банком', '1', 'A6K003', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K071', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за коштами в інших банках', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K072', 'Сума очікуваних контрактних надходжень протягом 30 днів за борговими цінними паперами, які не включені до високоякісних ліквідних активів (ВЛА), та нарахованими доходами за ними', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K073', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями зворотнього репо без переходу права власності/розпорядження та нарахованими доходами за ними ', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K074', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями зворотнього репо з переходом права власності/розпорядження, забезпеченими не високоякісними ліквідними активами, та нарахованими доходами за ними ', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K075', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями зворотнього репо з переходом права власності/розпорядження, забезпеченими високоякісними ліквідними активами, та нарахованими доходами за ними', '1', 'A6K003', NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K076', 'Сума очікуваних контрактних надходжень протягом 30 днів за операціями з деривативами', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K077', 'Сума очікуваних контрактних надходжень протягом 30 днів за дебіторською заборгованістю з придбання та продажу іноземної валюти за рахунок банку', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K078', 'Сума очікуваних контрактних надходжень протягом 30 днів за дебіторською заборгованістю за операціями з банками та клієнтами', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K022', 'Надходження за транзитними і кліринговими рахунками', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K080', 'Сума очікуваних контрактних надходжень протягом 30 днів за нарахованими доходами за кредитами овердрафт', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K081', 'Фактичне середньоарифметичне значення коефіцієнта покриття ліквідністю (LCR) за всіма валютами (LCRвв)', '0', NULL, 0, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K082', 'Фактичне середньоарифметичне значення коефіцієнта покриття ліквідністю (LCR) в іноземній валюті (LCRів)', '0', NULL, 0, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K083', 'Загальний обсяг високоякісних ліквідних активів в іноземній валюті', '0', 'A6K006', NULL, 
    NULL, NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K084', 'Сукупні очікувані відпливи грошових коштів в іноземній валюті', '0', 'A6K007', NULL, 
    NULL, NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K085', 'Сукупні очікувані надходження грошових коштів в іноземній валюті', '0', 'A6K008', NULL, 
    NULL, NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K086', 'Чистий очікуваний відплив грошових коштів в іноземній валюті', '0', NULL, NULL, 
    'A6K084 - LEAST(A6K085, 0.75 * A6K084)', NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K087', 'Коефіцієнт покриття ліквідністю (LCR) в іноземній валюті (LCRів)', '0', NULL, NULL, 
    'AE6083/AE6086', NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K088', 'Кошти банків у розрахунках (крім тих, які є забезпеченням за кредитами рефінансування Національного банку України)', '1', 'A6K003', 0, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K089', 'Кошти в іноземній валюті на кореспондентських рахунках в банках, які дотримуються LCRвв та LCRів та не віднесені до категорії неплатоспроможних', '1', NULL, 0, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K090', 'ума незнижувального залишку в іноземній валюті на рахунках ностро в банках, які дотримуються LCRвв та LCRів та не віднесені до категорії неплатоспроможних', '1', NULL, 0, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K045', 'Сума очікуваних контрактних відтоків протягом 30 днів за кредитами, що отримані від Національного банку України', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K079', 'Вклади бюджетних установ, за якими було отримано повідомлення про їх повернення', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
COMMIT;
