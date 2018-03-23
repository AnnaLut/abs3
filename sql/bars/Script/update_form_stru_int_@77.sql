-- на 01.02.2018 нова структура показника

exec bc.home;

Prompt NEW STRU FOR FILE @77 );

delete from form_stru_int where kodf = '77';

Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 1, '1-Дт~2-Кт', 'substr(kodp,1,1)', '1', 
    'С', 1);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 2, 'Бал.~рах.', 'substr(kodp,2,4)', '1', 
    'С', 2);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 3, 'Параметр~R011', 'substr(kodp,6,1)', '1', 
    'С', 5);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 4, 'Параметр~R013', 'substr(kodp,7,1)', '1', 
    'С', 6);

Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 5, '1-короткостр.~2-довгостр.', 'substr(kodp,8,1)', '1', 
    'С', 4);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 6, 'Код строку~до погашення', 'substr(kodp,9,1)', '1', 
    'С', 7);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 7, 'Резидент~нiсть', 'substr(kodp,10,1)', '1', 
    'С', 8);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 8, 'код строку~прострочення~(s190)', 'substr(kodp,11,1)', '1', 
    'С', 9);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('77', 9, 'Код~валюти', 'substr(kodp,12,3)', '1', 
    'С', 3);
Insert into BARS.FORM_STRU_INT
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('77', 10, 'Значення~показника', 'znap', 'С');


COMMIT;
