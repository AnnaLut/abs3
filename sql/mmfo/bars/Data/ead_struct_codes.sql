MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1 as ID,
  'Ідентифікаційні документи ФО' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  11 as ID,
  'Документи, що посвідчують особу' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  111 as ID,
  'Паспорт громадянина України' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  112 as ID,
  'Тимчасове посвідчення громадянина України (видається особам, що набули громадянства України та взяли зобов’язання припинити іноземне громадянство)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  113 as ID,
  'Тимчасове посвідчення, що підтверджує особу громадянина України (видається  на тимчасовий термін в разі втрати або викрадення паспорта)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  114 as ID,
  'Паспорт гр.України для виїзду за кордон без відмітки, що підтв. постійне проживання  за кордоном' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  115 as ID,
  'Паспорт гр. України для виїзду за кордон з відм. в пасп. про пост. прожив. за кордоном' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  116 as ID,
  'Паспортний документ іноземця з дозволом на постійне місце проживання в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  117 as ID,
  'Посвідка на постійне проживання в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  118 as ID,
  'Посвідчення біженця, що видане в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  119 as ID,
  'Національний паспорт громадянина іншої країни' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1110 as ID,
  'Посвідчення особи без громадянства для виїзду за кордон, що видане в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1111 as ID,
  'Свідоцтво про народження громадянина України' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1112 as ID,
  'Сторінка документу з фото та підписом' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1113 as ID,
  'Паспорт громадянина України для виїзду за кордон з відміткою про взяття на облік у дипломатичному представництві або консульській установі України' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1114 as ID,
  'Паспорт громадянина України, з місцезнаходженням/постійним проживанням на території ВЕЗ «Крим», без надання довідки про взяття на облік та переміщення' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  12 as ID,
  'Інформація про номер облікової картки платника податків' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  121 as ID,
  'Довідка про присвоєння реєстраційного номеру облікової картки платника податків' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  122 as ID,
  'Сторінка паспорта з відміткою про відмову від присвоєння ІПН' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  123 as ID,
  'Сторінка паспорта з даними про реєстраційний номер облікової картки платника податків' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  13 as ID,
  'Завірені копії документів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  131 as ID,
  'Копія паспорта громадянина України' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  132 as ID,
  'Копія тимчасового посвідчення громадянина України (видається особам, що набули громадянства України та взяли зобов’язання припинити іноземне громадянство)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  133 as ID,
  'Копія тимчасового посвідчення, що підтверджує особу громадянина України (видається  на тимчасовий термін в разі втрати або викрадення паспорта)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  134 as ID,
  'Копія паспорта гр.України для виїзду за кордон без відмітки, що підтв. постійне проживання  за кордоном' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  135 as ID,
  'Копія паспорта гр. України для виїзду за кордон з відм. в пасп. про пост. прожив. за кордоном' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  136 as ID,
  'Копія паспортного документа іноземця з дозволом на постійне місце проживання в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  137 as ID,
  'Копія посвідки на постійне проживання в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  138 as ID,
  'Копія посвідчення біженця, що видане в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  139 as ID,
  'Копія національного паспорта громадянина іншої країни' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1310 as ID,
  'Копія посвідчення особи без громадянства для виїзду за кордон, що видане в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1311 as ID,
  'Копія свідоцтва про народження громадянина України' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1312 as ID,
  'Копія дозволу на постійне місце проживання в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1313 as ID,
  'Копія дозволу на тимчасове місце проживання в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1314 as ID,
  'Копія документа, що підтверджує місце тимчасового перебування або реєстрації в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1315 as ID,
  'Копія довідки про присвоєння реєстраційного номеру облікової картки платника податків' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1316 as ID,
  'Копія сторінки паспорта з відміткою про відмову від присвоєння ІПН' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1317 as ID,
  'Копія документу, що підтверджує неможливість прочитати / підписати договір' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1318 as ID,
  'Копія документу, що підтверджує статус законного представника' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1319 as ID,
  'Копія довідки про взяття на облік платника податків (4-ОПП)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1320 as ID,
  'Копія пенсійного посвідчення' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1321 as ID,
  'Копія сторінки паспорта з даними про реєстраційний номер облікової картки платника податків' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1322 as ID,
  'Копія паспорта громадянина України для виїзду за кордон з відміткою про взяття на облік у дипломатичному представництві або консульській установі України' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  1323 as ID,
  'Копія паспорта громадянина України, з місцезнаходженням/постійним проживанням на території ВЕЗ «Крим», без надання довідки про взяття на облік та переміщення' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  14 as ID,
  'Інші документи' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  141 as ID,
  'Заява на зміну реквізитів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  142 as ID,
  'Документ, що підтверджує неможливість прочитати / підписати договір' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  143 as ID,
  'Пенсійне посвідчення' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  144 as ID,
  'Свідоцтво про смерть' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  145 as ID,
  'Документ, що підтверджує статус законного представника' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  146 as ID,
  'Заява клієнта на доступ через бек-офіс' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  147 as ID,
  'Документ, що підтверджує місце тимчасового перебування або реєстрації в Україні' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  148 as ID,
  'Довідка про взяття на облік платника податків (4-ОПП)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  149 as ID,
  'Посвідка на тимчасове проживання' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  2 as ID,
  'Депозити' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  21 as ID,
  'Документи договору' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  211 as ID,
  'Заява на дострокове закриття вкладного рахунку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  212 as ID,
  'Договір на відкриття вкладного (депозитного) рахунку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  213 as ID,
  'Додаткові договори' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  214 as ID,
  'Документи щодо виплати вкладів і процентів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  215 as ID,
  'Дозвіл на відкриття рахунку для нерезидента' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  216 as ID,
  'Підтверджувальні документи про походження коштів для нерезидента' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  217 as ID,
  'Договір про інвестиції в Україну (нерезидента-інвестора)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  218 as ID,
  'Довідка зі зразком підпису неповнолітньої особи (14-16 років), видана навчальним закладом' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  219 as ID,
  'Заява про зміну рахунків для перерахування вкладу та процентів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  2110 as ID,
  'Заява про відмову від автопролонгації договору' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  22 as ID,
  'Документи на розпорядження рахунком 3-ою особою' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  221 as ID,
  'Картка зі зразками підписів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  222 as ID,
  'Довіреність' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  223 as ID,
  'Заповіт' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  224 as ID,
  'Заява на доступ до вкладного рахунку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  225 as ID,
  'Заява на анулювання довіреності, оформленої в установі банку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  226 as ID,
  'Заява на анулювання заповідального розпорядження, оформленого в установі банку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  227 as ID,
  'Згода на набуття фізичною особою прав вкладника по рахунку, відкритому на її користь' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  3 as ID,
  'Запити державних органів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  31 as ID,
  'Арешти  рахунків' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  311 as ID,
  'Постанова державного виконавця, рішення, ухвала, постанова суду про арешт' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  312 as ID,
  'Постанова державного виконавця, постанова слідчого, рішення суду про зняття арешту' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  313 as ID,
  'Розпорядження про блокування рахунку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  32 as ID,
  'Виїмки' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  321 as ID,
  'Рішення (постанова) суду щодо ліквідації або визнанні клієнта банкротом; ухвала суду про порушення провадження у справі про банкрутство клієнта; рішення (ухвала) суду про проведення виїмки' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  322 as ID,
  'Запит державного органу' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  323 as ID,
  'Відповідь державному органу' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  324 as ID,
  'Протокол виїмки' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  325 as ID,
  'Письмові вимоги (запити) державних органів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  33 as ID,
  'Документи, що стосуються банківської таємниці' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  331 as ID,
  'Письмовий запит або дозвіл клієнта на розкриття банківської таємниці рішення суду' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  332 as ID,
  'Рішення (ухвала) суду про розкриття інформації, яка є банківською таємницею' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  333 as ID,
  'Довідка за рахунком' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  4 as ID,
  'Фінансовий моніторинг' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  40 as ID,
  'Фінансовий моніторинг' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  401 as ID,
  'Опитувальний лист клієнта-фізичної особи' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  402 as ID,
  'Листування з клієнтом щодо фінансового моніторингу' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5 as ID,
  'Договір комплексного банківського обслуговування' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  51 as ID,
  'Документи ДКБО' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  511 as ID,
  'Заява про приєднання до Договору комплексного банківського обслуговування фізичних осіб та відкриття поточного рахунку з використанням електронного платіжного засобу (платіжної картки)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  512 as ID,
  'Заява на встановлення відновлюваної кредитної лінії (Кредиту) відповідно до  умов Договору комплексного обслуговування фізичних осіб (ДКБО)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  513 as ID,
  'Заява про випуск додаткової картки в рамках Договору комплексного обслуговування фізичних осіб (ДКБО)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  514 as ID,
  'Заява на зміну графіку погашення Кредиту відповідно до умов Договору комплексного банківського обслуговування фізичних осіб, укладеного між  Банком та Клієнтом' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  515 as ID,
  'Заява про розірвання Договору комплексного банківського обслуговування фізичних осіб та/або закриття рахунку (ів)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  516 as ID,
  'Заява власника рахунку про спірну транзакцію' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  517 as ID,
  'Заява держателя картки про спірну транзакцію' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  518 as ID,
  'Заява щодо перевипуску платіжної картки но новий строк' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  519 as ID,
  'Витяг рішення Кредитного комітету про встановлення овердрафту за рахунком' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5110 as ID,
  'Довідка про доходи / біллінгова виписка' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5111 as ID,
  'Висновок за попередньою оцінкою фінансового стану Позичальника фізичною особою' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  52 as ID,
  'Кредитна фабрика' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  521 as ID,
  'Сторінки паспорту' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  522 as ID,
  'Реєстраційний номер облікової картки платника податків' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  523 as ID,
  'Довідка про доходи' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  524 as ID,
  'Довідка про розмір пенсії' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  525 as ID,
  'Білінгова виписка' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  526 as ID,
  'Довідка про наявність кредитної заборгованості' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  527 as ID,
  'Квитанції про оплату ним комунальних платежів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  528 as ID,
  'Виписка про здійснення комунальних платежів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  529 as ID,
  'Виписка з АБС про здійснення/отримання переказів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5210 as ID,
  'Пенсійне посвідчення' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5211 as ID,
  'Військовий квиток' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5212 as ID,
  'Наказ про звільнення з військової служби (для військових пенсіонерів)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5213 as ID,
  'Висновок фін стану' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5214 as ID,
  'Інше' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5215 as ID,
  'Підсумковий протокол' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  53 as ID,
  'Документи БПК' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  531 as ID,
  'Заява клієнта' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  532 as ID,
  'Заява на встановлення кредиту' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  533 as ID,
  'Анкета клієнта - фізичної особи' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  534 as ID,
  'Опитувальник клієнта - фізичної особи' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  535 as ID,
  'Заява на повернення затриманої банкоматом картки' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  536 as ID,
  'Заява про повернення коштів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  537 as ID,
  'Заява про заміну картки' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  538 as ID,
  'Заява про зміну інформації' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  539 as ID,
  'Заява про втрату БПК' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5310 as ID,
  'Заява про пошкодження БПК' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5311 as ID,
  'Заява про коригування залишку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5312 as ID,
  'Заява про відмову від трансакцій' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5313 as ID,
  'Повідомлення про умови кредитування' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5314 as ID,
  'Заява про зняття ліміту по БПК' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5315 as ID,
  'Заява про встановлення ліміту по БПК' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5316 as ID,
  'Заява про видачу коштів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5317 as ID,
  'Реквізити' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5318 as ID,
  'Заява про розблокування коштів' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5319 as ID,
  'Додаткова угода W4 зміна % ставки (співробітники)' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5320 as ID,
  'Опис документів до справи ФО\ЮО' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5321 as ID,
  'Таблиця сукупної вартості' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5322 as ID,
  'Таблиця сукупної вартості в WAY4 + 2.5% зняття готівки' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5323 as ID,
  'Заява про зарахування сум соціальної пенсії' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5324 as ID,
  'Заява про зарахування сум військової пенсії' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5325 as ID,
  'Заява працівник банку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5326 as ID,
  'Згода на передачу роботодавцю інформації по рахунку' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5327 as ID,
  'Заява зарахування зарплати на рахунок' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  5328 as ID,
  'Довідка про взяття на облік внутрішньопереміщених осіб' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  54 as ID,
  'Документи сформовані у WEB-банкінгу' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  541 as ID,
  'Заява про відкриття депозиту через Ощад 24/7' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  542 as ID,
  'Заява про відмову від автопролонгації за депозитом через Ощад 24/7' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

MERGE INTO BARS.EAD_STRUCT_CODES A USING
 (SELECT
  543 as ID,
  'Заява про зміну рахунку виплати відсотків та тіла депозиту через Ощад 24/7' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME)
VALUES (
  B.ID, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;

COMMIT;
