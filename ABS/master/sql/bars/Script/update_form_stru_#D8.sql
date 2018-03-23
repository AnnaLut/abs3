-- на 01.01.2018 новая структура показателя и
-- новые показатели

exec bc.home;

Prompt NEW STRU FOR FILE #D8 );
-- новая структура с 01.01.2018
-- Добавляются коды "H" - код оцінки кредитного ризику (S083)
-- Добавляются коды "O" - код розміру субєкта господарювання (K140) 

delete from form_stru where kodf = 'D8';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 1, 'Код~DDD', 'substr(kodp,1,3)', '1', 
    'G', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 2, 'Код~контрагента', 'substr(kodp,4,10)', '1', 
    'G', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 3, 'N кред.~договора', 'substr(kodp,14,4)', '1', 
    'G', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 4, 'Бал.~рах.', 'substr(kodp,18,4)', '1', 
    'G', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 5, 'Код~валюти', 'substr(kodp,22,3)', '1', 
    'G', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 6, 'Номер~траншу', 'substr(kodp,25,2)', '1', 
    'G', 6);
-- новые части кода показателя
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 7, 'Ознака~ідентиф.коду', 'substr(kodp,27,1)', '1', 
    'G', 7);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 8, '1-вкл. до нормативів~2-не вкл. до нормативів', 'substr(kodp,28,1)', '1', 
    'G', 8);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 9, 'Код виду~забеспечення', 'substr(kodp,29,2)', '1', 
    'G', 9);
---------------------------------------------------------------------------
на 01.01.2018
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 10, 'Тип оцінки~кредитного ризику', 'substr(kodp,31,1)', '1', 
    'G', 10);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 11, 'Код розміру~субєкту гос-ня', 'substr(kodp,32,1)', '1', 
    'G', 11);
---------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('D8', 12, 'Значення~показника', 'znap', 'G');

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 13, 'РНК', 'substr(kodp,31)', '0', 
    'G', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D8', 14, 'МФО', 'nbuc', '0', 
    'G', 10);

commit;
