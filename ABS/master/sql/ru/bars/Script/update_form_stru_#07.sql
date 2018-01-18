-- с 01.01.2018 новая структура файла LDBBBBZУУVVVЦППMMMLNNNN 
--                             вместо DBBBBZУVVVЦПП 

-- добавлен код L - (1-сума,2-к-сть,3-код ЦП)
-- добавлен код MMM - Код країни
-- добавлен код L - Код строку до погашення
-- добавлен код NNNN - порядковий номер ЦП

exec bc.home;  

delete from form_stru where kodf = '07';

-- новий код
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 1, 'Код L~(1-сума,2-к-сть,3-код ЦП)', 'substr(kodp,1,1)', '1', 
    'C', 3);
------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 2, 'Тип залишку~(1 - Дт,2 - Кт)', 'substr(kodp,2,1)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 3, 'Бал.~рах.', 'substr(kodp,3,4)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 4, 'Параметр~R011', 'substr(kodp,7,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 5, 'Код сектору~екон.(K072)', 'substr(kodp,8,2)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 6, 'Код~валюти', 'substr(kodp,10,3)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 7, 'Код початкового~строку погашення', 'substr(kodp,13,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 8, 'Код виду~цінних паперів', 'substr(kodp,14,2)', '1', 
    'C', 9);
--------------------------------------------------------------------------
--нові частини коду
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 9, 'Код~країни', 'substr(kodp,16,3)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 10, 'Код строку~до погашення', 'substr(kodp,19,1)', '1', 
    'C', 11);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('07', 11, 'Порядковий~номер ЦП', 'substr(kodp,20,4)', '1', 
    'C', 1);
--------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('07', 12, 'Код областi~безбаланс.вiд', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('07', 13, 'Значення~показника', 'znap', 'C');

commit;

