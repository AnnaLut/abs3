-- 03.01.2018 на 01.01.2018 меняется структура файла #F4 
-- вместо параметра R013 должен формироваться параметр R011
-- параметр K072 будет 2-х значным

exec bc.home;

delete from form_stru where kodf = 'F4';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 1, '1 - сума,~2 - %% ставка', 'substr(kodp,1,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 2, '5-Дт оборот~6-Кт оборот', 'substr(kodp,2,1)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 3, 'Бал.~рах.', 'substr(kodp,3,4)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 4, 'Параметр~R011', 'substr(kodp,7,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 5, 'Код секцii~виду економ.~дiяльностi', 'substr(kodp,8,1)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 6, 'Код~сектора~економiки', 'substr(kodp,9,2)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 7, 'Код початкового~строку~погашення', 'substr(kodp,11,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 8, 'Резиден~тнiсть', 'substr(kodp,12,1)', '1', 
    'C', 9);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 9, 'Параметр~D020', 'substr(kodp,13,2)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 10, 'Код~валюти', 'substr(kodp,15,3)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 11, 'Код розміру~суб''єкта господарювання', 'substr(kodp,18,1)', '1', 
    'C', 11);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('F4', 12, 'Код обл.~безбаланс.вiд', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('F4', 13, 'Значення показника', 'znap', '0', 
    'C');

commit;