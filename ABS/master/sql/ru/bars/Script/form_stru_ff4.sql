-- 12/06/2017 
-- новая структура файлу на 01.07.2017
-- вместо части показателя Код~''9'' 
-- будет формироваться параметр K140 (код розміру суб'єкта господарювання)

exec suda;

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
   ('F4', 4, 'Параметр~R013', 'substr(kodp,7,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 5, 'Код секцii~виду економ.~дiяльностi', 'substr(kodp,8,1)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 6, 'Код~сектора~економiки', 'substr(kodp,9,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 7, 'Код початкового~строку~погашення', 'substr(kodp,10,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 8, 'Резиден~тнiсть', 'substr(kodp,11,1)', '1', 
    'C', 9);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 9, 'Параметр~D020', 'substr(kodp,12,2)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 10, 'Код~валюти', 'substr(kodp,14,3)', '1', 
    'C', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('F4', 11, 'Код розміру~суб''єкта господарювання', 'substr(kodp,17,1)', '1', 
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
