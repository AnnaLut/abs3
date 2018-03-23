-- с 01.01.2018 новая структура файла DBBBBZУУRVVVЦППMMM 
--                             вместо DBBBBPУRVVVЦПП 

-- вместо параметра R013 будет формироваться параметр R011
-- параметр K072 будет формироваться 2-х значным вместо однозначного
-- добавлен код MMM - Код країни

exec bc.home;  

delete from form_stru where kodf = '08';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 1, 'Тип залишку~(1 - Дт,2 - Кт)', 'substr(kodp,1,1)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 2, 'Бал.~рах.', 'substr(kodp,2,4)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 3, 'Парам.~R011', 'substr(kodp,6,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 4, 'Код сектору~екон.(K072)', 'substr(kodp,7,2)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 5, 'Резидент~нiсть', 'substr(kodp,9,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 6, 'Код~валюти', 'substr(kodp,10,3)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 7, 'Код початкового~строку погашення', 'substr(kodp,13,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 8, 'Код виду~цінних паперів', 'substr(kodp,14,2)', '1', 
    'C', 8);
--------------------------------------------------------------------------
-- нова частина коду
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('08', 9, 'Код~країни', 'substr(kodp,16,3)', '1', 
    'C', 9);
--------------------------------------------------------------------------
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('08', 10, 'Код областi~безбаланс.вiд', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('08', 11, 'Значення~показника', 'znap', '0', 
    'C');

commit;
