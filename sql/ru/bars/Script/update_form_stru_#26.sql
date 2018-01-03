-- на 01.01.2018 меняется структура показателя файла #26 
-- добавлены части показателя 
--    параметр R011 
--    ознака обтяженості коштів (код J)
--    код початкового строку (параметр S181) 
--    код кінцевого строку (параметр S245)
--    код розподілу активів за групами ризику (параметр S580) 

exec suda;

delete from form_stru where kodf = '26';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 1, 'Код~"DD"', 'substr(kodp,1,2)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 2, 'Код~країни', 'substr(kodp,3,3)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 3, 'Код~банку', 'substr(kodp,6,10)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 4, 'Бал.~рах.', 'substr(kodp,16,4)', '1', 
    'C', 3);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 5, 'Параметр~R011', 'substr(kodp,20,1)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 6, 'Параметр~R013', 'substr(kodp,21,1)', '1', 
    'C', 6);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 7, 'Код~валюти', 'substr(kodp,22,3)', '1', 
    'C', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 8, 'Ознака~обтяженості', 'substr(kodp,25,1)', '1', 
    'C', 8);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 9, 'Код початкового~строку погашення(S181)', 'substr(kodp,26,1)', '1', 
    'C', 9);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 10, 'Код кінцевого~строку погашення(S245)', 'substr(kodp,27,1)', '1', 
    'C', 10);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('26', 11, 'Код активу за~групами ризмку(S580)', 'substr(kodp,28,1)', '1', 
    'C', 11);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('26', 12, 'Значення~показника', 'znap', '0', 
    'C');



commit;